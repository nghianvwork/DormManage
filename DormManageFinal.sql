USE [master]
GO
/****** Object:  Database [DepartmentManagementDB]    Script Date: 10/26/2024 10:42:05 PM ******/
CREATE DATABASE [DepartmentManagementDB]
 
GO
ALTER DATABASE [DepartmentManagementDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DepartmentManagementDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DepartmentManagementDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DepartmentManagementDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DepartmentManagementDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET RECOVERY FULL 
GO
ALTER DATABASE [DepartmentManagementDB] SET  MULTI_USER 
GO
ALTER DATABASE [DepartmentManagementDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DepartmentManagementDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DepartmentManagementDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DepartmentManagementDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DepartmentManagementDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DepartmentManagementDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DepartmentManagementDB', N'ON'
GO
ALTER DATABASE [DepartmentManagementDB] SET QUERY_STORE = OFF
GO
USE [DepartmentManagementDB]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 10/26/2024 10:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[BillID] [int] IDENTITY(1,1) NOT NULL,
	[RoomID] [int] NULL,
	[GuestID] [int] NULL,
	[TotalCost] [float] NULL,
	[CreateDate] [datetime] NULL,
	[PaymentStatus] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[BillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 10/26/2024 10:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](100) NOT NULL,
	[ManagerID] [int] NULL,
	[Address] [nvarchar](100) NULL,
	[Emptyroom] [int] NULL,
	[Price] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DormImage]    Script Date: 10/26/2024 10:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DormImage](
	[imageID] [int] IDENTITY(1,1) NOT NULL,
	[dormID] [int] NOT NULL,
	[imageURL] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[imageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DormService]    Script Date: 10/26/2024 10:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DormService](
	[dormServiceID] [int] IDENTITY(1,1) NOT NULL,
	[dormID] [int] NULL,
	[serviceID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 10/26/2024 10:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[BillID] [int] NULL,
	[PaymentDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rooms]    Script Date: 10/26/2024 10:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rooms](
	[RoomID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentID] [int] NOT NULL,
	[RoomNumber] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Services]    Script Date: 10/26/2024 10:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Services](
	[ServiceID] [int] IDENTITY(1,1) NOT NULL,
	[ServiceName] [nvarchar](100) NOT NULL,
	[ServiceDescription] [nvarchar](255) NULL,
	[Price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRooms]    Script Date: 10/26/2024 10:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRooms](
	[UserRoomID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[RoomID] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserRoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/26/2024 10:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[PasswordHash] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[FullName] [nvarchar](100) NULL,
	[Role] [nvarchar](20) NOT NULL,
	[RegistrationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserServices]    Script Date: 10/26/2024 10:42:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillService](
	billID [int] foreign key references Bill(BillID) NOT NULL,
	serviceID [int]  foreign key references Services(ServiceID) NOT NULL,
	 oldRecord int,
     newRecord int,
     total float,
     price float,
     usage int
)
GO
SET IDENTITY_INSERT [dbo].[Departments] ON 


INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [ManagerID], [Address], [Emptyroom], [Price]) VALUES (1020, N'Hus hus', 18, N'Ha Noi', 0, 10000000)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [ManagerID], [Address], [Emptyroom], [Price]) VALUES (1021, N'test', 18, N'Ha noi', 0, 1000000)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [ManagerID], [Address], [Emptyroom], [Price]) VALUES (1022, N'Nhà trọ CHâu ÂU', 2, N'Hòa Lạc', 11, 20000000)
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName], [ManagerID], [Address], [Emptyroom], [Price]) 
VALUES 
(13, N'Phòng Trọ A101', 1001, N'123 Đường Hoàng Quốc Việt, Cầu Giấy, Hà Nội', 3, 3500000),
(14, N'Phòng Trọ B202', 1002, N'45 Đường Nguyễn Trãi, Thanh Xuân, Hà Nội', 2, 3000000),
(15, N'Phòng Trọ C303', 1003, N'89 Đường Xuân Thủy, Cầu Giấy, Hà Nội', 4, 3200000),
(17, N'Phòng Trọ D404', 1004, N'56 Đường Đại Cồ Việt, Hai Bà Trưng, Hà Nội', 1, 4000000),
(18, N'Phòng Trọ E505', 1005, N'78 Đường Láng Hạ, Đống Đa, Hà Nội', 5, 2800000),
(19, N'Phòng Trọ F606', 1006, N'101 Đường Phạm Văn Đồng, Bắc Từ Liêm, Hà Nội', 2, 3300000),
(1016, N'Phòng Trọ G707', 1007, N'65 Đường Kim Mã, Ba Đình, Hà Nội', 3, 3700000),
(1017, N'Phòng Trọ H808', 1008, N'32 Đường Trường Chinh, Đống Đa, Hà Nội', 6, 2900000),
(1018, N'Phòng Trọ I909', 1009, N'98 Đường Giải Phóng, Hoàng Mai, Hà Nội', 4, 3100000),
(1019, N'Phòng Trọ J1010', 1010, N'12 Đường Tây Sơn, Đống Đa, Hà Nội', 2, 3500000);

