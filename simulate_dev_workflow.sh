#!/bin/bash
WD=`pwd`
WD_ESCAPED=`pwd | sed 's/\//\\\\\//g'`
cd dependent
sed -e 's/dir name="[^"]*"/dir name="'${WD_ESCAPED}'\/dependent\/build\/classes\/main"/' src/main/resources/rebel.xml.default > src/main/resources/rebel.xml

while true ; do
  sed --in-place src/main/java/com/dependent/Test1.java -e "s/\"[^\"]\+\"/\"`date`\"/"
  sed --in-place ../play-java/app/controllers/Application.java -e "s/\"My[^\"]\+\"/\"My                 time: `date`\"/"
  gradle compileJava
  sleep 5
done
