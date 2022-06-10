#!bin
#set -x
#cd torchpwl
#cd torchpwl

##abc=$(cat pwl_test.py | grep -B 10 "def test_pwl_is_continous" | grep "@pytest.mark.parametrize(" | cut -d'[' -f2)

##efg=$(cat pwl_test.py | grep -B 10 "def test_pwl_is_continous" | grep "@pytest.mark.parametrize(" | cut -d'[' -f2 | cut -d$'\n' -f1)

#echo $efg

##cd=$(echo "$abc" | tr -cd , | wc -c)

#cd=$(echo "$abc" | tr -cd , | wc -c)
##ef=$(echo "$abc" | tr -cd "\n")
#echo "$cd"
#for g in $abc;do
	# echo $g
#done
#echo "$ef"
#echo "total instances it can take:"

#num=`expr $cd + $ef`
#echo $num
#for f in $(cat hasparameters.csv);do
	 
 #   od_test=$(echo $f | cut -d',' -f4)
  #  od_file_name=$(echo $od_test | cut -d':' -f1)
   # od_file=$(echo $od_file_name | rev | cut -d'/' -f1 | rev)
    #od_test_name=$(echo $od_test | rev | cut -d':' -f1 | rev)

#    echo "$od_test"
 #   echo "$od_file_name"
  #  echo "$od_file"
   # echo "$od_test_name"

#done
for f in $(cat cloudntpy.csv |cut -d',' -f1-4)
do
    project=$(echo $f | cut -d',' -f1)

    if [[ "Project_Name" == "$project" ]]; then continue; fi;
    
    url=$(echo $f | cut -d',' -f2)
    sha=$(echo $f | cut -d',' -f3)
    od_test=$(echo $f | cut -d',' -f4)
    od_file_name=$(echo $od_test | cut -d':' -f1)
    od_file=$(echo $od_file_name | rev | cut -d'/' -f1 | rev)
    od_test_name=$(echo $od_test | rev | cut -d':' -f1 | rev | cut -d'[' -f1)
    file_loc=$(echo $od_file_name | rev | cut -d'/' -f2- | rev)

    #echo "$od_test"
    #echo "$od_file_name"
    echo "$project"
   # if [[ "Project_Name" == "$project" ]];then continue;
	
    echo "$url"
    echo "$od_file"
    echo "$od_test"
    echo "$od_test_name"

    git clone $url

    cd $project
    cd $file_loc
    git reset --hard $sha
    git rev-parse HEAD
    
      #| rev | cut -d':' -f1 | rev | cut -d'[' -f1 | sort -u );do
    #echo $f
    abc2=$(cat $od_file)
    if cat "$od_file" |  grep -B 5 "def $od_test_name(" | grep -q "@pytest.mark.parametrize"
    then
	abc=$(cat "$od_file" | grep -B 5 "def $od_test_name(" | grep -F "[" | cut -d'[' -f2)
    elif cat "$od_file" | grep -q "@pytest.fixture(param"
    then
	abc=$(cat "$od_file" | grep -C 1 "@pytest.fixture(param" | cut -d'[' -f2)
    fi  
    echo "$abc"   
    #$(cat "$od_file" | grep -B 10 "def $od_test_name" | grep "@pytest.mark.parametrize(" |  cut -d'[' -f2)
    #abc=$(cat pwl_test.py | grep -B 10 "def test_pwl_is_continous" | grep "@pytest.mark.parametrize(" |  cut -d'[' -f2)
    #echo $abc
    IFS=$'\n'
    myarray=()
    for g in $abc;do
	#myarray=1
	#$abc;do
	cd=$(echo "$g" | tr -cd , | wc -c )
	num=`expr $cd + 1`
	# cut -d$'\n' -f
	echo "==="
	echo $num
	
	myarray+=("$num")
	#echo $(let "myarray*=("$num")")
	# echo $myarray
	

	#echo $g
    done
    echo ${myarray[@]}
    mul=1
    for i in ${myarray[@]};do
	((mul *= i))
    done
    echo "$mul"
    echo "====================================="
    abc=()
done



   

