USE [pizzeria]
GO
/****** Object:  UserDefinedFunction [dbo].[ingrediente]    Script Date: 10/12/2019 8:22:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[ingrediente] (@Npizza varchar(20))
returns varchar(20)
as
begin
	declare @ingrediente varchar(25), @quantity decimal (4,0)
	select top 1 @ingrediente = ingredient ,@quantity = quantity
	from preparation
	where @Npizza = Npizza
	order by quantity desc

return @ingrediente
end
GO
/****** Object:  Table [dbo].[client]    Script Date: 10/12/2019 8:22:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[client](
	[clientCod] [int] NOT NULL,
	[nombre] [varchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[clientCod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pizzas]    Script Date: 10/12/2019 8:22:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pizzas](
	[NPizza] [varchar](20) NOT NULL,
	[price] [decimal](5, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NPizza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[preparation]    Script Date: 10/12/2019 8:22:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[preparation](
	[NPizza] [varchar](20) NOT NULL,
	[ingredient] [varchar](20) NOT NULL,
	[quantity] [decimal](4, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NPizza] ASC,
	[ingredient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales]    Script Date: 10/12/2019 8:22:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales](
	[NPizza] [varchar](20) NOT NULL,
	[clientCod] [int] NOT NULL,
	[orderCod] [int] NOT NULL,
	[date2] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[orderCod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[client] ([clientCod], [nombre]) VALUES (1, N'Alvaro')
INSERT [dbo].[client] ([clientCod], [nombre]) VALUES (2, N'Lorena')
INSERT [dbo].[client] ([clientCod], [nombre]) VALUES (3, N'Abdon')
INSERT [dbo].[client] ([clientCod], [nombre]) VALUES (4, N'Fulano')
INSERT [dbo].[client] ([clientCod], [nombre]) VALUES (5, N'Felipe')
INSERT [dbo].[client] ([clientCod], [nombre]) VALUES (6, N'Josep')
INSERT [dbo].[client] ([clientCod], [nombre]) VALUES (7, N'Ana')
INSERT [dbo].[client] ([clientCod], [nombre]) VALUES (8, N'Mengano')
INSERT [dbo].[pizzas] ([NPizza], [price]) VALUES (N'Besubio', CAST(13.00 AS Decimal(5, 2)))
INSERT [dbo].[pizzas] ([NPizza], [price]) VALUES (N'Besubio2', CAST(15.00 AS Decimal(5, 2)))
INSERT [dbo].[pizzas] ([NPizza], [price]) VALUES (N'Boloñesa', CAST(12.50 AS Decimal(5, 2)))
INSERT [dbo].[pizzas] ([NPizza], [price]) VALUES (N'Gitana', CAST(50.00 AS Decimal(5, 2)))
INSERT [dbo].[pizzas] ([NPizza], [price]) VALUES (N'Hawaiana', CAST(13.00 AS Decimal(5, 2)))
INSERT [dbo].[pizzas] ([NPizza], [price]) VALUES (N'Napolitana', CAST(18.00 AS Decimal(5, 2)))
INSERT [dbo].[pizzas] ([NPizza], [price]) VALUES (N'Simple', CAST(1.50 AS Decimal(5, 2)))
INSERT [dbo].[pizzas] ([NPizza], [price]) VALUES (N'Vegetariana', CAST(10.50 AS Decimal(5, 2)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Besubio', N'Huevos', CAST(2 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Besubio', N'Oregano', CAST(3 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Besubio', N'Pasta', CAST(10 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Besubio', N'Peperoni', CAST(46 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Besubio', N'Queso', CAST(10 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Besubio', N'Sal', CAST(34 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Besubio', N'Tomate', CAST(23 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Boloñesa', N'Tomate', CAST(15 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Hawaiana', N'Ajo', CAST(15 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Hawaiana', N'Piña', CAST(35 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Hawaiana', N'Tomate', CAST(15 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Napolitana', N'Botifarra', CAST(15 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Napolitana', N'Jamon York', CAST(34 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Napolitana', N'Oregano', CAST(15 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Napolitana', N'Queso', CAST(10 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Napolitana', N'Tomate', CAST(34 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Simple', N'Tomate', CAST(30 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Vegetariana', N'Alcachofas', CAST(45 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Vegetariana', N'Judias', CAST(4 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Vegetariana', N'Oregano', CAST(5 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Vegetariana', N'Queso', CAST(24 AS Decimal(4, 0)))
INSERT [dbo].[preparation] ([NPizza], [ingredient], [quantity]) VALUES (N'Vegetariana', N'Tomate', CAST(15 AS Decimal(4, 0)))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Vegetariana', 1, 1, CAST(N'2019-05-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Vegetariana', 1, 3, CAST(N'2019-07-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Vegetariana', 1, 4, CAST(N'2019-09-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Vegetariana', 3, 5, CAST(N'2019-10-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Vegetariana', 5, 6, CAST(N'2019-11-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Vegetariana', 4, 7, CAST(N'2019-12-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Vegetariana', 2, 8, CAST(N'2019-01-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Besubio', 1, 9, CAST(N'2019-02-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Besubio', 3, 10, CAST(N'2019-03-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Besubio', 4, 11, CAST(N'2019-04-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Besubio', 2, 12, CAST(N'2019-05-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Besubio', 5, 13, CAST(N'2019-06-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Besubio', 5, 14, CAST(N'2019-07-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Besubio', 2, 15, CAST(N'2019-08-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Napolitana', 2, 22, CAST(N'2019-07-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Napolitana', 3, 23, CAST(N'2019-08-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Boloñesa', 3, 24, CAST(N'2019-06-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Simple', 2, 25, CAST(N'2019-07-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Hawaiana', 3, 26, CAST(N'2019-08-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Simple', 8, 28, CAST(N'2019-07-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Simple', 3, 29, CAST(N'2019-07-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Simple', 3, 30, CAST(N'2019-07-03' AS Date))
INSERT [dbo].[sales] ([NPizza], [clientCod], [orderCod], [date2]) VALUES (N'Simple', 3, 31, CAST(N'2019-07-03' AS Date))
ALTER TABLE [dbo].[preparation]  WITH CHECK ADD  CONSTRAINT [fk_pre_NPizza] FOREIGN KEY([NPizza])
REFERENCES [dbo].[pizzas] ([NPizza])
GO
ALTER TABLE [dbo].[preparation] CHECK CONSTRAINT [fk_pre_NPizza]
GO
ALTER TABLE [dbo].[sales]  WITH CHECK ADD  CONSTRAINT [fk_sales_client] FOREIGN KEY([clientCod])
REFERENCES [dbo].[client] ([clientCod])
GO
ALTER TABLE [dbo].[sales] CHECK CONSTRAINT [fk_sales_client]
GO
ALTER TABLE [dbo].[sales]  WITH CHECK ADD  CONSTRAINT [fk_sales_NPizza] FOREIGN KEY([NPizza])
REFERENCES [dbo].[pizzas] ([NPizza])
GO
ALTER TABLE [dbo].[sales] CHECK CONSTRAINT [fk_sales_NPizza]
GO
