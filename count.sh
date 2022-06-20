#!/bin/bash
##set -x
pip install pytest
pip install pytest-csv

CWD="$(pwd)"
ls
awk -v OFS=',' '{
    cmd = "echo \047" $0 "\047 | md5sum"
    val = ( (cmd | getline line) > 0 ? line : "FAILED")
    close(cmd)
    sub(/ .*/,"",val)
    print $0, val
}' hasparams.csv > paramsmd5.csv

headr_m=$(awk -F, 'NR == 1 { print $10}' paramsmd5.csv)
sed -i -e '1s/'$headr_m'/md5sum/'  paramsmd5.csv

for f in $(cat paramsmd5.csv | sort -u)
do
    project=$(echo $f | cut -d',' -f1)

    if [[ "Project_Name" == "$project" ]]; then continue; fi;
    
    url=$(echo $f | cut -d',' -f2)
    sha=$(echo $f | cut -d',' -f3)
    od_test=$(echo $f | cut -d',' -f4)
    od_file_name=$(echo $od_test | cut -d':' -f1)
    od_file=$(echo $od_file_name | rev | cut -d'/' -f1	| rev)
    #od_test_name=$(echo $od_test | rev | cut -d':' -f1 | rev | cut -d'[' -f1)
    od_test_name=$(echo $od_test | rev | cut -d'[' -f2 | rev)
    file_loc=$(echo $od_file_name | rev | cut -d'/' -f2- | rev)
    md5sum=$(echo $f | cut -d',' -f10)

    #echo "$od_test"
    #echo "$od_file_name"
    ##echo "$project"
   # if [[ "Project_Name" == "$project" ]];then continue;
	
    ##echo "$url"
    ##echo "$od_file"
    ##echo "$od_test"
    ##echo "$od_test_name"

    git clone $url

    cd $project
    #cd $file_loc
    git reset --hard $sha
    git rev-parse HEAD

    #pipfile freeze -o
    pip install -U -r requirements.txt
    pip install -U -r test_requirements.txt
    pip install -U -r requirements-dev.txt
    pip install -U -r test-requirements.txt
    pip install -U -r requirements-docs.txt
    pip install -U -r optional-requirements.txt
    pip install -U -r requirements-pip.txt
    pip install -U -r requirements-test.txt
    pip install .

    python3 -m pytest $od_test_name --csv $md5sum"_"$project.csv
    
    #bpi=$(find $file_loc -name

    count=$(cat $md5sum"_"$project.csv | wc -l)
    count2=`expr $count - 1`

    echo $f,$count2
    
    #echo "$count2"
    unset count
    unset count2

    cd "$CWD"
    #bpr=$(grep -F "$od_test_name", $sha_$project.csv | cut -d, -f)
    #echo $f,$count2
done
