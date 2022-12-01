-- DROP DATABASE IF EXISTS elsistema;
CREATE DATABASE elsistema CHARACTER SET utf8mb4;
USE elsistema;
CREATE TABLE departamentos (
iddepartamento INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
presupuesto DOUBLE UNSIGNED NOT NULL,
estado  boolean NOT NULL
);
CREATE TABLE empleados (
idemplaedo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
cuil_cuit VARCHAR(15) NOT NULL UNIQUE,
nombre VARCHAR(100) NOT NULL,
apellido VARCHAR(100) NOT NULL,
id_departamento INT UNSIGNED,
estado BOOLEAN,
FOREIGN KEY (id_departamento) REFERENCES departamentos(iddepartamento)
);
CREATE TABLE clientes (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
apellido VARCHAR(30) NOT NULL,
cuitcuil VARCHAR(20),
ciudad VARCHAR(100),
categoría INT UNSIGNED
);
CREATE TABLE vendedores (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
apellido VARCHAR(30) NOT NULL,
cuitcuil VARCHAR(20),
comisión FLOAT
);
CREATE TABLE pedidos (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
cantidad DOUBLE NOT NULL,
fecha DATE,
id_cliente INT UNSIGNED NOT NULL,
id_vendedor INT UNSIGNED NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES clientes(id),
FOREIGN KEY (id_vendedor) REFERENCES vendedores(id)
);


-- 1. Agregar las entidades paises (id, nombre), provincias (id, nombre, idpais) y localidades
-- (id,nombre, cp,id_provincia). Tener en cuenta que:
-- ● En un país hay muchas provincias.
-- ● En una provincia hay muchas localidades.

CREATE TABLE IF NOT EXISTS `Pais` (
  `idPais` INT NOT NULL,
  `NombrePais` VARCHAR(25) NULL,
  PRIMARY KEY (`idPais`));

CREATE TABLE IF NOT EXISTS `Provincia` (
  `idProvincia` INT NOT NULL,
  `NombreProvincia` VARCHAR(25) NULL,
  `Pais_idPais` INT NOT NULL,
	PRIMARY KEY (`idProvincia`),
    FOREIGN KEY (`Pais_idPais`)
    REFERENCES `Pais` (`idPais`));

CREATE TABLE IF NOT EXISTS `Localidad` (
  `idLocalidad` INT NOT NULL,
  `nombreLocalidad` VARCHAR(25) NULL,
  `idProvincia` INT NOT NULL,  
	PRIMARY KEY (`idLocalidad`),
    FOREIGN KEY (`idProvincia`)
    REFERENCES `Provincia` (`idProvincia`));


-- -------------------------------------------------------------------------------------------------------------------------------

-- 2. Modificar la tabla empleados usando ALTER TABLE y agregar los campos:
-- ●direccion (varchar)
-- ●id_localidad (pk localidad) –Esta es un relación con la tabla localidades
-- ●email-- ●telefono ●fecha_ingreso ●tms (timestamp)

    alter table localidad 
    add index fk_localidad_empleados (idLocalidad);
    
    ALTER TABLE empleados 
    add idlocalidad int not null,
	add FOREIGN KEY (`idlocalidad`) REFERENCES `localidad`(`idlocalidad`),
    add direccion varchar(50),
	add email varchar(25),
    add telefono varchar(50),
    add fecha_ingreso datetime,
	add tms timestamp;
     
-- ------------------------------------------------------------------------------------------------------------------------------
/*
3. Modificar la tabla de departamentos  usando ALTER TABLE y agregar los campos:
●gasto (double)
●tms (timestamp)
*/
 ALTER TABLE departamentos 
    add gastos double,
	add tms timestamp;

/*4. Insertar 5 registros en cada tabla de: paises, provincias, localidades, departamentos,
empleados.
*/
--  - para colocar el autoincrement en la pk
SET FOREIGN_KEY_CHECKS = 0;

