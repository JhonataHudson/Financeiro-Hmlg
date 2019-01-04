#language:pt

Funcionalidade: acesssar ambiente para gerar um contrato/reserva

Contexto: Efetuar login no sistema  
Dado que estou autenticado no site


@abertura_contrato  
Esquema do Cenario: Efetuar abertura de contrato
Quando seleciono 'Menu_home' pesquisando por 'Contrato'
E executo abertura de Contrato com '<reserva>', '<contrato>', '<cliente>', '<agencia>', '<empresa>', '<retirada>', '<devolucao>', '<car>', '<tarifa>', '<placa>', '<pagamento>'
E realizo pagamento de contrato com pre_autorizacao ' Cheque' 
Entao tenho um contrato aberto


Exemplos:  
| reserva | contrato | cliente       | agencia | empresa | retirada         | devolucao        | car          | tarifa           | placa             | pagamento      |          
|  nil    |   nil    |  6605214960   |   nil   |   nil   | retirada_mensal  | devolucao_mensal | car_aleatory | tarifa_aleatory  | placa_aleatory    | pay_aleatory   |                         


@abertura_de_reserva
Esquema do Cenario: Efetuar abertura de reserva 
Quando seleciono 'Menu_home' pesquisando por 'Reservas'
E realizo reserva com '<cliente>' '<local_retirada>' '<retirada>' '<devolucao>' selecionando grupo de veiculos
Entao adiciono pagamento com '<companhia_aerea>' '<num_voo>' '<pagamento_reserva>'


Exemplos: 
| cliente     | local_retirada            | retirada          | devolucao          | companhia_aerea | num_voo| pagamento_reserva  | reserva                  | pagamento     |
| 6605214960  | local_retirada_aleatory   | retirada_aleatory | devolucao_aleatory |  voo_aleatory   | 12345  | pagamento d        | Numero_reserva_capturada |  pay_aleatory |



@abertura_de_reserva_e_contrato
Esquema do Cenario: Efetuar abertura de reserva realizando pagamento de contrato
Quando seleciono 'Menu_home' pesquisando por 'Reservas'
E realizo reserva com '<cliente>' '<local_retirada>' '<retirada>' '<devolucao>' selecionando grupo de veiculos
E adiciono pagamento com '<companhia_aerea>' '<num_voo>' '<pagamento_reserva>'
E seleciono 'Menu_home' pesquisando por 'Contrato'
E realizo consulta de '<reserva>' selecionando tipo de '<pagamento>'
E realizo pagamento de contrato com pre_autorizacao ' Cheque' 
Entao tenho um contrato aberto


Exemplos: 
| cliente     | local_retirada            | retirada          | devolucao          | companhia_aerea | num_voo| pagamento_reserva  | reserva                  | pagamento     |
| 6605214960  | local_retirada_aleatory   | retirada_aleatory | devolucao_aleatory |  voo_aleatory   | 12345  | pagamento d        | Numero_reserva_capturada |  pay_aleatory |



@tripartite_with_agencia
Esquema do Cenario: Efetuar abertura de contrato informando agencia
Quando seleciono 'Menu_home' pesquisando por 'Contrato'
E executo abertura de Contrato com '<reserva>', '<contrato>', '<cliente>', '<agencia>', '<empresa>', '<retirada>', '<devolucao>', '<car>', '<tarifa>', '<placa>', '<pagamento>'
E realizo pagamento de contrato com pre_autorizacao ' Cheque' 
Entao tenho um contrato aberto


Exemplos:  
| reserva | contrato | cliente       | agencia               | empresa | retirada          | devolucao          | car          | tarifa          | placa             | pagamento      |          
|  nil    |   nil    |  6605214960   | Agencia:1076026000011 |    nil  | retirada_aleatory | devolucao_aleatory | car_aleatory | tarifa_aleatory | placa_aleatory    | pay_aleatory   | 



@tripartite_with_empresa
Esquema do Cenario: Efetuar abertura de contrato informando empresa
Quando seleciono 'Menu_home' pesquisando por 'Contrato'
E executo abertura de Contrato com '<reserva>', '<contrato>', '<cliente>', '<agencia>', '<empresa>', '<retirada>', '<devolucao>', '<car>', '<tarifa>', '<placa>', '<pagamento>'
E realizo pagamento de contrato com pre_autorizacao ' Cheque' 
Entao tenho um contrato aberto


Exemplos:  
| reserva | contrato | cliente       | agencia  | empresa              | retirada          | devolucao          | car          | tarifa           | placa             | pagamento      |          
|  nil    |   nil    |  6605214960   | nil      | Empresa:8468348100   | retirada_aleatory | devolucao_aleatory | car_aleatory | tarifa_aleatory  | placa_aleatory    | pay_aleatory   | 



@tripartite_with_empresa_agencia
Esquema do Cenario: Efetuar abertura de contrato informando agencia e empresa
Quando seleciono 'Menu_home' pesquisando por 'Contrato'
E executo abertura de Contrato com '<reserva>', '<contrato>', '<cliente>', '<agencia>', '<empresa>', '<retirada>', '<devolucao>', '<car>', '<tarifa>', '<placa>', '<pagamento>'
E realizo pagamento de contrato com pre_autorizacao ' Cheque' 
Entao tenho um contrato aberto


Exemplos:  
| reserva | contrato | cliente     | agencia               | empresa             | retirada          | devolucao           | car          | tarifa           | placa             | pagamento      |          
|  nil    |   nil    | 6605214960  | Agencia:1076026000011 | Empresa:8468348100  | retirada_aleatory |  devolucao_aleatory | car_aleatory | tarifa_aleatory  | placa_aleatory    | pay_aleatory   | 


@devolucao_contrato 
Esquema do Cenario: Efetuar devolucao de contrato
Quando seleciono 'Menu_home' pesquisando por 'Contrato'
E consulto contratos existentes no '<cliente>'
E realizo processo de '<devolucao>'
Entao tenho um veiculo devolvido


Exemplos:  
| devolucao           | cliente  |
| sem_avaria/tanque_8 | 9775654  |   



@gerenciamento_multas
Esquema do Cenario: Aplicar multas em contrato existente
Quando seleciono 'Menu_home' pesquisando por 'Contrato'
E consulto contratos existentes no '<cliente>'
E capturo informaçoes essenciais para cadastro de Multas
E seleciono 'Menu_home' pesquisando por 'Gerenciamento de Multas'
E realizo processo de cadastro de Multas com '<pagamento>'
Entao tenho uma multa cadastrada com '<pagamento>'


Exemplos:  
| cliente    | pagamento    |
| 6605214960 | Faturado    |


