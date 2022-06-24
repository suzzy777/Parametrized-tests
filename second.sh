#!/bin/bash

CWD="$(pwd)"
for f in $(cat hasparams.csv | cut -d'[' -f1 | sort -u)  
do
    project=$(echo $f | cut -d',' -f1)                                           
                                                                              
    if [[ "Project_Name" == "$project" ]]; then count2="Maximum instances of parameters";echo $f,$count2; unset count2; cd "$CWD"; continue; fi;                    
                                                                              
    url=$(echo $f | cut -d',' -f2)                                               
    sha=$(echo $f | cut -d',' -f3)                                               
    od_test=$(echo $f | cut -d',' -f4)                                           
    od_file_name=$(echo $od_test | cut -d':' -f1)                                
    od_file=$(echo $od_file_name | rev | cut -d'/' -f1  | rev)                   
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
    
    #git clone $url 
    

    #cd $project                                                                 

    count2=$(python3 s.py $project/$od_test_name"_"$project.csv)
    #count=$(cat $od_test_name"_"$project.csv | wc -l)       
    #count2=`expr $count - 1`                          
    if [[ $count2 == "" ]];then count2="EMPTY";fi;                                              
    echo $f,$count2                                   
                                                  
    #echo "$count2"                                   
    #unset count                                       
    unset count2                                      
                                                  
    cd "$CWD"

done
