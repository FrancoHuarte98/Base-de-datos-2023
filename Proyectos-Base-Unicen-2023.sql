select * from ciudad; --Me trae todas las ciudades y sus respectivas columnas donde se realizron las peliculas
select id_ciudad from ciudad;--Me trae todas las ciudades, pero solo su columna id_ciudad
select nombre_ciudad from ciudad; --Me trae todas las ciudades, pero solo su columna nombre_ciudad
select id_ciudad, nombre_ciudad from ciudad; --Me trae todas las ciudades, pero solo sus columnas id_ciudad, nombre_ciudad


select id_ciudad, nombre_ciudad from ciudad where id_ciudad>800; --Me trae todas las ciudades que tienen un id_ciudad mayor a 800
select * from ciudad where nombre_ciudad = 'Skelton'; --Me trae la ciudad con nombre Skelton con sus respectivas columnas

-----------------------VOLUNTARIO CONSULTAS--------------------------------------

select distinct id_tarea from voluntario; --Te trae todos pero saca los repetidos
select id_tarea from voluntario; --Te trae todos hasta los repetidos

select  id_tarea from voluntario union select id_tarea from historico; --Trae las tareas actuales y viejas que se realizaron
                                                                       --el UNION hace que se traigan ambas y no una sola de ellas
                                                                       --ademas saca los repetidos, para traer los repetidos al UNION se le agrega "all".


select * from voluntario where nombre like  'A%'; --Me trae todos los voluntarios con nombre que empieza con "A"
select * from voluntario where nombre like  '_a%'; --Me trae todos los voluntarios que la segunda letra de su nombre sea "a" y la primera no importe que sea
select * from voluntario where nombre like  '_a%e'; --Me trae todos los voluntarios que la segunda letra de su nombre sea "a" y la primera no importe que sea y termine con "e"
select * from voluntario where nombre like  '%a%'; --Me trae todos los voluntarios que tengan una "a" en cualquier parte de su nombre
select * from voluntario where porcentaje is null; --Me trae los voluntarios en los cuales tengan "null" en la columna porcentaje
select * from voluntario where porcentaje between  0.1 and 0.5; --Me trae los voluntarios que tengan un porcentaje entre 0.1 y 0.5
select * from voluntario where porcentaje > 0.20 or porcentaje is null order by nombre; --Me trae todos los voluntarios que tengan un
                                                                                       --porcentaje mayor a 0.2 o tengan valor null, y con
                                                                                       --ORDER BY los ordeno por nombre

select * from voluntario where porcentaje > 0.20 or porcentaje is null order by  nombre desc; --Lo mismo pero por nombre de mayor a menor o de la Z a la A
select * from voluntario where porcentaje > 0.20 or porcentaje is null order by  nombre desc, apellido; --Si los nombres son iguales, ademas los ordena por apellido
select * from voluntario where porcentaje > 0.20 or porcentaje is null order by  nombre desc, apellido limit 10; --Trae las primeras 10 filas con el ordenamiento anterior
select * from voluntario where porcentaje > 0.20 or porcentaje is null order by  nombre desc, apellido offset 10;--Trae las filas de la 10 en adelante con el ordenamiento anterior

--------------------------------------------------------------------------------------------------------------------
select nro_voluntario, (apellido || ',' ||nombre) "Apellido y Nombre"-- RESULTADO: 100,"King,Steven"
from voluntario                                                                  --101,"Kochhar,Neena"
where  porcentaje > 0.2                                                          --102,"De Haan,Lex"
    or porcentaje is null                                                        --103,"Hunold,Alexander"
order by 1                                                                       --104,"Ernst,Bruce"
limit 10;                                                                        --105,"Austin,David"

