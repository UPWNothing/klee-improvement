#!/bin/bash

cd "$1"/lava-install/bin
klee --allow-external-sym-calls --use-query-log=all:kquery -debug-print-instructions=all:file --simplify-sym-indices --write-cvcs --write-cov --output-module --disable-inlining --optimize --use-forked-solver --use-cex-cache --libc=uclibc --posix-runtime --only-output-states-covering-new --max-sym-array-size=4096 --max-instruction-time=30. --max-time=18000. --watchdog --max-memory-inhibit=false --max-static-fork-pct=1 --max-static-solve-pct=1 --max-static-cpfork-pct=1 --switch-type=internal --search=random-path --search=nurs:covnew --use-batching-search --batch-instructions=10000 ./toy_test.bc A --sym-files 1 128 --sym-stdout
