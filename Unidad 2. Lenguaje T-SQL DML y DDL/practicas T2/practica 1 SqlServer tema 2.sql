CREATE DATABASE [clinica]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'clinica', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\clinica.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'clinica_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\clinica_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )

GO
USE [clinica]

GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [clinica] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

CREATE TABLE tblpacientes
(
	intCodigo smallint NOT NULL PRIMARY KEY ,
	strNombre nvarchar(30) NULL,
	strDireccion nvarchar(20) NULL,
	strCiudad nvarchar(15) NULL,
	strTelefono nvarchar(10) NULL,
	btDiabetico bit NOT NULL,
	dtmFechanac datetime Null,
	intTurno smallint NULL,
);

CREATE tABLE tblvisitas
(
	intNumvisita int NOT NULL PRIMARY KEY ,
	intCodigopaciente smallint NULL,
	dtmFecha datetime NULL,
	strEnfermedad nvarchar(25) NULL,
	intImporte int NULL,
	intPorcentajepago smallint Null,
	dtmProxvisita datetime Null,

);

ALTER TABLE tblvisitas
ADD CONSTRAINT fk_visitaspacientes
FOREIGN KEY (intCodigopaciente) REFERENCES tblpacientes (intCodigo);

-------------------------------------------------------------------------
-------------------------------------------------------------------------

CREATE DATABASE videoclub;

CREATE TABLE tblalqulier
(
	intCodigosocio int NOT NULL ,
	intCodigostock int NOT NULL ,
	dtmFechasalida datetime NOT NULL,
	dtmFechadevolucion datetime NOT NULL  ,
	intEstado smallint NULL,
	intCalificacion smallint NULL,
	PRIMARY KEY(intCodigosocio,intCodigostock,dtmFechasalida)
);

CREATE TABLE tblstock
(
	intCodigo int NOT NULL PRIMARY KEY ,
	intCodigopelicula int  NULL  ,
	strFormato nvarchar(3) NULL ,
);

CREATE TABLE tblpeliculas
(
	intCodigo int NOT NULL PRIMARY KEY ,
	strTitulo nvarchar(40) NULL,
	intCodigocategoria int NULL,
	strCompañia nvarchar(15) NULL,
	intDuracion smallint NULL,
	mnyPreciocompra money NULL,
	mnyPrecioalquiler money NULL,
	intMaximodias smallint NULL,
	rlOferta real NULL,
	ntxtComentario ntext NULL,
);


CREATE TABLE tblsocios
(
	strDni nvarchar(9) NOT NULL PRIMARY KEY ,
	intCodigo int NOT NULL,
	strNombre nvarchar(30) NOT NULL,
	strApellido nvarchar(40) NOT NULL,
	strTelefono nvarchar(10) NULL,
	dtmFechanacimiento datetime NULL,
	blnClientevip bit NULL,
	
);

-----------------------------------------------------------------------
------------------------------------------------------------------------

CREATE DATABASE pizzeria;

CREATE DATABASE [pizzeria]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'pizzeria', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\pizzeria.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'pizzeria_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\pizzeria_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )

GO
USE [pizzeria]

GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [pizzeria] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

CREATE TABLE pizzas 
(
  NPizza varchar(20) NOT NULL,
  price decimal(5,2) NOT NULL,
  PRIMARY KEY (NPizza)
);

INSERT INTO pizzas VALUES('Besubio','13.00');
INSERT INTO pizzas VALUES('Besubio2','15.00');
INSERT INTO pizzas VALUES('Napolitana','18.00');
INSERT INTO pizzas VALUES('Vegetariana','10.50');
INSERT INTO pizzas VALUES('Boloñesa','12.50');
INSERT INTO pizzas VALUES('Simple','1.50');
INSERT INTO pizzas VALUES('Hawaiana','13.00');
INSERT INTO pizzas VALUES('Gitana','50.00');

CREATE TABLE preparation 
(
  NPizza varchar(20) NOT NULL,
  ingredient varchar(20) NOT NULL,
  quantity decimal(4,0) NOT NULL,
  PRIMARY KEY (NPizza,ingredient),
  CONSTRAINT fk_pre_NPizza FOREIGN KEY (NPizza) REFERENCES pizzas
);

