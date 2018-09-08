/*
grupo 10

João Ferreira Nº49980
Joana Tomás Nº
Miguel Baptista Nº
Luis Tomé Nº
*/

/* 
1. Indique por ordem alfabética descendente o nome de todos os produtos com
classificação de comércio justo igual ou superior a B – em que A é a melhor
classificação.
*/
select S.nome
from Produto S
where S.comercioJusto = 'B' or S.comercioJusto = 'A' order by nome DESC;

/*
2. Indique o sexo e a idade de cada um dos dependentes do consumidor com email
'marcolina@hotmail.com'.
dar idade
*/
select S.sexo, S.nascimento
from Dependente S, Consumidor R
where R.numero = S.Consumidor and R.email = 'marcolina@hotmail.com';

/*
3. Email dos consumidores que compraram gasolina.
*/
select C.email
from compra R, Produto P, Consumidor C
where (P.codigo,P.marca) = (R.produto,R.prodMarca) and P.nome ='gasolina' and R.consumidor=C.numero;

/*
4. Email do(s) consumidor(es) que comprou mais gasolina.
*/
select C.email
from compra R, Produto P, Consumidor C
where (P.codigo,P.marca) = (R.produto,R.prodMarca) and P.nome ='gasolina' and R.consumidor=C.numero
having max(R.quantidade);

/*
5. Determine a pegada ecológica associada a cada um dos produtos do tipo lar.
*/
select P.nome, sum(R.percentagem * E.pegadaEcologica) as valor
from Produto P, composto R, Elemento E
where P.tipo = 'lar' and (P.marca,P.codigo) = (R.prodMarca,R.produto) and R.elemento = E.codigo
group by P.nome;


/*
6. Nome do(s) produto(s) mais prejudicial para a saúde – quanto maiores os valores
no atributo “saúde”, mais prejudiciais são para a mesma
*/
select sum(E.saude) as valor, S.nome 
from Produto S, composto R, Elemento E 
where S.marca = R.prodMarca and R.elemento = E.codigo 
group by S.nome 
having valor >= All(
    select sum(E.saude) 
    from Produto S, composto R, Elemento E 
    where S.marca = R.prodMarca and R.elemento = E.codigo 
    group by S.nome)

/*
7. Liste o sexo e a idade de todas as pessoas abrangidas por esta base de dados –
consumidores e seus dependentes.
*/  
SELECT Consumidor.sexo, YEAR(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(Consumidor.nascimento))) AS idade
FROM Consumidor
UNION
SELECT D.sexo, YEAR(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(D.nascimento))) AS idade
FROM Dependente as D;


/*
8
*/
create view pegada AS
select Consumidor.email as consumidor, sum(composto.percentagem*Elemento.pegadaEcologica*compra.quantidade) as num
from Consumidor, compra, Produto, composto, Elemento
where compra.consumidor=Consumidor.numero and (Produto.marca,Produto.codigo) = (composto.prodMarca,composto.produto) and (Produto.marca,Produto.codigo) = (compra.prodMarca,compra.produto) and Elemento.codigo = composto.elemento
group by Consumidor.email;

create view valor as
select Consumidor.email, count(Dependente.consumidor) as valor
from Consumidor, Dependente
where Consumidor.numero=Dependente.consumidor
group by Consumidor.email;

select max(pegada.num/valor.valor+1)
from pegada, valor
where pegada.consumidor=valor.email;



select Consumidor.email, sum(composto.percentagem * Elemento.pegadaEcologica)
from  Consumidor, Produto, compra, Elemento, composto
where (Produto.codigo,Produto.marca) = (compra.produto,compra.prodMarca) and compra.consumidor=Consumidor.numero
group by Consumidor.email;

select Consumidor.email, sum(composto.percentagem * Elemento.pegadaEcologica) as valor
from Produto, composto, Elemento, Consumidor
where (Produto.marca,Produto.codigo) = (composto.prodMarca,composto.produto) and composto.elemento = Elemento.codigo and compra.consumidor=Consumidor.numero
group by Consumidor.email;


select Consumidor.email, count(Dependente.consumidor) as valor
from Consumidor, Dependente
where Consumidor.numero=Dependente.consumidor
group by Consumidor.email;


