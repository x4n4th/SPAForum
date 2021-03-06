USE [master]
GO
/****** Object:  Database [ist421]    Script Date: 12/6/2014 8:58:51 PM ******/
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
/****** Object:  Table [dbo].[catagories]    Script Date: 12/6/2014 8:58:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[catagories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[comEvents]    Script Date: 12/6/2014 8:58:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[comEvents](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](256) NOT NULL,
	[dateCreated] [datetime] NULL,
	[dateStart] [datetime] NULL,
	[wayPoints] [text] NULL,
	[startPoint] [varchar](256) NULL,
	[endPoint] [varchar](256) NULL,
	[description] [text] NULL,
	[memberId] [int] NULL,
	[forumId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[forums]    Script Date: 12/6/2014 8:58:51 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[memberEvent]    Script Date: 12/6/2014 8:58:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memberEvent](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[member] [int] NULL,
	[event] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[members]    Script Date: 12/6/2014 8:58:51 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[posts]    Script Date: 12/6/2014 8:58:51 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[session]    Script Date: 12/6/2014 8:58:51 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[topics]    Script Date: 12/6/2014 8:58:51 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[tid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[catagories] ON 

INSERT [dbo].[catagories] ([id], [name]) VALUES (1, N'General')
INSERT [dbo].[catagories] ([id], [name]) VALUES (2, N'Events')
SET IDENTITY_INSERT [dbo].[catagories] OFF
SET IDENTITY_INSERT [dbo].[comEvents] ON 

INSERT [dbo].[comEvents] ([id], [name], [dateCreated], [dateStart], [wayPoints], [startPoint], [endPoint], [description], [memberId], [forumId]) VALUES (1, N'My first event', CAST(0x0000A3F500000000 AS DateTime), CAST(0x0000A41100000000 AS DateTime), N'["2620 W Skippack Pike, Norristown, PA 19403, United States"]', N'Penn State University University Park State College, PA 16801', N'1600 Woodland Rd, Abington, PA 19001', N'This is my first event', 1, 7)
INSERT [dbo].[comEvents] ([id], [name], [dateCreated], [dateStart], [wayPoints], [startPoint], [endPoint], [description], [memberId], [forumId]) VALUES (2, N'My second Event', CAST(0x0000A3F400000000 AS DateTime), CAST(0x0000A41100000000 AS DateTime), N'[]', N'10 N Main St
Doylestown, PA', N'935 First Avenue
King of Prussia, PA 19406', N'Trek to Ebay from doylestown', 1, 8)
INSERT [dbo].[comEvents] ([id], [name], [dateCreated], [dateStart], [wayPoints], [startPoint], [endPoint], [description], [memberId], [forumId]) VALUES (3, N'My third Event', CAST(0x0000A3F400000000 AS DateTime), CAST(0x0000A41100000000 AS DateTime), N'[]', N'2955 Market Street 
30th Street Station
Philadelphia, PA 19104', N'1600 Woodland Rd, Abington, PA 19001', N'30th street station to Pennstate Abinton', 1, 9)
SET IDENTITY_INSERT [dbo].[comEvents] OFF
SET IDENTITY_INSERT [dbo].[forums] ON 

INSERT [dbo].[forums] ([id], [topics], [posts], [name], [description], [position], [catagorieId]) VALUES (6, NULL, NULL, N'testtopic', N'this is a test', 1, 1)
INSERT [dbo].[forums] ([id], [topics], [posts], [name], [description], [position], [catagorieId]) VALUES (7, NULL, NULL, N'My first event', NULL, 2, 2)
INSERT [dbo].[forums] ([id], [topics], [posts], [name], [description], [position], [catagorieId]) VALUES (8, NULL, NULL, N'My second Event', NULL, 3, 2)
INSERT [dbo].[forums] ([id], [topics], [posts], [name], [description], [position], [catagorieId]) VALUES (9, NULL, NULL, N'My third Event', NULL, 4, 2)
SET IDENTITY_INSERT [dbo].[forums] OFF
SET IDENTITY_INSERT [dbo].[members] ON 

INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (1, N'x4n4th', 1, N'djlafey@gmail.com', CAST(0x0000A30300000000 AS DateTime), N'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3', 0)
INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (5, N'test', 0, N'asdasd', CAST(0x0000A31A012980CF AS DateTime), N'7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 0)
INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (6, N'testing2', 0, N'asjldjaskd', CAST(0x0000A31A0124C2C4 AS DateTime), N'7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 0)
INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (8, N'mma', 0, N'mamamamamamam', CAST(0x0000A31A01251166 AS DateTime), N'7c4a8d09ca3762af61e59520943dc26494f8941b', 0)
INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (9, N'undefined', 0, N'undefined', CAST(0x0000A31A0138962A AS DateTime), N'd5d4cd07616a542891b7ec2d0257b3a24b69856e', 0)
INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (10, N'dee', 0, N'A@dee.com', CAST(0x0000A31B0024731C AS DateTime), N'7c4a8d09ca3762af61e59520943dc26494f8941b', 0)
INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (11, N'jhjjj', 0, N'jjjjjjj', CAST(0x0000A31C00144F63 AS DateTime), N'46c8e8dfa3a61fd39d81bfd1a475e13b8dc37ab7', 0)
INSERT [dbo].[members] ([id], [name], [member_group_id], [email], [joined], [password_hash], [banned]) VALUES (12, N'test', 0, N'test', CAST(0x0000A3E900BE54D8 AS DateTime), N'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3', 0)
SET IDENTITY_INSERT [dbo].[members] OFF
SET IDENTITY_INSERT [dbo].[posts] ON 

INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (39, 1, N'x4n4th', CAST(0x0000A3E900000000 AS DateTime), N'lawl', 1018)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (40, 12, N'test', CAST(0x0000A3E900BF5216 AS DateTime), N'hello', 1018)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (41, 12, N'test', CAST(0x0000A3E900BF5A03 AS DateTime), N'this is the first post of the topic', 1019)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (1037, 1, N'x4n4th', CAST(0x0000A3F700C4BF2D AS DateTime), N'Hello', 1019)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (1038, 1, N'x4n4th', CAST(0x0000A40100000000 AS DateTime), N'Welcome to the new event', 2019)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (1039, 1, N'x4n4th', CAST(0x0000A56C00000000 AS DateTime), N'Hi ', 2020)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (1040, 1, N'x4n4th', CAST(0x0000A40100000000 AS DateTime), N'Hello', 2021)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (1041, 1, N'x4n4th', CAST(0x0000A3F9014A90A1 AS DateTime), N'Hello everyone my name is GRR', 2022)
INSERT [dbo].[posts] ([pid], [author_id], [author_name], [post_date], [post], [topic_id]) VALUES (1042, 1, N'x4n4th', CAST(0x0000A3F9014AA625 AS DateTime), N'Hello GRR you have an interesting name', 2022)
SET IDENTITY_INSERT [dbo].[posts] OFF
SET IDENTITY_INSERT [dbo].[session] ON 

INSERT [dbo].[session] ([id], [session], [member_id], [date]) VALUES (62, N'fe19db440bf7662f72c0a3b43bf4af5b4e0e9244', 5, CAST(0x0000A31A012A2000 AS DateTime))
INSERT [dbo].[session] ([id], [session], [member_id], [date]) VALUES (63, N'18e45605452513f5380e7a84e06faa7f38ce3cc5', 6, CAST(0x0000A31A0124ED7A AS DateTime))
INSERT [dbo].[session] ([id], [session], [member_id], [date]) VALUES (109, N'fae122ebb6374246cb2a8e2c686ab275b7038c3a', 8, CAST(0x0000A31C010C5C10 AS DateTime))
INSERT [dbo].[session] ([id], [session], [member_id], [date]) VALUES (112, N'ee5317b852147ae64dba3917713f377029dfa67e', 10, CAST(0x0000A31D00448F0E AS DateTime))
INSERT [dbo].[session] ([id], [session], [member_id], [date]) VALUES (114, N'5eb7e684b6d0fa5ebec37c0000d7cb858d10a035', 12, CAST(0x0000A3E900BF4E86 AS DateTime))
INSERT [dbo].[session] ([id], [session], [member_id], [date]) VALUES (1121, N'34386618cfd21c330e8b5c9eb5ccccaddd2baaf0', 1, CAST(0x0000A3F9014E07E4 AS DateTime))
SET IDENTITY_INSERT [dbo].[session] OFF
SET IDENTITY_INSERT [dbo].[topics] ON 

INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (1018, N'test', N'open', 1, CAST(0x0000A3E900000000 AS DateTime), 6, N'x4n4th                                                                                                                                                                                                                                                          ', 7, 2, N'This is another tets')
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (1019, N'Hello this is fun', N'open', 12, CAST(0x0000A3E900BF59FA AS DateTime), 6, N'test                                                                                                                                                                                                                                                            ', 13, 1, N'lawl')
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (2019, N'Welcome to the event', N'open', 1, CAST(0x0000A3FF00000000 AS DateTime), 7, N'x4n4th                                                                                                                                                                                                                                                          ', 425, 0, NULL)
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (2020, N'Welcome', N'open', 1, CAST(0x0000A3FF00000000 AS DateTime), 8, N'x4n4th                                                                                                                                                                                                                                                          ', 0, 0, NULL)
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (2021, N'Welcome', N'open', 1, CAST(0x0000A3FF00000000 AS DateTime), 9, N'x4n4th                                                                                                                                                                                                                                                          ', 0, 0, NULL)
INSERT [dbo].[topics] ([tid], [title], [state], [starter_id], [start_date], [forum_id], [starter_name], [views], [replies], [description]) VALUES (2022, N'Hello everyone', N'open', 1, CAST(0x0000A3F9014A9099 AS DateTime), 7, N'x4n4th                                                                                                                                                                                                                                                          ', 22, 1, N'This is a simple introduction')
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
ALTER TABLE [dbo].[forums]  WITH CHECK ADD  CONSTRAINT [fk_Catagories] FOREIGN KEY([catagorieId])
REFERENCES [dbo].[catagories] ([id])
GO
ALTER TABLE [dbo].[forums] CHECK CONSTRAINT [fk_Catagories]
GO
ALTER TABLE [dbo].[posts]  WITH CHECK ADD  CONSTRAINT [fk_posts_authors] FOREIGN KEY([author_id])
REFERENCES [dbo].[members] ([id])
GO
ALTER TABLE [dbo].[posts] CHECK CONSTRAINT [fk_posts_authors]
GO
ALTER TABLE [dbo].[posts]  WITH CHECK ADD  CONSTRAINT [fk_posts_topics] FOREIGN KEY([topic_id])
REFERENCES [dbo].[topics] ([tid])
GO
ALTER TABLE [dbo].[posts] CHECK CONSTRAINT [fk_posts_topics]
GO
ALTER TABLE [dbo].[session]  WITH CHECK ADD  CONSTRAINT [fk_session_members] FOREIGN KEY([member_id])
REFERENCES [dbo].[members] ([id])
GO
ALTER TABLE [dbo].[session] CHECK CONSTRAINT [fk_session_members]
GO
ALTER TABLE [dbo].[topics]  WITH CHECK ADD  CONSTRAINT [fk_topics_forumid] FOREIGN KEY([forum_id])
REFERENCES [dbo].[forums] ([id])
GO
ALTER TABLE [dbo].[topics] CHECK CONSTRAINT [fk_topics_forumid]
GO
ALTER TABLE [dbo].[topics]  WITH CHECK ADD  CONSTRAINT [fk_topics_members] FOREIGN KEY([starter_id])
REFERENCES [dbo].[members] ([id])
GO
ALTER TABLE [dbo].[topics] CHECK CONSTRAINT [fk_topics_members]
GO
USE [master]
GO
ALTER DATABASE [ist421] SET  READ_WRITE 
GO
