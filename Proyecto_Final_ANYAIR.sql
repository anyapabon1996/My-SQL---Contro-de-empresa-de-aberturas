############################################################ CREACIÓN DE ESQUEMA Y TABLAS, CON SUS RELACIONES ############################################################

/*CREA EL ESQUEMA*/
create schema ABERTURAS;

/*USAR EL ESQUEMA*/
use ABERTURAS;

/*CREA TABLA PROVEEDOR CON SU PK*/
create table if not exists PROVEEDOR (
	ID_PROVEEDOR 	int not null AUTO_INCREMENT,
    CUIT 			varchar(20) not null, 
    RAZON_SOCIAL 	varchar(40) not null, 
    TIPO_FACTURA 	char(1) not null,
    DIRECCION		varchar(100) not null, 
    TELEFONO 		varchar(20) not null,
    DEBITO 			decimal(15,5) not null,
    CREDITO 		decimal(15,5) not null,
    PRIMARY KEY (ID_PROVEEDOR)
);

/*CREA LA TABLA DISTRIBUIDORES CON SU PK*/
create table if not exists DISTRIBUIDOR(
	ID_DISTRIBUIDOR int not null AUTO_INCREMENT, 
    CUIT 			varchar(20) not null, 
    RAZON_SOCIAL 	varchar(40) not null, 
    DIRECCION		varchar(100) not null, 
    TELEFONO 		varchar(20) not null,
    DEBITO 			decimal(15,5) not null,
    CREDITO 		decimal(15,5) not null,
    PRIMARY KEY (ID_DISTRIBUIDOR)
);

/*CREA LA TABLA PRODUCTOS CON SU PK Y FK*/
create table if not exists PRODUCTOS (
	ID_PRODUCTO 	int not null AUTO_INCREMENT,
    DESCRIPCION 	varchar(200) not null,
    CANTIDAD 		int not null,
    F_ULTIMA_COMPRA date not null,
    P_INTERNO 		char(1) not null, 
    ID_PROVEEDOR 	int not null,
    PRIMARY KEY (ID_PRODUCTO),
	CONSTRAINT FK_ProductoProveedor FOREIGN KEY (ID_PROVEEDOR) REFERENCES PROVEEDOR(ID_PROVEEDOR)
);

/*CREA LA TABLA DE FACTURACION SOLO CON SU PK*/
create table if not exists FACTURACION (
	ID_FACT 		int not null AUTO_INCREMENT, 
    TIPO 			char(1) not null, 
    NRO_FACTURA 	varchar(20) not null,
    F_FACTURACION 	date not null,
    ID_DISTRIBUIDOR int not null,
    PRIMARY KEY (ID_FACT)
);


/*CREA LA TABKA DE GESTION DE ENVIOS. NOTAR QUE NO TIENE PK*/
create table if not exists GESTION_ENVIOS (
	FECHA_ENTREGA 	date not null,
    CANT_PROD_ENV 	int not null,
    OBSERVACIONES 	varchar(255),
    CANT_DEVOLUCIONES int,
    FECHA_DEVOLUCION date,
    EST_DEVOLUCION 	varchar(10),
    ID_DISTRIBUIDOR int not null,
    ID_PRODUCTO 	int not null,
    ID_FACT 		int not null
);

/*CREA LA FK DE FACTURACION A DISTRIBUIDOR*/
alter table FACTURACION
ADD CONSTRAINT FK_FacturacionDistribuidor 
FOREIGN KEY (ID_DISTRIBUIDOR)
REFERENCES DISTRIBUIDOR(ID_DISTRIBUIDOR);

/*SE AGREGAN LAS FK DE LA TABLA GESTION_ENVIOS*/
alter table GESTION_ENVIOS
ADD CONSTRAINT FK_EnvioDistribuidor
FOREIGN KEY (ID_DISTRIBUIDOR)
REFERENCES DISTRIBUIDOR(ID_DISTRIBUIDOR);

alter table GESTION_ENVIOS
ADD CONSTRAINT FK_EnvioProductos
FOREIGN KEY (ID_PRODUCTO)
REFERENCES PRODUCTOS(ID_PRODUCTO);

