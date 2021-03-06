USE [SERVICIO TECNICO]
GO
/****** Object:  Table [dbo].[REPARACIONES]    Script Date: 16/12/2019 18:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REPARACIONES](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[dni_tecnico] [nvarchar](25) NULL,
	[fecha] [date] NULL,
	[concepto] [nvarchar](25) NULL,
	[importe] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TECNICOS]    Script Date: 16/12/2019 18:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TECNICOS](
	[dni] [nvarchar](25) NOT NULL,
	[nombre] [nvarchar](25) NULL,
	[ciudad] [nvarchar](15) NULL,
	[salario] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TECNICOS_DEL_AÑO]    Script Date: 16/12/2019 18:08:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TECNICOS_DEL_AÑO](
	[nombre] [nvarchar](25) NOT NULL,
	[media] [money] NULL,
	[salario] [money] NULL,
	[fecha] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[REPARACIONES] ON 

INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (1, N'48330190Z', CAST(N'2019-12-31' AS Date), N'cambio ruedas', 500.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (2, N'79456123H', CAST(N'2018-06-25' AS Date), N'cambio aceite', 600.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (3, N'98654321Y', CAST(N'2019-11-03' AS Date), N'cambio pastillas freno', 250.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (4, N'48330190Z', CAST(N'2019-11-30' AS Date), N'cambio pastillas freno', 350.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (5, N'48330190Z', CAST(N'2018-06-15' AS Date), N'cambio luna', 450.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (6, N'79456123H', CAST(N'2019-05-04' AS Date), N'cambio motor', 9000.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (7, N'41258963G', CAST(N'2019-06-04' AS Date), N'equilibrado ruedas', 150.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (8, N'98654321Y', CAST(N'2018-06-04' AS Date), N'cambio asientos', 3000.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (9, N'36587741E', CAST(N'2018-01-15' AS Date), N'cambio ruedas', 500.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (10, N'35478994S', CAST(N'2019-08-04' AS Date), N'cambio aceite', 780.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (11, N'98654321Y', CAST(N'2018-03-15' AS Date), N'cambio luna', 850.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (12, N'13456789L', CAST(N'2018-09-15' AS Date), N'cambio ruedas', 900.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (13, N'41258963G', CAST(N'2019-01-25' AS Date), N'cambio motor', 8500.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (14, N'79456123H', CAST(N'2018-06-04' AS Date), N'equilibrado ruedas', 750.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (15, N'48330190Z', CAST(N'2018-05-04' AS Date), N'reparacion pinchazo', 100.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (16, N'48330190Z', CAST(N'2017-05-04' AS Date), N'cambio bateria', 80.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (17, N'48330190Z', CAST(N'2017-12-04' AS Date), N'equilibrado neumaticos', 250.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (18, N'48330190Z', CAST(N'2018-10-15' AS Date), N'cambio bateria', 80.0000)
INSERT [dbo].[REPARACIONES] ([Id], [dni_tecnico], [fecha], [concepto], [importe]) VALUES (19, N'48330190Z', CAST(N'2018-06-27' AS Date), N'cambio llantas', 300.0000)
SET IDENTITY_INSERT [dbo].[REPARACIONES] OFF
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'13456789L', N'felix', N'campello', 789.0000)
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'21458792A', N'pepe', N'campello', 800.0000)
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'35478994S', N'jose', N'villajoyosa', 750.0000)
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'36587741E', N'maria', N'benidorm', 980.0000)
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'41258963G', N'luis', N'alicante', 1000.0000)
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'48330190Z', N'frank', N'villajoyosa', 1000.0000)
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'79456123H', N'mateo', N'villajoyosa', 1100.0000)
INSERT [dbo].[TECNICOS] ([dni], [nombre], [ciudad], [salario]) VALUES (N'98654321Y', N'alberto', N'altea', 450.0000)
ALTER TABLE [dbo].[REPARACIONES]  WITH CHECK ADD  CONSTRAINT [fk_reparacionestecnicos] FOREIGN KEY([dni_tecnico])
REFERENCES [dbo].[TECNICOS] ([dni])
GO
ALTER TABLE [dbo].[REPARACIONES] CHECK CONSTRAINT [fk_reparacionestecnicos]
GO
