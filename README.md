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

## video demo link
http://bit.ly/2giN7TL

## demo
http://ec2-54-187-58-32.us-west-2.compute.amazonaws.com:8080/Facemash/
