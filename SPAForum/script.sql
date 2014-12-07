USE [master]
GO
/****** Object:  Database [ist421]    Script Date: 12/6/2014 8:10:04 PM ******/
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
/****** Object:  Table [dbo].[catagories]    Script Date: 12/6/2014 8:10:04 PM ******/
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
/****** Object:  Table [dbo].[comEvents]    Script Date: 12/6/2014 8:10:04 PM ******/
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
/****** Object:  Table [dbo].[forums]    Script Date: 12/6/2014 8:10:04 PM ******/
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
/****** Object:  Table [dbo].[memberEvent]    Script Date: 12/6/2014 8:10:04 PM ******/
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
/****** Object:  Table [dbo].[members]    Script Date: 12/6/2014 8:10:04 PM ******/
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
/****** Object:  Table [dbo].[posts]    Script Date: 12/6/2014 8:10:04 PM ******/
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
/****** Object:  Table [dbo].[session]    Script Date: 12/6/2014 8:10:04 PM ******/
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
/****** Object:  Table [dbo].[topics]    Script Date: 12/6/2014 8:10:04 PM ******/
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