alter table GESTION_ENVIOS
ADD CONSTRAINT FK_EnvioFacturacion 
FOREIGN KEY (ID_FACT)
REFERENCES FACTURACION(ID_FACT);

/*corroborar que se agregaron las fk*/
describe gestion_envios;


############################################################ INSERCIÓN DE DATOS EN LAS 5 TABLAS ############################################################
insert into distribuidor(CUIT, RAZON_SOCIAL, DIRECCION, TELEFONO, DEBITO, CREDITO)
values 
('222354259', 'PUERTAS FIRE NATION', 		 'ISLA EMBER', 			 '1122267488', 0, 			10000.0),
('222354259', 'PUERTAS NORTH WATER TRIBE', 	 'CAPITAL DEL NORTE',  	 '1122267499', 1245.3, 		0),
('222354259', 'PUERTAS SOUTH WATER TRIBE', 	 'CAPITAL DEL SUR', 	 '1122267477', 253647.33, 	0),
('222354259', 'PUERTAS EARTH KINGDOM', 		 'CAPITAL REINO TIERRA', '1122267466', 747458.374, 	0),
('222354259', 'PUERTAS NORTHERN AIR TEMPLE', 'CAPITAL TEMPLO NORTE', '1122267455', 44545.55, 	3000.0),
('222354259', 'PUERTAS SOUTHERN AIR TEMPLE', 'CAPITAL TEMPLO SUR', 	 '1122267444', 474775.347, 	100.0),
('222354259', 'PUERTAS WESTERN AIR TEMPLE',  'CAPITAL TEMPLO OESTE', '1122267433', 11111.11, 	25.0),
('222354259', 'PUERTAS EASTERN AIR TEMPLE',  'CAPITAL TEMPLO ESTE',  '1122267422', 25778573.4, 	0),
('222354259', 'PUERTAS OMASHU', 			 'OMASHU', 				 '1122267411', 5457.3, 		0),
('222354259', 'PUERTAS CIUDAD REPUBLICA',    'CIUDAD REPUBLICA', 	 '1122267400', 0, 			0)
;

insert into proveedor (CUIT, RAZON_SOCIAL, TIPO_FACTURA, DIRECCION, TELEFONO, DEBITO, CREDITO)
values 
    ('958474252', 'NIMBUS',			 	'C', 'CALLEJON DIAGON', '116412548', 141425.3, 	44554.3),
    ('369888745', 'SAETA', 				'C', 'CALLEJON DIAGON', '116412549', 9636.34, 	45458.3),
    ('112547896', 'MADERO', 			'C', 'CALLEJON DIAGON', '116412541', 8563.4, 	858536.3),
    ('963336587', 'ROBLES DOOR', 		'B', 'ROBERTANIA', 		'116412523', 75357.4, 	36557.3),
    ('258765424', 'LUMUS', 				'A', 'HOGWARTS', 		'116412542', 78325.75, 	4523.7878),
	('123456789', 'BARMETAL', 			'A', 'CAPITAL FEDERAL', '116412543', 1424.4, 	17365.3),
    ('123456781', 'PAVIR', 				'B', 'CAPITAL FEDERAL', '116412544', 12365.4, 	362541.3),
    ('123456782', 'OBLAK', 				'C', 'CAPITAL FEDERAL', '116412545', 1254.4, 	14275.3),
    ('123654789', 'PUERTAS DEL SUR', 	'A', 'BARILOCHE', 		'116412546', 0, 		0),
    ('123654259', 'PUERTAS DEL NORTE', 	'A', 'MISIONES', 		'116412577', 0, 		0),
    ('123354259', 'NOSOTROS', 			'A', 'PILAR', 			'116455548', 142536.36, 0);