INSERT INTO preparation VALUES('Besubio','Huevos','2.0');
INSERT INTO preparation VALUES('Besubio','Oregano','3');
INSERT INTO preparation VALUES('Besubio','Pasta','10');
INSERT INTO preparation VALUES('Besubio','Peperoni','46');
INSERT INTO preparation VALUES('Besubio','Queso','10');
INSERT INTO preparation VALUES('Besubio','Sal','34');
INSERT INTO preparation VALUES('Besubio','Tomate','23');
INSERT INTO preparation VALUES('Margarita','Jamon York','23');
INSERT INTO preparation VALUES('Margarita','Oregano','5');
INSERT INTO preparation VALUES('Margarita','Pasta','76');
INSERT INTO preparation VALUES('Margarita','Queso','50');
INSERT INTO preparation VALUES('Margarita','Tomate','20');
INSERT INTO preparation VALUES('Napolitana','Botifarra','15');
INSERT INTO preparation VALUES('Napolitana','Jamon York','34');
INSERT INTO preparation VALUES('Napolitana','Oregano','15');
INSERT INTO preparation VALUES('Napolitana','Queso','10');
INSERT INTO preparation VALUES('Napolitana','Tomate','34');
INSERT INTO preparation VALUES('Vegetariana','Alcachofas','45');
INSERT INTO preparation VALUES('Vegetariana','Judias','4');
INSERT INTO preparation VALUES('Vegetariana','Oregano','5');
INSERT INTO preparation VALUES('Vegetariana','Queso','24');
INSERT INTO preparation VALUES('Vegetariana','Tomate','15');
INSERT INTO preparation VALUES('Hawaiana','Tomate','15');
INSERT INTO preparation VALUES('Hawaiana','Piña','35');
INSERT INTO preparation VALUES('Hawaiana','Ajo','15');
INSERT INTO preparation VALUES('Boloñesa','Tomate','15');
INSERT INTO preparation VALUES('Simple','Tomate','30');

-----------------------------------------------


CREATE TABLE client 
(
  clientCod integer  NOT NULL,
  nombre varchar(45) NOT NULL,
  PRIMARY KEY (clientCod)
);

INSERT INTO client VALUES(1,'Alvaro');
INSERT INTO client VALUES(2,'Lorena');
INSERT INTO client VALUES(3,'Abdon');
INSERT INTO client VALUES(4,'Fulano');
INSERT INTO client VALUES(5,'Felipe');
INSERT INTO client VALUES(6,'Josep');
INSERT INTO client VALUES(7,'Ana');
INSERT INTO client VALUES(8,'Mengano');


CREATE TABLE sales 
(
  NPizza varchar(20) NOT NULL,
  clientCod integer NOT NULL,
  orderCod integer NOT NULL,
  date2 date NOT NULL,
  PRIMARY KEY (orderCod),
  CONSTRAINT fk_sales_NPizza FOREIGN KEY (NPizza) REFERENCES pizzas,
  CONSTRAINT fk_sales_client FOREIGN KEY (clientCod) REFERENCES client
);


INSERT INTO sales VALUES ('Vegetariana',1,1,convert(datetime,'03-05-19 09:02:44 PM',5));
INSERT INTO sales VALUES ('Vegetariana',1,3,convert(datetime,'03-07-19 10:02:44 PM',5));
INSERT INTO sales VALUES ('Vegetariana',1,4,convert(datetime,'03-09-19 11:02:44 PM',5));
INSERT INTO sales VALUES ('Vegetariana',3,5,convert(datetime,'03-10-19 02:02:44 AM',5));
INSERT INTO sales VALUES ('Vegetariana',5,6,convert(datetime,'03-11-19 01:02:44 AM',5));
INSERT INTO sales VALUES ('Vegetariana',4,7,convert(datetime,'03-12-19 03:02:44 AM',5));
INSERT INTO sales VALUES ('Vegetariana',2,8,convert(datetime,'03-01-19 04:02:44 AM',5));
INSERT INTO sales VALUES ('Besubio',1,9,convert(datetime,'03-02-19 12:02:44 PM',5));
INSERT INTO sales VALUES ('Besubio',3,10,convert(datetime,'03-03-19 01:02:44 PM',5));
INSERT INTO sales VALUES ('Besubio',4,11,convert(datetime,'03-04-19 02:02:44 PM',5));
INSERT INTO sales VALUES ('Besubio',2,12,convert(datetime,'03-05-19 03:02:44 PM',5));
INSERT INTO sales VALUES ('Besubio',5,13,convert(datetime,'03-06-19 09:02:44 PM',5));
INSERT INTO sales VALUES ('Besubio',5,14,convert(datetime,'03-07-19 09:02:44 PM',5));
INSERT INTO sales VALUES ('Besubio',2,15,convert(datetime,'03-08-19 04:02:44 PM',5));
INSERT INTO sales VALUES ('Margarita',4,16,convert(datetime,'03-09-19 05:02:44 PM',5));
INSERT INTO sales VALUES ('Margarita',4,17,convert(datetime,'03-10-19 06:02:44 PM',5));
INSERT INTO sales VALUES ('Margarita',5,18,convert(datetime,'03-11-19 06:02:44 PM',5));
INSERT INTO sales VALUES ('Margarita',2,19,convert(datetime,'03-12-19 09:02:44 PM',5));
INSERT INTO sales VALUES ('Margarita',1,20,convert(datetime,'03-05-19 08:02:44 PM',5));
INSERT INTO sales VALUES ('Margarita',3,21,convert(datetime,'03-06-19 09:02:44 PM',5));
INSERT INTO sales VALUES ('Napolitana',2,22,convert(datetime,'03-07-19 09:02:44 PM',5));
INSERT INTO sales VALUES ('Napolitana',3,23,convert(datetime,'03-08-19 09:02:44 PM',5));
INSERT INTO sales VALUES ('Boloñesa',3,24,convert(datetime,'03-06-19 09:02:44 PM',5));
INSERT INTO sales VALUES ('Simple',2,25,convert(datetime,'03-07-19 09:02:44 PM', 5));
INSERT INTO sales VALUES ('Hawaiana',3,26,convert(datetime,'03-08-19 09:02:44 PM',5));
INSERT INTO sales VALUES ('Margarita',7,27,convert(datetime,'03-08-19 09:02:44 PM',5));
INSERT INTO sales VALUES ('Simple',8,28,convert(datetime,'03-07-19 09:02:44 PM',5));
INSERT INTO sales VALUES ('Simple',3,29,convert(datetime,'03-07-19 09:02:44 PM',5));
INSERT INTO sales VALUES ('Simple',3,30,convert(datetime,'03-07-19 09:02:44 PM',5));
INSERT INTO sales VALUES ('Simple',3,31,convert(datetime,'03-07-19 09:02:44 PM',5));


