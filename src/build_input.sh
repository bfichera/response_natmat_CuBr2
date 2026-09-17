#!/usr/bin/env bash
set -euo pipefail

src_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
com_dir="$src_dir/com"
resp_dir="$src_dir/resp"
out_file="$src_dir/input.tex"

shopt -s nullglob

: > "$out_file"

for ref_com_dir in "$com_dir"/referee*/; do
    refname="$(basename "$ref_com_dir")"
    refnum_str="${refname#referee}"
    refnum=$((10#$refnum_str))
    ref_resp_dir="$resp_dir/$refname"

    printf '\\section*{Referee %d}\n\n' "$refnum" >> "$out_file"

    for compath in "$ref_com_dir"*.tex; do
        comname="$(basename "$compath")"
        resppath="$ref_resp_dir/$comname"

        printf '\\begin{response}{' >> "$out_file"
        cat "$compath" >> "$out_file"
        printf '}\n' >> "$out_file"

        if [ -f "$resppath" ]; then
            cat "$resppath" >> "$out_file"
        else
            printf '%% TODO\n%% Write response\n' >> "$out_file"
        fi

        printf '\n\\end{response}\n\n' >> "$out_file"
    done
done
