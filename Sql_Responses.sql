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
Select  E.netapa from etapa E where not exists (select * from puerto P where E.netapa=P.netapa and P.altura<=700 ) AND ExISTS (SELECT * FROM PUERTO P WHERE E.NETAPA=P.NETAPA AND P.ALTURA>700)
SELECT NOMEQ,DIRECTOR FROM EQUIPO E WHERE not exists(SELECT * FROM CICLISTA  C WHERE E.nomeq=C.nomeq and C.edad <=25) and exists(select * from ciclista C2 where E.nomeq=C2.nomeq and C2.edad>25)
Select C.dorsal,C.nombre from ciclista C where not exists (select * from etapa E1 where C.dorsal= E1.dorsal and E1.Km <=170) and exists(select* from Etapa E2 where E2.dorsal= C.dorsal and E2.km >170)
Select C.nombre from ciclista C where exists(select*from etapa E where (E.dorsal= C.dorsal  and not exists( select* from Puerto P where P.netapa=E.netapa and P.dorsal<>C.dorsal) and exists(select* from Puerto P where P.netapa=E.netapa)))

SELECT E.nomeq FROM EQUIPO E WHERE NOT EXISTS (SELECT *FROM CICLISTA C WHERE NOT EXISTS (  SELECT * FROM LLEVAR L WHERE C.dorsal=L.dorsal )
AND NOT EXISTS ( SELECT *FROM PUERTO P WHERE C.dorsal=P.dorsal ) AND C.nomeq=E.nomeq )
AND EXISTS (SELECT * FROM CICLISTA C WHERE C.nomeq=E.nomeq)

Select Distinct M.color, M.codigo from Maillot M ,Ciclista C,llevar L where L.codigo= M.codigo and C.dorsal=L.dorsal and not exists(Select* from Ciclista C1,LLEVAR L1 where C.nomeq<>C1.nomeq and L1.dorsal=C1.dorsal and L1.codigo=M.codigo)
Select distinct C.nomeq from ciclista C , puerto P where C.dorsal=P.dorsal and P.categoria='1'  and  not exists (Select * from Ciclista C1,Puerto P1 where C.nomeq= C1.nomeq and C1.dorsal=P1.dorsal and P1.categoria <>'1')

Select P.netapa, Count (nompuerto) from puerto P group by p.netapa
Select C.nomeq, count(nombre) from ciclista C group by C.nomeq order by nomeq
Select E.nomeq, COUNT(C.nombre) from Equipo E LEFT JOIN ciclista C on E.nomeq = C.nomeq group by E.nomeq order by E.nomeq
Select E.director, E.nomeq from Equipo E, Ciclista C where E.nomeq = C.nomeq group by E.Director ,E.nomeq having count(C.dorsal)>3 AND AVG(C.EDAD)<=30 order by E. Director
SELECT C.nombre, count(T.dorsal) from Ciclista C, Etapa T  where C.dorsal=T.dorsal group by C.nombre ,C.nomeq having C.nomeq in (Select C.nomeq from ciclista C group by C.nomeq having count (C.dorsal) > 5 ) order by C.nombre


select C1.nomeq, avg(C1.edad)
from ciclista C1
group by C1.nomeq
having avg(C1.edad) = (
    select max(A.average) 
    from (
        SELECT AVG(C2.edad) as average
        FROM CICLISTA C2
        GROUP BY C2.nomeq
    ) A 
)




SELECT E.director
FROM EQUIPO E JOIN CICLISTA C ON E.nomeq=C.nomeq JOIN LLEVAR L ON C.dorsal=L.dorsal
GROUP BY E.director
HAVING COUNT(L.dorsal) = (
    select max(T.counting) 
    from ( 
        select count(L.dorsal) as counting 
        from ciclista c
        join llevar l on c.dorsal=l.dorsal
        group by c.nomeq 
    ) T
)

Select distinct M.codigo, M.color from Maillot M, ciclista C ,llevar L where not exists(select C.dorsal from Etapa  E where C.dorsal=E.dorsal) and L.dorsal=C.dorsal and L.codigo=M.codigo
Select E.netapa,E.llegada,E.salida from etapa E,puerto P where E.km> 190 and P.netapa=E.netapa group by E.netapa,E.llegada,E.salida having Count(P.dorsal)>=2

SELECT C.dorsal, C.nombre
FROM CICLISTA C left JOIN LLEVAR L ON C.dorsal=L.dorsal
WHERE  EXISTS(SELECT *
           FROM CICLISTA C1 JOIN LLEVAR L1 ON C1.DORSAL=L1.DORSAL
           WHERE C1.DORSAL=20
           AND L1.CODIGO NOT IN(SELECT L2.CODIGO FROM LLEVAR L2
WHERE C.DORSAL = L2.DORSAL) )
GROUP BY C.DORSAL, C.NOMBRE
ORDER BY C.DORSAL

Select C.dorsal, C.nombre from Ciclista C join Llevar L on C.dorsal=L.dorsal 
where L.codigo in (Select L.codigo from LLevar L where L.dorsal =20) 
and L.dorsal <> 20 
group by C.dorsal ,C.nombre order by C.dorsal

Select C.dorsal, C.nombre from Ciclista C join Llevar L on C.dorsal=L.DORSAL
where not exists  (Select L.codigo from Llevar L where L.dorsal=20)
and L.dorsal in (select <>20
Group by C.dorsal, C.nombre order by C.dorsal

SELECT C.dorsal, C.nombre
 FROM CICLISTA C LEFT JOIN LLEVAR L ON L.dorsal=C.dorsal
 WHERE NOT EXISTS (SELECT *
                        FROM LLEVAR L
                        WHERE L.dorsal=20
                        AND L.codigo IN(SELECT L.codigo
                                            FROM LLEVAR L
                                            WHERE L.dorsal=C.dorsal))
GROUP BY C.dorsal, C.nombre
ORDER BY C.dorsal;