--Esta consulta concatena las columnas nombre y apellido, las separa con "," y la renombra "Apellido y Nombre
--ademas las ordena con "ORDER BY 1" por el item 1 del select es decir "nro_voluntario"
--------------------------------------------------------------------------------------------------------------------
select nro_voluntario, (apellido || ',' ||nombre) "Apellido y Nombre", age(fecha_nacimiento)
from voluntario
order by 1                                                                       --104,"Ernst,Bruce"
limit 10;
--Esta consulta ademas de ordenarme los voluntarios, con la funcion age(fecha_nacimiento) me duevuelve su edad
--RESULTADO:
--100,"King,Steven",36 years 2 mons 6 days 0 hours 0 mins 0.0 secs
--101,"Kochhar,Neena",33 years 11 mons 2 days 0 hours 0 mins 0.0 secs
--102,"De Haan,Lex",30 years 7 mons 10 days 0 hours 0 mins 0.0 secs
--103,"Hunold,Alexander",33 years 7 mons 20 days 0 hours 0 mins 0.0 secs
--------------------------------------------------------------------------------------------------------------------
select nro_voluntario, apellido, nombre, fecha_nacimiento, age(fecha_nacimiento)
from voluntario
where fecha_nacimiento > to_date('1/1/1990', 'dd/MM/yyyy')
order by 4;
--Esta consulta me devuelve los voluntarios con fecha de nacimiento mayor al 1/1/1990, hay que hacer especial
--enfasis en como manejar las fechas y sus funciones ya que son tipos de datos especiales, en este caso
--aclaramos la forma en la que estaban distribuidos los campos de la fecha con el "dd/MM/yyyy"
--RESULTADO:
--103,Hunold,Alexander,1990-01-03,33 years 7 mons 20 days 0 hours 0 mins 0.0 secs
--104,Ernst,Bruce,1991-05-21,32 years 3 mons 2 days 0 hours 0 mins 0.0 secs
--102,De Haan,Lex,1993-01-13,30 years 7 mons 10 days 0 hours 0 mins 0.0 secs
--204,Baer,Hermann,1994-06-07,29 years 2 mons 16 days 0 hours 0 mins 0.0 secs
--------------------------------------------------------------------------------------------------------------------
------------------------------------------TRABAJO PRACTICO Nº2------------------------------------------------------
--EJERCICIO2
--1) Muestre los apellidos, nombres y e_mail de los voluntarios que llevan aportadas más de 1.000 horas, ordenados por apellido.
select apellido, nombre,e_mail
from voluntario
where horas_aportadas > 1000
order by apellido;

--2) Muestre el apellido y teléfono de todos los voluntarios de las instituciones 20 y 50 en orden alfabético por apellido y nombre.
select apellido,nombre, telefono
from voluntario
where (id_institucion = 20 or id_institucion = 50)
order by apellido, nombre;

--3) Muestre el apellido, nombre y el e-mail de todos los voluntarios cuyo teléfono comienza con '+11'. Coloque como encabezado de las columnas los títulos 'Apellido y Nombre' y 'Dirección de mail'.
select (apellido|| ',' || nombre )"Apellido y Nombre", e_mail "Direccion de mail"
from voluntario
where telefono like  '+11%';

--EJERCICIO3
--1)Muestre apellido, nombre e identificador de todos los empleados que no cobran porcentaje de comisión . Ordene por apellido.
select apellido, nombre, id_empleado
from empleado
where porc_comision IS NULL OR porc_comision = 0
order by 1;

--2)Muestre los datos de los distribuidores internacionales que no tienen registrado teléfono.
select *
from distribuidor
where telefono is null and tipo = 'I';

--3) Seleccione la clave y el nombre de los departamentos sin jefe.
select id_departamento,nombre
from departamento
where jefe_departamento is null
order by 1;

--EJERCICIO4
--1)Haga un listado de los voluntarios donde se muestre el apellido y nombre (concatenados y separados por una coma) y la fecha de nacimiento (como año, mes y día), ordenados por año de nacimiento.
select (apellido|| ',' ||nombre) "Nombre y Apellido", to_char(fecha_nacimiento, 'YYYY-MM-DD') as "fecha nacimiento"
from voluntario
order by extract(year from fecha_nacimiento);

--2)Muestre todos los voluntarios nacidos a partir de 1998 con más de 5000 horas aportadas, ordenados por su identificador.
select voluntario
from voluntario
where (fecha_nacimiento >= to_date('1/1/1998', 'dd/MM/yyyy')) and (horas_aportadas > 5000)
order by nro_voluntario;

--3)Haga un listado de los voluntarios que cumplen años hoy (día y mes actual), indicando el nombre, apellido y su edad (en años).
select nombre, apellido, to_char(age(fecha_nacimiento), 'YY') "Edad (en años)", fecha_nacimiento
from voluntario
where to_char(fecha_nacimiento, 'dd-MM') != to_char(current_date, 'dd-MM');

