class Multas 
    include Capybara::DSL

    def captura_infos_cadastro_multas(var_accessor)
      
        within_frame('app') do 
            
            var_count = find('#QtdeContratos').find('.Grid').all('tr').count - 1

            var_rand = rand(0..var_count)
            
            $numero_contrato = find('#QtdeContratos').find('.Grid').all('tr')[var_rand].find('a').text

             find(EL['close_modal'], wait: 10 ).click

             find('#ContratoNro', wait: 10 ).set($numero_contrato)
            
             find('#ContratoNro', wait: 10 ).native.send_keys(:tab)
            
             if has_selector?('#dialog') == true 
                    
                click_button('Sim')
            
            end
            
            data_ret = find('#DT_Retirada').value 
            
            data_dev = find('#DT_Devolucao').value
       
            placa = find('#Frota').value
       
            var_accessor.retirada =  data_ret

            var_accessor.devolucao = data_dev

            var_accessor.placa_multa = placa
        end
    end

    def seleciona_data_hora_infracao(var_accessor)
 
        infracao_ret = Time.parse(var_accessor.retirada)

        infracao_dev = Time.parse(var_accessor.devolucao)
        
        data_infracao = rand(infracao_ret..infracao_dev)
     
        data_infracao = data_infracao.strftime('%d%m%Y %H%M')

        var_accessor.hora_infracao = data_infracao

        p var_accessor.hora_infracao

    end

    def adiciona_multas(var_accessor)

        within_frame('app') do 
           
            find('#TipoMulta').click

            find('#Placa', wait: 10).set(var_accessor.placa_multa)

            $var = $var.to_s + "\n" + "Placa do contrato #{$numero_contrato}" + ': ' + var_accessor.placa_multa

            find('#Placa', wait: 10).native.send_keys(:tab)
        
            infracao = rand(100..9000)

            find('#AutoInfracao').set("CT_#{infracao}")

            $var = $var.to_s + "\n" + "Numero AIT" + ': ' + "CT_#{infracao}"
            
            find('#DataInfracao', wait: 10 ).set(var_accessor.hora_infracao)
            
            $var = $var.to_s + "\n" + "Data infração" + ': ' + var_accessor.hora_infracao

            x = rand(1..40)  
            
            x.times do           
                find('#OrgaoID').native.send_keys(:down)                
            end  
           
           find('#CodigoInfracao').set("  ")
          
           sleep 1
          
           y = rand(1..9)  
           
           y.times do 
                find('#CodigoInfracao').native.send_keys(:down) 
            end
           
            find('#CodigoInfracao').native.send_keys(:enter)
       
            infracao = find('#DescricaoInfracao').value

            $var = $var.to_s + "\n" + "Descrição Infração" + ': ' + infracao

            notificar_ate = Time.now + 172800

            notificar_ate = notificar_ate.strftime('%d%m%Y')

            find('#Vencimento').set(notificar_ate)

            $var = $var.to_s + "\n" + "Notificar até" + ': ' + notificar_ate

            find('#OK').click

            for e in (0..4) do 

                p 'Aguarde...'
            
            end
        end
    end

    def realiza_cobranca(var_accessor,pagamento)
        within_frame('app') do 
            all('.ui-state-default.ui-corner-top', wait: 10 )[3].click
           
            within_frame('Faturas') do 

                page.execute_script("$('#ValorNominal').removeAttr('readonly')")

                10.times do 

                    find('#ValorNominal').native.send_keys(:backspace)
               
                end
           
                find('#ValorNominal').set('4,70')
                find('#ValorNominal').native.send_keys(:tab)

                if Metodos.new.alert_present == true 
                
                    page.driver.browser.switch_to.alert.accept 

                end

                find('#FormaID').select(pagamento)
                
                $var = $var.to_s + "\n" + "Forma de pagamento" + ': ' + pagamento

                find('#OK').click
                
                Metodos.new.load_rapid(5)            

                if pagamento == 'Cartão de Crédito'

                    if has_selector?('#modalTefDashBoard') == true
                    
                        find("input[type='button']").click

                        if Metodos.new.alert_present == true 

                            page.driver.browser.switch_to.alert.accept 
                    
                        end
                    end

                    Metodos.new.load_rapid(0)            

                    name_frame = find('iframe')['name']
                    
                    within_frame(name_frame) do 
        
                        cont = 0
        
                        while has_selector?('#TextoAnalise') == true   
                            
                            sleep 1
                            p "Aguarde a análise de crédito ..."
                            
                            cont += 1

                            p cont

                        raise "Sistema nao retorna análise de crédito Error: Time Out forma de pagamento: #{pagamento}" if cont == 30 
                        end
                    end
                else
                    
                    if has_selector?('#modalTefDashBoard') == true

                        find("input[value='Fechar']").click
                        page.driver.browser.switch_to.alert.accept 

                    end
                end
            end
        end
    end



end