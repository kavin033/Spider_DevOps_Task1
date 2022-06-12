#!/bin/bash

file="/home/School"
chmod 777 /home/School

if [[  $# -eq 0 ]];
then
	for i in {1..5}
	do
		sudo useradd -m -d ${file}/class_${i} teacher_${i}
        groupadd -f class_${i}
        sudo touch ${file}/class_$i/teachernotice.txt
        sudo touch ${file}/class_$i/principlenotice.txt
        for j in {1..5}
        do
            groupadd -f class_${i}_${j}
            sudo useradd -m -d ${file}/class_$i/student_$j student_${i}_${j}
            sudo touch ${file}/class_$i/student_$j/Student_marks.txt
            sudo touch ${file}/class_$i/student_$j/Student_attendence.txt
        done
    done
fi
