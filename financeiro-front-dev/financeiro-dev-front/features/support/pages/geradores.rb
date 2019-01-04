class Geradores
    include Capybara::DSL


    def gera_reserva(cliente,local_retirada,retirada,devolucao,var_accessor)
        within_frame('app') do 
            
            find(EL['fechar_modal'], wait: 10).click

            Selects.new.select_client_reserva(cliente,var_accessor)
        
            find(EL['aba_escolher_veiculo'], wait: 10 ).click

            Abertura.new.select_local_retirada(local_retirada,var_accessor)

            self.gera_feriado(var_accessor)
            
            Abertura.new.select_devolucao_retirada(retirada,devolucao,var_accessor)
            
            Abertura.new.select_grupo_car_modal(var_accessor)
            
            find(EL['finalizar_reserva'], wait: 10 ).click
            
        end 
    end
    
    def paga_reserva(companhia_aerea,num_voo,pagamento_reserva,var_accessor)
        
        within_frame('app') do 
          
            Abertura.new.select_companhia_aerea(companhia_aerea,var_accessor)
            
            Abertura.new.select_num_voo(num_voo,companhia_aerea,var_accessor)
            
            Abertura.new.select_pagamento_reserva(pagamento_reserva,var_accessor)
            
            sleep 2
        end
        
        Validate.new.confirma_reserva(var_accessor)
            
    end


    def gera_abertura(reserva,contrato,cliente,agencia,empresa,retirada,devolucao,car,tarifa,placa,pagamento,var_accessor)
               
        Abertura.new.select_reserva(reserva,var_accessor)
        
        Abertura.new.select_contrato(contrato,var_accessor)
        
        within_frame('app') do 

            Selects.new.select_client_contrato(cliente,var_accessor)
                        
            Abertura.new.select_agencia(agencia,var_accessor)
            
            Abertura.new.select_empresa(empresa,var_accessor)
            
            Abertura.new.select_devolucao_retirada(retirada,devolucao,var_accessor)
            
            Abertura.new.select_group_cars(car,var_accessor)
            
            Abertura.new.select_tarifas(tarifa,car,var_accessor)
            
            Abertura.new.select_placa(placa,car,var_accessor)
            
            Abertura.new.select_pagamento(pagamento,var_accessor)
        end
    end

    def gera_pagamentos(argumento_bdd,var_accessor)
        
        Selects.new.select_pre_autorization(argumento_bdd,var_accessor)        

    end

    def consulta_reserva(reserva,pagamento,var_accessor)
        
        Abertura.new.select_reserva(reserva,var_accessor)
    
        Abertura.new.select_placa_com_reserva(var_accessor)
    
        within_frame('app') do 

        Abertura.new.select_pagamento(pagamento,var_accessor)
        
        end
    end

   


end