alter table pais 
MODIFY column idpais int  AUTO_INCREMENT;

alter table provincia 
MODIFY column idprovincia int  AUTO_INCREMENT;

alter table localidad 
MODIFY column idlocalidad int  AUTO_INCREMENT;
SET FOREIGN_KEY_CHECKS = 1;


-- AGREGAR 5 VALORES A TABLA PAIS  

insert into pais (NombrePais) values("Brasil");
insert into pais (NombrePais) values("Argentina");
insert into pais (NombrePais) values("Colombia");
insert into pais (NombrePais) values("Ecuador");
insert into pais (NombrePais) values("Uruguay");

 -- AGREGAR 5 VALORES A TABLA PROVINCIAS 
 
insert into provincia (NombreProvincia,Pais_idPais) values("Misiones",02);
insert into provincia (NombreProvincia,Pais_idPais) values("Itapema",01);
insert into provincia (NombreProvincia,Pais_idPais) values("Antioquia.",03);
insert into provincia (NombreProvincia,Pais_idPais) values("Cañar",04);
insert into provincia (NombreProvincia,Pais_idPais) values("Punta del este",05);

-- AGREGAR 5 VALORES A TABLA LOCALIDAD 

insert into localidad (NombreLocalidad,idProvincia) values("Posadas",01);
insert into localidad (NombreLocalidad,idProvincia) values("praia",02);
insert into localidad (NombreLocalidad,idProvincia) values("intoki",03);
insert into localidad (NombreLocalidad,idProvincia) Values("cañantida",04);
insert into localidad (NombreLocalidad,idProvincia) values("el este",05);


-- AGREGAR 5 VALORES A TABLA DEPARTAMENTOS

insert into departamentos (nombre,presupuesto,estado,gastos,tms)values("Inspeccion",25000,1,5000, '2008-12-31 00:00:00');
insert into departamentos (nombre,presupuesto,estado,gastos,tms)values("Supervicion",5000,0,2000, '2017-12-05 00:00:00');
insert into departamentos (nombre,presupuesto,estado,gastos,tms)values("Desarrollo",55000,1,20000, '2010-07-31 00:00:00');
insert into departamentos (nombre,presupuesto,estado,gastos,tms)values("Sistemas",65000,1,8000, '2009-08-31 00:00:00');
insert into departamentos (nombre,presupuesto,estado,gastos,tms)values("Comercializacion",5000,0,2000, '2019-01-20 00:00:00');

-- AGREGAR 5 VALORES A TABLA EMPLEADOS

insert into empleados (cuil_cuit,nombre,apellido,id_departamento,estado,idlocalidad,direccion,email,telefono,fecha_ingreso,tms)
values("22-21456152","Roberto","Contreras",01,1,01,"Ita mini 5421","roberto@gmial.com",3764251245,'2015-01-25',sysdate());

insert into empleados (cuil_cuit,nombre,apellido,id_departamento,estado,idlocalidad,direccion,email,telefono,fecha_ingreso,tms)
values("22-2145523","Cristian","Franco",02,1,01,"ch 105 calle mocona 5421","cristian@gmial.com",3764523215,'2012-01-22',sysdate());

insert into empleados (cuil_cuit,nombre,apellido,id_departamento,estado,idlocalidad,direccion,email,telefono,fecha_ingreso,tms)
values("22-21456654","Juan","Benitez",02,02,01,"Ita mini 2541","JB@gmial.com",376425156,'2001-01-25',sysdate());

insert into empleados (cuil_cuit,nombre,apellido,id_departamento,estado,idlocalidad,direccion,email,telefono,fecha_ingreso,tms)
values("22-21456892","Lucas","Rodriguez",03,03,03,"guayavi5421","roberto@gmial.com",3766542754,'1999-01-25',sysdate());

insert into empleados (cuil_cuit,nombre,apellido,id_departamento,estado,idlocalidad,direccion,email,telefono,fecha_ingreso,tms)
values("22-26565622","Martin","Rodriguez",05,05,05,"Ita mini 5421","martin.roodz@gmial.com",337654654,'2022-01-25',sysdate());