-----------------------------------------------------
------------------------------------------------------

CREATE DATABASE [proyectos]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'proyectos', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\proyectos.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'proyectos_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\proyectos_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )

USE [proyectos]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [proyectos] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

CREATE TABLE tblclientes
(
	intCodigocliente int NOT NULL PRIMARY KEY,
	strNombrecliente nvarchar(30),
	strNif nvarchar(10),
	strDireccion nvarchar(40),
	strCiudad nvarchar(30),
	strTelefono nvarchar(15) NULL,
	
);

CREATE TABLE tblempleados
(
	intCodempleado int NOT NULL PRIMARY KEY,
	strNombreem nvarchar(30),
	strApellidoem nvarchar(30),
	mnySueldo money,
	strNombredp nvarchar(30),
	strCiudaddp nvarchar(15),
	strNumpro nvarchar(10),
);

CREATE TABLE tblproyectos
(
	intCodpro int NOT NULL PRIMARY KEY,
	strNombrepro nvarchar(10),
	mnyPrecio money,
	dtmFechainicio datetime,
	dtmFechaprevfi datetime,
	dtmFechafin datetime,
	intCodigocli int,	
);

CREATE TABLE tbldepartamentos
(
	strNombredep nvarchar(15),
	strCiudaddep nvarchar(15),
	strTelefono nvarchar(15),
	PRIMARY KEY (strNombredep,strCiudaddep)
	
);

-- CLAVES FORANEAS

ALTER TABLE tblproyectos
ADD CONSTRAINT fk_proyectoscliente
FOREIGN KEY (intCodigocli) REFERENCES tblclientes (intCodigocliente);

ALTER TABLE tblempleados
ADD CONSTRAINT fk_empleadosproyecto
FOREIGN KEY (strNumpro) REFERENCES tblproyectos (intCodpro);

ALTER TABLE tblempleados
ADD CONSTRAINT fk_empleadosdpto
FOREIGN KEY (strNombredp,strCiudaddp) REFERENCES tblproyectos (strNombredep,strCiudaddep);



INSERT INTO tblclientes VALUES(10,'SAB','38.567.893-C','Aragon 11','Barcelona','NULL');
INSERT INTO tblempleados VALUES(1,'Maria','Puig',100000,'DIR','Girona',1);
INSERT INTO tblproyectos VALUES(1,'TSB',1000000,convert(date,'01-01-19' ,5),convert(date,'01-01-20' ,5),NULL,10);
INSERT INTO tbldepartamentos VALUES('DIR','Barcelona','934226070');


-------------------------------------------------------
-------------------------------------------------------

CREATE DATABASE [concesionarios]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'concesionarios', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\concesionarios.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'concesionarios_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\concesionarios_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )

USE [concesionarios]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [concesionarios] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO


CREATE TABLE tblconcesionario
(
	strCif nvarchar(9),
	strNombre nvarchar(30),
	strCiudad nvarchar(15),
	PRIMARY KEY (strCif)

);