SET IDENTITY_INSERT [dbo].[Departments] OFF
GO
SET IDENTITY_INSERT [dbo].[DormImage] ON 

INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1004, 13, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721348766/hbctjrkqfhpexn7quzot.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1008, 14, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721329234/xwxmnd5b8dk83rhmuuwq.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1009, 14, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721329234/hni4dxcwnnnbcfkzoag0.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1010, 14, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721329244/saqezsegnsachqhb9b8h.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1011, 14, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721329255/uxbchk7xxbinjgvljdpn.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1012, 14, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721329264/pacld2a9rgk4didkogi5.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1013, 15, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721368126/ahod4dywconeigfcvm3w.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1014, 15, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721329623/rieavigrufnlgry5ocpl.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1018, 13, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721348401/pddn77oxkhw2yl01txg5.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1020, 17, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721348981/v7t5ugrvtyptzg82ywq4.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1021, 17, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721348927/jyahmk7bvspcfsvzkylc.png')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1022, 17, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721348968/ts0npxhnoinxljdx4dzw.png')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1023, 18, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721349022/zpedmt3lx8ywdjtkdccx.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1024, 18, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721349030/toxttrtgomoilb653vrc.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1025, 18, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721349041/wnpddbckxtj2n3qbslt8.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1026, 19, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721354124/slbpa6cbdnl1fdgxokxu.png')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (1027, 19, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721354132/j9vxuswizlmvpx5syu8w.png')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2015, 1016, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721367990/z5djddqokjjckqxdnh0p.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2016, 1016, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721368002/pkmgqhblv2fitwpii4lp.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2017, 1016, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721368008/f2ieiopinngwuawaipy9.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2018, 1018, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721368716/odxdllo2cabtaxqfbmwr.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2019, 1018, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721368752/wc0qf6jed4ryiebii8uz.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2020, 1017, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721372710/cpo1iteykyhkmngqw1vy.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2021, 1017, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721372717/jegudwx9di4ymqiczmjp.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2022, 1019, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721373687/fjjcjqmekpwyk1oxjan2.png')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2023, 1019, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721373713/dgqjdw1lx5pyfict0wlt.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2024, 1020, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721374578/hi8cr4xay08um4kxngit.png')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2025, 1020, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721374598/bmja3zpopl4an7udleac.png')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2026, 1021, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721375070/zdpbvn0aq8mstuiy9rsq.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2027, 1021, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1721376507/iseyxqwnjo4pkuao3dva.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2028, 1022, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1729956676/dwlgtcs3xqbul7rbqfjh.jpg')
INSERT [dbo].[DormImage] ([imageID], [dormID], [imageURL]) VALUES (2029, 1022, N'https://res.cloudinary.com/dtn0i6fvs/image/upload/v1729956692/razsn8npxpqnk0hwrx8c.png')
SET IDENTITY_INSERT [dbo].[DormImage] OFF
GO
SET IDENTITY_INSERT [dbo].[DormService] ON 

INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (15, 13, 14)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (18, 18, 13)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (20, 19, 14)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (25, 14, 15)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (1010, 1021, 12)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (7, 15, 13)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (1011, 1021, 13)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (1012, 1022, 12)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (1013, 1022, 13)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (1014, 1022, 14)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (6, 15, 12)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (8, 15, 14)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (9, 15, 15)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (16, 13, 16)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (14, 14, 12)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (17, 18, 12)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (19, 18, 15)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (21, 19, 16)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (22, 19, 13)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (23, 19, 15)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (24, 14, 14)
INSERT [dbo].[DormService] ([dormServiceID], [dormID], [serviceID]) VALUES (1015, 1022, 15)
SET IDENTITY_INSERT [dbo].[DormService] OFF
GO
SET IDENTITY_INSERT [dbo].[Rooms] ON 

