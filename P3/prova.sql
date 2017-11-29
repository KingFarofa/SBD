CREATE OR REPLACE FUNCTION total_ped () RETURNS void AS $$
DECLARE tupla RECORD;
compras cliente.totalcompras%TYPE;
BEGIN
	FOR TUPLA IN SELECT * FROM cliente LOOP
		SELECT COUNT(*) 
		INTO compras
		FROM cliente c, pedido p
		WHERE c.codcli = p.codcli AND c.codcli = tupla.codcli
		GROUP BY c.codcli;
		
		UPDATE cliente c SET totalcompras = compras
		WHERE c.codcli = tupla.codcli;
	END LOOP;
	
END$$ LANGUAGE 'plpgsql';

select total_ped();

CREATE OR REPLACE FUNCTION valordoPedido (IN pedido int) RETURNS float AS $$
DECLARE preco float;
DECLARE quant int;
DECLARE tupla record;
BEGIN
	FOR tupla IN SELECT * FROM itemped LOOP
		SELECT valunit
		INTO preco
		FROM itemped ip, produto p
		WHERE ip.numped = pedido AND p.codprod = ip.codprod;

		SELECT itemped.quant into quant from itemped;
		preco := preco*quant;
	END LOOP;
	
	
	RETURN preco;
END $$ LANGUAGE 'plpgsql';
select valordoPedido(1820);



CREATE OR REPLACE FUNCTION excessao(IN valor int) RETURNS void AS $$
BEGIN
	IF valor<0 THEN
		RAISE EXCEPTION 'NÃO PODE SER NEGATIVO';
	END IF;
	
END$$ LANGUAGE 'plpgsql';

select excessao(-10);

