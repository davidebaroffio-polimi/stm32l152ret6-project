#!/usr/bin/env python3
"""
Fault Injection Live Visualization Dashboard
============================================
Reads a CSV file (appended to by the injection script) and
renders a live-updating multi-panel dashboard.

Usage:
    python fault_viz.py [--csv PATH] [--interval MS]

Defaults:
    --csv      fault_log.csv
    --interval 1500   (refresh every 1.5 s)
"""

import argparse
import csv
import io
import math
import os
import textwrap
from collections import Counter, defaultdict
from pathlib import Path

import matplotlib as mpl
import matplotlib.gridspec as gridspec
import matplotlib.patches as mpatches
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from matplotlib.animation import FuncAnimation
from matplotlib.colors import ListedColormap

# ── colour palette ───────────────────────────────────────────────────────────
BG       = "#0d1117"
PANEL_BG = "#161b22"
BORDER   = "#30363d"
TEXT     = "#e6edf3"
SUBTEXT  = "#8b949e"

OUTCOME_META = {
     0: dict(label="Masked fault",             color="#8b949e", short="MASK"),
     1: dict(label="Data corruption detected",  color="#3fb950", short="DATA"),
     2: dict(label="CFG corruption detected",   color="#388bfd", short="CFG"),
    -1: dict(label="Hard fault",                color="#f7e466", short="HW"),
    -2: dict(label="Timeout",                   color="#bc8cff", short="TIME"),
    -3: dict(label="SDC (silent corruption)",   color="#ff0000", short="SDC"),
}
UNKNOWN_COLOR = "#1a1a2e"

# Higher = worse (used to pick the dominant outcome when a cell has many hits)
SEVERITY = {0: 1, 2: 2, 1: 3, -2: 4, -1: 5, -3: 6}

# Map outcome code → integer index for the matrix colourmap (0 = no data)
CODE_TO_IDX = {0: 1, 2: 2, 1: 3, -2: 4, -1: 5, -3: 6}
IDX_TO_CODE = {v: k for k, v in CODE_TO_IDX.items()}

# 7-colour map: index 0 = empty, 1-6 = outcomes in severity order
MATRIX_CMAP = ListedColormap([
    UNKNOWN_COLOR,             # 0  no data
    OUTCOME_META[ 0]["color"], # 1  masked
    OUTCOME_META[ 2]["color"], # 2  CFG detected
    OUTCOME_META[ 1]["color"], # 3  data detected
    OUTCOME_META[-2]["color"], # 4  timeout
    OUTCOME_META[-1]["color"], # 5  hard fault
    OUTCOME_META[-3]["color"], # 6  SDC
])

# ── CSV parsing ───────────────────────────────────────────────────────────────

def parse_csv(path: str) -> list:
    rows = []
    try:
        text = Path(path).read_text(errors="replace")
    except FileNotFoundError:
        return rows

    reader = csv.DictReader(io.StringIO(text))
    for raw in reader:
        row = {k.strip().lstrip("\ufeff"): (v or "").strip()
               for k, v in raw.items() if k is not None}
        try:
            target_str = row.get("target", "0x0")
            target_int = (int(target_str, 16)
                          if target_str.startswith("0x") else None)
            bitflip = int(row.get("bitflip", 1))
            bit_pos = int(math.log2(bitflip)) if bitflip > 0 else 0
            rows.append({
                "attempt":    int(row.get("attempt", 0)),
                "stop_addr":  row.get("stop_addr", "?"),
                "stop_fn":    row.get("stop_fn", "?").strip('"'),
                "delay":      float(row.get("delay", 0)),
                "target":     target_str,
                "target_int": target_int,
                "bitflip":    bitflip,
                "bit_pos":    bit_pos,
                "code":       int(row.get("code", 0)),
                "idx":        len(rows),
            })
        except (ValueError, KeyError):
            pass
    return rows

# ── helpers ───────────────────────────────────────────────────────────────────

def outcome_color(code):
    return OUTCOME_META.get(code, {}).get("color", UNKNOWN_COLOR)

def outcome_short(code):
    return OUTCOME_META.get(code, {}).get("short", str(code))

def dominant_code(codes):
    return max(codes, key=lambda c: SEVERITY.get(c, 0))