select Consumidor.email, sum(composto.percentagem * Elemento.pegadaEcologica), COUNT(Dependente.consumidor)
from  Consumidor, Produto, compra, Elemento, composto, Dependente
where (Produto.codigo,Produto.marca) = (compra.produto,compra.prodMarca) and compra.consumidor=Consumidor.numero and Consumidor.numero=Dependente.consumidor
group by Consumidor.email;

select valor2.pegada/(valor.valor+1)
from valor, valor2
where valor.email=valor2.email;

/*pegada ecologica de cada consumidor*/
select Consumidor.email, sum(compra.quantidade) *  (sum(composto.percentagem/100) * Elemento.pegadaEcologica) as valor
from Produto, composto, Elemento, Consumidor, compra
where (Produto.marca,Produto.codigo) = (composto.prodMarca,composto.produto) and composto.elemento = Elemento.codigo and compra.consumidor=Consumidor.numero
group by Consumidor.email;

select Consumidor.email, compra.quantidade * (sum(composto.percentagem/100) * Elemento.pegadaEcologica) as valor 
from composto, Elemento, Consumidor, compra
where (compra.prodMarca,compra.produto,Elemento.codigo) = (composto.prodMarca,composto.produto,composto.elemento) and compra.consumidor=Consumidor.numero 
group by Consumidor.email;


/*
quantidade de compras que cada um fez
*/
select Consumidor.email, sum(compra.quantidade) as valor 
from Consumidor, compra
where compra.consumidor=Consumidor.numero 
group by Consumidor.email;


/*
quantiddade de produto 1 a 1
*/
select Consumidor.email, compra.quantidade as valor 
from Consumidor, compra
where compra.consumidor=Consumidor.numero;

select Consumidor.email,Produto.nome, compra.quantidade as valor, sum(composto.produto) as numero
from Consumidor, compra, composto,Produto
where (compra.prodMarca,compra.produto) = (composto.prodMarca,composto.produto) and compra.consumidor=Consumidor.numero;


/*
9
*/
create view elementos as
select count(Elemento.codigo) as numero
from Elemento;


create view numero2 AS
select count(Consumidor.email) as numero2, Consumidor.email as email
from  Produto, compra, Consumidor
where (Produto.codigo,Produto.marca) = (compra.produto,compra.prodMarca) And compra.consumidor = Consumidor.numero
group by Consumidor.email;


select numero2.email
from numero2, elementos
where numero2.numero2=elementos.numero;



/* 
codigo certo da 8 
*/
select Consumidor.email, sum(compra.quantidade*)
from Consumidor, compra, Produto, composto, Elemento
where compra.consumidor=Consumidor.numero and (Produto.marca,Produto.codigo) = (composto.prodMarca,composto.produto) and (Produto.marca,Produto.codigo) = (compra.prodMarca,compra.produto) and Elemento.codigo = composto.elemento
group by Consumidor.email;


create view pegada AS
select Consumidor.email as consumidor, sum(composto.percentagem*Elemento.pegadaEcologica*compra.quantidade) as num
from Consumidor, compra, Produto, composto, Elemento
where compra.consumidor=Consumidor.numero and (Produto.marca,Produto.codigo) = (composto.prodMarca,composto.produto) and (Produto.marca,Produto.codigo) = (compra.prodMarca,compra.produto) and Elemento.codigo = composto.elemento
group by Consumidor.email;

select Consumidor.email, sum(compra.quantidade*pegada.num)
from Consumidor, compra, pegada
where compra.consumidor=Consumidor.numero and compra.consumidor = pegada.consumidor
group by Consumidor.email;


create view pegadaQuantidade as
select Consumidor.email, sum(compra.quantidade*pegada.num) as pe
from Consumidor, compra, pegada 
where compra.consumidor=Consumidor.numero and compra.consumidor = pegada.consumidor 
group by Consumidor.email;

select pegada.num/valor.valor
from pegada, valor
where pegada.consumidor=valor.email;




select C.email
from Consumidor C
where not exists (
	select E.codigo 
	from Elemento E
	where not exists(
	select cm.prodMarca
	from composto cm
	where cm.elemento = E.codigo and exists 
	(select Compra.prodMarca
	from compra Compra
	where Compra.consumidor = C.numero and cm.prodMarca = Compra.prodMarca)))