INSERT [dbo].[Rooms] ([RoomID], [DepartmentID], [RoomNumber], [Status]) VALUES (28, 13, N'104', N'Available')
INSERT [dbo].[Rooms] ([RoomID], [DepartmentID], [RoomNumber], [Status]) VALUES (34, 14, N'104', N'Available')
INSERT [dbo].[Rooms] ([RoomID], [DepartmentID], [RoomNumber], [Status]) VALUES (35, 17, N'101', N'Available')
INSERT [dbo].[Rooms] ([RoomID], [DepartmentID], [RoomNumber], [Status]) VALUES (36, 18, N'101', N'Occupied')
INSERT [dbo].[Rooms] ([RoomID], [DepartmentID], [RoomNumber], [Status]) VALUES (37, 18, N'102', N'Available')
INSERT [dbo].[Rooms] ([RoomID], [DepartmentID], [RoomNumber], [Status]) VALUES (38, 13, N'105', N'Available')
INSERT [dbo].[Rooms] ([RoomID], [DepartmentID], [RoomNumber], [Status]) VALUES (39, 19, N'101', N'Available')
INSERT [dbo].[Rooms] ([RoomID], [DepartmentID], [RoomNumber], [Status]) VALUES (40, 15, N'101', N'Occupied')
INSERT [dbo].[Rooms] ([RoomID], [DepartmentID], [RoomNumber], [Status]) VALUES (42, 1022, N'105', N'Available')
SET IDENTITY_INSERT [dbo].[Rooms] OFF
GO
SET IDENTITY_INSERT [dbo].[Services] ON 

INSERT [dbo].[Services] ([ServiceID], [ServiceName], [ServiceDescription], [Price]) VALUES (12, N'Điện', N'Điện tiêu dùng', CAST(4000.00 AS Decimal(10, 2)))
INSERT [dbo].[Services] ([ServiceID], [ServiceName], [ServiceDescription], [Price]) VALUES (13, N'Dịch vụ', N'Wifi, Điện hành lang, Vệ sinh', CAST(100000.00 AS Decimal(10, 2)))
INSERT [dbo].[Services] ([ServiceID], [ServiceName], [ServiceDescription], [Price]) VALUES (14, N'Thang máy', N'Sử dụng thang máy', CAST(20000.00 AS Decimal(10, 2)))
INSERT [dbo].[Services] ([ServiceID], [ServiceName], [ServiceDescription], [Price]) VALUES (15, N'Nước', N'Sử dụng nước', CAST(12000.00 AS Decimal(10, 2)))
INSERT [dbo].[Services] ([ServiceID], [ServiceName], [ServiceDescription], [Price]) VALUES (16, N'Điện VIP', N'Điện VIP', CAST(5000.00 AS Decimal(10, 2)))

SET IDENTITY_INSERT [dbo].[Services] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRooms] ON 

