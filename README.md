﻿# Techchallenge3-Terraform-mongodbatlas


# Modelagem de Dados

A seguir está a modelagem de dados para o nosso sistema. Essa tabela descreve a estrutura e os relacionamentos das entidades no banco de dados.

## Tabela Produto

| Campo         | Tipo           | Chave     | Descrição                                     |
|---------------|----------------|-----------|-----------------------------------------------|
| codigo        | Number         | Chave Primária | Código exclusivo do produto.              |
| nome          | String         |           | Nome do produto.                             |
| categoria     | String         |           | Categoria do produto (lanche, acompanhamento, bebida, sobremesa). |
| descricao     | String         |           | Descrição do produto.                        |
| preco         | Number         |           | Preço do produto.                            |

## Tabela Cliente

| Campo         | Tipo           | Chave     | Descrição                                     |
|---------------|----------------|-----------|-----------------------------------------------|
| cpf           | String         | Chave Primária | CPF exclusivo do cliente.                   |
| nome          | String         |           | Nome do cliente.                             |
| email         | String         |           | Endereço de e-mail do cliente.               |

## Tabela Pedido

| Campo         | Tipo           | Chave     | Descrição                                     |
|---------------|----------------|-----------|-----------------------------------------------|
| pedido_id     | ObjectId       | Chave Primária | Identificador único do pedido.             |
| cliente_cpf   | String         | Chave Estrangeira para Cliente | CPF do cliente que fez o pedido. |
| status        | String         |           | Status do pedido (Pagamento, Recebido, Em preparacao, Pronto, Finalizado). |
| ondecomer     | String         |           | Local de entrega do pedido.                 |
| preco_total   | Number         |           | Preço total do pedido.                       |

## Tabela PedidoProdutos (Relacionamento Muitos-para-Muitos entre Pedido e Produto)

| Campo         | Tipo           | Chave     | Descrição                                     |
|---------------|----------------|-----------|-----------------------------------------------|
| pedido_id     | ObjectId       | Chave Estrangeira para Pedido | Identificador do pedido. |
| produto_id    | ObjectId       | Chave Estrangeira para Produto | Identificador do produto no pedido. |
| quantidade    | Number         |           | Quantidade do produto no pedido.            |

## Tabela Campanha

| Campo         | Tipo           | Chave     | Descrição                                     |
|---------------|----------------|-----------|-----------------------------------------------|
| campanha_id   | ObjectId       | Chave Primária | Identificador único da campanha.           |
| cliente_cpf   | String         | Chave Estrangeira para Cliente | CPF do cliente associado à campanha. |
| campanha      | String         |           | Nome da campanha.                            |
