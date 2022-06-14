grep -F '[' Test_Status.csv > hasparams.csv

grep -F '[' hasparams.csv | cut -d, -f1-4 | cut -d'[' -f1 | sort | uniq -c | sed 's/ //g' | sed 's/"//g' | sed 's/[a-zA-Z]/,&/' > howmanyparams.csv