--EJERCICIO5
--1)Seleccione los datos de las 10 primeras direcciones ordenadas de acuerdo a su identificador.
select *
from direccion
order by id_direccion
limit 10;

--2)Si se desea paginar la consulta que selecciona los datos de las tareas cuyo nombre comience con O, A o C, y hay 5 registros por página, muestre la consulta que llenaría los datos para la 3er. página.
select *
from unc_esq_voluntario.tarea
where nombre_tarea like  'O%' or nombre_tarea like  'A%' or nombre_tarea like  'C%'
limit 5 offset 10;

-----------------------------------------------------------------------CONSULTAS MULTI TABLA (Parte 2) ----------------------------------------------------------------------------------------------
-- El group by, me agrupa determinadas tablas en una sola tabla
-- El having me filtra el grupo completo, es decir, si el grupo completo no cumple la condicion entonces no se trae esa tabla, para filtrar filas de ese grupo es el "where"

select *
from voluntario v
    join institucion i on v.id_institucion = i.id_institucion; --Uno las tablas de voluntario(v), con la de institucion(i) por medio de la misma tabla (id_institucion)
                                                               --Si la tabla voluntario tiene un voluntario sin institucion (null), a ese voluntario no lo va a devolver
                                                               --Por lo que si la cantidad de voluntarios es 107, la cantidad de filas de este join va a ser <=107
select v.* --Solo me quedo con las columnas de voluntario
from voluntario v
    join institucion i2 on v.id_institucion = i2.id_institucion
    join  direccion d on i2.id_direccion = d.id_direccion --Uni la tabla institucion(i2) con la de direccion(d) por medio de la columna "id_direccion"
where d.provincia like 'Texas'; --Traigo los voluntarios de la provincia de "Texas" para ello uni las 3 tablas para poder realizar el camino desde voluntario a direccion
                                -- (En el cual estan las provincias)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select v.*   --HACE LO MISMO QUE ARRIBA PERO COMO SUBCONSUTLAS (Menos eficiente)
from voluntario v
where id_institucion = (select i.id_institucion --Seleccion la columna id_institucion de la tabla institucion y las compara con la tabla voluntario
                        from institucion i
                        where id_direccion = (select d.id_direccion --Seleccion la columna id_direccion de la tabla direccion y las compara con la tabla institucion
                                                from direccion d
                                                where  d.provincia like 'Texas'));

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select *   --HACE LO MISMO QUE ARRIBA PERO COMO SUBCONSUTLAS Y AGREGA LA TABLA TAREA DEL VOLUNTARIO
from voluntario v
    join unc_esq_voluntario.tarea t on v.id_tarea = t.id_tarea --Ademas de la subconsulta va a traer la tarea que realiza el voluntario
where v.id_institucion = (select i.id_institucion --Seleccion la columna id_institucion de la tabla institucion y las compara con la tabla voluntario
                        from institucion i
                        where i.id_direccion = (select d.id_direccion --Seleccion la columna id_direccion de la tabla direccion y las compara con la tabla institucion
                                                from direccion d
                                                where  d.provincia like 'Texas'));
select *
from voluntario v
    natural join institucion i; --Toma las dos tablas y se fija que columnas se llaman igual, y ensambla esas (PELIGROSO). Ejemplo: Si en la tabla institucion hubiese una columna "nombre" y en
                                --voluntario tambien hubiese una columna "nombre" uniria esas tambien ademas de en este caso saber que tanto voluntario e institucion tienen una columna
                                --"id_insititucion", esto puede ser peligroso porque me filtraria por nombre tambien y no queremos eso.


select count(*)
from institucion; --Cuenta las filas que tiene la tabla institucion (27 en este caso)

-------------------------------------------------------------------- PRACTICO Nª2 (Parte 2) ------------------------------------------------------------------------------------
--Ejercicio 1-a-Haga un resumen de cuantas veces ha cambiado de tareas cada voluntario. Indique el número,  nombre y apellido del voluntario.

select count(distinct (h.id_tarea)), v.nro_voluntario, nombre, apellido --distinct elimina repetidos, y con el count contamos las tareas que hizo un voluntario historicamente
from historico h
    join voluntario v on h.nro_voluntario = v.nro_voluntario --Uno las tablas por nro_voluntario
group by nombre, v.nro_voluntario, apellido; --Creo una nueva tabla con estas columnas