def style_ax(ax, title="", xlabel="", ylabel=""):
    ax.set_facecolor(PANEL_BG)
    for sp in ax.spines.values():
        sp.set_edgecolor(BORDER)
    ax.tick_params(colors=SUBTEXT, labelsize=7)
    ax.xaxis.label.set_color(SUBTEXT)
    ax.yaxis.label.set_color(SUBTEXT)
    if title:
        ax.set_title(title, color=TEXT, fontsize=14, fontweight="bold", pad=6)
    if xlabel:
        ax.set_xlabel(xlabel, fontsize=10)
    if ylabel:
        ax.set_ylabel(ylabel, fontsize=10)

# ── figure setup ──────────────────────────────────────────────────────────────

def build_figure():
    fig = plt.figure(figsize=(16, 9), facecolor=BG)
    fig.canvas.manager.set_window_title("Fault Injection — Live Dashboard")
    fig.canvas.toolbar.pack_forget()

    gs = gridspec.GridSpec(
        3, 4,
        figure=fig,
        left=0.05, right=0.97,
        top=0.90,  bottom=0.06,
        hspace=0.60, wspace=0.40,
    )

    axes = {
        "donut":    fig.add_subplot(gs[0, 0]),
        "log":      fig.add_subplot(gs[0, 1:3]),
        "timeline": fig.add_subplot(gs[0, 3]),

        "memmap":   fig.add_subplot(gs[1:3, 1:3]),
        #"fnbit":    fig.add_subplot(gs[1, 2:4]),
        "bits":     fig.add_subplot(gs[1, 3]),
        "det_rate": fig.add_subplot(gs[2, 3]),
        "discussion": fig.add_subplot(gs[1:3, 0]),
    }

    fig.text(0.5, 0.966, "ASPIS Fault Injection — Live Analysis",
             ha="center", va="top", color=TEXT,
             fontsize=14, fontweight="bold", fontfamily="monospace")
    fig.text(0.5, 0.943,
             "STM32 Target  •  Software-Implemented Hardware Fault Tolerance",
             ha="center", va="top", color=SUBTEXT, fontsize=8)

    return fig, axes

# ── individual panel renderers ────────────────────────────────────────────────

def draw_donut(ax, rows):
    ax.clear()
    style_ax(ax, title="Outcome distribution")

    counts = Counter(r["code"] for r in rows)
    total  = sum(counts.values()) or 1
    codes  = sorted(counts, key=lambda c: OUTCOME_META.get(c, {}).get("label", ""))

    ax.pie(
        [counts[c] for c in codes],
        colors=[outcome_color(c) for c in codes],
        startangle=90,
        wedgeprops=dict(width=0.46, edgecolor=BG, linewidth=1.5),
    )

    ax.text(0, 0.12, str(len(rows)),
            ha="center", va="center", fontsize=22,
            fontweight="bold", color=TEXT, fontfamily="monospace")
    ax.text(0, -0.18, "attempts",
            ha="center", va="center", fontsize=8, color=SUBTEXT)

    handles = [
        mpatches.Patch(
            color=outcome_color(c),
            label=f"{outcome_short(c):4s}  {counts[c]:>3}"
                  f"  ({100*counts[c]/total:.2f}%)")
        for c in codes
    ]
    ax.legend(handles=handles, loc="lower center",
              bbox_to_anchor=(0.5, -0.38),
              frameon=False, fontsize=6.5, labelcolor=TEXT, ncol=1)


def draw_timeline(ax, rows, window=30):
    ax.clear()
    style_ax(ax, title=f"Attempt timeline  (last {window})")

    recent = rows[-window:]
    if not recent:
        ax.text(0.5, 0.5, "waiting for data…",
                ha="center", va="center", color=SUBTEXT,
                transform=ax.transAxes, fontsize=9)
        return

    for i, r in enumerate(recent):
        ax.scatter(i, 0, c=outcome_color(r["code"]),
                   s=30, zorder=3,
                   edgecolors=BG, linewidths=0.5)

    ax.set_xlim(-1, window)
    ax.set_ylim(-0.8, 0.8)
    ax.yaxis.set_visible(False)
    ax.set_xlabel("← older   newer →", fontsize=15)