insert into facturacion(TIPO, NRO_FACTURA, F_FACTURACION, ID_DISTRIBUIDOR)
values 
('A', '11111111', '2023-04-07', 1),
('A', '11111112', '2023-04-07', 1),
('A', '11111113', '2023-04-07', 1),
('A', '11111114', '2023-04-07', 1),
('B', '11111115', '2023-04-07', 6),
('B', '11111116', '2023-04-07', 6),
('B', '11111117', '2023-04-07', 6),
('B', '11111118', '2023-04-07', 6),
('B', '11111119', '2023-04-07', 6),
('C', '11111110', '2023-04-07', 4),
('C', '11111120', '2023-04-07', 4),
('C', '11111130', '2023-04-07', 4),
('B', '11111140', '2023-04-06', 4),
('B', '11111150', '2023-04-06', 4),
('B', '11111160', '2023-04-06', 4),
('B', '11111170', '2023-04-06', 4),
('C', '11111180', '2023-04-06', 2),
('C', '11111190', '2023-04-06', 2),
('B', '11111121', '2023-04-05', 3),
('B', '11111122', '2023-04-05', 3),
('B', '11111123', '2023-04-05', 3),
('B', '11111124', '2023-04-05', 3),
('B', '11111125', '2023-04-05', 3),
('C', '11111126', '2023-04-05', 3),
('C', '11111127', '2023-04-05', 3),
('C', '11111128', '2023-04-05', 3),
('A', '11111129', '2023-04-05', 5),
('A', '11111131', '2023-04-05', 5),
('A', '11111132', '2023-04-05', 5),
('A', '11111133', '2023-04-05', 5),
('B', '11111134', '2023-04-04', 7),
('B', '11111135', '2023-04-04', 7),
('B', '11111136', '2023-04-04', 8),
('B', '11111137', '2023-04-04', 8),
('B', '11111138', '2023-04-04', 9),
('C', '11111139', '2023-04-04', 9),
('C', '11111141', '2023-04-03', 10),
('C', '11111142', '2023-04-03', 10),
('A', '11111143', '2023-04-03', 10),
('A', '11111144', '2023-04-03', 1),
('A', '11111145', '2023-04-03', 1),
('A', '11111146', '2023-04-03', 1)
;

insert into productos (DESCRIPCION, CANTIDAD, F_ULTIMA_COMPRA, P_INTERNO, ID_PROVEEDOR)
values 
('puerta reja 80X200', 				15, '2023-02-15', 0, 6),
('puerta balcon roble 200X200', 	5, 	'2022-10-10', 0, 4), 
('puerta voladora 90x200', 			10, '2021-12-31', 0, 1),
('puerta balcon luminosa 200x200', 	5, 	'2023-01-04', 0, 5),
('puerta fugaz estella 90x200', 	20, '2021-09-20', 0, 2),
('puerta madero cedro 90x200', 		15, '2022-11-11', 0, 3),
('puerta reja metalica 90x200', 	10, '2023-02-04', 0, 6),
('puerta pavorosa trasera 70x200', 	10, '2023-04-07', 0, 7), 
('puerta oscura 80x200', 			5, 	'2022-05-15', 0, 8),
('puerta nevada 80x200', 			10, '2021-01-04', 0, 9), 
('puerta soleada 80x200', 			10, '2022-07-25', 0, 10),
('puerta particular 90x200', 		20, '2023-04-01', 1, 11)
;

EXPLAIN gestion_envios;