--1-b-------------------------------------------------------------------------------------------------------------------
--Liste los datos de contacto (nombre, apellido, e-mail y teléfono) de los voluntarios que hayan desarrollado tareas con diferencia
--max_horas-min_horas de hasta 5000 horas y que las hayan finalizado antes del  01/01/2000.
select v.nombre, v.apellido, v.e_mail, v.e_mail
from historico h
    join unc_esq_voluntario.tarea t on h.id_tarea = t.id_tarea
    join voluntario v on h.nro_voluntario = v.nro_voluntario
where t.max_horas - t.min_horas >= 5000 and h.fecha_fin <= To_date('01/01/2000','dd/mm/yyyy');

--1-c-------------------------------------------------------------------------------------------------------------------
--Indique nombre, id y dirección completa de las instituciones que no poseen voluntarios con
-- aporte de horas mayor o igual que el máximo de horas de la tarea que realiza.
select i.nombre_institucion, i.id_institucion, i.id_direccion
from institucion i
where i.id_institucion not in(select j.id_institucion
                                from institucion j
                                    join voluntario v on j.id_director = v.nro_voluntario
                                    join tarea t on v.id_tarea = t.id_tarea
                                    where v.horas_aportadas >= t.max_horas);

--1-d-------------------------------------------------------------------------------------------------------------------
--Liste en orden alfabético los nombres de los países que nunca han tenido acción de
-- voluntarios (considerando sólo información histórica, no tener en cuenta los voluntarios actuales).

select p.nombre_pais
from pais p
where p.id_pais not in(select p2.id_pais
                       from pais p2
                       join direccion d on p2.id_pais = d.id_pais
                       join institucion i on d.id_direccion = i.id_direccion
                       join historico h on i.id_institucion = h.id_institucion)
order by 1;

--1-e-------------------------------------------------------------------------------------------------------------------
--Indique los datos de las tareas que se han desarrollado históricamente y que no se están desarrollando actualmente.
select t.*
from tarea t
where not exists(select 1
                from historico h
                where h.id_tarea = t.id_tarea);

--1-f-------------------------------------------------------------------------------------------------------------------
--Liste el id, nombre y máxima cantidad de horas de las tareas que se están ejecutando solo una vez y que
--actualmente la están realizando voluntarios de la ciudad ‘Munich’. Ordene por id de tarea.

select v.id_tarea
from voluntario v
  join institucion i on v.id_institucion = i.id_institucion
  join direccion d on i.id_direccion = d.id_direccion
where d.ciudad = 'Munich'
group by v.id_tarea
having  count(*) < 2;
------------------------------------------------------------------------------------------------------------------------
--1-g Indique los datos de las instituciones que poseen director, donde históricamente se
-- hayan desarrollado tareas que actualmente las estén ejecutando voluntarios de otras instituciones.

select i.*
from institucion i
    join historico h on i.id_institucion = h.id_institucion
    join tarea t on h.id_tarea = t.id_tarea
where exists(select 1 --select 1 indica con que al menos exista 1 lo devuelve como verdadero
            from voluntario v
            where v.id_tarea = t.id_tarea and v.id_institucion != i.id_institucion and i.id_director is not null);
------------------------------------------------------------------------------------------------------------------------
--1.8 Liste los datos completos de todas las instituciones
--junto con el apellido y nombre de su director, si poseen.

select i.*, d.nombre, d.apellido, d.nro_voluntario
from institucion i
    join voluntario d on i.id_director = d.nro_voluntario
    where i.id_director is not null;
------------------------------------------------------------------------------------------------------------------------
-- 1.9 Para cada uno de los empleados indique su id, nombre y apellido junto con el id, nombre y apellido de su jefe, en caso de tenerlo

select e.id_empleado, e.nombre, e.apellido, j.id_empleado, j.nombre, j.apellido
from empleado e
     join empleado j on e.id_jefe = j.id_empleado
where e.id_jefe is not null;
------------------------------------------------------------------------------------------------------------------------
-- 1.10 Determine los ids, nombres y apellidos de los empleados que son jefes y cuyos departamentos donde se desempeñan
-- se encuentren en la ciudad ‘Rawalpindi’. Ordene los datos por los ids.