CREATE TABLE tblcoches
(
	strCod nvarchar(25),
	strNombre nvarchar(30),
	strMarca nvarchar(25),
	PRIMARY KEY (strCod)
);

CREATE TABLE tblclientes
(
	strId nvarchar (10),
	strNombre nvarchar(30),
	strApellido nvarchar(30),
	strCiudad nvarchar(15),
	PRIMARY KEY (strId)

);

CREATE TABLE tblventas
(
	strCif nvarchar(9),
	strDni nvarchar(9),
	strCoche nvarchar(15),
	strColor nvarchar(15),
	dtmFecha datetime,
	PRIMARY KEY (strCif,strDni)


);

CREATE TABLE tbldistribucion
(
	strCif nvarchar(9),
	strCoche nvarchar(20),
	intCantidad int ,
	PRIMARY KEY (strCif)
);

CREATE TABLE tblmarcas
(
	strCif nvarchar(9),
	strNombre nvarchar(30),
	strCiudad nvarchar(15),
	PRIMARY KEY (strCif)
);

--CLAVES FORANEAS

ALTER TABLE tblmarcas
ADD CONSTRAINT fk_marcascoches
FOREIGN KEY (strCif) REFERENCES tblcoches (strCod);

ALTER TABLE tbldistribucion
ADD CONSTRAINT fk_distribucionconcesionario
FOREIGN KEY (strCif) REFERENCES tblconcesionario (strCif);

ALTER TABLE tblventas
ADD CONSTRAINT fk_clientesventas
FOREIGN KEY (strDni) REFERENCES tblventas (strDni);

ALTER TABLE tblventas
ADD CONSTRAINT fk_ventasconcesionario
FOREIGN KEY (strCif) REFERENCES tblconcesionario (strCif);

ALTER TABLE tblventas
ADD CONSTRAINT fk_ventasconcesionario
FOREIGN KEY (strCif) REFERENCES tblconcesionario (strCif);

ALTER TABLE tblventas
ADD CONSTRAINT fk_ventascoche
FOREIGN KEY (strCoche) REFERENCES tblcoches (strCod);

---------------------------------------------------------------

INSERT INTO tblconcesionario VALUES('44543123','Fercar','Alicante');
INSERT INTO tblcoches VALUES('BMWe86','BMW Serie 1','BMW');
INSERT INTO tblclientes VALUES('24583143','Jose Luis','Perez','Alicante');
INSERT INTO tblventas VALUES('76543213','24583143','KRIO','rojo',convert(date,'03-06-16' ,5));
INSERT INTO tbldistribucion VALUES('44543123','BMWe86',5);
INSERT INTO tblmarcas VALUES('1','BMW','Barcelona');



-------------------------------------------------------------------------
-------------------------------------------------------------------------


--EJERCICIO 2

--A)
--1-.TABLA PROYECTOS

INSERT INTO tbldepartamentos VALUES('DIR','Barcelona','93.422.60.70');
INSERT INTO tbldepartamentos VALUES('DIR','Girona','972.23.89.70');
INSERT INTO tbldepartamentos VALUES('DIS','Lleida','973.23.50.40');
INSERT INTO tbldepartamentos VALUES('DIS','Barcelona','93.224.85.23');
INSERT INTO tbldepartamentos VALUES('PROG','Tarragona','977.33.38.52');
INSERT INTO tbldepartamentos VALUES('PROG','Girona','972.23.50.91');


INSERT INTO tblclientes VALUES(10,'SAB','38.567.893-C','Aragon 11','Barcelona','NULL');
INSERT INTO tblclientes VALUES(20,'CME','38.123.898-E','Valencia 22','Girona','972.23.57.21');
INSERT INTO tblclientes VALUES(30,'ACME','36.432.127-A','Mallorca 33','Lleida','973.23.45.67');
INSERT INTO tblclientes VALUES(60,'CEA','38.226.777-D','París 44','Barcelona','93.422.60.77');


INSERT INTO tblempleados VALUES(1,'Maria','Puig',100000,'DIR','Girona',1);
INSERT INTO tblempleados VALUES(2,'pedro','MAs',90000,'DIR','Barcelona',4);
INSERT INTO tblempleados VALUES(3,'Ana','Ros',70000,'DIS','Lleida',3);
INSERT INTO tblempleados VALUES(4,'Jorge','Roca',70000,'DIS','Barcelona',4);
INSERT INTO tblempleados VALUES(5,'Clara','Blanc',40000,'PROG','Tarragona',1);
INSERT INTO tblempleados VALUES(6,'Laura','Tort',30000,'PROG','Tarragona',3);
INSERT INTO tblempleados VALUES(7,'Rogelio','Salt',40000,'NULL','NULL',4);
INSERT INTO tblempleados VALUES(8,'Rogelio','Grau',30000,'PROG','Tarragona',NULL);