/*TODOS ESTOS CAMPOS QUE FUERON NULL, QUERÍA QUE TOMARAN EL VALOR POR DEFECTO. ¿CÓMO TENGO QUÉ HACES?*/
insert into gestion_envios(FECHA_ENTREGA, CANT_PROD_ENV, OBSERVACIONES, CANT_DEVOLUCIONES, FECHA_DEVOLUCION, ID_DISTRIBUIDOR, ID_PRODUCTO, ID_FACT)
values
('2023-04-03', 5, 'fueron rayados los marcos de las puertas nevadas', 3, '2023-04-07', 1, 10, 42),
('2023-04-03', 5, null, null, null, 1, 11, 41),
('2023-04-03', 5, null, null, null, 1, 12, 40),
('2023-04-03', 5, null, null, null, 10, 1, 39),
('2023-04-03', 3, null, null, null, 10, 6, 38),
('2023-04-03', 4, null, null, null, 10, 7, 37),
('2023-04-04', 3, null, null, null, 9, 11, 36),
('2023-04-04', 2, null, null, null, 9, 2, 35),
('2023-04-04', 12, null, null, null, 8, 1, 34),
('2023-04-04', 4, null, null, null, 8, 2, 33),
('2023-04-04', 7, null, null, null, 7, 7, 32),
('2023-04-04', 10, null, null, null, 7, 7, 31),
('2023-04-05', 5, null, null, null, 5, 1, 30),
('2023-04-05', 5, null, null, null, 5, 3, 29),
('2023-04-05', 5, null, null, null, 5, 4, 28),
('2023-04-05', 3, null, null, null, 5, 8, 27),
('2023-04-05', 4, null, null, null, 3, 7, 26),
('2023-04-05', 3, null, null, null, 3, 1, 25),
('2023-04-05', 2, null, null, null, 3, 2, 24),
('2023-04-05', 12, null, null, null, 3, 8, 23),
('2023-04-05', 4, null, null, null, 3, 9, 22),
('2023-04-05', 7, null, null, null, 3, 10, 21),
('2023-04-05', 10, null, null, null, 3, 12, 20),
('2023-04-05', 10, null, null, null, 3, 6, 19),
('2023-04-06', 5, null, null, null, 2, 2, 18),
('2023-04-06', 5, null, null, null, 2, 8, 17),
('2023-04-06', 5, null, null, null, 4, 9, 16),
('2023-04-06', 10, null, null, null, 4, 10, 15),
('2023-04-06', 10, null, null, null, 4, 12, 14),
('2023-04-06', 10, null, null, null, 4, 6, 13),
('2023-04-07', 5, null, null, null, 4, 12, 12),
('2023-04-07', 5, null, null, null, 4, 1, 11),
('2023-04-07', 3, null, null, null, 4, 6, 10),
('2023-04-07', 4, null, null, null, 6, 7, 9),
('2023-04-07', 3, null, null, null, 6, 12, 8),
('2023-04-07', 2, null, null, null, 6, 11, 7),
('2023-04-07', 12, null, null, null, 6, 1, 6),
('2023-04-07', 4, null, null, null, 6, 2, 5),
('2023-04-07', 7, null, null, null, 1, 2, 4),
('2023-04-07', 10, null, null, null, 1, 7, 3),
('2023-04-07', 5, null, null, null, 1, 1, 2),
('2023-04-07', 3, 'CLIENTE SATISFECHO', 0, null, 1, 10, 42),
('2023-04-07', 2, 'CLIENTE SATISFECHO', 0, null, 1, 8, 1)
;

/*DESACTIVO EL MODO SEGURO*/
SET SQL_SAFE_UPDATES = 0;

/*AGREGA CONTENIDO A LOS CAMPOS QUE SE CARGARON NULL, DEBIO SER ASI POR DEFECTO*/
update gestion_envios
set CANT_DEVOLUCIONES = 0,
OBSERVACIONES = 'CLIENTE SATISFECHO'
where OBSERVACIONES is null
and CANT_DEVOLUCIONES is null;

############################################################ CREACIÓN DE VISTAS ############################################################
/*Muestra el nombre del producto, la cantidad y el nombre de su proveedor*/
create or replace view vw_productos_proveedor as
(select p.DESCRIPCION , p.CANTIDAD, q.RAZON_SOCIAL as nombre_proveedor
from productos as p
inner join proveedor as q
on p.ID_PROVEEDOR = q.ID_PROVEEDOR);

/*Muestra las devoluciones que se han recibido, por parte de un distribuidor, reflejando el debito y credito que el distribuidor posee*/
create or replace view vw_productos_devueltos as
(select  p.DESCRIPCION as PRODUCTO, g.FECHA_ENTREGA, g.FECHA_DEVOLUCION, g.OBSERVACIONES, g.CANT_DEVOLUCIONES, d.RAZON_SOCIAL as DISTRIBUIDOR, d.DEBITO, d.CREDITO
from gestion_envios as g
inner join productos as p
on g.ID_PRODUCTO = p.ID_PRODUCTO
inner join distribuidor as d
on g.ID_DISTRIBUIDOR = d.ID_DISTRIBUIDOR
where g.OBSERVACIONES <> 'CLIENTE SATISFECHO');

