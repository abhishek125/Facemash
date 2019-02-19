# Facemash
This is a simple social networking project. it has features similar to facebook such as sending friend request, like, comment, share on friend's activities. users can also send multimedia messages or block other users,they can edit their profile or post status update which will be shown to their friends.

## possible enhancements
* peer to peer chat feature so users can chat with their friends.
* privacy setting for users so they can control who can send them messages and friend requests.

## Technologies
* Backend: Java 8 with Spring
* Frontend: jsp
* Database: MySQL
* ORM: Hibernate
* Security: Spring Security

## Requirements
* tomcat 7+,jdk 1.7+ ,mysql 5.6+

## Setup
* Install system dependencies: latest versions (at the time of this writing) of Java,tomcat and MySQL.If you are not using eclipse
then you also need to install maven.
* Update src/main/resources/hibernate.xml with your MySQL credentials. Default username is "root" and password is "123".
* Execute src/main/java/sql/fb.sql to create the database
* Run "mvn package" from the root of application directory which creates a war file located under {projectname}/target/ ,
  copy & paste this war file to Tomcats "webapps" directory.
* if you are using eclipse then skip previous step instead just import this project into eclipse and right click project -> run as -> run     on server.
* Start tomcat and visit http://localhost:8080/Facemash/

## note

we would not store user uploaded files inside the webapp(why? http://bit.ly/2sLfXwf) instead we would store all the user uploaded files in "c:/uploads/" which can be changed by modifying server.xml inside "server" directory of your eclipse workspace or under "conf" directory inside your tomcat installation directory if you are not using eclipse workspace.you also need to set environment variable UPLOAD_LOCATION to the value of your preferred location.

## video demo link
http://bit.ly/2giN7TL

## demo
http://ec2-54-187-58-32.us-west-2.compute.amazonaws.com:8080/Facemash/
