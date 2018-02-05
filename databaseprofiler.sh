#!/bin/bash
# Use like this: ./databaseprofiler.sh path/to/file.txt numberofcolumnstoanalyze #rowstoanalyze
#TODO: add a quick bit up here to count the number of columns in CSV automatically


            head -$3 $1 >> tempcsv.txt

        for i in `seq 1 $2`;
        do
                echo "Starting Column #"$i" out of "$2" from file "$1
                COLUMN_HEADER=$(cat tempcsv.txt | awk -F "\"*,\"*" 'NR==1{print $'$i'}')
                if [[ $(cat tempcsv.txt | awk -F "\"*,\"*" '{print $'$i'}' | grep -c '[A-Za-z]') > "1" ]]; then
                    #echo "NON-NUMERIC FOUND AT COLUMN #"$i" WITH COLUMN HEADER "$COLUMN_HEADER
                    echo $COLUMN_HEADER >> non_numeric.txt
                    echo "The non-numeric conversion for column #"$i" was caused by the string data found in "$(cat tempcsv.txt | awk -F "\"*,\"*" '{print $'$i'}' | grep '[A-Za-z]')
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
        rm tempcsv.txt