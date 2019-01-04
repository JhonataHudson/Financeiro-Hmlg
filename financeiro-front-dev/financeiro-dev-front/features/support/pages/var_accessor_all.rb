class Attr
#ABERTURA

    attr_accessor :fds

    attr_accessor :grupo_carro

    attr_accessor :tarifa_aplicada

    attr_accessor :placa_selecionada

    attr_accessor :tarifa_sem_cadastro

    attr_accessor :tipo_pagamento

    attr_accessor :cliente

    attr_accessor :retirada

    attr_accessor :devolucao

    attr_accessor :car_especifc

    attr_accessor :tarifa_especifc

    attr_accessor :placa_especifc

    attr_accessor :pagamento_especifc

    attr_accessor :empresa_select

    attr_accessor :agencia_select

    attr_accessor :contrato_select

    attr_accessor :reserva_select

#PAGAMENTOS

    attr_accessor :pre_autorizacao  	

    attr_accessor :banco_dados_cheque  	

    attr_accessor :status_contrato

    attr_accessor :protecao

    attr_accessor :protecao_especifica

    attr_accessor :produto_adicional

    attr_accessor :numero_serie

    attr_accessor :somente_num_status

#RESERVA

    attr_accessor :num_reserva

    attr_accessor :localRetirada

    attr_accessor :placa_selecionada_reserva

#DEVOLUCAO 

    attr_accessor :contratos_devolucao
    attr_accessor :filiais

#GERENCIAMENTO DE MULTAS 

    attr_accessor :retirada

    attr_accessor :devolucao

    attr_accessor :placa_multa

    attr_accessor :hora_infracao

end
