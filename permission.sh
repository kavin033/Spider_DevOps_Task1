#!/bin/bash

file="/home/School"

chown Principal:School ${file}
chmod 770 ${file}

chown Principal:School ${file}/notice.txt
chmod 740 ${file}/notice.txt

for j in $(ls -d class*)
do
    user=$(echo $j |cut -d '_' -f 2)
    chown teacher_${user}:${j} ${file}/${j}
    chown teacher_${user}:${j} ${file}/${j}/teachernotice.txt
    chown Principal:${j} ${file}/${j}/principlenotice.txt
    sudo usermod -aG $j Principal
    sudo setfacl -R -m u:Principal:rwx ${file}/$j
    sudo chmod 770 ${file}/${j}
    cd $j
    for i in $(ls -d student*)
    do
        stu=$(echo $i |cut -d '_' -f 2)
        chown student_${user}_${stu}:class_${user}_${stu} ${file}/${j}/${i}
        sudo chmod 770 ${file}/$j/$i
        sudo usermod -aG class_${user}_${stu} Principal
        sudo usermod -aG class_${user}_${stu} teacher_${user}
        sudo usermod -aG $j student_${user}_${stu}
        sudo chmod 777 ${file}/$j/$i/*.txt
        sudo setfacl -R -m u:Principal:rwx ${file}/$j/$i
        sudo setfacl -R -m u:teacher_${user}:rwx ${file}/$j/$i
    done
    cd ..
    sudo chmod 740 ${file}/${j}/teachernotice.txt
    sudo chmod 740 ${file}/${j}/principlenotice.txt
done