/*Muestra el nombre de los productos re entregados, las fehcas y las observaciones*/
create or replace view vw_productos_re_entregador as 
(select p.DESCRIPCION as PRODUCTO, g.FECHA_ENTREGA, g.FECHA_DEVOLUCION, g.OBSERVACIONES, g.CANT_DEVOLUCIONES, g.ID_FACT as FACTURA
from gestion_envios as g
inner join productos as p
on g.ID_PRODUCTO = p.ID_PRODUCTO
where g.ID_FACT in (
	select ID_FACT from gestion_envios
	group by ID_FACT
    having count(*) > 1)
group by p.DESCRIPCION, g.FECHA_ENTREGA, g.FECHA_DEVOLUCION, g.OBSERVACIONES, g.CANT_DEVOLUCIONES, g.ID_FACT
order by g.ID_FACT asc
);

/*Muestra el debito y el credito que se tiene con los proveedores, y la diferecia*/
create or replace view vw_saldos_proveedor as
(select p.RAZON_SOCIAL, sum(p.DEBITO) as DEDUDA, sum(p.CREDITO) as EN_CUENTA, p.CREDITO - p.DEBITO as DIREFERENCIA
from proveedor as p
group by p.RAZON_SOCIAL, p.CREDITO - p.DEBITO);

/*Muestra el debito y el credito que tienen los distribuidores, y la diferecia*/
create or replace view vw_saldos_distribuidor as
(select d.RAZON_SOCIAL, sum(d.DEBITO) as DEDUDA, sum(d.CREDITO) as EN_CUENTA, d.CREDITO - d.DEBITO as DIREFERENCIA
from distribuidor as d
group by d.RAZON_SOCIAL, d.CREDITO - d.DEBITO);

############################################################ FUNCIONES ############################################################
/*Encuentra las facturas que se repiten en la tabla de gestion de envios, es decir: los envíos que han sido devueltos y re-entregado*/
USE `aberturas`;
DROP function IF EXISTS `valores_repetidos`;

USE `aberturas`;
DROP function IF EXISTS `aberturas`.`valores_repetidos`;
;

DELIMITER $$
USE `aberturas`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `valores_repetidos`(cantidad int) RETURNS int
    READS SQL DATA
BEGIN
	declare response int;
    set response = (select g.ID_FACT
					from aberturas.gestion_envios as g
					group by g.ID_FACT
					having count(g.ID_FACT) > cantidad);
return response;
END$$

DELIMITER ;
;

/*sum el credito que tiene un distribuidor particular, o bien todos los distribuidores, depende de si se ingresa parametro*/
USE `aberturas`;
DROP function IF EXISTS `fn_get_credito_distribudior`;

USE `aberturas`;
DROP function IF EXISTS `aberturas`.`fn_get_credito_distribudior`;
;

DELIMITER $$
USE `aberturas`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_get_credito_distribudior`(razon_social varchar(50)) returns decimal(15,5)
    READS SQL DATA
BEGIN
	declare total decimal(15, 5);
    if razon_social <> "" then
		set total = (select sum(d.credito) as total_absoluto from aberturas.distribuidor as d where d.razon_social like razon_social);
	else 
		set total = (select sum(d.credito) as total_distribuidor from aberturas.distribuidor as d);
	end if;
return total;
END$$

DELIMITER ;
;

/*Obtiene el estado de una entrega a partir de su facturación*/
USE `aberturas`;
DROP function IF EXISTS `fn_get_descripcion`;

USE `aberturas`;
DROP function IF EXISTS `aberturas`.`fn_get_descripcion`;
;

DELIMITER $$
USE `aberturas`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_get_descripcion`(id int) RETURNS varchar(50) CHARSET utf8mb4
    READS SQL DATA
BEGIN
	declare response varchar(50);
    set response = (select g.OBSERVACIONES 
					from aberturas.gestion_envios as g
                    where g.ID_FACT = id);
RETURN response;
END$$

DELIMITER ;
;
############################################################ PROCEDIMIENTOS ALMACENADOS ############################################################
/*inserta y elimina de la tabla proveedor*/
USE `aberturas`;
DROP procedure IF EXISTS `sp_insert_and_delete`;

