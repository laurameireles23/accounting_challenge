# Accounting challenge

Esta aplicação é o resultado de um teste enviado pela empresa Iugu, onde deveria rodar um sistema que gerencia contas bancárias de clientes atravez de apis, permitindo fazer transferências de um cliente para outro e expor o saldo atual da conta, sempre em reais.


### Pré requisitos

Para este projeto funcionar, os seguintes pré requisitos devem ser atendidos:

```
- Ter instalado o Ruby (versão utilizada: 2.3.3);
- Ter instalado o Rails (versão utilizada: 5.1.7);
- Ter instalado o MySql;
- Ter instalado o bundle;
```

### Instalando

Para instalar este projeto basta seguir os seguintes passos:

```
- Clonar este projeto;
```

Após clonar, basta rodar os comandos abaixo:

```
$ bundle
$ rails db:create
$ rails db:migrate
$ rails db:migrate RAILS_ENV=test (para rodar a base de testes)
```

Após estes comandos, seu projeto estará pronto para uso :)

### Possiveis erros com o banco de dados
Caso tenha erros ao tentar criar o banco, rodar os seguintes comandos(os mesmos funcionaram no windows):

```
$ mysql -u root -p -h localhost
$ ALTER USER ‘root’@’localhost’ IDENTIFIED WITH mysql_native_password BY '1234';
```

## Explicando cada função
Este projeto visa três principais funcionalidades. São elas:

  ## 1 - Criar Conta

  ```
  Entrada: id da conta: opcional, nome da conta, saldo inicial
  ```
    
  Fluxo principal:

  - Cliente envia informações da conta;
  - O sistema valida todos os dados;
  - O sistema responde com as informações da conta criada e um token de autenticação;
  
  Fluxo excepcional determinado: id da conta já existe.

  Retornar que o id já foi utilizado  
  
  ```
  Saída: id da conta, token
  ```
  
  Fluxo excepcional encontrado: id da conta não foi informado
  
  Quando o número da conta não for informado pelo cliente, a mesma é gerada para ele, facilitando assim sua vida :)

  ## 2 - Transferir dinheiro
  ```
  Entrada: source_account_id, destination_account_id, amount
  ```
  **OBS: Para ter acesso a essa função, o cliente já deve possuir uma conta criada,  utilizar seu token informado anteriormente na criação.** 

  Fluxo principal:

  - O cliente faz uma requisição com os dados descritos acima;
  - O sistema valida todos os dados;
  - O sistema computa um débito na conta de origem;
  - O sistema computa um crédito na conta de destino.
  
  Fluxo excepcional: a conta de origem não possui saldo suficiente

  O sistema cancela a transferência e exibe uma mensagem.
  
  
  **Implementação extra:**
  
Todos os dados das transações são armazenados na coluna not_approved. Quando a transação não for aprovada, o mesmo estará com valor false, caso contrario, vira como true.
Esta coluna foi criada para manter um armazenamento de todas as transações feitas por cada usuario, facilitando assim o desenvolvimento de novas features como disponibilização de extratos de transferencia, entre outros.
  
  ```
    Saída: Mensagem de sucesso
  ```
  
  ## 3 - Consultar saldo
   ```
    Entrada: account_id
  ```
  
   **OBS: Para ter acesso a essa função, o cliente já deve possuir uma conta criada,  utilizar seu token informado anteriormente na criação.** 

  Fluxo principal:

  - O cliente faz uma requisição com os dados descritos acima;
  - O sistema calcula o saldo atual da conta baseado no histórico de transferências da conta.
  
  Fluxo excepcional: Conta inexistente

  O sistema responde que a conta informada não existe.


## Testes
Visando a qualidade, este projeto conta com um total de 18 testes. Todos presentes na pasta spec e divididos entre models e requests. 
Para executa-los basta o comando:
```
bundle exec rspec spec/
```

## Construído com

Foram utilizadas as gems:
* Rails - Utilizado para acelerar o desenvolvimento, pois promove muitas facilidades no desenvolvimento;
* Capybara - Uitilizado para a criação dos testes, pois é uma ótima ferramenta para utilizar em testes, automação, entre outras utilidades. Com ele é possível testar as aplicações simulando as ações que os usuários reais executariam.
* Rubocop - Usado para a padronização de codigo.
* FactoryBot - Utilizado para facilitar os testes, além de deixar semanticamente mais limpos.


## Autores

* **Laura Meireles** - [Perfil github](https://github.com/laurameireles23)
