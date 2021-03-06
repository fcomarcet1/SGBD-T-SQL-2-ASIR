USE [master]
GO
/****** Object:  Database [tienda informatica]    Script Date: 10/11/2019 11:41:42 ******/
CREATE DATABASE [tienda informatica]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tienda informatica', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\tienda informatica.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'tienda informatica_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\tienda informatica_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [tienda informatica] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [tienda informatica].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [tienda informatica] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [tienda informatica] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [tienda informatica] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [tienda informatica] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [tienda informatica] SET ARITHABORT OFF 
GO
ALTER DATABASE [tienda informatica] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [tienda informatica] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [tienda informatica] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [tienda informatica] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [tienda informatica] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [tienda informatica] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [tienda informatica] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [tienda informatica] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [tienda informatica] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [tienda informatica] SET  DISABLE_BROKER 
GO
ALTER DATABASE [tienda informatica] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [tienda informatica] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [tienda informatica] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [tienda informatica] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [tienda informatica] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [tienda informatica] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [tienda informatica] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [tienda informatica] SET RECOVERY FULL 
GO
ALTER DATABASE [tienda informatica] SET  MULTI_USER 
GO
ALTER DATABASE [tienda informatica] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [tienda informatica] SET DB_CHAINING OFF 
GO
ALTER DATABASE [tienda informatica] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [tienda informatica] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [tienda informatica] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'tienda informatica', N'ON'
GO
ALTER DATABASE [tienda informatica] SET QUERY_STORE = OFF
GO
USE [tienda informatica]
GO
/****** Object:  Table [dbo].[tblArticulos]    Script Date: 10/11/2019 11:41:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblArticulos](
	[intCodigo] [int] IDENTITY(1,1) NOT NULL,
	[strNombre] [nvarchar](100) NULL,
	[intPrecio] [int] NULL,
	[intFabricante] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[intCodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFabricantes]    Script Date: 10/11/2019 11:41:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFabricantes](
	[intCodigo] [int] IDENTITY(1,1) NOT NULL,
	[strNombre] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[intCodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblArticulos]  WITH CHECK ADD  CONSTRAINT [fk_articulosFabricantes] FOREIGN KEY([intFabricante])
REFERENCES [dbo].[tblFabricantes] ([intCodigo])
GO
ALTER TABLE [dbo].[tblArticulos] CHECK CONSTRAINT [fk_articulosFabricantes]
GO
USE [master]
GO
ALTER DATABASE [tienda informatica] SET  READ_WRITE 
GO
