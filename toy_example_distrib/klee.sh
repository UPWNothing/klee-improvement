#!/bin/bash

lavasuccess=(2 3 4 8 10 12 17 21 22 28 29 32 33 39 40 41 42 51 52 55 59 65 66 67 69 71 77 81 86 87 90 92 100 101 102 104 112 113 116 117 125 126 130 131 132 135 137 138 139 142 143 145 150 151 152 155 156 159 162 167 168 169 170 174 176 178 181 184 185 188 190 193 194 196 197 201 204 208 213 214 216 219 220 221 226 227 229 232 239 243 245 246 251 253 254 258 265 266 267 268 272 273 274 276 277 281 284 285 286 290 291 292 293 294 296 297 303 305 307 309 312 313 314 321 325 331 332 333 334 335 341 342 343 344 346 348 349 351 352 353 354 355 357 358 359 365 372 373 375 379 388 390 391 393 398 401 402 403 405 );
((total = 0))
((succeed = 0))
((count = 0))

if [ ! -e "output.txt" ]
then
  mk ouput.txt
fi
echo "Result:" > output.txt 

echo "" > log.txt

BASEDIR="$PWD"

for n in ${lavasuccess[*]}; do
  #echo "$n";
  D="buggy/$n"
  #echo "$D"
  if [ -d "$D" ] #&& [ $(basename "$D") -eq "8" ]
    then
      #echo "$D"
      (
      echo "START: $n"
      cd $BASEDIR/$D/toy
      clang -g -c -emit-llvm toy.c &>>$BASEDIR/log.txt
      klee_I --allow-external-sym-calls --use-query-log=all:kquery -debug-print-instructions=all:file --simplify-sym-indices --write-cvcs --write-cov --output-module --disable-inlining --optimize --use-forked-solver --use-cex-cache --libc=uclibc --posix-runtime --only-output-states-covering-new --max-sym-array-size=4096 --max-instruction-time=30. --max-time=18000. --watchdog --max-memory-inhibit=false --max-static-fork-pct=1 --max-static-solve-pct=1 --max-static-cpfork-pct=1 --switch-type=internal --search=random-path --search=nurs:covnew --use-batching-search --batch-instructions=10000 ./toy.bc A --sym-files 1 128 --sym-stdout &>>$BASEDIR/log.txt 
      
      count=`ls -1 klee-last/*.err 2>/dev/null | wc -l`
      if [ $count != 0 ]
      then
        echo "$(basename "$D") succeed" >> $BASEDIR/output.txt
        ((succeed++))
      else
        echo "$(basename "$D") failed" >> $BASEDIR/output.txt
      fi 
      rm -rf klee-out-*
      rm toy.bc
      rm klee-last
      echo "END: $n"
      )&
  fi
  ((total++)) 
  ((count++))
  if [ $count == 20 ]
  then
    wait
    ((count=0))
  fi
done
wait
cd $BASEDIR
echo "$succeed succeed / $total total" >> output.txt