USE `aberturas`;
DROP procedure IF EXISTS `aberturas`.`sp_insert_and_delete`;
;

DELIMITER $$
USE `aberturas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_and_delete`(IN CUIT1 varchar(20), IN RAZON_SOCIAL1 varchar(40), IN TIPO_FACTURA1 char(1), IN DIRECCION1 varchar(100), IN TELEFONO1 varchar(20), IN DEBITO1 decimal(15,5), IN CREDITO1 decimal(15,5), IN FIELD_TO_DELETE1 int)
BEGIN
	insert into aberturas.proveedor(CUIT, RAZON_SOCIAL, TIPO_FACTURA, DIRECCION, TELEFONO, DEBITO, CREDITO) 
    values
	(CUIT1, RAZON_SOCIAL1, TIPO_FACTURA1, DIRECCION1, TELEFONO1, DEBITO1, CREDITO1);
    
    delete from aberturas.proveedor
    where proveedor.ID_PROVEEDOR = FIELD_TO_DELETE1;
END$$

DELIMITER ;
;

/*obtiene y ordena una tabla segun el nombre de la tabla, el campo por el que se ordenara, y el tipo de orden*/
USE `aberturas`;
DROP procedure IF EXISTS `aberturas`.`order_sstatement`;
;

DELIMITER $$
USE `aberturas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `order_statement`(IN tableName varchar(20), IN field varchar(20), IN customOrder varchar(5))
BEGIN
	set @sql = concat('select * from ', tableName, ' order by ', field, ' ' , customOrder);
    prepare stmt from @sql;
    execute stmt;
    deallocate prepare stmt;
END$$

DELIMITER ;
;

############################################################ TRIGGERS ############################################################
SELECT * FROM aberturas.gestion_envios;
# Primer Trigger
# Creamos una tabla log para la tabla gestion de envíon 
create table GESTION_ENVIOS_LOG (
	FECHA_ENTREGA date,
	CANT_PROD_ENV int,
	OBSERVACIONES varchar(255),
	CANT_DEVOLUCIONES int,
	FECHA_DEVOLUCION date,
	ID_DISTRIBUIDOR int, 
	ID_PRODUCTO int,
	ID_FACT int, 
    USUARIO varchar(50),
    FECHA date,
    HORA time
);

# Trigger que se dispara tras insertar un dato en la tabla 
create trigger `tg_insert_insertar_en_gestion_envios`
after insert on `gestion_envios`
for each row
insert into `GESTION_ENVIOS_LOG` (FECHA_ENTREGA, CANT_PROD_ENV, OBSERVACIONES, CANT_DEVOLUCIONES, FECHA_DEVOLUCION, ID_DISTRIBUIDOR, ID_PRODUCTO, ID_FACT, USUARIO, FECHA, HORA)
values (new.FECHA_ENTREGA, new.CANT_PROD_ENV, new.OBSERVACIONES, new.CANT_DEVOLUCIONES, new.FECHA_DEVOLUCION, new.ID_DISTRIBUIDOR, new.ID_PRODUCTO, new.ID_FACT, user(), current_date(), current_time());

# Trigger que se dispara tras eliminar un dato de la tabla
create trigger `tg_delete_eliminar_en_gestion_envios`
before delete on `gestion_envios`
for each row
insert into `GESTION_ENVIOS_LOG` (FECHA_ENTREGA, CANT_PROD_ENV, OBSERVACIONES, CANT_DEVOLUCIONES, FECHA_DEVOLUCION, ID_DISTRIBUIDOR, ID_PRODUCTO, ID_FACT, USUARIO, FECHA, HORA)
values (old.FECHA_ENTREGA, old.CANT_PROD_ENV, old.OBSERVACIONES, old.CANT_DEVOLUCIONES, old.FECHA_DEVOLUCION, old.ID_DISTRIBUIDOR, old.ID_PRODUCTO, old.ID_FACT, user(), current_date(), current_time());

# Ejemplos
insert into gestion_envios(FECHA_ENTREGA, CANT_PROD_ENV, OBSERVACIONES, CANT_DEVOLUCIONES, FECHA_DEVOLUCION, ID_DISTRIBUIDOR, ID_PRODUCTO, ID_FACT)
values
('2023-04-29', 5, 'fueron rayados los marcos de las puertas nevadas', 5, '2023-05-03', 1, 10, 42);

delete from gestion_envios where OBSERVACIONES like 'fueron rayados los marcos de las puertas nevadas' and CANT_DEVOLUCIONES = 5;

# Segundos Trigger
# Creamos tablalog para la tabla proveedor
SELECT * FROM aberturas.proveedor;
create table PROVEEDOR_LOG (
	ID_PROVEEDOR int,
	CUIT varchar(20),
	RAZON_SOCIAL varchar(40), 
	TIPO_FACTURA char(1), 
	DIRECCION varchar(100), 
	TELEFONO varchar(20), 
	DEBITO decimal(15,5), 
	CREDITO decimal(15,5),
	USUARIO varchar(50),
    FECHA date,
    HORA time,
    TIPO varchar(20)
);

# Trigger que se ejecuta tras actualizar la tabla 
create trigger `tg_update_actualizar_proveedor`
after update on `proveedor`
for each row
insert into `PROVEEDOR_LOG` (ID_PROVEEDOR, CUIT, RAZON_SOCIAL, TIPO_FACTURA, DIRECCION, TELEFONO, DEBITO, CREDITO, USUARIO, FECHA, HORA, TIPO)
values (old.ID_PROVEEDOR, old.CUIT, old.RAZON_SOCIAL, old.TIPO_FACTURA, old.DIRECCION, old.TELEFONO, old.DEBITO, old.CREDITO, user(), current_date(), current_time(), 'ACTUALIZACIÓN');

# Trigger que se jecuta tras insertar en la tabla 
create trigger `tg_insert_insertarr_proveedor`
after insert on `proveedor`
for each row
insert into `PROVEEDOR_LOG` (ID_PROVEEDOR, CUIT, RAZON_SOCIAL, TIPO_FACTURA, DIRECCION, TELEFONO, DEBITO, CREDITO, USUARIO, FECHA, HORA, TIPO)
values (new.ID_PROVEEDOR, new.CUIT, new.RAZON_SOCIAL, new.TIPO_FACTURA, new.DIRECCION, new.TELEFONO, new.DEBITO, new.CREDITO, user(), current_date(), current_time(), 'INSERCIÓN');

# Ejemplos
update proveedor set DEBITO = 120.0 where ID_PROVEEDOR = 15;

insert into proveedor (CUIT, RAZON_SOCIAL, TIPO_FACTURA, DIRECCION, TELEFONO, DEBITO, CREDITO)
values ('958466652', 'GIROSCOPIO', 'C', 'CALLEJON DIAGON', '1167777548', 0.0, 	100000.0);

############################################################ OTROS USUARIOS ############################################################
use mysql;
############################ USUARIO 1 ############################
-- Creamos el usuario 
create user 'usuario1'@'localhost' identified by '123654';

-- Le concedemos permisos sobre el esquema de aberturas 
grant all on aberturas to 'usuario1'@'localhost';

-- le concedemos permisos de solo lectura 
grant select on aberturas.proveedor to 'usuario1'@'localhost';
grant select on aberturas.distribuidor to 'usuario1'@'localhost';
grant select on aberturas.gestion_envios to 'usuario1'@'localhost';
grant select on aberturas.productos to 'usuario1'@'localhost';
grant select on aberturas.facturacion to 'usuario1'@'localhost';

-- mostramos los permisos asociados que tiene
show grants for 'usuario1'@'localhost';

############################ USUARIO 2 ############################
-- Creamos el usuario 
create user 'usuario2'@'localhost' identified by '456321';

-- Le concedemos permisos sobre el esquema de aberturas 
grant all on aberturas to 'usuario2'@'localhost';

-- le concedemos permisos de lectura, modificación e inserción
grant select, update, insert on aberturas.proveedor to 'usuario2'@'localhost';
grant select, update, insert on aberturas.distribuidor to 'usuario2'@'localhost';
grant select, update, insert on aberturas.gestion_envios to 'usuario2'@'localhost';
grant select, update, insert on aberturas.productos to 'usuario2'@'localhost';
grant select, update, insert on aberturas.facturacion to 'usuario2'@'localhost';

-- mostramos los permisos asociados que tiene
show grants for 'usuario2'@'localhost';

############################ EJEMPLOS DE RESPUESTA ############################
#USUARIO 1
/*
SELECT * FROM aberturas.proveedor;

-- Error Code: 1142. INSERT command denied to user 'usuario1'@'localhost' for table 'proveedor'
insert into aberturas.proveedor(CUIT, RAZON_SOCIAL, TIPO_FACTURA, DIRECCION, TELEFONO, DEBITO, CREDITO)
values ('222354258', 'PUERTAS ISLA COLA DE BALLENA', 	'a', 'TRIBU AGUA DEL SUR', '1198547412', 0.0000, 0.0000);

-- Error Code: 1142. UPDATE command denied to user 'usuario1'@'localhost' for table 'proveedor'
update aberturas.proveedor set CREDITO = 10.00 where ID_PROVEEDOR = 15;

-- Intentamos realziar una accion para la cual no tenemos permiso: respuesta: Error Code: 1142. DELETE command denied to user 'usuario2'@'localhost' for table 'proveedor'
delete from aberturas.proveedor where ID_PROVEEDOR = 15;
*/

#USUARIO 2
/*
SELECT * FROM aberturas.proveedor;

-- Respuesta ok
insert into aberturas.proveedor(CUIT, RAZON_SOCIAL, TIPO_FACTURA, DIRECCION, TELEFONO, DEBITO, CREDITO)
values ('222354258', 'PUERTAS BA SING SE', 	'a', 'REINO TIERRA', '1198547412', 0.0000, 0.0000);

-- Respuesta ok
update aberturas.proveedor set CREDITO = 20000.00 where ID_PROVEEDOR = 15;

-- Intentamos realziar una accion para la cual no tenemos permiso: respuesta: Error Code: 1142. DELETE command denied to user 'usuario2'@'localhost' for table 'proveedor'
delete from aberturas.proveedor where ID_PROVEEDOR = 15;
*/

############################################################ TRANSACCIONES SIN AUTO-COMMIT ############################################################
use aberturas;
SELECT * FROM aberturas.gestion_envios;
set @@autocommit=0;

start transaction;
delete from aberturas.gestion_envios where ID_DISTRIBUIDOR = 10 and ID_PRODUCTO = 1;
delete from aberturas.gestion_envios where ID_DISTRIBUIDOR = 9 and ID_PRODUCTO = 11;
delete from aberturas.gestion_envios where ID_DISTRIBUIDOR = 6 and ID_PRODUCTO = 7;
-- rollback;
-- commit;

/*
start transaction;
insert into gestion_envios(FECHA_ENTREGA, CANT_PROD_ENV, OBSERVACIONES, CANT_DEVOLUCIONES, FECHA_DEVOLUCION, ID_DISTRIBUIDOR, ID_PRODUCTO, ID_FACT)
values
('2023-04-07', 4, null, null, null, 6, 7, 9),
('2023-04-03', 5, null, null, null, 10, 1, 39),
('2023-04-04', 3, null, null, null, 9, 11, 36);
commit;
*/

start transaction;
insert into facturacion(TIPO, NRO_FACTURA, F_FACTURACION, ID_DISTRIBUIDOR)
values 
('D', '21111111', '2023-05-07', 1),
('D', '21111112', '2023-05-07', 1),
('D', '21111113', '2023-05-07', 1),
('D', '21111114', '2023-05-07', 1);
savepoint lote_1;

insert into facturacion(TIPO, NRO_FACTURA, F_FACTURACION, ID_DISTRIBUIDOR)
values 
('E', '21111115', '2023-05-07', 6),
('E', '21111116', '2023-05-07', 6),
('E', '21111117', '2023-05-07', 6),
('E', '21111118', '2023-05-07', 6);
savepoint lote_2;

-- release savepoint lote_1;