Quando("consulto contratos existentes no {string}") do |cliente|
    @var_accessor = Attr.new

    Devolucao.new.consulta_cliente(cliente,@var_accessor)

end

Quando("realizo processo de {string}") do |devolucao|
    
    Devolucao.new.devolve_car(devolucao,@var_accessor)

end


Quando("capturo informaçoes essenciais para cadastro de Multas") do
    
    Multas.new.captura_infos_cadastro_multas(@var_accessor)
    
    Multas.new.seleciona_data_hora_infracao(@var_accessor)

end

Quando("realizo processo de cadastro de Multas com {string}") do |pagamento|    

    Multas.new.adiciona_multas(@var_accessor)

    Multas.new.realiza_cobranca(@var_accessor,pagamento)

end

Entao("tenho uma multa cadastrada com {string}") do |pagamento|

    Validate.new.confirma_multas(pagamento)
    
end

Entao("tenho um veiculo devolvido") do



end