# ─── Memory map ──────────────────────────────────────────────────────────────
#
# Tiles all injected target addresses into a rectangular grid.
# Each cell covers a fixed chunk of the address space; its colour
# is the highest-severity outcome recorded in that chunk.
#
# We target a 32-column layout and compute the number of rows
# automatically from the address range.

def _make_memory_grid(rows, grid_cols=128):
    import numpy as np

    valid = [(r["target_int"], r["code"])
             for r in rows if r["target_int"] is not None]
    if not valid:
        return None, 0, 0, 0, 0

    addrs = [a for a, _ in valid]
    base  = min(addrs)
    span  = max(addrs) - base + 1

    chunk     = max(1, math.ceil(span / (grid_cols * grid_cols)))
    n_cells   = math.ceil(span / chunk)
    grid_rows = max(1, math.ceil(n_cells / grid_cols))

    img = np.zeros((grid_rows, grid_cols), dtype=float)
    cell_codes = defaultdict(list)

    for addr, code in valid:
        cell = (addr - base) // chunk
        col  = cell % grid_cols
        row  = cell // grid_cols
        if row < grid_rows:
            cell_codes[(row, col)].append(code)

    for (r, c), codes in cell_codes.items():
        img[r, c] = CODE_TO_IDX[dominant_code(codes)]

    return img, base, chunk, grid_rows, grid_cols


def draw_memory_map(ax, rows):
    ax.clear()
    style_ax(ax, title="Memory map")

    img, base, chunk, nrows, ncols = _make_memory_grid(rows)
    if img is None:
        ax.text(0.5, 0.5, "waiting for data…",
                ha="center", va="center", color=SUBTEXT,
                transform=ax.transAxes, fontsize=9)
        return

    ax.imshow(img, aspect="auto", origin="upper",
              cmap=MATRIX_CMAP, vmin=0, vmax=6,
              interpolation="nearest")

    # x-axis address labels (every ~8 columns)
    #step   = max(1, ncols // 8)
    #xticks = list(range(0, ncols, step))
    #ax.set_xticks(xticks)
    ax.set_xticklabels([])
    ax.set_xticks([])
    #    [f"0x{base + col*chunk:07x}" for col in xticks],
    #    fontsize=10, rotation=35, ha="right"))

    #ax.set_yticks(range(nrows))
    #ax.set_yticklabels([str(r) for r in range(nrows)], fontsize=5)
    #ax.set_ylabel("row", fontsize=6)

    # minor grid to separate cells
    #ax.set_xticks([x - 0.5 for x in range(ncols + 1)], minor=True)
    #ax.set_yticks([y - 0.5 for y in range(nrows + 1)], minor=True)
    #ax.grid(which="minor", color=BG, linewidth=0.3)
    #ax.tick_params(which="minor", bottom=False, left=False)    
    ax.set_yticklabels([])
    ax.set_yticks([])


    # compact legend
    handles = [
        mpatches.Patch(color=MATRIX_CMAP(i / 6),
                       label=outcome_short(IDX_TO_CODE[i]))
        for i in range(1, 7)
    ]
    ax.legend(handles=handles, loc="lower right",
              ncol=3, fontsize=10, framealpha=0.8,
              facecolor=PANEL_BG, edgecolor=BORDER, labelcolor=TEXT)


# ─── Function × bit-position matrix ──────────────────────────────────────────
#
# Rows  = top-N stop_fn values (sorted by hit count).
# Cols  = bit positions 0-7.
# Colour = highest-severity outcome for that (function, bit) pair.
# Each non-empty cell is annotated with the short outcome label.
# The right y-axis shows how many times each function was hit.

