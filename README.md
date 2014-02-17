xinuta
======

(For lab5-part2) Put lab6_testcase.c and lab6_hooks.c into testcases/ directory

Run ./autograde.sh 

This script automatically uncompress turnin files into separate directories. Also, it initiates grader script

To manually grader a student's lab, 

run ./grader.sh  *student_id*

This script starts rdserver at port 10000, and it also copies lab6_testcase.c and hooks.c into system/main.c and system/hooks.c respectively. Finally it patches port number to 10000 and change NFRAMES macro to 50.
