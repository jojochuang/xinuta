#!/bin/bash
for submission in *
do
	echo $submission
	#echo `expr match "$submission" '.*\.sh$' `
	if [ 0 -eq  `expr match "$submission" '.*\.sh$' ` ]
	then
		uncompress $submission
		#echo "prefix=" ${submission/\.Z/}
		prefix=${submission/\.Z/}
		mv $prefix $prefix.tar
		mkdir $prefix
		tar xf $prefix.tar -C $prefix 
		
		#for labdir in *
		#do
		#	if [ `expr match $lab` ]
		#done


		#cd ..
    rm $prefix.tar
	else
		echo "$submission's a shell script"
	fi 
done
