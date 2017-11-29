CREATE TABLE auditoria_salarios(
	codvend		int,
	asalario	int,
	nsalario	int,
	alt		timestamp
	);
CREATE OR REPLACE FUNCTION insere() RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO auditoria_salarios VALUES (
		new.codvend,
		old.salfixo,
		new.salfixo,
		now()
	);
	RETURN NEW;
END $$ LANGUAGE 'plpgsql';


DROP TRIGGER insere_audioria ON vendedor;
CREATE TRIGGER insere_audioria after UPDATE ON vendedor 
FOR EACH ROW EXECUTE PROCEDURE insere();

CREATE OR REPLACE FUNCTION aumento() RETURNS void AS $$
DECLARE tupla RECORD;
BEGIN
	FOR tupla IN SELECT * FROM vendedor LOOP
		CASE
			WHEN tupla.faixacomis='A' THEN
				UPDATE vendedor SET salfixo = salfixo*1.05;
			WHEN tupla.faixacomis='B' THEN
				UPDATE vendedor SET salfixo = salfixo*1.1;
			ELSE 
				UPDATE vendedor SET salfixo = salfixo*1.15;
		END CASE;
	END LOOP;
	
END $$ LANGUAGE 'plpgsql';
SELECT aumento();
select * from auditoria_salarios;


ALTER TABLE pedido ADD COLUMN quant int ;


CREATE OR REPLACE FUNCTION quant() RETURNS TRIGGER AS $$
DECLARE tupla RECORD;
DECLARE n int;
BEGIN
	
	FOR tupla IN SELECT * FROM pedido LOOP
		SELECT COUNT(*) INTO n 
		FROM itemped ip 
		WHERE tupla.numped = ip.numped
		GROUP BY numped;
		IF n >10 THEN
			RAISE EXCEPTION 'MAIS Q 10 N POHA';
			RAISE EXCEPTION 'CONTINUA';
			RETURN old;
		END IF;
		UPDATE pedido SET quant=n WHERE pedido.numped = tupla.numped;
	END LOOP;
	RETURN NEW;
END $$ LANGUAGE 'plpgsql';

DROP TRIGGER upq ON pedido;
CREATE TRIGGER upq AFTER INSERT OR DELETE ON itemped FOR EACH STATEMENT
EXECUTE PROCEDURE quant();

DELETE FROM itemped where numped=300 AND codprod=25;
SELECT * FROM pedido where numped=2775;

SELECT numped,COUNT(*) FROM itemped GROUP BY numped order by count DESC;
2775,31,10

INSERT INTO itemped VALUES (2775,2,10);
select * from produto order by codprod;

insert into produto VALUES (1,'F','aad',6541);
insert into produto VALUES (2,'F','aad',6541);
insert into produto VALUES (3,'F','aad',6541);