INSERT INTO tblproyectos VALUES(1,'GESCOM',1000000,convert(date,'01-01-17' ,5),convert(date,'01-01-19' ,5),NULL,10);
INSERT INTO tblproyectos VALUES(2,'TSB',2000000,convert(date,'01-10-18',5),convert(date,'31-03-19' ,5),convert(date,'01-05-19' ,5),20);
INSERT INTO tblproyectos VALUES(3,'SALSA',1000000,convert(date,'10-02-17' ,5),convert(date,'01-02-19' ,5),NULL,20);
INSERT INTO tblproyectos VALUES(4,'TINELL',4000000,convert(date,'01-01-19' ,5),convert(date,'01-12-20' ,5),NULL,30);

--------------------------------------------


--2.-TABLA CLIENTES

INSERT INTO tblclientes VALUES(10,'SAB','38.567.893-C','Aragon 11','Barcelona','NULL');

--3.-Obtén la sentencia para incrementar el sueldo de todos los empleados del proyecto 2 en 1.000 euros.

UPDATE empleados
SET sueldo = sueldo+1000
WHERE strNumpro = 2;

--4.-Obtén la sentencia para cambiar las fechas de inicio que estén en el año 2017, al 2018.

UPDATE proyectos
SET dtmFechainicio='2018'
WHERE dtmFechainicio='2017';



--B)INSERTAR EN LA BD CONCESIONARIO

INSERT INTO tblconcesionario VALUES('44543123','Fercar','Alicante');
INSERT INTO tblconcesionario VALUES('85543123','Multi Car','Alicante');
INSERT INTO tblconcesionario VALUES('77323232','Motor Sport','Murcia');
INSERT INTO tblconcesionario VALUES('85643123','BMW Villa de campo','Madrid');
INSERT INTO tblconcesionario VALUES('76543213','Todo motor','Madrid');
INSERT INTO tblconcesionario VALUES('98654678','Tope Gama','Madrid');
INSERT INTO tblconcesionario VALUES('11232123','BMW Barna','Barcelona');
INSERT INTO tblconcesionario VALUES('54345432','Tot Turbo','Barcelona');
INSERT INTO tblconcesionario VALUES('32323232','4 rodes','Ibiza');
INSERT INTO tblconcesionario VALUES('56429642','Grant Turismo','Alicante');



INSERT INTO tblcoches VALUES('BMWe86','BMW Serie 1','BMW');
INSERT INTO tblcoches VALUES('BMWe46','BMW Serie 3','BMW');
INSERT INTO tblcoches VALUES('BMWe34','BMW Serie 5','BMW');
INSERT INTO tblcoches VALUES('BMWe45','BMW Serie 7','BMW');
INSERT INTO tblcoches VALUES('BMWe87','BMW Serie 4','BMW');
INSERT INTO tblcoches VALUES('A3','AUDI A3','AUDI');
INSERT INTO tblcoches VALUES('A5','AUDI A5','AUDI');
INSERT INTO tblcoches VALUES('A6Q','AUDI A6 QUATTRO','AUDI');
INSERT INTO tblcoches VALUES('C4C','C4','Citroen');
INSERT INTO tblcoches VALUES('C5C','C5','Citroen');
INSERT INTO tblcoches VALUES('IBIZA','Ibiza','Seat');
INSERT INTO tblcoches VALUES('KCEED','CEED','KIA');
INSERT INTO tblcoches VALUES('KSPORT','SPORTAGE','KIA');
INSERT INTO tblcoches VALUES('KRIO','RIO','KIA');
INSERT INTO tblcoches VALUES('NISQA','QASQAI','Nissan');
INSERT INTO tblcoches VALUES('NISPU','PULSAR','Nissan');


INSERT INTO tblclientes VALUES('24583143','Jose Luis','Perez','Alicante');
INSERT INTO tblclientes VALUES('65344533','Silvia','García','Alicante');
INSERT INTO tblclientes VALUES('44545433','Abdon','Bañón','Murcia');
INSERT INTO tblclientes VALUES('14123233','Raquel','Perez','Madrid');
INSERT INTO tblclientes VALUES('44567676','Fulgencio','Oliver','La Romana');
INSERT INTO tblclientes VALUES('44599887','Javier','Romo','Madrid');
INSERT INTO tblclientes VALUES('44512333','Manuel','Ivorra','Madrid');
INSERT INTO tblclientes VALUES('67453423','Alvaro','Kamen','Madrid');
INSERT INTO tblclientes VALUES('87643455','Sergi','Villaplana','Alicante');
INSERT INTO tblclientes VALUES('76357844','Carles','Puig','Barcelona');
INSERT INTO tblclientes VALUES('76411111','Antoni','Punset','Ibiza');
INSERT INTO tblclientes VALUES('11111112','Carlos','Pérez','Valencia');
INSERT INTO tblclientes VALUES('22222211','José','Jover','Valencia');
INSERT INTO tblclientes VALUES('00000031','Francisco','Esteve','Zaragoza');