-- 5. Modificar el nombre de la tabla “pedidos” por “movimientos”. RENAME TABLE

ALTER TABLE pedidos
RENAME TO movimientos;

/*
----------------------------------------------------------------------------------------------------------
6. Agregar las entidades:
●Productos (id, nombre, descripcion, id_marca fk, stock, precio, estado, tms)
●Marcas (id, nombre, descripción, imagen, id_proveedor, estado, tms)
●Proveedores (id, razon_social, nombre, apellido, naturaleza (fisica o juridica),
cuit,id_localidad fk, estado,tms)
●Cajas (id,horainicio(datatime),horacierre(datatime), estado, tms)
*/
SET FOREIGN_KEY_CHECKS = 0;
CREATE TABLE IF NOT EXISTS `Provedores` (
  `idProvedores` INT NOT NULL AUTO_INCREMENT,
  `razonSocial` VARCHAR(25) NULL,
  `nombreProvedores` VARCHAR(25),
  `apellidoProvedores` VARCHAR(25),
  `naturaleza` VARCHAR(25),
  `cuitProvedores` int unique,
  `idLocalidad_fk` int,
  `estadoProvedores` boolean,
  `tmsProvedores` timestamp,
  PRIMARY KEY (`idProvedores`),
  FOREIGN KEY (`idLocalidad_fk`)
  REFERENCES `Localidad` (`idLocalidad`));