def draw_fn_bit_matrix(ax, rows, max_fns=14):
    ax.clear()
    style_ax(ax,
             title="Stop-function × bit-position  —  fault outcome heatmap",
             xlabel="Bit position")

    if not rows:
        ax.text(0.5, 0.5, "waiting for data…",
                ha="center", va="center", color=SUBTEXT,
                transform=ax.transAxes, fontsize=9)
        return

    import numpy as np

    cell_codes = defaultdict(list)
    fn_counts  = Counter()
    for r in rows:
        cell_codes[(r["stop_fn"], r["bit_pos"])].append(r["code"])
        fn_counts[r["stop_fn"]] += 1

    top_fns = [fn for fn, _ in fn_counts.most_common(max_fns)]
    n_fns   = len(top_fns)
    n_bits  = 8

    img    = np.zeros((n_fns, n_bits), dtype=float)
    annots = [[""] * n_bits for _ in range(n_fns)]

    for fi, fn in enumerate(top_fns):
        for bit in range(n_bits):
            codes = cell_codes.get((fn, bit), [])
            if codes:
                dc = dominant_code(codes)
                img[fi, bit]    = CODE_TO_IDX[dc]
                annots[fi][bit] = outcome_short(dc)

    ax.imshow(img, aspect="auto", origin="upper",
              cmap=MATRIX_CMAP, vmin=0, vmax=6,
              interpolation="nearest")

    # cell annotations
    for fi in range(n_fns):
        for bit in range(n_bits):
            lbl = annots[fi][bit]
            if lbl:
                ax.text(bit, fi, lbl,
                        ha="center", va="center",
                        fontsize=5, color=BG, fontweight="bold")

    ax.set_xticks(range(n_bits))
    ax.set_xticklabels([f"b{b}" for b in range(n_bits)], fontsize=7)
    ax.set_yticks(range(n_fns))
    ax.set_yticklabels(
        [textwrap.shorten(fn, 28, placeholder="…") for fn in top_fns],
        fontsize=5.5, fontfamily="monospace")

    # minor grid
    ax.set_xticks([x - 0.5 for x in range(n_bits + 1)], minor=True)
    ax.set_yticks([y - 0.5 for y in range(n_fns + 1)], minor=True)
    ax.grid(which="minor", color=BG, linewidth=0.6)
    ax.tick_params(which="minor", bottom=False, left=False)

    # hit-count annotation on the right y-axis
    ax2 = ax.twinx()
    ax2.set_facecolor("none")
    ax2.set_ylim(ax.get_ylim())
    ax2.set_yticks(range(n_fns))
    ax2.set_yticklabels(
        [f"×{fn_counts[fn]}" for fn in top_fns],
        fontsize=5, color=SUBTEXT)
    for sp in ax2.spines.values():
        sp.set_visible(False)
    ax2.tick_params(colors=SUBTEXT, length=0)


def draw_log(ax, rows, n=10):
    ax.clear()
    ax.set_facecolor(PANEL_BG)
    for sp in ax.spines.values():
        sp.set_edgecolor(BORDER)
    ax.set_xticks([])
    ax.set_yticks([])
    ax.set_title("Recent attempts", color=TEXT, fontsize=14,
                 fontweight="bold", pad=6)

    recent = rows[-n:]
    if not recent:
        return

    headers = ["#", "delay", "fn", "bit", "target", "outcome"]
    col_x   = [0.01, 0.09, 0.21, 0.60, 0.68, 0.87]
    row_h   = 0.085
    top_y   = 0.92

    for hdr, x in zip(headers, col_x):
        ax.text(x, top_y, hdr, transform=ax.transAxes,
                color=SUBTEXT, fontsize=12,
                fontfamily="monospace", fontweight="bold")

    for i, r in enumerate(reversed(recent)):
        y     = top_y - (i + 1) * row_h
        color = outcome_color(r["code"])
        bg_c  = "#1f2937" if i % 2 == 0 else PANEL_BG

        rect = mpatches.FancyBboxPatch(
            (0, y - 0.015), 1.0, row_h - 0.005,
            transform=ax.transAxes,
            boxstyle="round,pad=0.002",
            facecolor=bg_c, edgecolor="none", zorder=1)
        ax.add_patch(rect)

        cells = [
            str(r["attempt"]),
            f"{r['delay']:.3f}",
            textwrap.shorten(r["stop_fn"], 28, placeholder="…"),
            f"b{r['bit_pos']}",
            r["target"],
            outcome_short(r["code"]),
        ]
        for cell, x in zip(cells, col_x):
            c = color if cell == cells[-1] else TEXT
            ax.text(x, y, cell, transform=ax.transAxes,
                    color=c, fontsize=10,
                    fontfamily="monospace", zorder=2)


