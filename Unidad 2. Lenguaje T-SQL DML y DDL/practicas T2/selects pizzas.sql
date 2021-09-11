CREATE TABLE pizzas (
  NPizza varchar2(20) NOT NULL,
  price decimal(5,2) NOT NULL,
  PRIMARY KEY (NPizza)
);

INSERT INTO pizzas VALUES ('Besubio','13,00');
INSERT INTO pizzas VALUES('Margarita','15,00');
INSERT INTO pizzas VALUES('Napolitana','18,00');
INSERT INTO pizzas VALUES('Vegetariana','10,50');
INSERT INTO pizzas VALUES('Boloñesa','12,50');
INSERT INTO pizzas VALUES('Simple','1,50');
INSERT INTO pizzas VALUES('Hawaiana','13,00');


CREATE TABLE preparation (
  NPizza varchar2(20) NOT NULL,
  ingredient varchar2(20) NOT NULL,
  quantity decimal(4,0) NOT NULL,
  PRIMARY KEY (NPizza,ingredient),
  CONSTRAINT fk_pre_NPizza FOREIGN KEY (NPizza) REFERENCES pizzas
);

INSERT INTO preparation VALUES ('Besubio','Huevos','2');
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
INSERT INTO preparation VALUES('Napolitana','Jamón York','34');
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




CREATE TABLE client (
  clientCod integer  NOT NULL,
  name varchar2(45) NOT NULL,
  PRIMARY KEY (clientCod)
);

INSERT INTO client VALUES (1,'Alvaro');
INSERT INTO client VALUES(2,'Lorena');
INSERT INTO client VALUES(3,'Abdon');
INSERT INTO client VALUES(4,'Fulano');
INSERT INTO client VALUES(5,'Felipe');
INSERT INTO client VALUES(6,'Josep');
INSERT INTO client VALUES(7,'Ana');
INSERT INTO client VALUES(8,'Mengano');


CREATE TABLE sales (
  NPizza varchar2(20) NOT NULL,
  clientCod integer NOT NULL,
  orderCod integer NOT NULL,
  date2 date NOT NULL,
  PRIMARY KEY (orderCod),
  CONSTRAINT fk_sales_NPizza FOREIGN KEY (NPizza) REFERENCES pizzas,
  CONSTRAINT fk_sales_client FOREIGN KEY (clientCod) REFERENCES client
);


INSERT INTO sales VALUES ('Vegetariana',1,1,TO_DATE('21:02:44 3/05/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Vegetariana',2,2,TO_DATE('01:02:44 3/08/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Vegetariana',1,3,TO_DATE('22:02:44 3/07/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Vegetariana',1,4,TO_DATE('23:02:44 3/09/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Vegetariana',3,5,TO_DATE('2:02:44 3/10/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Vegetariana',5,6,TO_DATE('1:02:44 3/11/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Vegetariana',4,7,TO_DATE('3:02:44 3/12/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Vegetariana',2,8,TO_DATE('4:02:44 3/01/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Besubio',1,9,TO_DATE('12:02:44 3/02/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Besubio',3,10,TO_DATE('13:02:44 3/03/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Besubio',4,11,TO_DATE('14:02:44 3/04/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Besubio',2,12,TO_DATE('15:02:44 3/05/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Besubio',5,13,TO_DATE('21:02:44 3/06/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Besubio',5,14,TO_DATE('21:02:44 3/07/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Besubio',2,15,TO_DATE('16:02:44 3/08/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Margarita',4,16,TO_DATE('17:02:44 3/09/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Margarita',4,17,TO_DATE('18:02:44 3/10/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Margarita',5,18,TO_DATE('18:02:44 3/11/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Margarita',2,19,TO_DATE('21:02:44 3/12/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Margarita',1,20,TO_DATE('20:02:44 3/05/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Margarita',3,21,TO_DATE('21:02:44 3/06/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Napolitana',2,22,TO_DATE('21:02:44 3/07/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Napolitana',3,23,TO_DATE('21:02:44 3/08/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Boloñesa',3,24,TO_DATE('21:02:44 3/06/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Simple',2,25,TO_DATE('21:02:44 3/07/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Hawaiana',3,26,TO_DATE('21:02:44 3/08/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Margarita',7,27,TO_DATE('21:02:44 3/08/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Simple',8,28,TO_DATE('21:02:44 3/07/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Simple',3,29,TO_DATE('21:02:44 3/07/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Simple',3,30,TO_DATE('21:02:44 3/07/2019', 'hh24:mi:ss dd/mm/yyyy'));
INSERT INTO sales VALUES ('Simple',3,31,TO_DATE('21:02:44 3/07/2019', 'hh24:mi:ss dd/mm/yyyy'));


