/*
SQLyog Community v11.27 (64 bit)
MySQL - 5.5.35-0ubuntu0.13.10.2 : Database - SPAForum
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

USE ist331;

/*Table structure for table forums */
CREATE TABLE forums (
  id int NOT NULL IDENTITY(1,1) ,
  topics int DEFAULT NULL,
  posts int DEFAULT NULL,
  name varchar(128) NOT NULL,
  description text,
  position int DEFAULT NULL,
  PRIMARY KEY (id)
);

/*Data for the table forums */

/*Table structure for table members */
CREATE TABLE members (
  id int NOT NULL IDENTITY(1,1) ,
  name varchar(255) NOT NULL,
  member_group_id int NOT NULL,
  email varchar(150) NOT NULL,
  joined datetime NOT NULL,
  password_hash varchar(32) NOT NULL,
  banned int NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
);

/*Data for the table members */

/*Table structure for table posts */

CREATE TABLE posts (
  pid int NOT NULL IDENTITY(1,1) ,
  author_id int NOT NULL,
  author_name varchar(255) DEFAULT NULL,
  post_date datetime NOT NULL,
  post text,
  topic_id int NOT NULL,
  PRIMARY KEY (pid)
);

/*Data for the table posts */

/*Table structure for table topics */

CREATE TABLE topics (
  tid int NOT NULL IDENTITY(1,1) ,
  title varchar(250) NOT NULL,
  state varchar(8) DEFAULT NULL,
  starter_id int NOT NULL,
  start_date datetime NOT NULL,
  forum_id int NOT NULL,
  PRIMARY KEY (tid)
) ;

/*Data for the table topics */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