INSERT [dbo].[UserRooms] ([UserRoomID], [UserID], [RoomID], [StartDate], [EndDate], [status]) VALUES (15, 19, 34, CAST(N'2024-07-19T00:00:00.000' AS DateTime), CAST(N'2025-12-19T00:00:00.000' AS DateTime), N'Reject')
INSERT [dbo].[UserRooms] ([UserRoomID], [UserID], [RoomID], [StartDate], [EndDate], [status]) VALUES (16, 19, 34, CAST(N'2024-07-19T00:00:00.000' AS DateTime), CAST(N'2024-10-26T22:33:16.577' AS DateTime), N'Close')
INSERT [dbo].[UserRooms] ([UserRoomID], [UserID], [RoomID], [StartDate], [EndDate], [status]) VALUES (17, 19, 28, CAST(N'2024-07-11T00:00:00.000' AS DateTime), CAST(N'2024-07-19T06:52:29.770' AS DateTime), N'Close')
INSERT [dbo].[UserRooms] ([UserRoomID], [UserID], [RoomID], [StartDate], [EndDate], [status]) VALUES (1014, 19, 40, CAST(N'2024-07-01T00:00:00.000' AS DateTime), CAST(N'2024-11-27T00:00:00.000' AS DateTime), N'Active')
INSERT [dbo].[UserRooms] ([UserRoomID], [UserID], [RoomID], [StartDate], [EndDate], [status]) VALUES (1015, 20, 35, CAST(N'2024-07-19T00:00:00.000' AS DateTime), CAST(N'2025-02-13T00:00:00.000' AS DateTime), N'Pending')
INSERT [dbo].[UserRooms] ([UserRoomID], [UserID], [RoomID], [StartDate], [EndDate], [status]) VALUES (1016, 19, 36, CAST(N'2027-07-02T00:00:00.000' AS DateTime), CAST(N'2024-11-14T00:00:00.000' AS DateTime), N'Active')
INSERT [dbo].[UserRooms] ([UserRoomID], [UserID], [RoomID], [StartDate], [EndDate], [status]) VALUES (1017, 1, 28, CAST(N'2024-10-10T00:00:00.000' AS DateTime), CAST(N'2024-10-17T00:00:00.000' AS DateTime), N'Pending')
SET IDENTITY_INSERT [dbo].[UserRooms] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [Role], [RegistrationDate]) VALUES (1, N'a', N'123', N'user1@example.com', N'User One', N'User', CAST(N'2024-07-04T14:03:30.133' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [Role], [RegistrationDate]) VALUES (2, N'b', N'123', N'manager1@example.com', N'Manager One', N'Manager', CAST(N'2024-07-04T14:03:30.133' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [Role], [RegistrationDate]) VALUES (3, N'test', N'123', N'user123@gmail.com', N'Nguyen Van Nghia', N'User', CAST(N'2024-07-04T16:01:53.777' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [Role], [RegistrationDate]) VALUES (6, N'ducanh', N'123', N'phan@gmail.com', N'Phan Duc Anh', N'Manager', CAST(N'2024-07-16T20:49:32.717' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Username], [PasswordHash], [Email], [FullName], [Role], [RegistrationDate]) VALUES (19, N'ducanh2', N'12345', N'pdanhtb04@gmail.com', N'Phan Đức Anh', N'User', CAST(N'2024-07-17T00:32:51.597' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__536C85E420DFC7A1]    Script Date: 10/26/2024 10:42:06 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [RegistrationDate]
GO
ALTER TABLE [dbo].[UserServices] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([GuestID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([RoomID])
REFERENCES [dbo].[Rooms] ([RoomID])
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[DormImage]  WITH CHECK ADD FOREIGN KEY([dormID])
REFERENCES [dbo].[Departments] ([DepartmentID])
GO
ALTER TABLE [dbo].[DormImage]  WITH CHECK ADD  CONSTRAINT [fk_Image_Dorm] FOREIGN KEY([dormID])
REFERENCES [dbo].[Departments] ([DepartmentID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DormImage] CHECK CONSTRAINT [fk_Image_Dorm]
GO
ALTER TABLE [dbo].[DormService]  WITH CHECK ADD  CONSTRAINT [fk_Service_Dorm] FOREIGN KEY([dormID])
REFERENCES [dbo].[Departments] ([DepartmentID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DormService] CHECK CONSTRAINT [fk_Service_Dorm]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD FOREIGN KEY([BillID])
REFERENCES [dbo].[Bill] ([BillID])
GO
ALTER TABLE [dbo].[Rooms]  WITH CHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Departments] ([DepartmentID])
GO
ALTER TABLE [dbo].[Rooms]  WITH CHECK ADD  CONSTRAINT [fk_Room_Dorm] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Departments] ([DepartmentID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Rooms] CHECK CONSTRAINT [fk_Room_Dorm]
GO
ALTER TABLE [dbo].[UserRooms]  WITH CHECK ADD FOREIGN KEY([RoomID])
REFERENCES [dbo].[Rooms] ([RoomID])
GO
ALTER TABLE [dbo].[UserRooms]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserRooms]  WITH CHECK ADD  CONSTRAINT [fk_user_room] FOREIGN KEY([RoomID])
REFERENCES [dbo].[Rooms] ([RoomID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRooms] CHECK CONSTRAINT [fk_user_room]
GO
ALTER TABLE [dbo].[UserServices]  WITH CHECK ADD FOREIGN KEY([ServiceID])
REFERENCES [dbo].[Services] ([ServiceID])
GO
ALTER TABLE [dbo].[UserServices]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
USE [master]
GO
ALTER DATABASE [DepartmentManagementDB] SET  READ_WRITE 
GO
