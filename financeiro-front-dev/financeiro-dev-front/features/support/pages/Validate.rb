class Validate 

    include Capybara::DSL

    def confirma_multas(pagamento)
        within_frame('app') do 

            within_frame('Faturas') do 

                if pagamento == 'Faturado'

                  numero_multa =  find('.GridCtrl').all('tr')[1].all('td')[11].text
                 
                  $var = $var.to_s + "\n" + 'Multa cadastrada' + ': ' + numero_multa

                elsif pagamento == 'Cartão de Crédito'
                    
                end
            end
        end
    end


    def confirma_reserva(var_accessor)
        
        within_frame('app') do 
        
            find('#leg_teclas_action', wait: 10).click
            
            find('#BtnConfirmar', wait: 10 ).click
            
            Metodos.new.load_rapid(2)            
            
            name_frame = find('iframe')['name']
            
            within_frame(name_frame) do 
                
                if has_text?('COTAÇÃO') == true
                    
                    find('#BtnVoltar').click            
                    
                else
                    
                    find('#BtnVoltar').click            
                    
                end
                
            end
            
            find('#BtnConfirmar', wait: 10 ).click
            
            Metodos.new.load_rapid(1)            

            if has_selector?("div[id='MsgErro']") == true 
                        
                find("input[value='fechar']").click
               
                reserva = find('#NumReservaID').text
                var_accessor.num_reserva = reserva 
               
                Metodos.new.save_text_all(var_accessor,'Reserva',var_accessor.num_reserva)
      
            else    
                
                name_frame = find('iframe')['name']
                
                within_frame(name_frame) do 
                    
                    find('#BtnVoltar').click            
                    
                end                
                
                reserva = find('#NumReservaID').text
                
                var_accessor.num_reserva = reserva
                
                Metodos.new.save_text_all(var_accessor,'Reserva',var_accessor.num_reserva)
                
                $var = $var.to_s + "\n" + 'Reserva' + ': ' + var_accessor.num_reserva
                p $var
            
            end
        end
    end
        
    def valida_contrato_aberto(var_accessor)
      
        Metodos.new.captura_status_contrato(var_accessor)

        if var_accessor.status_contrato.include?('Aberto')
            puts 'Contrato Aberto Com sucesso'
        else
            raise "#{var_accessor.status_contrato} Nao foi aberto com Sucesso !!"
        end 
       
        $var = $var.to_s + "\n" + 'Status contrato' + ': ' + var_accessor.status_contrato
        p $var

    end
end