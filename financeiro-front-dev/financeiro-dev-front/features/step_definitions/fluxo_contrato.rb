Quando("seleciono {string} pesquisando por {string}") do |arg,arg2|
    
    Selects.new.select_option_menu_home(arg,arg2)
    
end

Quando("executo abertura de Contrato com {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}") do |reserva, contrato, cliente, agencia, empresa, retirada, devolucao, car, tarifa, placa, pagamento|

    @var_accessor = Attr.new                                                                                                                               
    Geradores.new.gera_abertura(reserva,contrato,cliente,agencia,empresa,retirada,devolucao,car,tarifa,placa,pagamento,@var_accessor)

end
  

Quando("realizo pagamento de contrato com pre_autorizacao {string}") do |pre_autorizacao|
    
    
    Pagamentos.new.pre_pagamento(pre_autorizacao,@var_accessor)

end

Entao("tenho um contrato aberto") do
    
    Validate.new.valida_contrato_aberto(@var_accessor)    
    
end

  
