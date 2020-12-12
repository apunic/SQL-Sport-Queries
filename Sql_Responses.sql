select * from maillot 
select dorsal , nombre from ciclista where edad <=25
select nompuerto, altura from puerto where categoria is NULL
select netapa from etapa where salida= llegada
select COUNT(*) from ciclista
select COUNT(*) from ciclista where edad >25
SELECT COUNT (*) from equipo
SELECT AVG (edad) from ciclista
SELECT  MAX(altura) , MIN(altura) from puerto
SELECT  nompuerto , categoria from puerto, ciclista where ciclista.nomeq LIKE 'Banesto' AND puerto.dorsal =ciclista.dorsal
select  nompuerto, etapa.netapa, km from puerto, etapa where puerto.netapa= etapa.netapa
SELECT Distinct equipo.nomeq, director from equipo,ciclista where edad >33 and ciclista.nomeq= equipo.nomeq
SELECT distinct nombre, color from ciclista, maillot,llevar where llevar.dorsal= ciclista.dorsal and llevar.codigo = maillot.codigo
Select distinct nombre, etapa.netapa from ciclista, etapa ,maillot,llevar where etapa.dorsal= ciclista.dorsal  and llevar.dorsal=ciclista.dorsal and llevar.codigo = maillot.codigo and color = 'Amarillo'
Select E1.netapa from etapa E1, etapa E2 where not (E1.salida = E2.llegada) and E1.netapa= E2.netapa +1
SELECT etapa.netapa, salida from etapa where etapa.netapa not in (SELECT puerto.netapa from puerto where etapa.netapa=puerto.netapa)
SELECT AVG(edad) FROM ciclista WHERE ciclista.dorsal in (SELECT dorsal FROM etapa WHERE ciclista.dorsal = etapa.dorsal)
Select nompuerto from puerto where puerto.altura > (Select avg(altura)  from puerto)
Select etapa.salida ,etapa.llegada from etapa,puerto where etapa.netapa=puerto.netapa and puerto.pendiente=(select MAX(puerto.pendiente)from puerto)
Select ciclista.dorsal, ciclista.nombre from ciclista, puerto where ciclista.dorsal= puerto.dorsal and puerto.altura= (select max(altura)from puerto)
Select ciclista.nombre from ciclista where ciclista.edad= (select min(edad)from ciclista )
SELECT C1.nombre FROM ciclista C1 WHERE C1.edad = (SELECT MIN(C2.edad)FROM ciclista C2 WHERE C2.dorsal IN (SELECT etapa.dorsal FROM etapa) AND C1.dorsal IN (SELECT etapa.dorsal from etapa ))
Select Distinct C.nombre from ciclista C,puerto P where 1 < (select count (*) from puerto P2 where C.dorsal= P2.dorsal)
