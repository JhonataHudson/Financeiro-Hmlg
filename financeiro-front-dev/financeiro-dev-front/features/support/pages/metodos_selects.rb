class Selects
    include Capybara::DSL
    

    def select_client_contrato(cliente,var_accessor)
    
        if cliente == 'client_aleatory'
            
                 find(EL['Campo_cliente']).set('66052149604')      
                
                if has_selector?(EL['el_dropdown'], wait: 30) == true 
    
                    find(EL['el_dropdown'], wait: 10).find(EL['li_dropdown'], wait: 10).click
                
                else
                    
                    raise "Droplist Nomes nao apresentada a tempo !!"
                
                end        
                

               nome_cliente =  find('#Cliente').value

                $var = $var.to_s + "\n" + 'Cliente' + ': ' + nome_cliente
                p $var
                
                find(EL['Campo_cliente'], wait: 10).native.send_keys(:tab) #comandos que executam comandos do teclado (tab/enter/backspace/up/down)
                       
                
                #  if has_selector?(EL['modal_contratos'], wait: 10) == true 
                
                #      find(EL['close_modal']).click
                
                #  end
                           
        
        elsif cliente != 'client_aleatory' # se for diferente de aleatorias
           
            
             find(EL['Campo_cliente']).set(cliente)      
            
             sleep 2
            
             if has_selector?(EL['el_dropdown'], wait: 10) == true 
                
                find(EL['el_dropdown'], wait: 10).find(EL['li_dropdown'], wait: 10).click
                   
                 else
                       
                     raise "Droplist Nomes nao apresentada a tempo !!"
                   
                 end        
                        
                 nome_cliente =  find('#Cliente').value

                $var = $var.to_s + "\n" + 'Cliente' + ': ' + nome_cliente
                p $var

                find(EL['Campo_cliente'], wait: 10).native.send_keys(:tab) #comandos que executam comandos do teclado (tab/enter/backspace/up/down)    
                            
                 if has_selector?(EL['modal_contratos'], wait: 10) == true 
                    
                     find(EL['close_modal']).click
              
                 end
            end
    end
    def select_client_reserva(cliente,var_accessor)
    
        if cliente == 'client_aleatory'
            
                 find(EL['Campo_cliente']).set('43512289')      
                
                
                if has_selector?(EL['el_dropdown'], wait: 30) == true 
    
                    find(EL['el_dropdown'], wait: 10).find(EL['li_dropdown'], wait: 10).click
                
                else
                    
                    raise "Droplist Nomes nao apresentada a tempo !!"
                
                end        
                
                nome_cliente =  find('#Cliente').value

                $var = $var.to_s + "\n" + 'Cliente' + ': ' + nome_cliente
                p $var
                
                find(EL['Campo_cliente'], wait: 10).native.send_keys(:tab) #comandos que executam comandos do teclado (tab/enter/backspace/up/down)
        
        elsif cliente != 'client_aleatory' # se for diferente de aleatorias
           
            
             find(EL['Campo_cliente']).set(cliente)      
            
             sleep 1
            
             find(EL['el_dropdown'], wait: 10).find(EL['li_dropdown'], wait: 10).click
            
                        
             nome_cliente =  find('#Cliente').value

             $var = $var.to_s + "\n" + 'Cliente' + ': ' + nome_cliente
             p $var

                find(EL['Campo_cliente'], wait: 10).native.send_keys(:tab) #comandos que executam comandos do teclado (tab/enter/backspace/up/down)    
                            
            end
    end
    
    def select_option_menu_home(arg,arg2) # menu e contrato 
    
        find(EL[arg], wait: 15).click #clica opçao menu home  

        find(EL['pesquisa_home']).set(arg2) #escreve conteudo no campo de busca tela home 
   
        find(EL['lista']).find(EL['tag_a'], exact_text: arg2, wait:10).click # seleciona opçao digitada

    end

    def select_pre_autorization(argumento_bdd,var_accessor)
      
        within_frame('app') do

            find('.ui-state-default.ui-corner-top', text: "Pagamentos").click

                within_frame('FramePagamentos') do
                   
                    find('#FormaPreA').click
                    
                    pre_autorizacao = find('#FormaPreA').find('option', exact_text: argumento_bdd, wait: 10).click
                    
                    find('#FormaPreA').click

                    var_accessor.pre_autorizacao = pre_autorizacao
                    
                    for e in (0..30) do 
                        sleep 1
                        p 'Aguarde...'
                    end
                end    
                if argumento_bdd == ' Cheque'
                    
                    Pagamentos.new.dados_cheque('Aleatorias',var_accessor)
                    
                elsif argumento_bdd == ' Cartão de Crédito'    
                    
                    Selects.new.dados_cartao_credito()
                    
                end
            end            
        end
    end

    def dados_cartao_credito(argumento_metodo,var_accessor)
    
        if argumento_metodo == 'Aleatorias'
            
            within('.highslide-body') do 
            
                modal_frame = find('iframe')['name']
            
                within_frame(modal_frame) do
               
                    var_count_option = find('#CartaoID').all('option').count
                    var_rand = rand(0..var_count_option)
                    var_click_rand =  find('#CartaoID').all('option')[var_rand].click
                    banco = find('#CartaoID').all('option')[var_rand] .text

                    var_accessor.banco_dados_cheque = banco 
                
                    valor = find('#ValorC').value
                    
                    agencia = find('#TID').set('0000')
                    conta = find('#TNroCV').set('0000')
                    n_cheque = find('#TDocumento').set('00000')
                    nome_cheque = find('#NomeCheque').set('333')
                end
            end
    end
 
  end