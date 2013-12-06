#!/bin/bash
BACKEND="xinu135"
RDSERVER_PORT=10000
basedir=`pwd`
echo $basedir

skipped=0

if [ $# -eq 1 ]
then
  echo "Skip until " $1
fi


grading_ts=`date +"%F_%T"`

echo "Timestamp: $grading_ts"

selective_start=0

for submission in *
do
  cd "$basedir"
  if [ -d "$submission" ]; then
    echo $submission
  else
    continue
  fi
    
  if [ $# -eq 1 ]
  then
    if [ $1 = $submission  ] || [ $selective_start -eq 1 ];
    then
      echo "start from " $1
      selective_start=1
    else
      echo "skip" $1
      continue
    fi
  fi

  cd $basedir/$submission

  XINUSRC=`ls -d *`

  if [ $? -eq 0 ]; then
    echo "XINUSRC is set to $XINUSRC" 
  else
    echo "\$XINUSRC undefined"
  fi

  cd $XINUSRC
  echo "at " `pwd`
  if [ ! -e system/_orig_main.c ]; then
    cp system/main.c system/_orig_main.c
  fi

  mv system/main.c system/main.c.$grading_ts

  # patch rdserver port number
  ../../../patch_rdserver_port.sh


  # patch bug 
  #cp ../../../new_xdone.c system/xdone.c
  #cp ../../../new_kprintf.c system/kprintf.c

  cp ../../../testcases/lab6_testcase.c system/main.c
  cp ../../../testcases/lab6_hooks.c system/hooks.c

  #echo "Pause before patching main.c"
  #read choice
  cd rdserver/
  make
  cd ..
  cd compile/

  if [ $? -ne 0 ]; then
    echo "compile/ subdirectory not found. error and don't grade"
    continue;
  fi

  retry_compile='y'
  while [ $retry_compile == 'y' ]; do
    make clean all > ../make.log
    if [ $? -eq 0 ]; then
      break
    else
      echo "can't compile. retry? (y/n)"
      read retry_compile
      #retry_compile='n'
    fi
  done

  if [ $retry_compile != 'y' ]; then
    echo "code does not compile. give up. move up to the next student";
    continue
  fi

  # start the remote backend machine
  rm -f ../rdserver/backing_store
  ../rdserver/rdserver $RDSERVER_PORT &> ../rdserver.log &

  # start the kernel
  ../../../../manual-run.exp $BACKEND xinu | tee ../grading.log


  killall rdserver
  sleep 5
done