select j.id_empleado, j.nombre, j.apellido, j.id_departamento
from empleado j
     join departamento d on j.id_empleado = d.jefe_departamento
     join ciudad c on d.id_ciudad = c.id_ciudad
where c.nombre_ciudad = 'Rawalpindi'
order by j.id_empleado;
------------------------------------------------------------------------------------------------------------------------
--1.11 Liste los ids y números de inscripción de los distribuidores nacionales que hayan
-- entregado películas en idioma Español luego del año 2010.

select  d.id_distribuidor
from distribuidor d
     join nacional n on d.id_distribuidor = n.id_distribuidor
     join entrega e on d.id_distribuidor = e.id_distribuidor
     join renglon_entrega re on e.nro_entrega = re.nro_entrega
     join pelicula p on re.codigo_pelicula = p.codigo_pelicula
where p.idioma = 'Español' and e.fecha_entrega >= to_date('01/01/2010', 'DD/MM/YYYY');
------------------------------------------------------------------------------------------------------------------------
--1.12 Liste las películas que nunca han sido entregadas por un distribuidor nacional.

select p.*, d.tipo
from pelicula p
     join renglon_entrega re on p.codigo_pelicula = re.codigo_pelicula
     join  entrega e on re.nro_entrega = e.nro_entrega
     join distribuidor d on e.id_distribuidor = d.id_distribuidor
where d.tipo = 'I';
------------------------------------------------------------------------------------------------------------------------
--1.13 Liste el apellido y nombre de los empleados que trabajan en departamentos residentes en el país Argentina y
-- donde el jefe de departamento posee más del 40% de comisión.

select e.apellido, e.nombre
from empleado e
    join departamento d on d.id_departamento = e.id_departamento
    join ciudad c on d.id_ciudad = c.id_ciudad
    join empleado j on e.id_jefe = j.id_empleado
where c.id_pais = 'AR' and j.porc_comision > 40; --Filtramos por el pais con id_pais= "AR" y por los empleados con porc_comision > 40
------------------------------------------------------------------------------------------------------------------------
--1.14 Indique los departamentos (nombre e identificador completo) que tienen más de 3 empleados con tareas con
-- sueldo mínimo menor a 6000. Muestre el resultado ordenado por distribuidor.

select d.*
from departamento d
     join empleado e on e.id_departamento = d.id_departamento and d.id_distribuidor = e.id_distribuidor
     join tarea t on e.id_tarea = t.id_tarea
where t.sueldo_minimo < 6000
group by d.id_departamento, d.id_distribuidor
having count(e.id_empleado) > 3
order by d.id_distribuidor;
------------------------------------------------------------------------------------------------------------------------
--1.15 Liste los datos de los departamentos en los que trabajan menos del 10 % de los empleados que hay registrados.

SELECT d.nombre AS nombre_departamento, COUNT(e.id_departamento) AS total_empleados
FROM departamento d
    LEFT JOIN empleado e ON d.id_departamento = e.id_departamento
GROUP BY d.nombre
HAVING COUNT(e.id_departamento) < (SELECT COUNT(*) * 0.10 FROM empleado);
------------------------------------------------------------------------------------------------------------------------
---------------------------------------- TRABAJO PRACTICO ADICIONALES --------------------------------------------------
--EJERCICIO_1
--Realice un resumen por país, indicando el nombre del país y la cantidad de voluntarios mayores de edad.
-- Tenga en cuenta sólo aquellos voluntarios que pertenezcan a instituciones con más de 4 voluntarios (FALTA ESTO ULTIMO)

select p.nombre_pais, v.nro_voluntario
from pais p
    join direccion d on p.id_pais = d.id_pais
    join institucion i on d.id_direccion = i.id_direccion
    join voluntario v on i.id_institucion = v.id_institucion
group by v.nro_voluntario, p.nombre_pais
having extract(year from age(fecha_nacimiento)) > 18
order by 1;
------------------------------------------------------------------------------------------------------------------------
--EJERCICIO_2
--Liste el id, nombre y apellido de los voluntarios de instituciones asentadas en el continente ‘Europeo’ y que
-- además cumplen con el rol de director de alguna institución. Ordene el resultado alfabéticamente por apellido y nombre.

select v.nro_voluntario, v.nombre, v.apellido
from voluntario v
    join institucion i on v.id_institucion = i.id_institucion
    join direccion d on i.id_direccion = d.id_direccion
    join pais p on d.id_pais = p.id_pais
    join continente c on p.id_continente = c.id_continente
