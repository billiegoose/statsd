#!/bin/bash
disk() {
    df -l -x tmpfs -x devtmpfs --output=target,pcent | tail -n +2
}
