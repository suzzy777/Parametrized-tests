#!/bin/bash                                                                              
#set -x                                                                                 
#pip install pytest                                                                       
#pip install pytest-csv                                                                   
                                                                                         
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
#awk '{print "$4}' paramsmd5.csv                                                         


for f in $(cat paramsmd5.csv | cut -d'[' -f1 | sort -u )                                 
do                                                                                       
    project=$(echo $f | cut -d',' -f1)                                                   
                                                                                         
    if [[ "Project_Name" == "$project" ]]; then continue; fi;                            
                                                                                         
    url=$(echo $f | cut -d',' -f2)                                                       
    sha=$(echo $f | cut -d',' -f3)                                                       
    od_test=$(echo $f | cut -d',' -f4)                                                   
    od_file_name=$(echo $od_test | cut -d':' -f1)                                        
    od_file=$(echo $od_file_name | rev | cut -d'/' -f1  | rev)                           
    #od_test_name=$(echo $od_test | rev | cut -d':' -f1 | rev | cut -d'[' -f1)           
    od_test_name=$(echo $od_test | rev | cut -d'[' -f2 | rev)                            
    file_loc=$(echo $od_file_name | rev | cut -d'/' -f2- | rev)                          
    md5sum=$(echo $f | cut -d',' -f10)

    ab=$(grep $od_test resultt.csv); var2=""; for gg in $ab; do cd=$(echo $gg | cut -d'[' -f2- | cut -d']' -f1); var2="  $var2 | $cd ";var3="[$var2]";done;fin=$(echo $var3 | sed 's/\[ | /\[ /g' | sed 's/-/;/g' );   
                                                                                                                                                                                                                                                    
    cd=$(grep $od_test resultt.csv | cut -d, -f11 | sort -u)

    #echo $cd
    ef=$(grep $od_test howmanyparams.csv | cut -d, -f1)
    if [[ "$ef" == "$cd" ]]
    then
	continue;
    else
	
	echo $f,$fin,$cd | sed 's/"//g'                   
    fi                                                                               


    #echo "$od_test"                                                                     
    #echo "$od_file_name"                                                                
    ##echo "$project"                                                                    
   # if [[ "Project_Name" == "$project" ]];then continue;                                
                                                                                         
    ##echo "$url"                                                                        
    ##echo "$od_file"                                                                    
    ##echo "$od_test"                                                                    
    ##echo "$od_test_name"                                                               
                                                                                         
done