def draw_bits(ax, rows):
    ax.clear()
    style_ax(ax, title="Bit-position distribution",
             xlabel="Bit", ylabel="Count")

    if not rows:
        return

    bit_counts = Counter(r["bit_pos"] for r in rows)
    bits   = sorted(bit_counts)

    ax.bar([f"b{b}" for b in bits],
           [bit_counts[b] for b in bits],
           color="#388bfd", width=0.6,
           edgecolor=BG, linewidth=0.5)
    ax.tick_params(axis="x", labelsize=7)
    ax.tick_params(axis="y", labelsize=7)
    ax.grid(True, axis="y", color=BORDER, linewidth=0.4, alpha=0.5)


def draw_detection_rate(ax, rows):
    ax.clear()
    style_ax(ax, title="Cumulative detection rate",
             xlabel="Attempt index", ylabel="Rate")

    if len(rows) < 2:
        return

    detected_codes = {1, 2, -1}
    det, xs, rates, sdc_rates = 0, [], [], []

    for i, r in enumerate(rows):
        det += r["code"] in detected_codes
        xs.append(r["idx"])
        rates.append(det / (i + 1))
        sdc_rates.append(
            sum(1 for rr in rows[:i+1] if rr["code"] == -3) / (i + 1))

    ax.plot(xs, rates, color="#3fb950", linewidth=1.5, zorder=3,
            label="Detection rate")
    ax.fill_between(xs, rates, alpha=0.12, color="#3fb950")
    ax.plot(xs, sdc_rates, color="#ff0000",
            linewidth=1.2, linestyle="--", zorder=3, label="SDC rate")

    ax.set_ylim(-0.02, 0.22)
    ax.set_xlim(0, max(xs) + 1)
    ax.yaxis.set_major_formatter(ticker.PercentFormatter(xmax=1))
    ax.tick_params(axis="x", labelsize=6)
    ax.tick_params(axis="y", labelsize=6)
    ax.grid(True, color=BORDER, linewidth=0.4, alpha=0.5)
    ax.legend(fontsize=6, frameon=False, labelcolor=TEXT, loc="upper right")

    if rates:
        ax.annotate(f"{rates[-1]:.2%}",
                    xy=(xs[-1], rates[-1]),
                    xytext=(-32, 8), textcoords="offset points",
                    color="#3fb950", fontsize=7,
                    arrowprops=dict(arrowstyle="-", color="#3fb950", lw=0.8))
        ax.annotate(f"{sdc_rates[-1]:.2%}",
                    xy=(xs[-1], sdc_rates[-1]),
                    xytext=(-32, 8), textcoords="offset points",
                    color="#ff0000", fontsize=7,
                    arrowprops=dict(arrowstyle="-", color="#ff0000", lw=0.8))


def draw_stats_bar(fig, rows):
    for child in fig.texts[:]:
        if getattr(child, "_is_stat", False):
            child.remove()
    if not rows:
        return

    total  = len(rows)
    counts = Counter(r["code"] for r in rows)
    det    = sum(counts[c] for c in (1, 2, -1))
    sdcs   = counts.get(-3, 0)

    stats = [
        ("total",    str(total)),
        ("detected", f"{det}  ({det/total*100:.0f}%)"),
        ("SDC",      f"{sdcs}  ({sdcs/total*100:.1f}%)"),
        ("masked",   f"{counts.get(0,0)}"),
        ("timeout",  f"{counts.get(-2,0)}"),
    ]
    for (lbl, val), xp in zip(stats, [0.12, 0.30, 0.48, 0.65, 0.82]):
        t1 = fig.text(xp, 0.924, lbl.upper(),
                      ha="center", color=SUBTEXT, fontsize=6.5)
        t1._is_stat = True
        color = "#ff0000" if lbl == "SDC" else TEXT
        t2 = fig.text(xp, 0.910, val,
                      ha="center", color=color,
                      fontsize=9, fontweight="bold",
                      fontfamily="monospace")
        t2._is_stat = True

