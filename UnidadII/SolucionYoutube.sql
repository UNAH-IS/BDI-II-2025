--Crear una consulta que muestre la información de los usuarios con toda su información de forma legible
--(es decir en vez de códigos mostrar su valor, omitir el campo codigo_municipio), mostrar el nombre
--completo y las fechas en formato DD*NOMBRE_MES*AÑO. Para los lugares mostrar el primer y segundo
--nivel (ejemplo: municipio y departamento). Utilizar producto cartesiano con el operador (+).
SELECT CODIGO_USUARIO,
        NOMBRE || ' ' || APELLIDO AS NOMBRE_COMPLETO,
        USUARIO,
        CORREO_ELECTRONICO,
        PASSWORD,
        SEXO,
        TO_CHAR(FECHA_NACIMIENTO, 'DD*Month*YYYY') AS FECHA_NACIMIENTO,
        TO_CHAR(FECHA_REGISTRO, 'DD*Month*YYYY') AS FECHA_REGISTRO,
        TELEFONO,
        B.NOMBRE_LUGAR AS MUNICIPIO,
        C.NOMBRE_LUGAR AS DEPARTAMENTO,
        D.TIPO_USUARIO,
        E.ESTADO_USUARIO
FROM TBL_USUARIOS A,
     TBL_LUGARES B,
     TBL_LUGARES C,
     TBL_TIPOS_USUARIOS D,
     TBL_ESTADOS_USUARIOS E
WHERE A.CODIGO_LUGAR = B.CODIGO_LUGAR (+)
AND B.CODIGO_LUGAR_PADRE = C.CODIGO_LUGAR (+)
AND A.CODIGO_TIPO_USUARIO = D.CODIGO_TIPO_USUARIO (+)
AND A.CODIGO_ESTADO_USUARIO = E.CODIGO_ESTADO_USUARIO (+);


SELECT *
FROM TBL_USUARIOS;

SELECT *
FROM TBL_LUGARES;

SELECT *
FROM TBL_TIPOS_USUARIOS;

SELECT *
FROM TBL_ESTADOS_USUARIOS;

--2. Mostrar el video que más y menos veces ha sido compartido. Mostrar los datos del video, cantidad de
--shares y cantidad de usuarios diferentes (distinct) que lo han compartido.
SELECT *
FROM TBL_VIDEOS;

WITH SHARES_VIDEOS AS (
    SELECT CODIGO_VIDEO,
            COUNT(*) AS CANTIDAD_SHARES,
            COUNT(DISTINCT CODIGO_USUARIO) AS CANTIDAD_USUARIOS_DISTINTOS
    FROM TBL_SHARES
    GROUP BY CODIGO_VIDEO
)
SELECT  B.CODIGO_VIDEO,
        B.NOMBRE_VIDEO,
        B.URL,
        B.RESOLUCION,
        A.CANTIDAD_SHARES, A.CANTIDAD_USUARIOS_DISTINTOS
FROM    SHARES_VIDEOS A, TBL_VIDEOS B
WHERE   A.CANTIDAD_SHARES = (
        SELECT  MAX(CANTIDAD_SHARES) AS CANTIDAD_SHARES
        FROM SHARES_VIDEOS
)
AND A.CODIGO_VIDEO = B.CODIGO_VIDEO;

SELECT *
FROM TBL_SHARES;

SELECT *
FROM TBL_VIDEOS;


--3. Mostrar todos los usuarios que no tienen ninguna lista de reproducción.
--4. Mostrar todos los videos que tienen un canal, los que no tienen un canal y los canales que no tienen
--videos.
--5. Mostrar el histórico mensual de pagos a usuarios con el siguiente detalle:
--a. Año-Mes
--b. Monto total
--c. Total Impuestos
--d. Total Descuentos
--e. Total neto
--f. Cantidad de usuarios distintos
--g. Cantidad de videos distintos
--6. Mostrar los videos con la siguiente información:
--a. Nombre Video
--b. Resolución
--c. Nombre completo del usuario
--d. Nombre de usuario
--e. Estado del video
--f. Idioma
--g. Canal al que pertenece
--h. Duración en minutos
--i. Fecha de subida en formato DD#MM#YYYY Horas:Minutos:Segundos
--j. URL
--k. Cantidad de Likes (no usar el campo CANTIDAD_LIKES obtenerlo de la tabla de likes)
--l. Cantidad de Dislikes (no usar el campo CANTIDAD_DISLIKES obtenerlo de la tabla de likes)
--m. Cantidad de visualizaciones (no usar el campo CANTIDAD_VISUALIZACIONES utilizar la tabla de
--historial)
--n. Cantidad de Shares (no usar el campo CANTIDAD_SHARES utilizar la tabla de shares)
--o. Cantidad de listas en las que ha sido incluido.
--7. Crear una vista materializada de la consulta del inciso anterior, deje planteada la instrucción para
--actualizar una vista materializada.