#!/bin/bash
java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005 -jar target/snake-game-1.0-SNAPSHOT.jar