where v.nro_voluntario in(select i.id_director
                          from institucion i)and c.nombre_continente like 'Europeo'
order by 2,3;
------------------------------------------------------------------------------------------------------------------------
                             ---------------------TRIGGERS---------------------
------------------------------------------------------------------------------------------------------------------------
-- Quiero un select que me de id_articulo y cant de palabras (ESQUEMA DE EJEMPLO NO EXISTE)
SELECT a.id_articulo, count(*)
from articulo a
    join  contiene c on a.id_articulo = c.id_articulo
group by a.id_articulo;

--Ahora quiero que ese articulo no contenga mas de 15 palabras por lo que voy a hacer un Trigger que se dispare en caso de update o insert
CREATE OR REPLACE FUNCTION  cant_palabras() returns trigger as $$
    BEGIN
        if(exists(
            select 1 from contiene c
            group by id_articulo
            having count(*)>15
            )) then
            raise exception 'Hay un error';
        end if;
        return new;
    END;
$$ language 'plpgsql';
--Si yo lo hiciera asi lo haria para toda la tabla, y como eso resultaria ineficiente yo tengo que filtrar solo por los nuevos id_articulo
CREATE FUNCTION  cant_palabras() returns trigger as $$
    BEGIN
        if(exists(
            select 1 from contiene c
            where c.id_articulo = new.id_articulo
            group by id_articulo
            having count(*)>15
            )) then
            raise exception 'Hay un error';
        end if;
        return new;
    END;
$$ language 'plpgsql';

CREATE TRIGGER tr_cant_palabras
    before insert or update of id_articulo
    on contiene
    for each row
    execute function cant_palabras();

------------------------------------------TRABAJO PRACTICO 4------------------------------------------------------------
--Ejercicio 1
--Para los ejercicios 3 y 5 del Práctico 3, implemente con triggers aquellos chequeos que no pudo implementar
--declarativamente en Postgresql. Previamente complete la grilla dada a continuación, con los eventos críticos
--para las tablas involucradas.

--a) Controlar que las nacionalidades sean 'Argentina' 'Español' 'Inglesa' 'Alemana' o 'Chilena'.
create or replace  function fn_nacionalidad_valida() returns trigger as $$
    BEGIN
        if(exists( select 1
                   from articulo a
                   where a.nacionalidad not like 'argentina' or a.nacionalidad not like 'español' or a.nacionalidad not like 'inglesa'))  then
            raise exception 'No es una nacionalidad valida';
        end if;
        return new;
    END;$$
    language 'plpgsql';

create trigger tr_nacionalidad
    after insert or update of nacionalidad on articulo
    for each row execute function fn_nacionalidad_valida();

--b) Para las fechas de publicaciones se debe considerar que sean fechas posteriores o iguales al 2010.

create or replace  function fn_fecha_validad() returns trigger as $$
    BEGIN
        if (exists( select 1
                    from articulo a
                    where extract(year from(fecha_pub)) < '2010')) then
            raise exception 'La fecha de publicacion son antes del 2010 por lo que no son validas';
        end if;
        return new;
    END;$$
    language 'plpgsql';

create trigger tr_fecha_valida
    after insert or update of fecha_pub on articulo
    for each row execute function fn_fecha_validad();

--c) Sólo se pueden publicar artículos argentinos que contengan hasta 10 palabras claves.

CREATE OR REPLACE FUNCTION fn_contiene_maxpalbras() returns trigger as $$
    BEGIN
        if(exists(
            select 1
            from contiene c
                join unc_249248.articulo a on c.id_articulo = a.id_articulo
            where nacionalidad like 'argentina' and c.id_articulo = new.id_articulo and c.idioma = new.idioma and c.cod_palabra = new.cod_palabra --Verifico que sea haga solo para las filas nuevas
            group by c.id_articulo
            having count(*) > 10 ))then
                raise exception 'El articulo es argentino pero contiene mas de 10 palabras claves';
        end if;
        return new;
    END;$$
    LANGUAGE 'plpgsql';

CREATE TRIGGER tr_contiene_maxPalabras
    AFTER INSERT OR UPDATE OF id_articulo ON contiene
    FOR EACH ROW EXECUTE FUNCTION fn_contiene_maxPalbras();






