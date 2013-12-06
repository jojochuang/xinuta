#!/bin/bash
#Script to generate the grading report

user=default
grading_dir=lab4grades
if [ ! -d $grading_dir ]; then
        mkdir $grading_dir
fi
while [ "$user" != "done" ]; do
        #comments="Lab4 Grade : \nHW2 Grade : \nTotal Grade : \n\n\nLab4 Comments (250 pts)\n------------------------\n"
        comments="\n\n\nLab4 Comments (250 pts)\n------------------------\n"
        score=250
        echo "Enter the username "
        read user
        if [ $user == "done" ]; then
                break
        fi

        echo "Test 1"
        echo "Verifying vcreate() is implemented and does not crash [25]?"
        read choice
        if [ $choice == 'n' ]; then
                score=$(($score-25))
                comments=$comments"Test1 vcreate() is implemented and does not crash failed : -25 pts\n"
        fi

        echo "Test 2"
        echo "Verifying you can create/read/write mapped address in vcreate() process [25]?"
        read choice
        if [ $choice == 'n' ]; then
                score=$(($score-25))
                comments=$comments"Test2 Create/read/write mapped address in vcreate() process failed : -25 pts\n"
        fi

        echo "Test 3"
        echo "Verifying each process (create()) has its own page directory [25]?"
        read choice
        if [ $choice == 'n' ]; then
                score=$(($score-25))
                comments=$comments"Test3 verifying each process (create()) has its own page directory failed : -25 pts\n"
        fi

        echo "Test 4"
        echo "Verifying vgetmem() returns address in private heap (>= 4096th page) [25]?"
        read choice
        if [ $choice == 'n' ]; then
                score=$(($score-25))
                comments=$comments"Test4 verifying vgetmem() returns address in private heap (>= 4096th page) failed : -25 pts\n"
        fi

        echo "Test 5"
        echo "Verifying xmmap option MAP_PRIVATE does work [25]?"
        read choice
        if [ $choice == 'n' ]; then
                score=$(($score-25))
                comments=$comments"Test5 Verifying xmmap option MAP_PRIVATE does work failed : -25 pts\n"
        fi

        echo "Test 6"
        echo "Verifying each process (vcreate()) has its own page directory [25]?"
        read choice
        if [ $choice == 'n' ]; then
                score=$(($score-25))
                comments=$comments"Test6 verifying each process (vcreate()) has its own page directory failed : -25 pts\n"
        fi

        echo "Test 7"
        echo "Verifying xmmap/write/xmunmap/read works and can be remapped by another vcreate() process [25]?"
        read choice
        if [ $choice == 'n' ]; then
                score=$(($score-25))
                comments=$comments"Test7 verifying xmmap/write/xmunmap/read works and can be remapped by another vcreate() process failed : -25 pts\n"
        fi

        echo "Test 8"
        echo "Verifying invalid memory access kills() the vcreate() process [25]?"
        read choice
        if [ $choice == 'n' ]; then
                score=$(($score-25))
                comments=$comments"Test8 verifying invalid memory access kills() the vcreate() process failed : -25 pts\n"
        fi

        echo "Test 9"
        echo "Verifying kill() cleans up mappings and deallocates vcreate() process [25]?"
        read choice
        if [ $choice == 'n' ]; then
                score=$(($score-25))
                comments=$comments"Test9  Verifying kill() cleans up mappings and deallocates vcreate() process failed: -25 pts\n"
        fi

        echo "Test 10"
        echo "Verifying frame replacement policy using vcreate() process [25]?"
        read choice
        if [ $choice == 'n' ]; then
                score=$(($score-25))
                comments=$comments"Test10 verifying frame replacement policy using vcreate() process failed : -25 pts\n"
        fi

        echo "Other Comments ?"
        read choice
        if [ $choice == 'y' ]; then
                comments=$comments"\nOTHER COMMENTS\n---------------\n"
        fi

        if [ -d $grading_dir/$user ]; then
                rm -r $grading_dir/$user
        fi
        mkdir $grading_dir/$user
        echo -ne $"Lab4 Score (250 Pts) : $score\n\n" >> $grading_dir/$user/lab4.rpt
        #echo $comments
        echo -ne $"$comments" >> $grading_dir/$user/lab4.rpt

done

echo "done grading !!!"