INSERT INTO tblventas VALUES('76543213','24583143','KRIO','rojo',convert(date,'03-06-16' ,5));
INSERT INTO tblventas VALUES('76543213','11111112','KRIO','blanco',convert(date,'23-06-16' ,5));
INSERT INTO tblventas VALUES('44543123','24583143','BMWe86','rojo',convert(date,'03-06-16' ,5));
INSERT INTO tblventas VALUES('44543123','24583143','BMWe46','blanco',convert(date,'13-05-16' ,5));
INSERT INTO tblventas VALUES('44543123','65344533','BMWe34','azul',convert(date,'23-04-16' ,5));
INSERT INTO tblventas VALUES('85543123','65344533','NISPU','blanco',convert(date,'04-03-16' ,5));
INSERT INTO tblventas VALUES('85543123','44545433','NISPU','rojo',convert(date,'05-02-16' ,5));
INSERT INTO tblventas VALUES('85543123','44599887','NISPU','rojo',convert(date,'06-01-16' ,5));
INSERT INTO tblventas VALUES('85543123','14123233','C4C','blanco',convert(date,'07-02-16' ,5));
INSERT INTO tblventas VALUES('85543123','44599887','C4C','rojo',convert(date,'13-03-16' ,5));
INSERT INTO tblventas VALUES('85543123','44567676','C4C','azul',convert(date,'23-06-19' ,5));
INSERT INTO tblventas VALUES('77323232','44512333','KRIO','rojo',convert(date,'15-06-16' ,5));
INSERT INTO tblventas VALUES('77323232','67453423','KRIO','blanco',convert(date,'15-06-16' ,5));
INSERT INTO tblventas VALUES('77323232','87643455','KRIO','rojo',convert(date,'06-07-16' ,5));
INSERT INTO tblventas VALUES('77323232','76357844','C4C','azul',convert(date,'07-08-16' ,5));
INSERT INTO tblventas VALUES('85643123','76411111','A6Q','blanco',convert(date,'08-09-16' ,5));
INSERT INTO tblventas VALUES('76543213','11111112','KCEED','azul',convert(date,'09-10-16' ,5));
INSERT INTO tblventas VALUES('76543213','11111112','A3','rojo',convert(date,'13-11-16' ,5));
INSERT INTO tblventas VALUES('76543213','14123233','A3','blanco',convert(date,'11-12-16' ,5));
INSERT INTO tblventas VALUES('98654678','00000031','KSPORT','azul',convert(date,'12-06-16' ,5));
INSERT INTO tblventas VALUES('11232123','00000031','NISQA','blanco',convert(date,'23-08-16' ,5));
INSERT INTO tblventas VALUES('32323232','00000031','KCEED','rojo',convert(date,'28-09-16' ,5));
INSERT INTO tblventas VALUES('32323232','76411111','IBIZA','rojo',convert(date,'18-09-16' ,5));
INSERT INTO tblventas VALUES('44543123','22222211','BMWe86','rojo',convert(date,'10-05-16' ,5));



INSERT INTO tbldistribucion VALUES('44543123','BMWe86',5);
INSERT INTO tbldistribucion VALUES('44543123','BMWe46',15);
INSERT INTO tbldistribucion VALUES('44543123','BMWe34',4);
INSERT INTO tbldistribucion VALUES('85543123','NISPU',12);
INSERT INTO tbldistribucion VALUES('85543123','BMWm45',21);
INSERT INTO tbldistribucion VALUES('85543123','C4C',15);
INSERT INTO tbldistribucion VALUES('77323232','A3',3);
INSERT INTO tbldistribucion VALUES('77323232','KRIO',1);
INSERT INTO tbldistribucion VALUES('76543213','KRIO',6);
INSERT INTO tbldistribucion VALUES('77323232','C4C',2);
INSERT INTO tbldistribucion VALUES('85643123','A6Q',3);
INSERT INTO tbldistribucion VALUES('85643123','NISPU',4);
INSERT INTO tbldistribucion VALUES('85643123','BMWm45',5);
INSERT INTO tbldistribucion VALUES('76543213','C4C',6);
INSERT INTO tbldistribucion VALUES('76543213','KCEED',7);
INSERT INTO tbldistribucion VALUES('76543213','A3',8);
INSERT INTO tbldistribucion VALUES('98654678','C4C',1);
INSERT INTO tbldistribucion VALUES('98654678','A6Q',6);
INSERT INTO tbldistribucion VALUES('98654678','KSPORT',8);
INSERT INTO tbldistribucion VALUES('11232123','NISQA',9);
INSERT INTO tbldistribucion VALUES('11232123','A3',14);
INSERT INTO tbldistribucion VALUES('11232123','C5C',16);
INSERT INTO tbldistribucion VALUES('54345432','BMWm45',15);
INSERT INTO tbldistribucion VALUES('54345432','KSPORT',15);
INSERT INTO tbldistribucion VALUES('54345432','A6Q',25);
INSERT INTO tbldistribucion VALUES('32323232','NISQA',1);
INSERT INTO tbldistribucion VALUES('32323232','KCEED',3);
INSERT INTO tbldistribucion VALUES('32323232','IBIZA',0);




