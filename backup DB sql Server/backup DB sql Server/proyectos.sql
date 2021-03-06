USE [master]
GO
/****** Object:  Database [proyectos]    Script Date: 10/11/2019 11:40:18 ******/
CREATE DATABASE [proyectos]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'proyectos', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\proyectos.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'proyectos_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\proyectos_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [proyectos] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [proyectos].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [proyectos] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [proyectos] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [proyectos] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [proyectos] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [proyectos] SET ARITHABORT OFF 
GO
ALTER DATABASE [proyectos] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [proyectos] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [proyectos] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [proyectos] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [proyectos] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [proyectos] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [proyectos] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [proyectos] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [proyectos] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [proyectos] SET  DISABLE_BROKER 
GO
ALTER DATABASE [proyectos] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [proyectos] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [proyectos] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [proyectos] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [proyectos] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [proyectos] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [proyectos] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [proyectos] SET RECOVERY FULL 
GO
ALTER DATABASE [proyectos] SET  MULTI_USER 
GO
ALTER DATABASE [proyectos] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [proyectos] SET DB_CHAINING OFF 
GO
ALTER DATABASE [proyectos] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [proyectos] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [proyectos] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'proyectos', N'ON'
GO
ALTER DATABASE [proyectos] SET QUERY_STORE = OFF
GO
USE [proyectos]
GO
/****** Object:  Table [dbo].[tblclientes]    Script Date: 10/11/2019 11:40:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblclientes](
	[intCodigocliente] [int] NOT NULL,
	[strNombrecliente] [nvarchar](30) NULL,
	[strNif] [nvarchar](10) NULL,
	[strDireccion] [nvarchar](40) NULL,
	[strCiudad] [nvarchar](30) NULL,
	[strTelefono] [nvarchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[intCodigocliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbldepartamentos]    Script Date: 10/11/2019 11:40:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbldepartamentos](
	[strNombredep] [nvarchar](15) NULL,
	[strCiudaddep] [nvarchar](15) NULL,
	[strTelefono] [nvarchar](15) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblempleados]    Script Date: 10/11/2019 11:40:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblempleados](
	[intCodempleado] [int] NOT NULL,
	[strNombreem] [nvarchar](30) NULL,
	[strApellidoem] [nvarchar](30) NULL,
	[mnySueldo] [money] NULL,
	[strNombredp] [nvarchar](30) NULL,
	[strCiudaddp] [nvarchar](15) NULL,
	[strNumpro] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[intCodempleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblproyectos]    Script Date: 10/11/2019 11:40:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblproyectos](
	[intCodpro] [int] NOT NULL,
	[strNombrepro] [nvarchar](10) NULL,
	[mnyPrecio] [money] NULL,
	[dtmFechainicio] [datetime] NULL,
	[dtmFechaprevfi] [datetime] NULL,
	[dtmFechafin] [datetime] NULL,
	[intCodigocli] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[intCodpro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tbldepartamentos] ([strNombredep], [strCiudaddep], [strTelefono]) VALUES (N'DIR', N'Barcelona', N'934226070')
INSERT [dbo].[tbldepartamentos] ([strNombredep], [strCiudaddep], [strTelefono]) VALUES (N'DIR', N'Barcelona', N'934226070')
INSERT [dbo].[tbldepartamentos] ([strNombredep], [strCiudaddep], [strTelefono]) VALUES (N'DIR', N'Barcelona', N'93.422.60.70')
INSERT [dbo].[tbldepartamentos] ([strNombredep], [strCiudaddep], [strTelefono]) VALUES (N'DIR', N'Girona', N'972.23.89.70')
INSERT [dbo].[tbldepartamentos] ([strNombredep], [strCiudaddep], [strTelefono]) VALUES (N'DIS', N'Lleida', N'973.23.50.40')
INSERT [dbo].[tbldepartamentos] ([strNombredep], [strCiudaddep], [strTelefono]) VALUES (N'DIS', N'Barcelona', N'93.224.85.23')
INSERT [dbo].[tbldepartamentos] ([strNombredep], [strCiudaddep], [strTelefono]) VALUES (N'PROG', N'Tarragona', N'977.33.38.52')
INSERT [dbo].[tbldepartamentos] ([strNombredep], [strCiudaddep], [strTelefono]) VALUES (N'PROG', N'Girona', N'972.23.50.91')
INSERT [dbo].[tblempleados] ([intCodempleado], [strNombreem], [strApellidoem], [mnySueldo], [strNombredp], [strCiudaddp], [strNumpro]) VALUES (1, N'Maria', N'Puig', 100000.0000, N'DIR', N'Girona', N'1')
INSERT [dbo].[tblempleados] ([intCodempleado], [strNombreem], [strApellidoem], [mnySueldo], [strNombredp], [strCiudaddp], [strNumpro]) VALUES (2, N'pedro', N'MAs', 90000.0000, N'DIR', N'Barcelona', N'4')
INSERT [dbo].[tblempleados] ([intCodempleado], [strNombreem], [strApellidoem], [mnySueldo], [strNombredp], [strCiudaddp], [strNumpro]) VALUES (3, N'Ana', N'Ros', 70000.0000, N'DIS', N'Lleida', N'3')
INSERT [dbo].[tblempleados] ([intCodempleado], [strNombreem], [strApellidoem], [mnySueldo], [strNombredp], [strCiudaddp], [strNumpro]) VALUES (4, N'Jorge', N'Roca', 70000.0000, N'DIS', N'Barcelona', N'4')
INSERT [dbo].[tblempleados] ([intCodempleado], [strNombreem], [strApellidoem], [mnySueldo], [strNombredp], [strCiudaddp], [strNumpro]) VALUES (5, N'Clara', N'Blanc', 40000.0000, N'PROG', N'Tarragona', N'1')
INSERT [dbo].[tblempleados] ([intCodempleado], [strNombreem], [strApellidoem], [mnySueldo], [strNombredp], [strCiudaddp], [strNumpro]) VALUES (6, N'Laura', N'Tort', 30000.0000, N'PROG', N'Tarragona', N'3')
INSERT [dbo].[tblempleados] ([intCodempleado], [strNombreem], [strApellidoem], [mnySueldo], [strNombredp], [strCiudaddp], [strNumpro]) VALUES (7, N'Rogelio', N'Salt', 40000.0000, N'NULL', N'NULL', N'4')
INSERT [dbo].[tblempleados] ([intCodempleado], [strNombreem], [strApellidoem], [mnySueldo], [strNombredp], [strCiudaddp], [strNumpro]) VALUES (8, N'Rogelio', N'Grau', 30000.0000, N'PROG', N'Tarragona', NULL)
INSERT [dbo].[tblproyectos] ([intCodpro], [strNombrepro], [mnyPrecio], [dtmFechainicio], [dtmFechaprevfi], [dtmFechafin], [intCodigocli]) VALUES (1, N'GESCOM', 1000000.0000, CAST(N'2017-01-01T00:00:00.000' AS DateTime), CAST(N'2019-01-01T00:00:00.000' AS DateTime), NULL, 10)
INSERT [dbo].[tblproyectos] ([intCodpro], [strNombrepro], [mnyPrecio], [dtmFechainicio], [dtmFechaprevfi], [dtmFechafin], [intCodigocli]) VALUES (2, N'TSB', 2000000.0000, CAST(N'2018-01-01T00:00:00.000' AS DateTime), CAST(N'2019-03-31T00:00:00.000' AS DateTime), CAST(N'2019-05-01T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[tblproyectos] ([intCodpro], [strNombrepro], [mnyPrecio], [dtmFechainicio], [dtmFechaprevfi], [dtmFechafin], [intCodigocli]) VALUES (3, N'SALSA', 1000000.0000, CAST(N'2017-02-10T00:00:00.000' AS DateTime), CAST(N'2019-02-01T00:00:00.000' AS DateTime), NULL, 10)
INSERT [dbo].[tblproyectos] ([intCodpro], [strNombrepro], [mnyPrecio], [dtmFechainicio], [dtmFechaprevfi], [dtmFechafin], [intCodigocli]) VALUES (4, N'TINELL', 4000000.0000, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2020-01-12T00:00:00.000' AS DateTime), NULL, 10)
INSERT [dbo].[tblproyectos] ([intCodpro], [strNombrepro], [mnyPrecio], [dtmFechainicio], [dtmFechaprevfi], [dtmFechafin], [intCodigocli]) VALUES (6, N'CCC', 1000000.0000, CAST(N'2019-01-01T00:00:00.000' AS DateTime), CAST(N'2020-01-01T00:00:00.000' AS DateTime), NULL, 10)
USE [master]
GO
ALTER DATABASE [proyectos] SET  READ_WRITE 
GO
