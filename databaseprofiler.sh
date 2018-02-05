#!/bin/bash
# Use like this: ./databaseprofiler.sh path/to/file.txt numberofcolumnstoanalyze maxrows
#TODO: add a quick bit up here to count the number of columns in CSV automatically
#TODO: add a "max row sample count" parameter to help with performance  ~~ DONE

        for i in `seq 1 $2`;
        do
                echo "Starting Column #"$i" out of "$2 
                #cat $1 | awk -F "\"*,\"*" '{print $'$i'}' | grep -c '[A-Za-z]'
                COLUMN_HEADER=$(cat $1 | awk -F "\"*,\"*" 'NR==1{print $'$i'}')
                #if [[ $(cat $1 | sed -n 1,$3p | awk -F "\"*,\"*" '{print $'$i'}' | grep -c '[A-Za-z]') > "1" ]]; then
                if [[ $(head -$3 $1 | awk -F "\"*,\"*" '{print $'$i'}' | grep -c '[A-Za-z]') > "1" ]]; then
                    #echo "NON-NUMERIC FOUND AT COLUMN #"$i" WITH COLUMN HEADER "$COLUMN_HEADER
                    echo $COLUMN_HEADER >> non_numeric.txt
                else
                    #echo "NUMBERIC ONLY CHARACTERS IN COLUMN #"$i" WITH COLUMN HEADER "$COLUMN_HEADER
                    echo $COLUMN_HEADER >> numeric.txt
                fi
                echo "Finished Column #"$i" out of "$2 
        done  

        echo "-----------------------------"
        echo "-----------------------------"
        echo "-LIST OF NON NUMERIC COLUMNS-"
        echo "-----------------------------"
        echo "-----------------------------"
        cat non_numeric.txt
        echo "-----------------------------"
        echo "-----------------------------"
        echo "-----------------------------"
        echo "-----------------------------"
        echo "-----------------------------"
        echo "-----------------------------"
        echo "-----------------------------"
        echo "-----------------------------"
        echo "-----------------------------"
        echo "-----------------------------"
        echo "-----------------------------"
        echo "-----------------------------"
        echo "---LIST OF NUMERIC COLUMNS---"
        echo "-----------------------------"
        echo "-----------------------------"
        cat numeric.txt
        rm numeric.txt
        rm non_numeric.txt