INSERT INTO tblmarcas VALUES('1','BMW','Barcelona');
INSERT INTO tblmarcas VALUES('2','AUDI','Madrid');
INSERT INTO tblmarcas VALUES('3','Citroen','Vigo');
INSERT INTO tblmarcas VALUES('4','Seat','Barcelona');
INSERT INTO tblmarcas VALUES('5','KIA','Madrid');
INSERT INTO tblmarcas VALUES('6','Renault','Valladolid');
INSERT INTO tblmarcas VALUES('7','Opel','Zaragoza');
INSERT INTO tblmarcas VALUES('8','Ford','Valencia');
INSERT INTO tblmarcas VALUES('9','Mercedes','Vitoria');


--Clinica  

--c)PACIENTES
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30001, 'Jose Gonzalez', 'Paseo Agran', 'ALICANTE', '856262515', 0, '10-08-1990', 1);
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30002, 'Federico Rodriguez', 'Travesía Desarraconàvem', 'VILLAJOYOSA', '843846078', 0, '10-01-1965', 2);
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30003, 'Gabriel García', 'Constitució n17 4B', 'SAN JUAN', '744671599', 0, '13-03-1967', 3);
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30004, 'Ana Tuent',' C. Comercial Flitam', 'SAN JUAN', '680090786', 0, '14-04-1989', 1);
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30005, 'Luisa Gómez', 'Carrer Omprometre, 134B 9A', 'EL CAMPELLO', '767031177', 0, '15-07-1983', 2);
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30006, 'Maria Navarro', 'Carrera Destarotem', 'EL CAMPELLO', '767031177', 1, '16-01-1954', 3);
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30007, 'Elena Giner', 'Pasadizo Inventariesses', 'ALICANTE', '877280026', 1, '17-12-1948', 1);
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30012, 'Javier Satorres', 'Camino Desnieris', 'MUTXAMEL', '765293339', 1, '18-11-1991', 2);
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30014, 'Jorge Beltrán', 'Rambla Convulsàssim', 'SAN JUAN', '656742684', 1, '21-11-1978', 3);
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30015, 'Beatriz Rico', 'Walia, 21',' VILLAJOYOSA', '965636585', 1, '23-12-1974', 1);
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30016, 'Roberto Saez', 'Macarena n23', 'ALICANTE', '965634041', 1, '24-03-1969', 1);
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30017, 'Emilio Pérez', 'Alfonso Pesquera', 'ALICANTE', '965635815', 0, '26-05-1984', 2);
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30018, 'Sandra Belda', 'San Pedro', 'VILLAJOYOSA', '753633365', 1, '27-06-1983', 2);
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30026, 'Laura Pastor', 'Prolongación Salud', 'MUTXAMEL', '616975467', 0, '07-09-1963', 1);
INSERT INTO tblpacientes (intCodigo, strNombre, strDireccion, strCiudad, strTelefono, btDiabetico, dtmFechanac, intTurno) VALUES (30099, 'David Ramirez','Sant Rafael', 'ALICANTE', '786261666', 1, '01-03-1972', 1);
                                                                                                              
