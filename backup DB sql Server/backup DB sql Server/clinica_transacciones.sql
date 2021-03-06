USE [master]
GO
/****** Object:  Database [clinica_transacciones]    Script Date: 10/11/2019 10:26:26 ******/
CREATE DATABASE [clinica_transacciones]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'clinica_transacciones', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\clinica_transacciones.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'clinica_transacciones_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\clinica_transacciones_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [clinica_transacciones] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [clinica_transacciones].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [clinica_transacciones] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [clinica_transacciones] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [clinica_transacciones] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [clinica_transacciones] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [clinica_transacciones] SET ARITHABORT OFF 
GO
ALTER DATABASE [clinica_transacciones] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [clinica_transacciones] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [clinica_transacciones] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [clinica_transacciones] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [clinica_transacciones] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [clinica_transacciones] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [clinica_transacciones] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [clinica_transacciones] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [clinica_transacciones] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [clinica_transacciones] SET  DISABLE_BROKER 
GO
ALTER DATABASE [clinica_transacciones] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [clinica_transacciones] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [clinica_transacciones] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [clinica_transacciones] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [clinica_transacciones] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [clinica_transacciones] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [clinica_transacciones] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [clinica_transacciones] SET RECOVERY FULL 
GO
ALTER DATABASE [clinica_transacciones] SET  MULTI_USER 
GO
ALTER DATABASE [clinica_transacciones] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [clinica_transacciones] SET DB_CHAINING OFF 
GO
ALTER DATABASE [clinica_transacciones] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [clinica_transacciones] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [clinica_transacciones] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'clinica_transacciones', N'ON'
GO
ALTER DATABASE [clinica_transacciones] SET QUERY_STORE = OFF
GO
USE [clinica_transacciones]
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = ON;
GO
USE [clinica_transacciones]
GO
/****** Object:  Table [dbo].[CopiaPacientesAlicante]    Script Date: 10/11/2019 10:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CopiaPacientesAlicante](
	[strNombre] [nvarchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblpacientes]    Script Date: 10/11/2019 10:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblpacientes](
	[intCodigo] [smallint] NOT NULL,
	[strNombre] [nvarchar](30) NULL,
	[strDireccion] [nvarchar](20) NULL,
	[strCiudad] [nvarchar](15) NULL,
	[strTelefono] [nvarchar](10) NULL,
	[btDiabetico] [bit] NOT NULL,
	[dtmFechanac] [datetime] NULL,
	[intTurno] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[intCodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblvisitas]    Script Date: 10/11/2019 10:26:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblvisitas](
	[intNumvisita] [int] NOT NULL,
	[dtmFecha] [datetime] NULL,
	[strEnfermedad] [nvarchar](25) NULL,
	[intImporte] [int] NULL,
	[intPorcentajepago] [smallint] NULL,
	[dtmProxvisita] [datetime] NULL,
	[intCodigopaciente] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[intNumvisita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[CopiaPacientesAlicante] ([strNombre]) VALUES (N'David Ramirez')
INSERT [dbo].[CopiaPacientesAlicante] ([strNombre]) VALUES (N'Emilio Pérez')
INSERT [dbo].[CopiaPacientesAlicante] ([strNombre]) VALUES (N'Jose Gonzalez')
INSERT [dbo].[CopiaPacientesAlicante] ([strNombre]) VALUES (N'Roberto Saez')
INSERT [dbo].[tblpacientes] ([intCodigo], [strNombre], [strDireccion], [strCiudad], [strTelefono], [btDiabetico], [dtmFechanac], [intTurno]) VALUES (30001, N'Jose Gonzalez', N'Paseo Agran', N'ALICANTE', N'856262515', 0, CAST(N'1990-08-10T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tblpacientes] ([intCodigo], [strNombre], [strDireccion], [strCiudad], [strTelefono], [btDiabetico], [dtmFechanac], [intTurno]) VALUES (30003, N'Gabriel García', N'Constitució n17 4B', N'SAN JUAN', N'744671599', 0, CAST(N'1967-03-13T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[tblpacientes] ([intCodigo], [strNombre], [strDireccion], [strCiudad], [strTelefono], [btDiabetico], [dtmFechanac], [intTurno]) VALUES (30004, N'Ana Tuent', N' C. Comercial Flitam', N'SAN JUAN', N'680090786', 0, CAST(N'1989-04-14T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tblpacientes] ([intCodigo], [strNombre], [strDireccion], [strCiudad], [strTelefono], [btDiabetico], [dtmFechanac], [intTurno]) VALUES (30006, N'Maria Navarro', N'Carrera Destarotem', N'EL CAMPELLO', N'767031177', 1, CAST(N'1954-01-16T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[tblpacientes] ([intCodigo], [strNombre], [strDireccion], [strCiudad], [strTelefono], [btDiabetico], [dtmFechanac], [intTurno]) VALUES (30012, N'Javier Satorres', N'Camino Desnieris', N'MUTXAMEL', N'765293339', 1, CAST(N'1991-11-18T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[tblpacientes] ([intCodigo], [strNombre], [strDireccion], [strCiudad], [strTelefono], [btDiabetico], [dtmFechanac], [intTurno]) VALUES (30014, N'Jorge Beltrán', N'Rambla Convulsàssim', N'SAN JUAN', N'656742684', 1, CAST(N'1978-11-21T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[tblpacientes] ([intCodigo], [strNombre], [strDireccion], [strCiudad], [strTelefono], [btDiabetico], [dtmFechanac], [intTurno]) VALUES (30015, N'Beatriz Rico', N'Walia, 21', N' VILLAJOYOSA', N'965636585', 1, CAST(N'1974-12-23T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tblpacientes] ([intCodigo], [strNombre], [strDireccion], [strCiudad], [strTelefono], [btDiabetico], [dtmFechanac], [intTurno]) VALUES (30016, N'Roberto Saez', N'Macarena n23', N'ALICANTE', N'965634041', 1, CAST(N'1969-03-24T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tblpacientes] ([intCodigo], [strNombre], [strDireccion], [strCiudad], [strTelefono], [btDiabetico], [dtmFechanac], [intTurno]) VALUES (30017, N'Emilio Pérez', N'Alfonso Pesquera', N'ALICANTE', N'965635815', 0, CAST(N'1984-05-26T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[tblpacientes] ([intCodigo], [strNombre], [strDireccion], [strCiudad], [strTelefono], [btDiabetico], [dtmFechanac], [intTurno]) VALUES (30018, N'Sandra Belda', N'San Pedro', N'VILLAJOYOSA', N'753633365', 1, CAST(N'1983-06-27T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[tblpacientes] ([intCodigo], [strNombre], [strDireccion], [strCiudad], [strTelefono], [btDiabetico], [dtmFechanac], [intTurno]) VALUES (30026, N'Laura Pastor', N'Prolongación Salud', N'MUTXAMEL', N'616975467', 0, CAST(N'1963-09-07T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tblpacientes] ([intCodigo], [strNombre], [strDireccion], [strCiudad], [strTelefono], [btDiabetico], [dtmFechanac], [intTurno]) VALUES (30099, N'David Ramirez', N'Sant Rafael', N'ALICANTE', N'786261666', 1, CAST(N'1972-03-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (1, CAST(N'2019-12-09T00:00:00.000' AS DateTime), N'Úlcera', 50, 50, CAST(N'2019-12-11T00:00:00.000' AS DateTime), 30001)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (2, CAST(N'2019-02-15T00:00:00.000' AS DateTime), N'Migrañas', 50, 25, CAST(N'2019-05-15T00:00:00.000' AS DateTime), 30001)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (4, CAST(N'2019-05-15T00:00:00.000' AS DateTime), N'Anemia', 80, 40, CAST(N'2019-09-15T00:00:00.000' AS DateTime), 30004)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (6, CAST(N'2019-01-08T00:00:00.000' AS DateTime), N'Amigdalitis', 60, 50, CAST(N'2019-01-11T00:00:00.000' AS DateTime), 30006)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (8, CAST(N'2019-04-07T00:00:00.000' AS DateTime), N'Otitis', 80, 80, CAST(N'2019-04-10T00:00:00.000' AS DateTime), 30012)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (9, CAST(N'2019-07-06T00:00:00.000' AS DateTime), N'Migrañas', 60, 55, CAST(N'2019-07-07T00:00:00.000' AS DateTime), 30014)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (10, CAST(N'2019-09-02T00:00:00.000' AS DateTime), N'Herpes', 50, 15, CAST(N'2019-09-06T00:00:00.000' AS DateTime), 30015)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (11, CAST(N'2019-05-14T00:00:00.000' AS DateTime), N'Anemia', 45, 20, CAST(N'2019-09-14T00:00:00.000' AS DateTime), 30016)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (12, CAST(N'2019-01-13T00:00:00.000' AS DateTime), N'Anemia', 67, 50, CAST(N'2019-06-13T00:00:00.000' AS DateTime), 30017)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (13, CAST(N'2019-04-04T00:00:00.000' AS DateTime), N'Herpes', 100, 25, CAST(N'2019-04-05T00:00:00.000' AS DateTime), 30018)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (14, CAST(N'2019-08-03T00:00:00.000' AS DateTime), N'Migrañas', 50, 60, CAST(N'2019-08-07T00:00:00.000' AS DateTime), 30026)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (15, CAST(N'2019-06-23T00:00:00.000' AS DateTime), N'Otitis', 40, 40, CAST(N'2019-10-23T00:00:00.000' AS DateTime), 30099)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (18, CAST(N'2019-06-30T00:00:00.000' AS DateTime), N'Migrañas', 50, 70, CAST(N'2019-07-30T00:00:00.000' AS DateTime), 30004)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (21, CAST(N'2017-08-15T00:00:00.000' AS DateTime), N'Gripe', 40, 15, CAST(N'2017-09-15T00:00:00.000' AS DateTime), 30004)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (22, CAST(N'2017-08-21T00:00:00.000' AS DateTime), N'Otitis', 80, 20, CAST(N'2017-10-21T00:00:00.000' AS DateTime), 30004)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (23, CAST(N'2017-07-23T00:00:00.000' AS DateTime), N'Amigdalitis', 60, 50, CAST(N'2017-09-23T00:00:00.000' AS DateTime), 30012)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (25, CAST(N'2018-12-28T00:00:00.000' AS DateTime), N'Amigdalitis', 60, 25, CAST(N'2019-03-28T00:00:00.000' AS DateTime), 30014)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (28, CAST(N'2018-11-29T00:00:00.000' AS DateTime), N'Gripe', 50, 60, CAST(N'2019-01-29T00:00:00.000' AS DateTime), 30015)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (30, CAST(N'2018-10-30T00:00:00.000' AS DateTime), N'Herpes', 80, 40, CAST(N'2018-11-30T00:00:00.000' AS DateTime), 30016)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (34, CAST(N'2018-01-30T00:00:00.000' AS DateTime), N'Migrañas', 60, 30, CAST(N'2018-03-30T00:00:00.000' AS DateTime), 30017)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (35, CAST(N'2018-04-26T00:00:00.000' AS DateTime), N'Asma', 50, 50, CAST(N'2018-05-26T00:00:00.000' AS DateTime), 30018)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (36, CAST(N'2018-03-21T00:00:00.000' AS DateTime), N'Gripe', 45, 70, CAST(N'2018-06-21T00:00:00.000' AS DateTime), 30026)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (37, CAST(N'2018-06-15T00:00:00.000' AS DateTime), N'Asma', 67, 80, CAST(N'2018-07-15T00:00:00.000' AS DateTime), 30026)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (39, CAST(N'2018-02-10T00:00:00.000' AS DateTime), N'Gripe', 80, 15, CAST(N'2018-03-10T00:00:00.000' AS DateTime), 30004)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (42, CAST(N'2018-12-03T00:00:00.000' AS DateTime), N'Esguince', 90, 50, CAST(N'2019-03-05T00:00:00.000' AS DateTime), 30018)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (45, CAST(N'2018-07-15T00:00:00.000' AS DateTime), N'Anemia', 60, 70, CAST(N'2018-09-15T00:00:00.000' AS DateTime), 30015)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (46, CAST(N'2018-10-04T00:00:00.000' AS DateTime), N'Alergia', 120, 80, CAST(N'2018-04-12T00:00:00.000' AS DateTime), 30012)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (47, CAST(N'2018-01-06T00:00:00.000' AS DateTime), N'Gripe', 50, 55, CAST(N'2018-06-03T00:00:00.000' AS DateTime), 30015)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (48, CAST(N'2018-02-04T00:00:00.000' AS DateTime), N'Alergia', 70, 50, CAST(N'2018-04-05T00:00:00.000' AS DateTime), 30018)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (49, CAST(N'2018-07-01T00:00:00.000' AS DateTime), N'Esguince', 100, 25, CAST(N'2018-01-08T00:00:00.000' AS DateTime), 30026)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (50, CAST(N'2018-06-08T00:00:00.000' AS DateTime), N'Gripe', 40, 70, CAST(N'2018-08-08T00:00:00.000' AS DateTime), 30012)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (60, CAST(N'2018-03-09T00:00:00.000' AS DateTime), N'Amigdalitis', 80, 80, CAST(N'2018-09-05T00:00:00.000' AS DateTime), 30014)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (61, CAST(N'2019-04-02T00:00:00.000' AS DateTime), N'Alergia', 60, 30, CAST(N'2019-02-06T00:00:00.000' AS DateTime), 30015)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (62, CAST(N'2019-10-12T00:00:00.000' AS DateTime), N'Gripe', 60, 50, CAST(N'2019-12-11T00:00:00.000' AS DateTime), 30014)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (63, CAST(N'2019-06-19T00:00:00.000' AS DateTime), N'Esguince', 50, 70, CAST(N'2019-07-19T00:00:00.000' AS DateTime), 30018)
INSERT [dbo].[tblvisitas] ([intNumvisita], [dtmFecha], [strEnfermedad], [intImporte], [intPorcentajepago], [dtmProxvisita], [intCodigopaciente]) VALUES (64, CAST(N'2019-08-05T00:00:00.000' AS DateTime), N'Esguince', 80, 10, CAST(N'2019-05-10T00:00:00.000' AS DateTime), 30014)
ALTER TABLE [dbo].[tblvisitas]  WITH CHECK ADD  CONSTRAINT [fk_visitaspacientes] FOREIGN KEY([intCodigopaciente])
REFERENCES [dbo].[tblpacientes] ([intCodigo])
GO
ALTER TABLE [dbo].[tblvisitas] CHECK CONSTRAINT [fk_visitaspacientes]
GO
USE [master]
GO
ALTER DATABASE [clinica_transacciones] SET  READ_WRITE 
GO
