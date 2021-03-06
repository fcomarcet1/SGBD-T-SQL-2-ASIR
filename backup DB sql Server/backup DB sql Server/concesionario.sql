USE [master]
GO
/****** Object:  Database [concesionarios]    Script Date: 10/11/2019 10:24:52 ******/
CREATE DATABASE [concesionarios]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'concesionarios', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\concesionarios.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'concesionarios_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\concesionarios_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [concesionarios] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [concesionarios].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [concesionarios] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [concesionarios] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [concesionarios] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [concesionarios] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [concesionarios] SET ARITHABORT OFF 
GO
ALTER DATABASE [concesionarios] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [concesionarios] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [concesionarios] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [concesionarios] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [concesionarios] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [concesionarios] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [concesionarios] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [concesionarios] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [concesionarios] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [concesionarios] SET  DISABLE_BROKER 
GO
ALTER DATABASE [concesionarios] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [concesionarios] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [concesionarios] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [concesionarios] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [concesionarios] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [concesionarios] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [concesionarios] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [concesionarios] SET RECOVERY FULL 
GO
ALTER DATABASE [concesionarios] SET  MULTI_USER 
GO
ALTER DATABASE [concesionarios] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [concesionarios] SET DB_CHAINING OFF 
GO
ALTER DATABASE [concesionarios] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [concesionarios] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [concesionarios] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'concesionarios', N'ON'
GO
ALTER DATABASE [concesionarios] SET QUERY_STORE = OFF
GO
USE [concesionarios]
GO
/****** Object:  Table [dbo].[tblclientes]    Script Date: 10/11/2019 10:24:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblclientes](
	[strId] [nvarchar](10) NULL,
	[strNombre] [nvarchar](30) NULL,
	[strApellido] [nvarchar](30) NULL,
	[strCiudad] [nvarchar](15) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblcoches]    Script Date: 10/11/2019 10:24:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblcoches](
	[strCod] [nvarchar](25) NULL,
	[strNombre] [nvarchar](30) NULL,
	[strMarca] [nvarchar](25) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblconcesionario]    Script Date: 10/11/2019 10:24:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblconcesionario](
	[strCif] [nvarchar](9) NULL,
	[strNombre] [nvarchar](30) NULL,
	[strCiudad] [nvarchar](15) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbldistribucion]    Script Date: 10/11/2019 10:24:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbldistribucion](
	[strCif] [nvarchar](9) NULL,
	[strCoche] [nvarchar](20) NULL,
	[intCantidad] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblmarcas]    Script Date: 10/11/2019 10:24:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblmarcas](
	[strCif] [nvarchar](9) NULL,
	[strNombre] [nvarchar](30) NULL,
	[strCiudad] [nvarchar](15) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblventas]    Script Date: 10/11/2019 10:24:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblventas](
	[strCif] [nvarchar](9) NULL,
	[strDni] [nvarchar](9) NULL,
	[strCoche] [nvarchar](15) NULL,
	[strColor] [nvarchar](15) NULL,
	[dtmFecha] [datetime] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'24583143', N'Jose Luis', N'Perez', N'Alicante')
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'24583143', N'Jose Luis', N'Perez', N'Alicante')
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'65344533', N'Silvia', N'García', N'Alicante')
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'44545433', N'Abdon', N'Bañón', N'Murcia')
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'14123233', N'Raquel', N'Perez', N'Madrid')
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'44567676', N'Fulgencio', N'Oliver', N'La Romana')
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'44599887', N'Javier', N'Romo', N'Madrid')
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'44512333', N'Manuel', N'Ivorra', N'Madrid')
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'67453423', N'Alvaro', N'Kamen', N'Madrid')
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'87643455', N'Sergi', N'Villaplana', N'Alicante')
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'76357844', N'Carles', N'Puig', N'Barcelona')
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'76411111', N'Antoni', N'Punset', N'Ibiza')
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'11111112', N'Carlos', N'Pérez', N'Valencia')
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'22222211', N'José', N'Jover', N'Valencia')
INSERT [dbo].[tblclientes] ([strId], [strNombre], [strApellido], [strCiudad]) VALUES (N'00000031', N'Francisco', N'Esteve', N'Zaragoza')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'BMWe86', N'BMW Serie 1', N'BMW')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'BMWe86', N'BMW Serie 1', N'BMW')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'BMWe46', N'BMW Serie 3', N'BMW')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'BMWe34', N'BMW Serie 5', N'BMW')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'BMWe45', N'BMW Serie 7', N'BMW')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'BMWe87', N'BMW Serie 4', N'BMW')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'A3', N'AUDI A3', N'AUDI')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'A5', N'AUDI A5', N'AUDI')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'A6Q', N'AUDI A6 QUATTRO', N'AUDI')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'C4C', N'C4', N'Citroen')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'C5C', N'C5', N'Citroen')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'IBIZA', N'Ibiza', N'Seat')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'KCEED', N'CEED', N'KIA')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'KSPORT', N'SPORTAGE', N'KIA')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'KRIO', N'RIO', N'KIA')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'NISQA', N'QASQAI', N'Nissan')
INSERT [dbo].[tblcoches] ([strCod], [strNombre], [strMarca]) VALUES (N'NISPU', N'PULSAR', N'Nissan')
INSERT [dbo].[tblconcesionario] ([strCif], [strNombre], [strCiudad]) VALUES (N'44543123', N'Fercar', N'Alicante')
INSERT [dbo].[tblconcesionario] ([strCif], [strNombre], [strCiudad]) VALUES (N'44543123', N'Fercar', N'Alicante')
INSERT [dbo].[tblconcesionario] ([strCif], [strNombre], [strCiudad]) VALUES (N'85543123', N'Multi Car', N'Alicante')
INSERT [dbo].[tblconcesionario] ([strCif], [strNombre], [strCiudad]) VALUES (N'77323232', N'Motor Sport', N'Murcia')
INSERT [dbo].[tblconcesionario] ([strCif], [strNombre], [strCiudad]) VALUES (N'85643123', N'BMW Villa de campo', N'Madrid')
INSERT [dbo].[tblconcesionario] ([strCif], [strNombre], [strCiudad]) VALUES (N'76543213', N'Todo motor', N'Madrid')
INSERT [dbo].[tblconcesionario] ([strCif], [strNombre], [strCiudad]) VALUES (N'98654678', N'Tope Gama', N'Madrid')
INSERT [dbo].[tblconcesionario] ([strCif], [strNombre], [strCiudad]) VALUES (N'11232123', N'BMW Barna', N'Barcelona')
INSERT [dbo].[tblconcesionario] ([strCif], [strNombre], [strCiudad]) VALUES (N'54345432', N'Tot Turbo', N'Barcelona')
INSERT [dbo].[tblconcesionario] ([strCif], [strNombre], [strCiudad]) VALUES (N'32323232', N'4 rodes', N'Ibiza')
INSERT [dbo].[tblconcesionario] ([strCif], [strNombre], [strCiudad]) VALUES (N'56429642', N'Grant Turismo', N'Alicante')
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'44543123', N'BMWe86', 5)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'44543123', N'BMWe86', 5)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'44543123', N'BMWe46', 15)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'44543123', N'BMWe34', 4)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'85543123', N'NISPU', 12)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'85543123', N'BMWm45', 21)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'85543123', N'C4C', 15)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'77323232', N'A3', 3)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'77323232', N'KRIO', 1)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'76543213', N'KRIO', 6)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'77323232', N'C4C', 2)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'85643123', N'A6Q', 3)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'85643123', N'NISPU', 4)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'85643123', N'BMWm45', 5)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'76543213', N'C4C', 6)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'76543213', N'KCEED', 7)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'76543213', N'A3', 8)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'98654678', N'C4C', 1)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'98654678', N'A6Q', 6)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'98654678', N'KSPORT', 8)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'11232123', N'NISQA', 9)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'11232123', N'A3', 14)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'11232123', N'C5C', 16)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'54345432', N'BMWm45', 15)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'54345432', N'KSPORT', 15)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'54345432', N'A6Q', 25)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'32323232', N'NISQA', 1)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'32323232', N'KCEED', 3)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'32323232', N'IBIZA', 0)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'44543123', N'BMWe86', 5)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'44543123', N'BMWe46', 15)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'44543123', N'BMWe34', 4)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'85543123', N'NISPU', 12)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'85543123', N'BMWm45', 21)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'85543123', N'C4C', 15)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'77323232', N'A3', 3)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'77323232', N'KRIO', 1)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'76543213', N'KRIO', 6)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'77323232', N'C4C', 2)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'85643123', N'A6Q', 3)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'85643123', N'NISPU', 4)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'85643123', N'BMWm45', 5)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'76543213', N'C4C', 6)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'76543213', N'KCEED', 7)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'76543213', N'A3', 8)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'98654678', N'C4C', 1)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'98654678', N'A6Q', 6)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'98654678', N'KSPORT', 8)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'11232123', N'NISQA', 9)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'11232123', N'A3', 14)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'11232123', N'C5C', 16)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'54345432', N'BMWm45', 15)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'54345432', N'KSPORT', 15)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'54345432', N'A6Q', 25)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'32323232', N'NISQA', 1)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'32323232', N'KCEED', 3)
INSERT [dbo].[tbldistribucion] ([strCif], [strCoche], [intCantidad]) VALUES (N'32323232', N'IBIZA', 0)
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'1', N'BMW', N'Barcelona')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'1', N'BMW', N'Barcelona')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'2', N'AUDI', N'Madrid')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'3', N'Citroen', N'Vigo')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'4', N'Seat', N'Barcelona')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'5', N'KIA', N'Madrid')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'6', N'Renault', N'Valladolid')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'7', N'Opel', N'Zaragoza')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'8', N'Ford', N'Valencia')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'9', N'Mercedes', N'Vitoria')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'1', N'BMW', N'Barcelona')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'2', N'AUDI', N'Madrid')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'3', N'Citroen', N'Vigo')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'4', N'Seat', N'Barcelona')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'5', N'KIA', N'Madrid')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'6', N'Renault', N'Valladolid')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'7', N'Opel', N'Zaragoza')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'8', N'Ford', N'Valencia')
INSERT [dbo].[tblmarcas] ([strCif], [strNombre], [strCiudad]) VALUES (N'9', N'Mercedes', N'Vitoria')
INSERT [dbo].[tblventas] ([strCif], [strDni], [strCoche], [strColor], [dtmFecha]) VALUES (N'76543213', N'24583143', N'KRIO', N'rojo', CAST(N'2016-03-06T00:00:00.000' AS DateTime))
INSERT [dbo].[tblventas] ([strCif], [strDni], [strCoche], [strColor], [dtmFecha]) VALUES (N'76543213', N'24583143', N'KRIO', N'rojo', CAST(N'2016-03-06T00:00:00.000' AS DateTime))
INSERT [dbo].[tblventas] ([strCif], [strDni], [strCoche], [strColor], [dtmFecha]) VALUES (N'44543123', N'24583143', N'BMWe86', N'rojo', CAST(N'2016-03-06T00:00:00.000' AS DateTime))
INSERT [dbo].[tblventas] ([strCif], [strDni], [strCoche], [strColor], [dtmFecha]) VALUES (N'85543123', N'65344533', N'NISPU', N'blanco', CAST(N'2016-04-03T00:00:00.000' AS DateTime))
INSERT [dbo].[tblventas] ([strCif], [strDni], [strCoche], [strColor], [dtmFecha]) VALUES (N'85543123', N'44545433', N'NISPU', N'rojo', CAST(N'2016-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[tblventas] ([strCif], [strDni], [strCoche], [strColor], [dtmFecha]) VALUES (N'85543123', N'44599887', N'NISPU', N'rojo', CAST(N'2016-06-01T00:00:00.000' AS DateTime))
INSERT [dbo].[tblventas] ([strCif], [strDni], [strCoche], [strColor], [dtmFecha]) VALUES (N'85543123', N'14123233', N'C4C', N'blanco', CAST(N'2016-07-02T00:00:00.000' AS DateTime))
INSERT [dbo].[tblventas] ([strCif], [strDni], [strCoche], [strColor], [dtmFecha]) VALUES (N'77323232', N'87643455', N'KRIO', N'rojo', CAST(N'2016-06-07T00:00:00.000' AS DateTime))
INSERT [dbo].[tblventas] ([strCif], [strDni], [strCoche], [strColor], [dtmFecha]) VALUES (N'77323232', N'76357844', N'C4C', N'azul', CAST(N'2016-07-08T00:00:00.000' AS DateTime))
INSERT [dbo].[tblventas] ([strCif], [strDni], [strCoche], [strColor], [dtmFecha]) VALUES (N'85643123', N'76411111', N'A6Q', N'blanco', CAST(N'2016-08-09T00:00:00.000' AS DateTime))
INSERT [dbo].[tblventas] ([strCif], [strDni], [strCoche], [strColor], [dtmFecha]) VALUES (N'76543213', N'11111112', N'KCEED', N'azul', CAST(N'2016-09-10T00:00:00.000' AS DateTime))
INSERT [dbo].[tblventas] ([strCif], [strDni], [strCoche], [strColor], [dtmFecha]) VALUES (N'76543213', N'14123233', N'A3', N'blanco', CAST(N'2016-11-12T00:00:00.000' AS DateTime))
INSERT [dbo].[tblventas] ([strCif], [strDni], [strCoche], [strColor], [dtmFecha]) VALUES (N'98654678', N'00000031', N'KSPORT', N'azul', CAST(N'2016-12-06T00:00:00.000' AS DateTime))
INSERT [dbo].[tblventas] ([strCif], [strDni], [strCoche], [strColor], [dtmFecha]) VALUES (N'44543123', N'22222211', N'BMWe86', N'rojo', CAST(N'2016-05-10T00:00:00.000' AS DateTime))
USE [master]
GO
ALTER DATABASE [concesionarios] SET  READ_WRITE 
GO
