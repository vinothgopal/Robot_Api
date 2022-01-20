#!/bin/bash

echo "#######################################"
echo "# Cleaning workspace                  #"
echo "#######################################"
rm -fr Results
mkdir Results

echo "#######################################"
echo "# Running tests first time            #"
echo "#######################################"
robot -d Results Test_Suites/

if [ "$?" -eq "0" ]; then
    echo "#######################################"
    echo "# Tests passed, no rerun #"
    echo "#######################################"
    exit
fi
cp Results/log.html Results/first_run_log.html

echo "#######################################"
echo "# Running again the tests that failed #"
echo "#######################################"
robot --nostatusrc --outputdir Results --rerunfailed Results/output.xml --output rerun.xml Test_Suites/

cp Results/log.html Results/second_run_log.html


echo "########################"
echo "# Merging output files #"
echo "########################"
rebot --nostatusrc --outputdir Results --output output.xml --merge Results/output.xml Results/rerun.xml

