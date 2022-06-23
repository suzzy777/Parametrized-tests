#!/bin/bash
#set -x
pip install pytest
pip install pytest-csv

CWD="$(pwd)"

#awk '{print "$4}' paramsmd5.csv 
#cat resultt.csv | cut -d'[' -f2- | cut -d']' -f1 |  sort -u
for f in $(cat hasparams.csv | cut -d'[' -f1 | sort -u)
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

    #ab=$(grep "tests/test_routing.py::TestRouting::test_jwt_route" resultt.csv);for gg in $ab;do cd=$(echo $gg | cut -d'[' -f2- | cut -d']' -f1);echo $cd;done;
    #ab=$(grep "tests/test_routing.py::TestRouting::test_jwt_route" resultt.csv); var2="["; for gg in $ab; do cd=$(echo $gg | cut -d'[' -f2- | cut -d']' -f1); echo $cd;var2="  $var2 | $cd ";done;echo $var2;

    #ab=$(grep "tests/test_routing.py::TestRouting::test_jwt_route" resultt.csv); var2=""; for gg in $ab; do cd=$(echo $gg | cut -d'[' -f2- | cut -d']' -f1); echo $cd;var2="  $var2 | $cd ";var3="[$var2]";done;echo $var3 | sed 's/\[ | /\[ /g'; 

    #grep "tests/test_routing.py::TestRouting::test_jwt_route" resultt.csv | cut -d, -f11 |  sort -u
    
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

    python3 -m pytest $od_test_name --csv $od_test_name"_"$project.csv
    #bpi=$(find $file_loc -name

    count=$(cat $od_test_name"_"$project.csv | wc -l)
    count2=`expr $count - 1`

    echo $f,$count2
    
    #echo "$count2"
    unset count
    unset count2
    
#    $(echo $f | cut -d'[' -f1 | sort | uniq -c | sed 's/ //g' | sed 's/"//g' | sed 's/[a-zA-Z]/,&/')                                                                                                                                                    
    cd "$CWD"
    #bpr=$(grep -F "$od_test_name", $sha_$project.csv | cut -d, -f)
    #echo $f,$count2
done
