USE [master]
GO
/****** Object:  Database [videoclub_transacciones]    Script Date: 10/11/2019 11:43:02 ******/
CREATE DATABASE [videoclub_transacciones]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'videoclub_transacciones', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\videoclub_transacciones.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'videoclub_transacciones_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\videoclub_transacciones_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [videoclub_transacciones] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [videoclub_transacciones].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [videoclub_transacciones] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET ARITHABORT OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [videoclub_transacciones] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [videoclub_transacciones] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET  DISABLE_BROKER 
GO
ALTER DATABASE [videoclub_transacciones] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [videoclub_transacciones] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET RECOVERY FULL 
GO
ALTER DATABASE [videoclub_transacciones] SET  MULTI_USER 
GO
ALTER DATABASE [videoclub_transacciones] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [videoclub_transacciones] SET DB_CHAINING OFF 
GO
ALTER DATABASE [videoclub_transacciones] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [videoclub_transacciones] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [videoclub_transacciones] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'videoclub_transacciones', N'ON'
GO
ALTER DATABASE [videoclub_transacciones] SET QUERY_STORE = OFF
GO
USE [videoclub_transacciones]
GO
/****** Object:  Table [dbo].[PeliculasMasVistas]    Script Date: 10/11/2019 11:43:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeliculasMasVistas](
	[Codigo] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](25) NULL,
	[Categoria] [nvarchar](25) NULL,
	[numAlquileres] [int] NULL,
	[PrecioAlquiler] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblalqulier]    Script Date: 10/11/2019 11:43:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblalqulier](
	[intCodigosocio] [int] NOT NULL,
	[intCodigostock] [int] NOT NULL,
	[dtmFechasalida] [datetime] NOT NULL,
	[dtmFechadevolucion] [datetime] NOT NULL,
	[intEstado] [smallint] NULL,
	[intCalificacion] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[intCodigosocio] ASC,
	[intCodigostock] ASC,
	[dtmFechasalida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblpeliculas]    Script Date: 10/11/2019 11:43:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblpeliculas](
	[intCodigo] [int] NOT NULL,
	[strTitulo] [nvarchar](40) NULL,
	[intCodigocategoria] [int] NULL,
	[strCompañia] [nvarchar](15) NULL,
	[intDuracion] [smallint] NULL,
	[mnyPreciocompra] [money] NULL,
	[mnyPrecioalquiler] [money] NULL,
	[intMaximodias] [smallint] NULL,
	[rlOferta] [real] NULL,
	[ntxtComentario] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[intCodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblsocios]    Script Date: 10/11/2019 11:43:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblsocios](
	[strDni] [nvarchar](9) NOT NULL,
	[intCodigo] [int] NOT NULL,
	[strNombre] [nvarchar](30) NOT NULL,
	[strApellido] [nvarchar](40) NOT NULL,
	[strTelefono] [nvarchar](10) NULL,
	[dtmFechanacimiento] [datetime] NULL,
	[blnClientevip] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[strDni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblstock]    Script Date: 10/11/2019 11:43:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblstock](
	[intCodigo] [int] NOT NULL,
	[intCodigopelicula] [int] NULL,
	[strFormato] [nvarchar](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[intCodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tblalqulier] ([intCodigosocio], [intCodigostock], [dtmFechasalida], [dtmFechadevolucion], [intEstado], [intCalificacion]) VALUES (1, 1, CAST(N'2019-07-04T00:00:00.000' AS DateTime), CAST(N'2019-07-06T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[tblalqulier] ([intCodigosocio], [intCodigostock], [dtmFechasalida], [dtmFechadevolucion], [intEstado], [intCalificacion]) VALUES (2, 3, CAST(N'2019-08-05T00:00:00.000' AS DateTime), CAST(N'2019-08-07T00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[tblpeliculas] ([intCodigo], [strTitulo], [intCodigocategoria], [strCompañia], [intDuracion], [mnyPreciocompra], [mnyPrecioalquiler], [intMaximodias], [rlOferta], [ntxtComentario]) VALUES (1, N'ramboI', 1, N'warner', 90, 30.0000, 5.0000, 3, 1, N'aaa')
INSERT [dbo].[tblpeliculas] ([intCodigo], [strTitulo], [intCodigocategoria], [strCompañia], [intDuracion], [mnyPreciocompra], [mnyPrecioalquiler], [intMaximodias], [rlOferta], [ntxtComentario]) VALUES (2, N'rambo2', 1, N'warner', 60, 20.0000, 6.0000, 3, NULL, NULL)
INSERT [dbo].[tblpeliculas] ([intCodigo], [strTitulo], [intCodigocategoria], [strCompañia], [intDuracion], [mnyPreciocompra], [mnyPrecioalquiler], [intMaximodias], [rlOferta], [ntxtComentario]) VALUES (3, N'rambo 3', 1, N'bbh', 80, 132.0000, 7.0000, 3, NULL, NULL)
INSERT [dbo].[tblpeliculas] ([intCodigo], [strTitulo], [intCodigocategoria], [strCompañia], [intDuracion], [mnyPreciocompra], [mnyPrecioalquiler], [intMaximodias], [rlOferta], [ntxtComentario]) VALUES (4, N'casablanca', 2, N'ghj', 55, 12.0000, 2.0000, 3, NULL, NULL)
INSERT [dbo].[tblpeliculas] ([intCodigo], [strTitulo], [intCodigocategoria], [strCompañia], [intDuracion], [mnyPreciocompra], [mnyPrecioalquiler], [intMaximodias], [rlOferta], [ntxtComentario]) VALUES (5, N'resident evil', 3, N'ser', 99, 127.0000, 4.0000, NULL, NULL, NULL)
INSERT [dbo].[tblsocios] ([strDni], [intCodigo], [strNombre], [strApellido], [strTelefono], [dtmFechanacimiento], [blnClientevip]) VALUES (N'11225664L', 4, N'nacho', N'garcia', N'636544778', CAST(N'1960-02-20T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tblsocios] ([strDni], [intCodigo], [strNombre], [strApellido], [strTelefono], [dtmFechanacimiento], [blnClientevip]) VALUES (N'21357489G', 3, N'pepe', N'lotas', N'478523651', CAST(N'1980-04-23T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[tblsocios] ([strDni], [intCodigo], [strNombre], [strApellido], [strTelefono], [dtmFechanacimiento], [blnClientevip]) VALUES (N'47665824A', 2, N'merche', N'lopez', N'555474585', CAST(N'1990-05-14T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[tblsocios] ([strDni], [intCodigo], [strNombre], [strApellido], [strTelefono], [dtmFechanacimiento], [blnClientevip]) VALUES (N'48330190Z', 1, N'francisco', N'marcet', N'636585669', CAST(N'1984-10-26T00:00:00.000' AS DateTime), 1)
USE [master]
GO
ALTER DATABASE [videoclub_transacciones] SET  READ_WRITE 
GO
