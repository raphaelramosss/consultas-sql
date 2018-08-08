-- 1 Selecione o nome completo de todos os empregados.
select concat(e.pnome,' ',e.unome) as nome_completo from empregado as e

-- 2 Selecione o número e nome de todos os departamentos
select d.dnumero, d.dnome from departamento as d

-- 3 Selecione o número, nome e a localização de todos os projetos.
select p.pnumero, p.pjnome, p.plocalizacao from projeto as p order by p.pjnome

-- 4 Selecione o ssn, nome e a data de nascimento (dd-mm-yyyy) dos empregados do sexo masculino
select e.ssn, e.pnome, date_format(e.datanasc,'%d/%m/%y') as DataNascimento from empregado as e

-- 5 Selecione o nome de todos os empregados que não possuem supervisor
select * from empregado as e having e.superssn is null

-- 6 Selecione todos os dependentes que são cônjuge
select * from dependente where parentesco = "CÔNJUGE"

-- 7 Selecione todos os empregados que têm salário maior que 30000.
select * from empregado as e having e.salario > 30000

-- 8 Selecione todos os empregados do sexo femino e que ganham mais que 25000.
select * from empregado as e where e.sexo = "F" and e.salario > 25000 order by e.pnome

-- 9 Selecione todos os empregados que iniciem o nome pela letra J.
select * from empregado as e where e.pnome like('j%')

-- 10 Selecione todos os empregados que possui endereço em Houston.
select * from empregado as e having e.endereco = 'Houston'

-- 11 Selecione o nome e a data de nascimento (dd-mm-yyyy) de todos os dependentes que são cônjuge
--ou que são filho.
select p.nome_dependente, date_format(p.datanasc, '%d/%m/%y') as DataNascimento from dependente as p where p.parentesco = 'Cônjuge' or p.parentesco = 'Filho'

-- 12 Selecione o nome de todos os projetos que estão localizados em Stafford.
select e.pjnome from projeto as e where e.plocalizacao = "Stafford"

-- 13 Selecione o nome concatenado pelo último nome de todos os empregados do sexo feminino, que
-- ganham mais de 3000 e que mora em Berry.

select concat(e.unome,", ", e.pnome) as nome_completo from empregado as e where e.sexo = "F" and e.salario > 3000 and e.endereco = "Berry"

-- 14 Selecione todos os empregados que ganham salário entre 38000 e 43000.
select * from empregado as e where e.salario > 38000 and e.salario < 43000

-- 15 Selecione a quantidade de empregados por sexo.
select e.sexo, count(*) as quantidade from empregado as e group by e.sexo

-- 16 Selecione a quantidade de empregados por departamento.
select e.dno as CodigoDepartamento, count(e.ssn) as QuantidadeEmpregados from empregado as e group by e.dno

-- 17 Selecione a quantidade de projetos por departamento
select p.dnum as departamento ,count(p.dnum) as TotalProjetos from projeto as p group by p.dnum

-- 18 Selecione a média salarial por departamento.
select e.dno as CodigoDepartamento, avg(e.salario) as MédiaSalarial from empregado as e group by e.dno

-- 19 Selecione os maiores salário por sexo.
select e.sexo, max(e.salario) as MaiorSalario from empregado as e group by e.sexo

-- 20 Selecione a soma de todos salários dos empregados que são do departamento 4.
select sum(e.salario) as SomaSalarioDepartamento4 from empregado as e where e.dno = 4 group by e.dno

-- 21 Selecione a média de todos os salários dos empregados que moram em Houston e que são do sexo
-- masculino.

select avg(e.salario) as MediaEmpregados from empregado as e where e.endereco = 'Houston' and e.sexo = 'M'

-- 22 Selecione o nome dos empregados e a quantidade de vezes que cada nome se repete.

select e.pnome, count(*) from empregado as e group by e.pnome

-- 23 Selecione o tipo de parentesco dos dependentes e a quantidade de vezes em que cada tipo aparece

select e.parentesco, count(*) from dependente as e group by e.parentesco

-- 24 Selecione todos os empregados ordenados acesdentemente por nome.
select * from empregado as e order by e.pnome asc 

-- 25 Selecione todos os empregados ordenados decrescentemente por idade
select * from empregado as e order by year( curdate() ) - year(e.datanasc) desc

-- 26 Selecione todos os empregados ordenado decrescentemento por salário, e ascendente por nome.
select * from empregado as e order by e.salario desc, e.pnome asc

-- 27 Selecione todos os empregados que têm dependentes.
select * from dependente as d inner join empregado as e on (d.essn = e.ssn)
group by e.pnome

/* 28 Selecione o nome e a data de nascimento dos empregados e o nome e a data de nascimento
 do dependente cônjugue, em que a data de nascimento do empregado for menor que a data de
 nascimento do seu cônjugue. */

select e.pnome, e.datanasc, d.nome_dependente, d.datanasc from empregado as e
inner join dependente as d on (e.ssn = d.essn)
where e.datanasc < d.datanasc

-- 29 Selecione todos os empregados que trabalham em um projeto cujo departamento não é o seu 
select * from empregado as e 
inner join trabalha_em as t on (e.ssn = t.essn)
inner join projeto as p on (t.pno = p.dnum)
where e.dno != p.dnum

-- 30 Selecione o ssn, o nome, e a diferença salarial em relação à média por sexo dos funcionários