CREATE TABLE IF NOT EXISTS `Productos` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombreProducto` VARCHAR(25) NULL,
  `descripcionProducto` VARCHAR(100),
  `idMarca_fk` INT NOT NULL,
  `stock` INT ,
  `precioProducto` DECIMAL,
  `estadoProducto` boolean,
  `tmsProducto` timestamp,
   PRIMARY KEY (`idProducto`),
   FOREIGN KEY (`idMarca_fk`)
   REFERENCES `marcas` (`idMarca`));
   

CREATE TABLE IF NOT EXISTS `Cajas`(
	`idCajas` int NOT NULL AUTO_INCREMENT,
    `horaInicio` datetime,
	`horaCierre` datetime,
	`estadoCajas` boolean,
	`tmsCajas` timestamp,
    PRIMARY KEY (`idCajas`)
);
CREATE TABLE IF NOT EXISTS `Marcas` (
  `idMarca` INT NOT NULL AUTO_INCREMENT,
  `nombreMarca` VARCHAR(25) NULL,
  `descripcionMarca` VARCHAR(100),
  `idProvedor` INT NOT NULL,
  `estado` boolean,
  `tmsMarcas` timestamp,
   PRIMARY KEY (`idMarca`),
   FOREIGN KEY (`idProvedor`)
   REFERENCES `provedores` (`idProvedores`));
    
SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------------------------------------------------------------------------------

/*
7. Insertar 5 registros en cada tabla del punto 6. Tener en cuenta que el script debe ejecutarse
secuencialmente y no fallar.
*/

insert into provedores (razonSocial,nombreProvedores,apellidoProvedores,naturaleza,cuitProvedores,idLocalidad_fk,estadoProvedores,tmsProvedores)
values ("Coca Cola Corp.","Juan","Contrerprovedoresas","Fisica",52-54752156-3,1,1,sysdate());
insert into provedores (razonSocial,nombreProvedores,apellidoProvedores,naturaleza,cuitProvedores,idLocalidad_fk,estadoProvedores,tmsProvedores)
values ("Doritos Corp.","Lucas","Alvarez","Fisica",52-45528452-3,5,0,sysdate());
insert into provedores (razonSocial,nombreProvedores,apellidoProvedores,naturaleza,cuitProvedores,idLocalidad_fk,estadoProvedores,tmsProvedores)
values ("Milka Corp.","Julian","Gomez","Juridica",52-52158751-8,4,1,sysdate());
insert into provedores (razonSocial,nombreProvedores,apellidoProvedores,naturaleza,cuitProvedores,idLocalidad_fk,estadoProvedores,tmsProvedores)
values ("Arcor. Corp.","Franco","Rodriguez","Fisica",45-58452154-4,3,0,sysdate());
insert into provedores (razonSocial,nombreProvedores,apellidoProvedores,naturaleza,cuitProvedores,idLocalidad_fk,estadoProvedores,tmsProvedores)
values ("Pepsi Corp.","Martin","Gauna","Juridica",22-54853215-5,2,1,sysdate());

insert into marcas (nombreMarca,descripcionMarca,idProvedor,estado,tmsMarcas) values ("Coca Cola","Marca de bebidas",1,1,sysdate());
insert into marcas (nombreMarca,descripcionMarca,idProvedor,estado,tmsMarcas) values ("Doritos","Los Mejores Snack",5,1,sysdate());
insert into marcas (nombreMarca,descripcionMarca,idProvedor,estado,tmsMarcas) values ("Milka","Chocolates mas ricos del mundo",4,0,sysdate());
insert into marcas (nombreMarca,descripcionMarca,idProvedor,estado,tmsMarcas) values ("Arcor","Productos de primera calidad",3,1,sysdate());
insert into marcas (nombreMarca,descripcionMarca,idProvedor,estado,tmsMarcas) values ("Pepsi","Las Mejores Bebidas son pepsi",2,1,sysdate());

insert into Cajas (horaInicio,HoraCierre,estadoCajas,tmsCajas) values ('2022-11-16 13:00:00','2022-11-16 18:00:00',1,sysdate());
insert into Cajas (horaInicio,HoraCierre,estadoCajas,tmsCajas) values ('2022-11-17 13:00:00','2022-11-17 18:00:00',0,sysdate());
insert into Cajas (horaInicio,HoraCierre,estadoCajas,tmsCajas) values ('2022-11-19 13:00:00','2022-11-19 18:00:00',1,sysdate());
insert into Cajas (horaInicio,HoraCierre,estadoCajas,tmsCajas) values ('2022-11-18 12:30:00','2022-11-18 17:00:00',1,sysdate());
insert into Cajas (horaInicio,HoraCierre,estadoCajas,tmsCajas) values ('2022-11-20 07:00:00','2022-11-20 12:30:00',0,sysdate());

insert into Productos (nombreProducto,descripcionProducto ,idMarca_fk,stock  ,precioProducto ,estadoProducto,tmsProducto)
values ("Coca Cola","envase de 1LTS",1,400,450,1,sysdate());
insert into Productos (nombreProducto,descripcionProducto ,idMarca_fk,stock  ,precioProducto ,estadoProducto,tmsProducto)
values ("Doritos","Doritos de 500g extra grande",5,200,50,1,sysdate());
insert into Productos (nombreProducto,descripcionProducto ,idMarca_fk,stock  ,precioProducto ,estadoProducto,tmsProducto)
values ("Milka","envase de 1LTS",1,400,450,1,sysdate());
insert into Productos (nombreProducto,descripcionProducto ,idMarca_fk,stock  ,precioProducto ,estadoProducto,tmsProducto)
values ("Galletita Arcor","Calle 500g neto",3,200,250,1,sysdate());
insert into Productos (nombreProducto,descripcionProducto ,idMarca_fk,stock  ,precioProducto ,estadoProducto,tmsProducto)
values ("Pepsi","envase de 1.5LTS",2,150,300,1,sysdate());
 
 -- -------------------------------------------------------------------------------------------------------------------------------------

/*
8. Listar el nombre, presupuesto, gastos y diferencia(presupuesto-gasto) de todos los
departamentos con estado activo o 1.
*/ 

select nombre, presupuesto, gastos, presupuesto-gastos as diferencia from departamentos where estado=1;

-- -------------------------------------------------------------------------------------------------------------------------------------

/* 9. Listar todas todas las localidades agrupadas por pais. En la vista se deberia ver el nombre
del pais y el nombre de la localidad*/

select pais.NombrePais, localidad.nombreLocalidad from localidad join provincia on localidad.idProvincia=provincia.idprovincia 
join pais on provincia.Pais_idPais=pais.idpais;

-- -------------------------------------------------------------------------------------------------------------------------------------

/*
 10. Modificar (UPADTE):
●el telefono de un empleado cuando el id es igual a uno que hayan declarado.
●el fecha_ingreso y la localidad de otro empleado.
*/

UPDATE empleados
SET empleados.telefono = "3764873338", empleados.fecha_ingreso= '2022-11-20'
WHERE empleados.idemplaedo=1;

-- -------------------------------------------------------------------------------------------------------------------------------------

/*11. Insertar 5 vendedores.*/
insert into vendedores (nombre,apellido,cuitcuil,comisión) values ("Marcos","Doller",52-542313-2,250.05);
insert into vendedores (nombre,apellido,cuitcuil,comisión) values ("Julian","Tigo",2-456465-3,1.800);
insert into vendedores (nombre,apellido,cuitcuil,comisión) values ("Paolo","Vizzca",1-545462-0,1.950);
insert into vendedores (nombre,apellido,cuitcuil,comisión) values ("Facundo","Frezer",6-251527-32,2.220);
insert into vendedores (nombre,apellido,cuitcuil,comisión) values ("Pablo","Escobar",54-215665-2,20.520);

-- -------------------------------------------------------------------------------------------------------------------------------------

 /*
 12. Modificar la tabla movimientos y agregar los campos: id_producto fk, estado, tms(timestamp), tipo_movimiento (ingreso, egreso, pedido)
 */
 alter table productos 
 add index fk_productos_movimientos (idProducto);
 
 alter table movimientos 
 add idproducto_fk int not null,
 add FOREIGN KEY (idproducto_fk) references `productos`(`idProducto`),
 add tms timestamp,
 add estado boolean,
 add tipo_movimiento varchar(25);
 
  -- -------------------------------------------------------------------------------------------------------------------------------------

 /*13. Insertar 5 movimientos distintos.*/
 
 -- AGREGAR CLIENTES ---


 insert into clientes (nombre,apellido,cuitcuil,ciudad,categoría) values ("Romero","Trivia",'3-251548-2','Posadas',1);
 insert into clientes (nombre,apellido,cuitcuil,ciudad,categoría) values ("Juan","Gomez",'9-2256214-3','El Dorado',2);
 insert into clientes (nombre,apellido,cuitcuil,ciudad,categoría) values ("Miguel","Santa",'4-545621-9','Iguazu',3);
 insert into clientes (nombre,apellido,cuitcuil,ciudad,categoría) values ("Jose","Romos",'8-4464123-5','Cordoba',4);
 insert into clientes (nombre,apellido,cuitcuil,ciudad,categoría) values ("Ezequiel","Lopez",'5-465465-1','Corrientes',4);
-- -------------------------------------------------------------------------------------------------------------------------------------

 insert into movimientos (cantidad,fecha,id_cliente,id_vendedor,idproducto_fk,tms,tipo_movimiento,estado) values (500,'2022-11-17',1,1,1,'2022-11-17 18:00:00',"ingreso",1);
 insert into movimientos (cantidad,fecha,id_cliente,id_vendedor,idproducto_fk,tms,tipo_movimiento,estado) values (150,'2022-10-15',2,2,2,'2022-10-15 20:00:00',"pedido",1);
 insert into movimientos (cantidad,fecha,id_cliente,id_vendedor,idproducto_fk,tms,tipo_movimiento,estado) values (50,'2022-10-07',3,3,3,'2022-10-07 13:30:00',"egreso",1);
 insert into movimientos (cantidad,fecha,id_cliente,id_vendedor,idproducto_fk,tms,tipo_movimiento,estado) values (20,'2022-09-01',4,4,4,'2022-09-17 20:00:00',"ingreso",1);
 insert into movimientos (cantidad,fecha,id_cliente,id_vendedor,idproducto_fk,tms,tipo_movimiento,estado) values (300,'2022-05-05',5,5,5,'2022-05-05 17:00:00',"pedido",0);
 
/*
14. Borrar lógicamente (UPDATE de la columna estado):
●2 movimientos que fueron cargados mal
●un pais que tenga al menos 3 localidades
*/ 

UPDATE movimientos
SET estado = 0
WHERE movimientos.id=1 or movimientos.id=2;

-- -------------------------------------------------------------------------------------------------

/*
15. Modificar el campo stock de la tabla productos teniendo en cuenta la cantidad de la tabla
de movimientos. Sumar el stock si es un ingreso, restar si es un egreso. Esto hacerlo de
manera manual en base los 5 movimientos insertados en el punto 13. Es decir deben haber
5 updates de la tabla producto.
*/

  update productos
	  join movimientos
	  on productos.idProducto=movimientos.idproducto_fk
	  set stock= stock - movimientos.cantidad where tipo_movimiento = "egreso";

 update productos
	  join movimientos
	  on productos.idProducto=movimientos.idproducto_fk
	  set stock= stock + movimientos.cantidad where tipo_movimiento = "ingreso";


-- -------------------------------------------------------------------------------------
 /*
 16. Crear la tabla parametros (id, tms,cosas(json), id_usuario)
 */
 
 CREATE TABLE IF NOT EXISTS `parametros` (
  `idParametros` INT NOT NULL AUTO_INCREMENT,
  `idUsuario` INT NOT NULL,
  `tmsParametros` timestamp,
  `cosas` json default null,
   PRIMARY KEY (`idParametros`));
   
-- -------------------------------------------------------------------------------------

 /*17. Insertar en la tabla parametros teniendo en cuenta la columna cosas:
●{"idDeLaCosa": 101, "permisos": "PUT, GET"}
●{"vistasPermitidas":"menuPrincipal,menuSecundario,ventas,estadisticaVentas,listaCliente",
“grupo": "ventas"}
●{"zonaHoraria": "America/Argentina/BuenosAires"}
●{"fechaInicioActividades": 01/01/2019, "mesAperturaCaja": "Enero", "mesCierreCaja":
"Diciembre"}
●{"balancesAniosAnteriores": {"2019": {"ingreso": "7374901.93","egreso":
"3732538,75"},"2020":{"ingreso": "27442665,12","egreso": "8522331,82"},"2021": {"ingreso":
"31634912,57","egreso": "9757142,66"}}}
Nota: Rellenar a criterio los campos id, tms,id_usuario
*/

insert parametros (idUsuario,tmsParametros,cosas) values (1,sysdate(),'{"idDeLaCosa": 101, "permisos": "PUT, GET"}');

insert parametros (idUsuario,tmsParametros,cosas) values (2,sysdate(),'{
	"vistasPermitidas": ["menuPrincipal", "menuSecundario", "ventas", "estadisticaVentas", "listaCliente"], "grupo": "ventas"}');

insert parametros (idUsuario,tmsParametros,cosas) values (3,sysdate(),'{"zonaHoraria": "America/Argentina/BuenosAires"}');

insert parametros (idUsuario,tmsParametros,cosas) values (4,sysdate(),'{"fechaInicioActividades": "01/01/2019", "mesAperturaCaja": "Enero", "mesCierreCaja":
"Diciembre"}');

insert parametros (idUsuario,tmsParametros,cosas) values (5,sysdate(),'{"balancesAniosAnteriores": {"2019": {"ingreso": "7374901.93","egreso":
"3732538,75"},"2020":{"ingreso": "27442665,12","egreso": "8522331,82"},"2021": {"ingreso":
"31634912,57","egreso": "9757142,66"}}}');