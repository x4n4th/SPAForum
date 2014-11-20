﻿USE [master]
GO
/****** Object:  Database [ist421]    Script Date: 4/30/2014 4:03:48 PM ******/
CREATE DATABASE [ist421]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ist421', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ist421.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ist421_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ist421_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ist421] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ist421].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ist421] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ist421] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ist421] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ist421] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ist421] SET ARITHABORT OFF 
GO
ALTER DATABASE [ist421] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ist421] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ist421] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ist421] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ist421] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ist421] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ist421] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ist421] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ist421] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ist421] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ist421] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ist421] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ist421] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ist421] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ist421] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ist421] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ist421] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ist421] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ist421] SET RECOVERY FULL 
GO
ALTER DATABASE [ist421] SET  MULTI_USER 
GO
ALTER DATABASE [ist421] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ist421] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ist421] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ist421] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ist421', N'ON'
GO
USE [ist421]
GO
/****** Object:  User [ist421]    Script Date: 4/30/2014 4:03:48 PM ******/
CREATE USER [ist421] FOR LOGIN [ist421] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [ist421]
GO
ALTER ROLE [db_datareader] ADD MEMBER [ist421]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [ist421]
GO
/****** Object:  Table [dbo].[catagories]    Script Date: 4/30/2014 4:03:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[catagories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
PRIMARY KEY (id)
)

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[forums]    Script Date: 4/30/2014 4:03:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[forums](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[topics] [int] NULL,
	[posts] [int] NULL,
	[name] [varchar](128) NOT NULL,
	[description] [text] NULL,
	[position] [int] NULL,
	[catagorieId] [int] NOT NULL,
PRIMARY KEY (id),
CONSTRAINT fk_Catagories FOREIGN KEY (catagorieId)
REFERENCES catagories(id)
)

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[members]    Script Date: 4/30/2014 4:03:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[members](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[member_group_id] [int] NOT NULL,
	[email] [varchar](150) NOT NULL,
	[joined] [datetime] NOT NULL,
	[password_hash] [varchar](45) NOT NULL,
	[banned] [int] NOT NULL,
PRIMARY KEY (id) 
)
GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[session]    Script Date: 4/30/2014 4:03:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[session](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[session] [varchar](50) NOT NULL,
	[member_id] [int] NOT NULL,
	[date] [datetime] NOT NULL,
	PRIMARY KEY (id),
 CONSTRAINT fk_session_members FOREIGN KEY (member_id)
 REFERENCES members(id) 
)
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[topics]    Script Date: 4/30/2014 4:03:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[topics](
	[tid] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](250) NOT NULL,
	[state] [varchar](8) NULL,
	[starter_id] [int] NOT NULL,
	[start_date] [datetime] NOT NULL,
	[forum_id] [int] NOT NULL,
	[starter_name] [nchar](256) NULL,
	[views] [int] NOT NULL,
	[replies] [int] NOT NULL,
	[description] [varchar](50) NULL,
PRIMARY KEY (tid),
CONSTRAINT fk_topics_members FOREIGN KEY (starter_id)
REFERENCES members(id),
CONSTRAINT fk_topics_forumid FOREIGN KEY (forum_id)
REFERENCES forums(id)  
)
/****** Object:  Table [dbo].[posts]    Script Date: 4/30/2014 4:03:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[posts](
	[pid] [int] IDENTITY(1,1) NOT NULL,
	[author_id] [int] NOT NULL,
	[author_name] [varchar](255) NULL,
	[post_date] [datetime] NOT NULL,
	[post] [text] NULL,
	[topic_id] [int] NOT NULL,
PRIMARY KEY (pid),
CONSTRAINT fk_posts_authors FOREIGN KEY (author_id)
REFERENCES members(id),
CONSTRAINT fk_posts_topics FOREIGN KEY (topic_id)
REFERENCES topics(tid)
)

GO
SET ANSI_PADDING OFF
GO
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[catagories] ON 

INSERT [dbo].[catagories] ([id], [name]) VALUES (1, N'General')
INSERT [dbo].[catagories] ([id], [name]) VALUES (2, N'Off Topic')
SET IDENTITY_INSERT [dbo].[catagories] OFF
SET IDENTITY_INSERT [dbo].[forums] ON 

INSERT [dbo].[forums] ([id], [topics], [posts], [name], [description], [position], [catagorieId]) VALUES (1, NULL, NULL, N'General', N'General Stuff', 1, 1)
INSERT [dbo].[forums] ([id], [topics], [posts], [name], [description], [position], [catagorieId]) VALUES (2, NULL, NULL, N'Off Topic', N'Off Topic', 2, 1)
INSERT [dbo].[forums] ([id], [topics], [posts], [name], [description], [position], [catagorieId]) VALUES (3, NULL, NULL, N'Random 3rd Topic', N'Random 3rd Topic', 3, 1)
INSERT [dbo].[forums] ([id], [topics], [posts], [name], [description], [position], [catagorieId]) VALUES (4, NULL, NULL, N'TEst', N'test', 4, 1)
INSERT [dbo].[forums] ([id], [topics], [posts], [name], [description], [position], [catagorieId]) VALUES (5, NULL, NULL, N'Dee test', N'trt', 5, 2)
SET IDENTITY_INSERT [dbo].[forums] OFF
SET IDENTITY_INSERT [dbo].[members] ON 

INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (1, N'x4n4th', 1, N'lawl@lawl.com', CAST(0x0000A30300000000 AS DateTime), N'7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 0)
INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (5, N'test', 0, N'asdasd', CAST(0x0000A31A012980CF AS DateTime), N'7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 0)
INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (6, N'testing2', 0, N'asjldjaskd', CAST(0x0000A31A0124C2C4 AS DateTime), N'7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 0)
INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (8, N'mma', 0, N'mamamamamamam', CAST(0x0000A31A01251166 AS DateTime), N'7c4a8d09ca3762af61e59520943dc26494f8941b', 0)
INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (9, N'undefined', 0, N'undefined', CAST(0x0000A31A0138962A AS DateTime), N'd5d4cd07616a542891b7ec2d0257b3a24b69856e', 0)
INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (10, N'dee', 0, N'A@dee.com', CAST(0x0000A31B0024731C AS DateTime), N'7c4a8d09ca3762af61e59520943dc26494f8941b', 0)
INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (11, N'jhjjj', 0, N'jjjjjjj', CAST(0x0000A31C00144F63 AS DateTime), N'46c8e8dfa3a61fd39d81bfd1a475e13b8dc37ab7', 0)
SET IDENTITY_INSERT [dbo].[members] OFF
SET IDENTITY_INSERT [dbo].[posts] ON 

INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (1, 3, N'x4n4th', CAST(0x0000A30C00000000 AS DateTime), N'Hello Welcome to the forums', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (2, 3, N'x4n4th', CAST(0x0000A30B00000000 AS DateTime), N'FIRST!', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (5, 3, N'x4n4th', CAST(0x0000A31000000000 AS DateTime), N'First!..dsad I i mean awesome', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (6, 3, N'x4n4th', CAST(0x0000A31000000000 AS DateTime), N'Some some what meaningfull comment', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (7, 3, N'x4n4th', CAST(0x0000A30000000000 AS DateTime), N'This is more test data from before the topic was even made', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (8, 3, N'x4n4th', CAST(0x0000AB9300000000 AS DateTime), N'Im from the future!', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (9, 1, N'x4n4th', CAST(0x0000A31A00F16CAB AS DateTime), N'hello this is my first test post', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (10, 1, N'x4n4th', CAST(0x0000A31A00FA34C3 AS DateTime), N'sadfasdf', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (11, 1, N'x4n4th', CAST(0x0000A31A00FA4AA3 AS DateTime), N'This seems to work!', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (12, 1, N'x4n4th', CAST(0x0000A31A00FAEF5B AS DateTime), N'I though i would add something to this topic', 1011)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (13, 1, N'x4n4th', CAST(0x0000A31A00FBD487 AS DateTime), N'Testing if reply increments replies', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (14, 1, N'x4n4th', CAST(0x0000A31A011960E7 AS DateTime), N'test', 1011)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (15, 1, N'x4n4th', CAST(0x0000A31A011A7FB5 AS DateTime), N'testing...', 1011)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (16, 1, N'x4n4th', CAST(0x0000A31A011AF210 AS DateTime), N'More testing of the post function', 10)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (17, 1, N'x4n4th', CAST(0x0000A31A01212377 AS DateTime), N'Continued Testing', 8)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (18, 5, N'test', CAST(0x0000A31A012A2DB5 AS DateTime), N'Posting as TEST!~', 1011)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (19, 8, N'mma', CAST(0x0000A31A01253CFD AS DateTime), N'Snazy', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (21, 1, N'x4n4th', CAST(0x0000A31A014B6A9E AS DateTime), N'I just wanted to post something. This is pretty cool!', 8)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (22, 10, N'dee', CAST(0x0000A31B00259D87 AS DateTime), N'Deeeed', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (23, 10, N'dee', CAST(0x0000A31B0025F64A AS DateTime), N'we need a good comments for demo', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (24, 10, N'dee', CAST(0x0000A31B002815AB AS DateTime), N'Need to make a new user profile page', 10)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (25, 1, N'x4n4th', CAST(0x0000A31B00D9C6A5 AS DateTime), N'Another test for fun!', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (26, 1, N'x4n4th', CAST(0x0000A31B013B17FB AS DateTime), N'undefined', 0)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (27, 1, N'x4n4th', CAST(0x0000A31B013BFFFD AS DateTime), N'This should be the first post in that topic', 1014)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (28, 1, N'x4n4th', CAST(0x0000A31B013C1672 AS DateTime), N'And it was the first post in the topic!', 1014)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (30, 1, N'x4n4th', CAST(0x0000A31B013CE09E AS DateTime), N'rsgfsdfsd', 1013)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (31, 1, N'x4n4th', CAST(0x0000A31B01522A99 AS DateTime), N'alkjsdhfkjasdf', 4)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (32, 1, N'x4n4th', CAST(0x0000A31B01524E15 AS DateTime), N'asdASD', 1015)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (33, 1, N'x4n4th', CAST(0x0000A31C006C7D36 AS DateTime), N'Gigity', 1014)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (34, 1, N'x4n4th', CAST(0x0000A31C00D5C8BA AS DateTime), N'dfsgsdfgasdfasdfasdf', 1014)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (35, 1, N'x4n4th', CAST(0x0000A31C00D631A6 AS DateTime), N'Welcome!', 1016)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (36, 1, N'x4n4th', CAST(0x0000A31C00DA7F11 AS DateTime), N'Test', 1017)
SET IDENTITY_INSERT [dbo].[posts] OFF
SET IDENTITY_INSERT [dbo].[session] ON 

INSERT [dbo].[session] ([id], [session], [member_id], [date]) VALUES (62, N'fe19db440bf7662f72c0a3b43bf4af5b4e0e9244', 5, CAST(0x0000A31A012A2000 AS DateTime))
INSERT [dbo].[session] ([id], [session], [member_id], [date]) VALUES (63, N'18e45605452513f5380e7a84e06faa7f38ce3cc5', 6, CAST(0x0000A31A0124ED7A AS DateTime))
INSERT [dbo].[session] ([id], [session], [member_id], [date]) VALUES (107, N'455d4d177eeb0cacd8a49bcb899dad70e1ce4ea6', 1, CAST(0x0000A31C00E59176 AS DateTime))
INSERT [dbo].[session] ([id], [session], [member_id], [date]) VALUES (109, N'fae122ebb6374246cb2a8e2c686ab275b7038c3a', 8, CAST(0x0000A31C010C5C10 AS DateTime))
INSERT [dbo].[session] ([id], [session], [member_id], [date]) VALUES (112, N'ee5317b852147ae64dba3917713f377029dfa67e', 10, CAST(0x0000A31D00448F0E AS DateTime))
SET IDENTITY_INSERT [dbo].[session] OFF
SET IDENTITY_INSERT [dbo].[topics] ON 

INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (4, N'Welcome', N'open', 3, CAST(0x0000A30C00000000 AS DateTime), 1, N'x4n4th                                                                                                                                                                                                                                                          ', 129, 6, NULL)
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (6, N'Interesting tidbits', N'open', 3, CAST(0x0000A30D00000000 AS DateTime), 1, N'x4n4th                                                                                                                                                                                                                                                          ', 42, 1, NULL)
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (8, N'Hello', N'open', 3, CAST(0x0000A31400000000 AS DateTime), 1, N'x4n4th                                                                                                                                                                                                                                                          ', 14, 2, NULL)
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (9, N'In a World', N'open', 3, CAST(0x0000A1A700000000 AS DateTime), 1, N'x4n4th                                                                                                                                                                                                                                                          ', 8, 0, NULL)
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (10, N'tRY', N'open', 3, CAST(0x0000A1A800C5C100 AS DateTime), 3, N'x4n4th                                                                                                                                                                                                                                                          ', 18, 2, NULL)
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (1011, N'Second Forum', N'open', 3, CAST(0x0000A1A700000000 AS DateTime), 2, N'x4n4th                                                                                                                                                                                                                                                          ', 32, 3, NULL)
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (1012, N'undefined', N'open', 1, CAST(0x0000A31B013B0F94 AS DateTime), 1, N'x4n4th                                                                                                                                                                                                                                                          ', 5, 0, N'undefined')
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (1013, N'test1', N'open', 1, CAST(0x0000A31B013B9B7D AS DateTime), 1, N'x4n4th                                                                                                                                                                                                                                                          ', 10, 1, N'undefined')
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (1014, N'This is a test topic', N'open', 1, CAST(0x0000A31B013BFFDA AS DateTime), 2, N'x4n4th                                                                                                                                                                                                                                                          ', 17, 4, N'This is the first topic added by New Topic')
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (1015, N'ADASD', N'open', 1, CAST(0x0000A31B01524E15 AS DateTime), 4, N'x4n4th                                                                                                                                                                                                                                                          ', 6, 0, N'asdASD')
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (1016, N'Some Topic', N'open', 1, CAST(0x0000A31C00D63183 AS DateTime), 5, N'x4n4th                                                                                                                                                                                                                                                          ', 3, 0, N'I have no idea')
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (1017, N'New Test Topic', N'open', 1, CAST(0x0000A31C00DA7F0C AS DateTime), 2, N'x4n4th                                                                                                                                                                                                                                                          ', 1, 0, N'This is my test topic')
SET IDENTITY_INSERT [dbo].[topics] OFF
ALTER TABLE [dbo].[forums] ADD  DEFAULT (NULL) FOR [topics]
GO
ALTER TABLE [dbo].[forums] ADD  DEFAULT (NULL) FOR [posts]
GO
ALTER TABLE [dbo].[forums] ADD  DEFAULT (NULL) FOR [position]
GO
ALTER TABLE [dbo].[members] ADD  DEFAULT ('0') FOR [banned]
GO
ALTER TABLE [dbo].[posts] ADD  DEFAULT (NULL) FOR [author_name]
GO
ALTER TABLE [dbo].[topics] ADD  DEFAULT (NULL) FOR [state]
GO
ALTER TABLE [dbo].[topics] ADD  CONSTRAINT [DF_topics_views]  DEFAULT ((0)) FOR [views]
GO
ALTER TABLE [dbo].[topics] ADD  CONSTRAINT [DF_topics_replies]  DEFAULT ((0)) FOR [replies]
GO
USE [master]
GO
ALTER DATABASE [ist421] SET  READ_WRITE 
GO