--VISITAS
INSERT INTO tblvisitas VALUES (1,30001,'09-12-2019','Úlcera',50,50,'11-12-2019');
INSERT INTO tblvisitas VALUES (2,30001,'15-02-2019','Migrañas',50,25,'15-05-2019');
INSERT INTO tblvisitas VALUES (3,30002,'19-06-2019','Cistitis',40,60,'19-07-2019');
INSERT INTO tblvisitas VALUES (4,30004,'15-05-2019','Anemia',80,40,'15-09-2019');
INSERT INTO tblvisitas VALUES (5,30005,'21-10-2019','Gripe',60,30,'21-12-2019');
INSERT INTO tblvisitas VALUES (6,30006,'08-01-2019','Amigdalitis',60,50,'11-01-2019');
INSERT INTO tblvisitas VALUES (7,30007,'08-08-2019','Herpes',50,70,'12-08-2019');
INSERT INTO tblvisitas VALUES (8,30012,'07-04-2019','Otitis',80,80,'10-04-2019');
INSERT INTO tblvisitas VALUES (9,30014,'06-07-2019','Migrañas',60,55,'07-07-2019');
INSERT INTO tblvisitas VALUES (10,30015,'2019-02-09','Herpes',50,15,'06-09-2019');
INSERT INTO tblvisitas VALUES (11,30016,'14-05-2019','Anemia',45,20,'14-09-2019');
INSERT INTO tblvisitas VALUES (12,30017,'13-01-2019','Anemia',67,50,'13-06-2019');
INSERT INTO tblvisitas VALUES (13,30018,'04-04-2019','Herpes',100,25,'05-04-2019');
INSERT INTO tblvisitas VALUES (14,30026,'03-08-2019','Migrañas',50,60,'07-08-2019');
INSERT INTO tblvisitas VALUES (15,30099,'23-06-2019','Otitis',40,40,'23-10-2019');
INSERT INTO tblvisitas VALUES (16,30007,'21-09-2019','Gripe',80,30,'21-11-2019');
INSERT INTO tblvisitas VALUES (17,30002,'22-02-2019','Gripe',60,50,'22-12-2019');
INSERT INTO tblvisitas VALUES (18,30004,'30-06-2019','Migrañas',50,70,'30-07-2019');
INSERT INTO tblvisitas VALUES (19,30007,'25-05-2017','Gripe',70,80,'25-08-2017');
INSERT INTO tblvisitas VALUES (20,30005,'14-11-2017','Anemia',100,55,'14-03-2018');
INSERT INTO tblvisitas VALUES (21,30004,'15-08-2017','Gripe',40,15,'15-09-2017');
INSERT INTO tblvisitas VALUES (22,30004,'21-08-2017','Otitis',80,20,'21-10-2017');
INSERT INTO tblvisitas VALUES (23,30012,'23-07-2017','Amigdalitis',60,50,'23-09-2017');
INSERT INTO tblvisitas VALUES (25,30014,'28-12-2018','Amigdalitis',60,25,'28-03-2019');
INSERT INTO tblvisitas VALUES (28,30015,'29-11-2018','Gripe',50,60,'29-01-2019');
INSERT INTO tblvisitas VALUES (30,30016,'30-10-2018','Herpes',80,40,'30-11-2018');
INSERT INTO tblvisitas VALUES (34,30017,'30-01-2018','Migrañas',60,30,'30-03-2018');
INSERT INTO tblvisitas VALUES (35,30018,'26-04-2018','Asma',50,50,'26-05-2018');
INSERT INTO tblvisitas VALUES (36,30026,'21-03-2018','Gripe',45,70,'21-06-2018');
INSERT INTO tblvisitas VALUES (37,30026,'15-06-2018','Asma',67,80,'15-07-2018');
INSERT INTO tblvisitas VALUES (38,30002,'15-12-2018','Asma',100,55,'15-01-2019');
INSERT INTO tblvisitas VALUES (39,30004,'10-02-2018','Gripe',80,15,'10-03-2018');
INSERT INTO tblvisitas VALUES (42,30018,'03-12-2018','Esguince',90,50,'05-03-2019');
INSERT INTO tblvisitas VALUES (45,30015,'15-07-2018','Anemia',60,70,'15-09-2018');
INSERT INTO tblvisitas VALUES (46,30012,'04-10-2018','Alergia',120,80,'12-04-2018');
INSERT INTO tblvisitas VALUES (47,30015,'06-01-2018','Gripe',50,55,'03-06-2018');
INSERT INTO tblvisitas VALUES (48,30018,'04-02-2018','Alergia',70,50,'05-04-2018');
INSERT INTO tblvisitas VALUES (49,30026,'01-07-2018','Esguince',100,25,'08-01-2018');
INSERT INTO tblvisitas VALUES (50,30012,'08-06-2018','Gripe',40,70,'08-08-2018');
INSERT INTO tblvisitas VALUES (60,30014,'09-03-2018','Amigdalitis',80,80,'05-09-2018');
INSERT INTO tblvisitas VALUES (61,30015,'02-04-2019','Alergia',60,30,'06-02-2019');
INSERT INTO tblvisitas VALUES (62,30014,'12-10-2019','Gripe',60,50,'11-12-2019');
INSERT INTO tblvisitas VALUES (63,30018,'19-06-2019','Esguince',50,70,'19-07-2019');
INSERT INTO tblvisitas VALUES (64,30014,'05-08-2019','Esguince',80,10,'10-05-2019');




