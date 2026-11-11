#!/usr/bin/env bash
# Builds servlet/hotel.war (needs JDK 8+ and curl)
set -e; cd "$(dirname "$0")/servlet"
M=https://repo1.maven.org/maven2
mkdir -p lib build/WEB-INF/classes build/WEB-INF/lib
[ -f lib/servlet-api.jar ] || curl -L -o lib/servlet-api.jar $M/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar
[ -f lib/mysql.jar ] || curl -L -o lib/mysql.jar $M/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar
javac -cp lib/servlet-api.jar -d build/WEB-INF/classes src/api/RoomServlet.java
cp WEB-INF/web.xml build/WEB-INF/ && cp lib/mysql.jar build/WEB-INF/lib/
(cd build && jar cf ../hotel.war .)
echo "Built servlet/hotel.war -> copy to Tomcat 9 webapps/ and start Tomcat"
