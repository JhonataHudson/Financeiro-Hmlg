class Devolucao 

    include Capybara::DSL

    def consulta_cliente(cliente,var_accessor)
        within_frame('app') do 
            if cliente == 'client_aleatory'
                
                find(EL['Campo_cliente']).set('43512289')      
                
            
                if has_selector?(EL['el_dropdown'], wait: 30) == true 

                    find(EL['el_dropdown'], wait: 10).find(EL['li_dropdown'], wait: 10).click
                
                else
                    
                    raise "Droplist Nomes nao apresentada a tempo !!"
                
                end        
                
                $var = $var.to_s + "\n" + 'Cliente' + ': ' + 'Lucas Longobardi Arena dos Santos'
                p $var
                
                find(EL['Campo_cliente'], wait: 10).native.send_keys(:tab) #comandos que executam comandos do teclado (tab/enter/backspace/up/down)
    
            elsif cliente != 'client_aleatory' # se for diferente de aleatorias
        
                find(EL['Campo_cliente']).set(cliente)      
                
                cliente_select = find(EL['Campo_cliente']).value   

                sleep 1
                
                find(EL['el_dropdown'], wait: 10).find(EL['li_dropdown'], wait: 10).click
              
                $var = $var.to_s + "\n" + 'Cliente' + ': ' + cliente_select
                p $var
                
                find(EL['Campo_cliente'], wait: 10).native.send_keys(:tab) #comandos que executam comandos do teclado (tab/enter/backspace/up/down)    
                                
            end
        end
    end


    def devolve_car(devolucao,var_accessor)

            Devolucao.new.captura_contratos(var_accessor)
            
            binding.pry
            
            Devolucao.new.efetua_devolucao(devolucao,var_accessor)
    end


    def efetua_devolucao(devolucao,var_accessor)

        execute = var_accessor.contratos_devolucao.count
    
        cont = 0 

        while cont < execute 
    
            within_frame('app') do 
                
                find('#ContratoNro', wait: 10 ).set(var_accessor.contratos_devolucao[cont])
                
                find('#ContratoNro', wait: 10 ).native.send_keys(:tab)
                
                if has_selector?('#dialog') == true 
                    
                    click_button('Sim')
                end
                
                if Metodos.new.alert_present == true 
                    
                    page.driver.browser.switch_to.alert.accept 
                    
                    raise 'Pop up nao desaparece, após clicar no botao ok' if Metodos.new.alert_present == true 
                    
                end
                
                
                if find('#TabelaID').text == 'Ops! Nenhuma tarifa válida foi encontrada!'
                    
                    $var = $var.to_s + "\n" + 'ERRO' + ':' + "Ops! Nenhuma tarifa válida foi encontrada! para o contrato #{var_accessor.contratos_devolucao[cont]}"
                    
                    p 'Ops! Nenhuma tarifa válida foi encontrada!'
                    
                    find('a', exact_text:'Contrato', wait: 10).click
                    
                    if Metodos.new.alert_present == true 
                        page.driver.browser.switch_to.alert.accept 
                        find('a', exact_text:'Contrato', wait: 10).click
                    end
                end
                
                cont += 1                     
            end
        end
    end

    def execute_aba_pagamentos
        find('a', exact_text:'Pagamentos').click

    end

    def execute_aba_devolucao(devolucao,var_accessor)

        find('span', text: 'Devolução').click


        qtd_meses_locacao = find('#InfoGeral').all('tr')[1].all('input').count
        cont = 0  

        while cont < qtd_meses_locacao
            
            find('#InfoGeral').all('tr')[1].all('input')[cont].click

            if devolucao[0] == 'sem_avaria'

                all('.TemAvaria')[0].click


            elsif devolucao[0] == 'com_avaria'   
                
                all('.TemAvaria')[1].click
            
            end
            
            find('#D_Km').set('1')
            
        end
    end


    def captura_contratos(var_accessor)
        within_frame('app') do

            if has_selector?('#QtdeContratos', wait: 30) == true 
                
            contratos_devolucao = []

            qtd_contratos = find('#QtdeContratos').find('.Grid').all('tr').count - 1
            
            if qtd_contratos == 1 
               
                numero_contrato = find('#QtdeContratos').find('.Grid').all('tr')[1].find('a').text  

                contratos_devolucao << numero_contrato
               
                var_accessor.contratos_devolucao = contratos_devolucao

            else

                var_count = find('#QtdeContratos').find('.Grid').all('tr').count - 1

                var_rand = rand(0..var_count)
                
                numero_contrato = find('#QtdeContratos').find('.Grid').all('tr')[var_rand].find('a').text

                contratos_devolucao << numero_contrato

                var_accessor.contratos_devolucao = numero_contrato
            end
            
            find(EL['close_modal'], wait: 10 ).click

            end
        end
    end
end