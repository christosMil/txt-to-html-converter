#!/bin/bash

#Bash program that converts simple .txt files to .html files
#author: Christos Milarokostas
#date: 02/06/2018

#For modified output
BOLD="\033[0;1m"
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
NO_MODIFICATION="\033[0m"

#input parameters
argc=$#

#check if parameters are 2
if [ $argc -ne 2 ]
then
  echo -e "${RED}Error! The parameters you entered are not valid, try this:"
  echo -e "$0 {root_dir} {text_file}"
  echo -e "Exiting MyWebCreator v0.1...${NO_MODIFICATION}"
  exit 0
fi

#valid number of parameters
echo -e "${BOLD}Welcome to MyWebCreator v0.1...${NO_MODIFICATION}"
root_dir=$1
text_file=$2

#check if directory exists and is valid
if [ -e $1 ]
then if [ -d $root_dir ]
  then
    echo -e "${GREEN}Success! $root_dir is a valid directory.${NO_MODIFICATION}"
  else
    echo -e "${RED}Error! $root_dir is not a valid directory."
    echo -e "Exiting MyWebCreator v0.1...${NO_MODIFICATION}"
    exit 0
  fi
else
  echo -e "${YELLOW}Warning: $root_dir does not exists.${NO_MODIFICATION}"
  echo -e "${GREEN}Creating $root_dir...${NO_MODIFICATION}"
  mkdir $root_dir;
  echo -e "${GREEN}Success! $root_dir was created.${NO_MODIFICATION}"
fi

#check if text_file exists and is valid
if [ -e $2 ]
then  if [ -f $text_file ]
  then
    echo -e "${GREEN}Success! $text_file is a valid textfile.${NO_MODIFICATION}"
  else
    echo -e "${RED}Error! $text_file is not a valid textfile."
    echo -e "Exiting MyWebCreator v0.1...${NO_MODIFICATION}"
    exit 0
  fi
else
  echo -e "${RED}Error! $text_file does not exists."
  echo -e "Exiting MyWebCreator v0.1...${NO_MODIFICATION}"
  exit 0
fi

#check if directory is empty
if [[ "$(ls -A $root_dir)" ]]
then
    echo -e "${YELLOW}Warning: directory is full, what to do?"
    echo -e "0. Purge"
    echo -e "1. Leave as is${NO_MODIFICATION}"
    read userChoice
    if [ "$userChoice" -eq "0" ]
    then
      echo -e "${GREEN}Directory is full, purging...${NO_MODIFICATION}"
      rm -rf $root_dir/*
    fi
  else
    echo -e "${GREEN}Directory is empty!${NO_MODIFICATION}"
fi

#create web page
text_file2=${text_file::-4}
echo -e "${GREEN}Creating web page $root_dir/$text_file2.html...${NO_MODIFICATION}"
touch $root_dir/$text_file2.html
echo "<!DOCTYPE html>" > $root_dir/$text_file2.html
#from now on append!!!
echo "<html>" >> $root_dir/$text_file2.html
echo "  <body>" >> $root_dir/$text_file2.html
#fill the html body
while IFS='' read -r line || [[ -n "$line" ]]
do
  echo "  <br>$line" >> $root_dir/$text_file2.html
done < "$2"
echo "  </body>" >> $root_dir/$text_file2.html
echo "</html>" >> $root_dir/$text_file2.html

#Success!
echo -e "${GREEN}Success! $text_file was converted to $text_file2.${NO_MODIFICATION}"

#Goodbye!
echo -e "${GREEN}Done.${NO_MODIFICATION}"
