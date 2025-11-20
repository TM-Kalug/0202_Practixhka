USE [master]
GO
/****** Object:  Database [New_Technologies]    Script Date: 21.11.2025 0:59:06 ******/
CREATE DATABASE [New_Technologies]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'New_Technologies', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\New_Technologies.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'New_Technologies_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\New_Technologies_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [New_Technologies] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [New_Technologies].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [New_Technologies] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [New_Technologies] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [New_Technologies] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [New_Technologies] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [New_Technologies] SET ARITHABORT OFF 
GO
ALTER DATABASE [New_Technologies] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [New_Technologies] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [New_Technologies] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [New_Technologies] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [New_Technologies] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [New_Technologies] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [New_Technologies] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [New_Technologies] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [New_Technologies] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [New_Technologies] SET  DISABLE_BROKER 
GO
ALTER DATABASE [New_Technologies] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [New_Technologies] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [New_Technologies] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [New_Technologies] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [New_Technologies] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [New_Technologies] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [New_Technologies] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [New_Technologies] SET RECOVERY FULL 
GO
ALTER DATABASE [New_Technologies] SET  MULTI_USER 
GO
ALTER DATABASE [New_Technologies] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [New_Technologies] SET DB_CHAINING OFF 
GO
ALTER DATABASE [New_Technologies] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [New_Technologies] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [New_Technologies] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [New_Technologies] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'New_Technologies', N'ON'
GO
ALTER DATABASE [New_Technologies] SET QUERY_STORE = ON
GO
ALTER DATABASE [New_Technologies] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [New_Technologies]
GO
/****** Object:  Table [dbo].[Material_type]    Script Date: 21.11.2025 0:59:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Material_type](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[material_type] [nvarchar](50) NULL,
	[defective_material_percent] [float] NULL,
 CONSTRAINT [PK_Material_type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Materials]    Script Date: 21.11.2025 0:59:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Materials](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[material_name] [nvarchar](100) NULL,
	[material_type] [int] NULL,
	[price] [float] NULL,
	[quantity_in_warehouse] [float] NULL,
	[minimal_quantity] [float] NULL,
	[quantity_in_pack] [int] NULL,
	[unit_of_measurement] [int] NULL,
 CONSTRAINT [PK_Materials] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partner_products_request]    Script Date: 21.11.2025 0:59:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partner_products_request](
	[ID] [int] IDENTITY(81,1) NOT NULL,
	[prodcut] [int] NULL,
	[partner] [int] NULL,
	[product_quantity] [int] NULL,
 CONSTRAINT [PK_Partner_products_request] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partners]    Script Date: 21.11.2025 0:59:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partners](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[partner_type] [int] NULL,
	[partner_name] [nvarchar](100) NULL,
	[director_surname] [nvarchar](100) NULL,
	[director_name] [nvarchar](100) NULL,
	[director_patronymic] [nvarchar](100) NULL,
	[partner_email] [nvarchar](100) NULL,
	[phone] [nvarchar](15) NULL,
	[partner_adress] [nvarchar](255) NULL,
	[INN] [float] NULL,
	[rating] [int] NULL,
 CONSTRAINT [PK_Partners] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partners_types]    Script Date: 21.11.2025 0:59:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partners_types](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](3) NULL,
 CONSTRAINT [PK_Partners_types] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product_types]    Script Date: 21.11.2025 0:59:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_types](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[product_type_coefficient] [float] NULL,
 CONSTRAINT [PK_Product_types] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products_import]    Script Date: 21.11.2025 0:59:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products_import](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[product_type] [int] NULL,
	[product_name] [nvarchar](255) NULL,
	[article] [float] NULL,
	[patner_minimal_price] [float] NULL,
	[quantity] [int] NULL,
 CONSTRAINT [PK_Products_import] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Units_of_measurement]    Script Date: 21.11.2025 0:59:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Units_of_measurement](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](10) NULL,
 CONSTRAINT [PK_Units_of_measurement] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Material_type] ON 
GO
INSERT [dbo].[Material_type] ([ID], [material_type], [defective_material_percent]) VALUES (1, N'Тип материала 1', 0.002)
GO
INSERT [dbo].[Material_type] ([ID], [material_type], [defective_material_percent]) VALUES (2, N'Тип материала 2', 0.005)
GO
INSERT [dbo].[Material_type] ([ID], [material_type], [defective_material_percent]) VALUES (3, N'Тип материала 3', 0.003)
GO
INSERT [dbo].[Material_type] ([ID], [material_type], [defective_material_percent]) VALUES (4, N'Тип материала 4', 0.0015)
GO
INSERT [dbo].[Material_type] ([ID], [material_type], [defective_material_percent]) VALUES (5, N'Тип материала 5', 0.0018)
GO
SET IDENTITY_INSERT [dbo].[Material_type] OFF
GO
SET IDENTITY_INSERT [dbo].[Materials] ON 
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (1, N'Глина', 1, 15.29, 1570, 5500, 30, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (2, N'Каолин', 1, 18.2, 1030, 3500, 25, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (3, N'Гидрослюда', 1, 17.2, 2147, 3500, 25, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (4, N'Монтмориллонит', 1, 17.666666666666668, 3000, 3000, 30, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (5, N'Перлит', 2, 13.99, 150, 1000, 50, 2)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (6, N'Стекло', 2, 2.4, 3000, 1500, 500, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (7, N'Дегидратированная глина', 2, 21.95, 3000, 2500, 20, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (8, N'Шамот', 2, 27.5, 2300, 1960, 20, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (9, N'Техническая сода', 3, 54.55, 1200, 1500, 25, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (10, N'Жидкое стекло', 3, 76.59, 500, 1500, 15, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (11, N'Кварц', 4, 375.96, 1500, 2500, 10, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (12, N'Полевой шпат', 4, 15.99, 750, 1500, 100, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (13, N'Краска-раствор', 5, 200.9, 1496, 2500, 5, 2)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (14, N'Порошок цветной', 5, 84.39, 511, 1750, 25, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (15, N'Кварцевый песок', 2, 4.29, 3000, 1600, 50, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (16, N'Жильный кварц', 2, 18.6, 2556, 1600, 25, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (17, N'Барий углекислый', 4, 303.6384, 340, 1500, 25, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (18, N'Бура техническая', 4, 125.99, 165, 1300, 25, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (19, N'Углещелочной реагент', 3, 3.45, 450, 1100, 25, 1)
GO
INSERT [dbo].[Materials] ([ID], [material_name], [material_type], [price], [quantity_in_warehouse], [minimal_quantity], [quantity_in_pack], [unit_of_measurement]) VALUES (20, N'Пирофосфат натрия', 3, 700.99, 356, 1200, 25, 1)
GO
SET IDENTITY_INSERT [dbo].[Materials] OFF
GO
SET IDENTITY_INSERT [dbo].[Partner_products_request] ON 
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (0, 12, 5, 10000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (1, 4, 1, 2000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (2, 5, 2, 3000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (3, 1, 3, 1000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (4, 3, 4, 9500)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (5, 1, 5, 2000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (6, 18, 6, 1100)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (7, 12, 7, 5000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (8, 1, 8, 2500)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (9, 2, 9, 6000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (10, 6, 10, 7000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (11, 4, 11, 5000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (12, 4, 12, 7500)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (13, 1, 13, 3000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (14, 18, 14, 500)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (15, 16, 15, 7000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (16, 9, 16, 4000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (17, 1, 17, 3500)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (18, 1, 18, 7900)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (19, 15, 19, 9600)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (20, 11, 20, 1200)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (21, 19, 1, 10000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (22, 8, 2, 3000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (23, 2, 3, 3010)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (24, 7, 4, 3020)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (25, 5, 5, 3050)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (26, 14, 6, 3040)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (27, 19, 7, 3050)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (28, 4, 8, 3060)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (29, 18, 9, 3070)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (30, 9, 10, 5400)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (31, 12, 11, 5500)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (32, 11, 12, 5600)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (33, 9, 13, 5700)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (34, 14, 14, 5800)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (35, 2, 15, 5900)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (36, 12, 16, 6000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (37, 6, 17, 6100)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (38, 9, 18, 8000)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (39, 3, 19, 7060)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (40, 17, 20, 6120)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (41, 15, 1, 5180)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (42, 10, 2, 4240)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (43, 10, 3, 3300)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (44, 10, 4, 2360)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (45, 8, 5, 1420)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (46, 11, 6, 1500)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (47, 5, 7, 1700)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (48, 12, 8, 1900)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (49, 15, 9, 2100)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (50, 12, 10, 2300)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (51, 8, 11, 2500)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (52, 15, 12, 2700)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (53, 12, 13, 2900)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (54, 1, 14, 3100)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (55, 18, 15, 3300)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (56, 20, 16, 3500)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (57, 10, 17, 3750)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (58, 14, 18, 6700)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (59, 7, 19, 6950)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (60, 11, 20, 7200)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (61, 17, 1, 7450)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (62, 19, 2, 7700)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (63, 20, 3, 7950)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (64, 8, 4, 8200)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (65, 10, 5, 8450)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (66, 7, 6, 8700)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (67, 8, 7, 8950)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (68, 20, 8, 9200)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (69, 4, 9, 1300)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (70, 16, 10, 1500)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (71, 16, 11, 1700)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (72, 12, 12, 1900)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (73, 20, 13, 2100)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (74, 9, 14, 2300)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (75, 13, 15, 2500)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (76, 13, 16, 2700)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (77, 12, 17, 2900)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (78, 3, 18, 3100)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (79, 14, 19, 3300)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (80, 18, 20, 3500)
GO
INSERT [dbo].[Partner_products_request] ([ID], [prodcut], [partner], [product_quantity]) VALUES (83, 13, 1, 2)
GO
SET IDENTITY_INSERT [dbo].[Partner_products_request] OFF
GO
SET IDENTITY_INSERT [dbo].[Partners] ON 
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (1, 1, N'Стройдвор', N'Андреева', N'Ангелина', N'Николаевна', N'angelina77@kart.ru', N'492 452 22 82', N'143001, Московская область, город Одинцово, уд. Ленина, 21', 9432455179, 5)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (2, 1, N'Самоделка', N'Мельников', N'Максим', N'Петрович', N'melnikov.maksim88@hm.ru', N'812 267 19 59', N'306230, Курская область, город Обоянь, ул. 1 Мая, 89', 7803888520, 3)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (3, 2, N'Деревянные изделия', N'Лазарев', N'Алексей', N'Сергеевич', N'aleksejlazarev@al.ru', N'922 467 93 83', N'238340, Калининградская область, город Светлый, ул. Морская, 12', 8430391035, 4)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (4, 2, N'Декор и отделка', N'Саншокова', N'Мадина', N'Муратовна', N'mmsanshokova@lss.ru', N'413 230 30 79', N'685000, Магаданская область, город Магадан, ул. Горького, 15', 4318170454, 7)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (5, 2, N'Паркет', N'Иванов', N'Дмитрий', N'Сергеевич', N'ivanov.dmitrij@mail.ru', N'921 851 21 22', N'606440, Нижегородская область, город Бор, ул. Свободы, 3', 7687851800, 7)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (6, 4, N'Дом и сад', N'Аникеева', N'Екатерина', N'Алексеевна', N'ekaterina.anikeeva@ml.ru', N'499 936 29 26', N'393760, Тамбовская область, город Мичуринск, ул. Красная, 50', 6119144874, 7)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (7, 3, N'Легкий шаг', N'Богданова', N'Ксения', N'Владимировна', N'bogdanova.kseniya@bkv.ru', N'495 445 61 41', N'307370, Курская область, город Рыльск, ул. Гагарина, 16', 1122170258, 6)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (8, 4, N'СтройМатериалы', N'Холодова', N'Валерия', N'Борисовна', N'holodova@education.ru', N'499 234 56 78', N'140300, Московская область, город Егорьевск, ул. Советская, 24', 8355114917, 5)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (9, 3, N'Мир отделки', N'Крылов', N'Савелий', N'Тимофеевич', N'stkrylov@mail.ru', N'908 713 51 88', N'344116, Ростовская область, город Ростов-на-Дону, ул. Артиллерийская, 4', 3532367439, 8)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (10, 3, N'Технологии комфорта', N'Белов', N'Кирилл', N'Александрович', N'kirill_belov@kir.ru', N'918 432 12 34', N'164500, Архангельская область, город Северодвинск, ул. Ломоносова, 29', 2362431140, 4)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (11, 4, N'Твой дом', N'Демидов', N'Дмитрий', N'Александрович', N'dademidov@ml.ru', N'919 698 75 43', N'354000, Краснодарский край, город Сочи, ул. Больничная, 11', 4159215346, 10)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (12, 1, N'Новые краски', N'Алиев', N'Дамир', N'Игоревич', N'alievdamir@tk.ru', N'812 823 93 42', N'187556, Ленинградская область, город Тихвин, ул. Гоголя, 18', 9032455179, 9)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (13, 3, N'Политехник', N'Котов', N'Михаил', N'Михайлович', N'mmkotov56@educat.ru', N'495 895 71 77', N'143960, Московская область, город Реутов, ул. Новая, 55', 3776671267, 5)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (14, 3, N'СтройАрсенал', N'Семенов', N'Дмитрий', N'Максимович', N'semenov.dm@mail.ru', N'896 123 45 56', N'242611, Брянская область, город Фокино, ул. Фокино, 23', 7447864518, 5)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (15, 4, N'Декор и порядок', N'Болотов', N'Артем', N'Игоревич', N'artembolotov@ab.ru', N'950 234 12 12', N'309500, Белгородская область, город Старый Оскол, ул. Цветочная, 20', 9037040523, 5)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (16, 4, N'Умные решения', N'Воронова', N'Анастасия', N'Валерьевна', N'voronova_anastasiya@mail.ru', N'923 233 27 69', N'652050, Кемеровская область, город Юрга, ул. Мира, 42', 6221520857, 3)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (17, 1, N'Натуральные покрытия', N'Горбунов', N'Василий', N'Петрович', N'vpgorbunov24@vvs.ru', N'902 688 28 96', N'188300, Ленинградская область, город Гатчина, пр. 25 Октября, 17', 2262431140, 9)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (18, 2, N'СтройМастер', N'Смирнов', N'Иван', N'Андреевич', N'smirnov_ivan@kv.ru', N'917 234 75 55', N'184250, Мурманская область, город Кировск, пр. Ленина, 24', 4155215346, 9)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (19, 2, N'Гранит', N'Джумаев', N'Ахмед', N'Умарович', N'dzhumaev.ahmed@amail.ru', N'495 452 55 95', N'162390, Вологодская область, город Великий Устюг, ул. Железнодорожная, 36', 3961234561, 5)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (20, 1, N'Строитель', N'Петров', N'Николай', N'Тимофеевич', N'petrov.nikolaj31@mail.ru', N'916 596 15 55', N'188910, Ленинградская область, город Приморск, ш. Приморское, 18', 9600275878, 10)
GO
INSERT [dbo].[Partners] ([ID], [partner_type], [partner_name], [director_surname], [director_name], [director_patronymic], [partner_email], [phone], [partner_adress], [INN], [rating]) VALUES (21, 2, N'Антон', N'Антонини', N'Антон', N'Антонович', N'', N'+79228341193', N'г. Село ул.Габара д.88', NULL, 1234567)
GO
SET IDENTITY_INSERT [dbo].[Partners] OFF
GO
SET IDENTITY_INSERT [dbo].[Partners_types] ON 
GO
INSERT [dbo].[Partners_types] ([ID], [name]) VALUES (1, N'ЗАО')
GO
INSERT [dbo].[Partners_types] ([ID], [name]) VALUES (2, N'ООО')
GO
INSERT [dbo].[Partners_types] ([ID], [name]) VALUES (3, N'ОАО')
GO
INSERT [dbo].[Partners_types] ([ID], [name]) VALUES (4, N'ПАО')
GO
SET IDENTITY_INSERT [dbo].[Partners_types] OFF
GO
SET IDENTITY_INSERT [dbo].[Product_types] ON 
GO
INSERT [dbo].[Product_types] ([ID], [name], [product_type_coefficient]) VALUES (1, N'Древесно-плитные материалы', 1.5)
GO
INSERT [dbo].[Product_types] ([ID], [name], [product_type_coefficient]) VALUES (2, N'Декоративные панели', 3.5)
GO
INSERT [dbo].[Product_types] ([ID], [name], [product_type_coefficient]) VALUES (3, N'Плитка', 5.25)
GO
INSERT [dbo].[Product_types] ([ID], [name], [product_type_coefficient]) VALUES (4, N'Фасадные материалы', 4.5)
GO
INSERT [dbo].[Product_types] ([ID], [name], [product_type_coefficient]) VALUES (5, N'Напольные покрытия', 2.17)
GO
SET IDENTITY_INSERT [dbo].[Product_types] OFF
GO
SET IDENTITY_INSERT [dbo].[Products_import] ON 
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (1, 1, N'Фанера ФСФ 1800х1200х27 мм бежевая береза', 6549922, 5100, 5)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (2, 2, N'Мягкие панели прямоугольник велюр цвет оливковый 600х300х35 мм', 7018556, 1880, 10)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (3, 5, N'Бетонная плитка Белый кирпич микс 30х7,3 см', 5028272, 2080, 15)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (4, 4, N'Плитка Мозаика 10x10 см цвет белый глянец', 8028248, 2500, 20)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (5, 5, N'Ламинат Дуб Античный серый 32 класс толщина 8 мм с фаской', 9250282, 4050, 23)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (6, 3, N'Стеновая панель МДФ Флора 1440x500x10 мм', 7130981, 2100.56, 11)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (7, 5, N'Бетонная плитка Красный кирпич 20x6,5 см', 5029784, 2760, 22)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (8, 5, N'Ламинат Канди Дизайн 33 класс толщина 8 мм с фаской', 9658953, 3200.96, 25)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (9, 2, N'Плита ДСП 11 мм влагостойкая 594x1815 мм', 6026662, 497.69, 30)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (10, 5, N'Ламинат с натуральным шпоном Дуб Эксперт толщина 6 мм с фаской', 9159043, 3750, 35)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (11, 4, N'Плитка настенная Формат 20x40 см матовая цвет мята', 8588376, 2500, 40)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (12, 2, N'Плита ДСП Кантри 16 мм 900x1200 мм', 6758375, 1050.96, 45)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (13, 3, N'Стеновая панель МДФ Сосна Полярная 60х280х4мсм цвет коричневый', 7759324, 1700, 50)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (14, 5, N'Клинкерная плитка коричневая 29,8х29,8 см', 5118827, 860, 55)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (15, 4, N'Плитка настенная Цветок 60x120 см цвет зелено-голубой', 8559898, 2300, 60)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (16, 3, N'Пробковое настенное покрытие 600х300х3 мм белый ', 7259474, 3300, 65)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (17, 4, N'Плитка настенная Нева 30x60 см цвет серый', 8115947, 1700, 70)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (18, 5, N'Гипсовая плитка настенная Дом на берегу кирпич белый 18,5х4,5 см', 5033136, 499, 75)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (19, 5, N'Ламинат Дуб Северный белый 32 класс толщина 8 мм с фаской', 9028048, 2550, 80)
GO
INSERT [dbo].[Products_import] ([ID], [product_type], [product_name], [article], [patner_minimal_price], [quantity]) VALUES (20, 1, N'Дерево волокнистая плита Дуб Винтаж 1200х620х3 мм светло-коричневый', 6123459, 900.5, 100)
GO
SET IDENTITY_INSERT [dbo].[Products_import] OFF
GO
SET IDENTITY_INSERT [dbo].[Units_of_measurement] ON 
GO
INSERT [dbo].[Units_of_measurement] ([ID], [Name]) VALUES (1, N'кг.')
GO
INSERT [dbo].[Units_of_measurement] ([ID], [Name]) VALUES (2, N'л.')
GO
SET IDENTITY_INSERT [dbo].[Units_of_measurement] OFF
GO
ALTER TABLE [dbo].[Materials]  WITH CHECK ADD  CONSTRAINT [FK_Materials_Material_type] FOREIGN KEY([material_type])
REFERENCES [dbo].[Material_type] ([ID])
GO
ALTER TABLE [dbo].[Materials] CHECK CONSTRAINT [FK_Materials_Material_type]
GO
ALTER TABLE [dbo].[Materials]  WITH CHECK ADD  CONSTRAINT [FK_Materials_Units_of_measurement] FOREIGN KEY([unit_of_measurement])
REFERENCES [dbo].[Units_of_measurement] ([ID])
GO
ALTER TABLE [dbo].[Materials] CHECK CONSTRAINT [FK_Materials_Units_of_measurement]
GO
ALTER TABLE [dbo].[Partner_products_request]  WITH CHECK ADD  CONSTRAINT [FK_Partner_products_request_Partners] FOREIGN KEY([partner])
REFERENCES [dbo].[Partners] ([ID])
GO
ALTER TABLE [dbo].[Partner_products_request] CHECK CONSTRAINT [FK_Partner_products_request_Partners]
GO
ALTER TABLE [dbo].[Partner_products_request]  WITH CHECK ADD  CONSTRAINT [FK_Partner_products_request_Products_import] FOREIGN KEY([prodcut])
REFERENCES [dbo].[Products_import] ([ID])
GO
ALTER TABLE [dbo].[Partner_products_request] CHECK CONSTRAINT [FK_Partner_products_request_Products_import]
GO
ALTER TABLE [dbo].[Partners]  WITH CHECK ADD  CONSTRAINT [FK_Partners_Partners_types] FOREIGN KEY([partner_type])
REFERENCES [dbo].[Partners_types] ([ID])
GO
ALTER TABLE [dbo].[Partners] CHECK CONSTRAINT [FK_Partners_Partners_types]
GO
ALTER TABLE [dbo].[Products_import]  WITH CHECK ADD  CONSTRAINT [FK_Products_import_Product_types] FOREIGN KEY([product_type])
REFERENCES [dbo].[Product_types] ([ID])
GO
ALTER TABLE [dbo].[Products_import] CHECK CONSTRAINT [FK_Products_import_Product_types]
GO
USE [master]
GO
ALTER DATABASE [New_Technologies] SET  READ_WRITE 
GO