def draw_discussion(ax, rows):
    ax.clear()
    style_ax(ax, title="What is this demo?")
    
    # Hide ticks because this is a text box
    ax.set_xticks([])
    ax.set_yticks([])

    content = (
"""You are watching live fault injection experiments on the board here on the table!

The board is an STM32L152RE whose software is hardened solely with ASPIS:
 - EDDI for data protection;
 - RASM for CFG protection.

The board is running FreeRTOS with a set of microbenchmarks stressing specific FreeRTOS components and two real-time benchmarks: CRC32 and Matrix Multiply. 
Faults are injected as single-bit flips with a uniform random probability in time and in space on 80KB of the RAM and the 16 registers of the Cortex-M3. 

This dashboard shows live results of the injection, with an interesting snapshot of the RAM vulnerability :) 
"""
    )

    
    # Wrap text to fit the box width
    wrapped_text = "\n".join([textwrap.fill(line, width=30) for line in content.splitlines()])

    ax.text(0.05, 0.95, wrapped_text,
            transform=ax.transAxes,
            color=TEXT, fontsize=9,
            va='top', ha='left',
            fontfamily="monospace")
    
# ── main animation loop ───────────────────────────────────────────────────────

def make_updater(csv_path, fig, axes):
    _cache = {"mtime": -1.0, "rows": []}

    def update(_frame):
        try:
            mtime = os.path.getmtime(csv_path)
        except FileNotFoundError:
            mtime = -1.0

        if mtime != _cache["mtime"]:
            _cache["rows"]  = parse_csv(csv_path)
            _cache["mtime"] = mtime

        rows = _cache["rows"]
        draw_donut(axes["donut"], rows)
        draw_timeline(axes["timeline"], rows)
        draw_memory_map(axes["memmap"], rows)
        #draw_fn_bit_matrix(axes["fnbit"], rows)
        draw_log(axes["log"], rows)
        draw_bits(axes["bits"], rows)
        draw_detection_rate(axes["det_rate"], rows)
        draw_discussion(axes["discussion"], rows)
        #draw_stats_bar(fig, rows)
        fig.canvas.draw_idle()

    return update

# ── entry point ───────────────────────────────────────────────────────────────

def main():
    ap = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--csv",      default="fault_log.csv",
                    help="Path to fault-injection CSV (default: fault_log.csv)")
    ap.add_argument("--interval", type=int, default=1500,
                    help="Refresh interval in ms (default: 1500)")
    args = ap.parse_args()

    if not Path(args.csv).exists():
        sample = textwrap.dedent("""\
            attempt,stop_addr,stop_fn,delay,target,bitflip,code,seed
            0,0x08001630,xTaskResumeAll,0.019,0x20003c1c,64,0,3735928559
            1,0x08009b88,prvAddCurrentTaskToDelayedList_dup,0.915,0x20003056,128,0,3735928559
            2,0x080165aa,crc32buf_ret_dup,0.339,0x20002eb0,64,0,3735928559
            3,0x08002668,xTaskIncrementTick,0.74,0x20005b42,16,0,3735928559
            4,0x08003638,vTaskSwitchContext,0.282,0x20007c83,16,0,3735928559
            5,0x080057b4,vListInsert_dup,0.181,0x20002857,64,0,3735928559
            6,0x08014a4c,Multiply_dup,0.139,0x200034b4,32,0,3735928559
            7,0x080146b2,Initialize_dup,0.587,0x20003c94,4,0,3735928559
            8,0x080165fe,crc32buf_ret_dup,0.972,0x200000f9,4,0,3735928559
            9,0x0802168e,vTaskPrioritySet_dup,0.401,0x200016b1,16,0,3735928559
            10,0x08014a8a,Multiply_dup,0.165,0x20005af1,128,0,3735928559
            11,memset,"<xDummyStack>,",0.341,0x2000319c,128,0,3735928559
            12,0x0800346c,vTaskSwitchContext,0.999,0x20002129,8,0,3735928559
        """)
        Path(args.csv).write_text(sample)
        print(f"[fault_viz] '{args.csv}' not found — wrote sample data.")

    print(f"[fault_viz] Watching '{args.csv}' (refresh every {args.interval} ms)")
    print("[fault_viz] Close the window to exit.\n")

    plt.style.use("dark_background")
    fig, axes = build_figure()
    updater   = make_updater(args.csv, fig, axes)

    ani = FuncAnimation(
        fig, updater,
        interval=args.interval,
        cache_frame_data=False,
    )
    updater(0)
    plt.show()
    del ani


if __name__ == "__main__":
    main()