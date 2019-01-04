Quando("realizo reserva com {string} {string} {string} {string} selecionando grupo de veiculos") do |cliente, local_retirada, retirada, devolucao|
    @var_accessor = Attr.new
    Geradores.new.gera_reserva(cliente,local_retirada,retirada,devolucao,@var_accessor)
end

  
Entao("adiciono pagamento com {string} {string} {string}") do |companhia_aerea,num_voo,pagamento_reserva|

    Geradores.new.paga_reserva(companhia_aerea,num_voo,pagamento_reserva,@var_accessor)
    
end

Quando("realizo consulta de {string} selecionando tipo de {string}") do |reserva,pagamento|
    
    Geradores.new.consulta_reserva(reserva,pagamento,@var_accessor)

end
  