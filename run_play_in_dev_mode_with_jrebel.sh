#!/bin/bash
cd play-java
JAVA_OPTS="-javaagent:/tmp/jrebel.jar -Drebel.log=true -Drebel.log.file=/var/log/jrebel.log -Drebel.license=/tmp/jrebel.lic -Drebel.packages_include=com.example.dependent" ./activator run
