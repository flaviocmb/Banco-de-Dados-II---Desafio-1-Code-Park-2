CREATE DATABASE loja;

CREATE TABLE clientes (
	id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_cadastro TIMESTAMP NOT NULL
);

CREATE TABLE pedidos (
  id_pedido SERIAL PRIMARY KEY,
  valor FLOAT NOT NULL,
  data_pedido TIMESTAMP NOT NULL,
  fk_id_cliente INT NOT NULL,
  CONSTRAINT fk_clientes FOREIGN KEY (fk_id_cliente) REFERENCES clientes (id)
  on DELETE CASCADE
);

INSERT INTO clientes (nome, email, data_cadastro) VALUES
('João Silva', 'joao.silva@example.com', '2023-06-08 10:00:00'),
('Maria Santos', 'maria.santos@example.com', '2023-06-08 11:30:00'),
('Pedro Oliveira', 'pedro.oliveira@example.com', '2023-06-08 13:45:00'),
('Ana Pereira', 'ana.pereira@example.com', '2023-06-08 15:20:00'),
('Lucas Fernandes', 'lucas.fernandes@example.com', '2023-06-08 17:10:00');

INSERT INTO pedidos (valor, data_pedido, fk_id_cliente) VALUES
(180.90, '2023-05-18 14:30:00', 5),
(150.75, '2023-06-17 14:40:00', 3),
(85.50, '2023-06-13 12:15:00', 2),
(110.20, '2023-06-30 16:05:00', 4),
(90.80, '2023-06-23 15:20:00', 4),
(65.00, '2023-06-08 10:30:00', 1),
(50.00, '2023-06-11 10:00:00', 1),
(75.20, '2023-06-08 11:30:00', 2),
(200.00, '2023-06-12 17:10:00', 5),
(120.50, '2023-06-04 13:45:00', 3);

CREATE FUNCTION mostrar_mensagem()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'Pedido inserido.';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_mostrar_mensagem
AFTER INSERT ON pedidos
FOR EACH ROW
EXECUTE FUNCTION mostrar_mensagem();

INSERT INTO pedidos (valor, data_pedido, fk_id_cliente) VALUES
(200.00, '2023-06-13 23:30:00', 4);