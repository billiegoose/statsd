#!/bin/bash
mem() {
    # (used - buffers - cached) / total
    free | awk '/Mem/ {printf "%.2f\n", 100*($3-$6-$7)/$2}'
}
