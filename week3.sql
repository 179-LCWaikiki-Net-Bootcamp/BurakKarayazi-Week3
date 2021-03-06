USE [master]
GO
/****** Object:  Database [TestShop]    Script Date: 06/05/2022 00:29:30 ******/
CREATE DATABASE [TestShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestShop', FILENAME = N'/var/opt/mssql/data/TestShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TestShop_log', FILENAME = N'/var/opt/mssql/data/TestShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TestShop] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestShop] SET RECOVERY FULL 
GO
ALTER DATABASE [TestShop] SET  MULTI_USER 
GO
ALTER DATABASE [TestShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TestShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TestShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TestShop', N'ON'
GO
ALTER DATABASE [TestShop] SET QUERY_STORE = OFF
GO
USE [TestShop]
GO
/****** Object:  Table [dbo].[KeyValuePairs]    Script Date: 06/05/2022 00:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KeyValuePairs](
	[Id] [uniqueidentifier] NOT NULL,
	[Identifier] [nvarchar](max) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_KeyValuePairs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Cities]    Script Date: 06/05/2022 00:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Cities] AS
SELECT Id,Value
FROM KeyValuePairs
WHERE Identifier='City'
GO
/****** Object:  View [dbo].[Countries]    Script Date: 06/05/2022 00:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Countries] AS
SELECT Id,Value
FROM KeyValuePairs
WHERE Identifier='Country'
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 06/05/2022 00:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[CountryId] [uniqueidentifier] NOT NULL,
	[CityId] [uniqueidentifier] NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartLines]    Script Date: 06/05/2022 00:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartLines](
	[Id] [uniqueidentifier] NOT NULL,
	[CartId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[Amount] [int] NOT NULL,
	[Price] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Carts]    Script Date: 06/05/2022 00:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Current] [bit] NOT NULL,
 CONSTRAINT [PK_Carts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 06/05/2022 00:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[ParentId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 06/05/2022 00:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [uniqueidentifier] NOT NULL,
	[CartId] [uniqueidentifier] NOT NULL,
	[Date] [datetime] NOT NULL,
	[PaymentDate] [datetime] NULL,
	[TotalValue] [decimal](18, 2) NULL,
	[DeliveryAddressId] [uniqueidentifier] NOT NULL,
	[BillAddressId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategories]    Script Date: 06/05/2022 00:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategories](
	[Id] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[CategoryId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ProductCategories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 06/05/2022 00:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Sku] [nvarchar](max) NULL,
	[Price] [decimal](18, 2) NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 06/05/2022 00:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Surname] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Hash] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [Name]    Script Date: 06/05/2022 00:29:30 ******/
CREATE NONCLUSTERED INDEX [Name] ON [dbo].[Products]
(
	[Id] ASC
)
INCLUDE([Name]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Price]    Script Date: 06/05/2022 00:29:30 ******/
CREATE NONCLUSTERED INDEX [Price] ON [dbo].[Products]
(
	[Price] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Name]    Script Date: 06/05/2022 00:29:30 ******/
CREATE NONCLUSTERED INDEX [Name] ON [dbo].[Users]
(
	[Id] ASC
)
INCLUDE([Name]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Surname]    Script Date: 06/05/2022 00:29:30 ******/
CREATE NONCLUSTERED INDEX [Surname] ON [dbo].[Users]
(
	[Id] ASC
)
INCLUDE([Surname]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addresses] ADD  CONSTRAINT [DF_Addresses_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[Carts] ADD  CONSTRAINT [DF_Carts_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[Categories] ADD  CONSTRAINT [DF_Categories_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[KeyValuePairs] ADD  CONSTRAINT [DF_KeyValuePairs_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Order_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[ProductCategories] ADD  CONSTRAINT [DF_ProductCategories_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_KeyValuePairs] FOREIGN KEY([CountryId])
REFERENCES [dbo].[KeyValuePairs] ([Id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_KeyValuePairs]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_KeyValuePairs1] FOREIGN KEY([CityId])
REFERENCES [dbo].[KeyValuePairs] ([Id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_KeyValuePairs1]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Users]
GO
ALTER TABLE [dbo].[CartLines]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[CartLines] CHECK CONSTRAINT [FK_Cart_Products]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK_Carts_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK_Carts_Users]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Categories] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Categories]
GO
ALTER TABLE [dbo].[ProductCategories]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategories_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[ProductCategories] CHECK CONSTRAINT [FK_ProductCategories_Categories]
GO
ALTER TABLE [dbo].[ProductCategories]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategories_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[ProductCategories] CHECK CONSTRAINT [FK_ProductCategories_Products]
GO
/****** Object:  Trigger [dbo].[InsertOrder]    Script Date: 06/05/2022 00:29:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[InsertOrder]
ON [dbo].[Orders]
AFTER INSERT
AS
BEGIN
	PRINT('Order Success')
END
GO
ALTER TABLE [dbo].[Orders] ENABLE TRIGGER [InsertOrder]
GO
USE [master]
GO
ALTER DATABASE [TestShop] SET  READ_WRITE 
GO
