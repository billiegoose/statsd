#!/bin/bash
# The first part in { } outputs the contents of /proc/stat twice, separated by DELAY seconds.
# The awk expression filters only lines starting with 'cpu '
# The first matching row will set usr, sys, idle, and iow. Because the vars are initially unset, subtracting their values has no effect.
# The second matching row will set usr, sys, idle, and iow to the difference between the new value and the old value because of the subtraction.
# The END block computes the total, multiplies by 100 to get percent, and formats to 2 decimal places
cpu() {
    DELAY="${1:-2}"
    { cat /proc/stat; sleep "$DELAY"; cat /proc/stat; } | \
        awk '/^cpu / {usr=$2-usr; sys=$4-sys; idle=$5-idle; iow=$6-iow} \
        END {total=usr+sys+idle+iow; printf "%.2f\n", (total-idle)*100/total}'
}
