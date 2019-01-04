class Pagamentos
    include Capybara::DSL


    def dados_cheque(argumento_metodo,var_accessor)
        if argumento_metodo == 'Aleatorias'
            
            within('.highslide-body') do 
            
                modal_frame = find('iframe')['name']
            
                within_frame(modal_frame) do
               
                    var_count_option = find('#CartaoID').all('option').count
                    var_rand = rand(1..var_count_option)
                    var_click_rand =  find('#CartaoID').all('option')[var_rand].click
                    banco = find('#CartaoID').all('option')[var_rand] .text

                    var_accessor.banco_dados_cheque = banco 
                
                    valor = find('#ValorC').value
                    
                    agencia = find('#TID').set('0000')
                    conta = find('#TNroCV').set('0000')
                    n_cheque = find('#TDocumento').set('00000')
                    nome_cheque = find('#NomeCheque').set('333')
              
                    find('#OK').click
                    
                    if Metodos.new.alert_present == true 

                        page.driver.browser.switch_to.alert.accept 

                        var_count_option = find('#CartaoID').all('option').count
                        var_rand = rand(1..var_count_option)
                        var_click_rand =  find('#CartaoID').all('option')[var_rand].click
                        banco = find('#CartaoID').all('option')[var_rand] .text
                        
                        find('#OK').click
                    end
                end
            end
        elsif argumento_metodo != 'Aleatorias'
            
            within('.highslide-body') do 
            
                modal_frame = find('iframe')['name']
            
                within_frame(modal_frame) do 
                    
                    find('#CartaoID').find('option', text: argumento_metodo).click
                    banco = find('#CartaoID').find('option', text: argumento_metodo).text
            
                    var_accessor.banco_dados_cheque = banco 
                    
                    valor = find('#ValorC').value
                    agencia = find('#TID').set('0000')
                    conta = find('#TNroCV').set('0000')
                    n_cheque = find('#TDocumento').set('00000')
                    nome_cheque = find('#NomeCheque').set('333')
    
                    find('#OK').click
                end
            end        
        end
    end



    def pre_pagamento(pre_autorizacao,var_accessor)
        
        if var_accessor.empresa_select != nil or var_accessor.agencia_select != nil 
            within_frame('app') do 
            
                if has_selector?('#BtnVoucher') == true 

                    find('#BtnVoucher').click            
                
                    name_frame = find('iframe')['name']
                    
                    within_frame(name_frame) do                 
                        
                        within('#frm_contrato_voucher') do 
                    
                            within('.tbl_resp') do 
                                x = all('tr', wait: 10 ).count 
                                
                                y = rand(0..x)
                                
                                Metodos.new.load_rapid(1)
                                
                                all('tr')[y].find("input[type='radio']", wait:10).click
                                
                                @voucher = all('td')[y].text        
                                
                            end                     
                            if @voucher == ' Pagamento Direto'

                                find('#OK').click

                            elsif @voucher == ' Faturamento e garantia total para empresa (inclusive apropriação indébita).'

                                find('#OK').click

                                Metodos.new.load_rapid(6)

                            end
                            $var = $var.to_s + "\n" + 'Voucher' + ': ' + @voucher
                        end
                    end  
                end
            end

            Selects.new.select_pre_autorization(pre_autorizacao,var_accessor)    
        
        else    
            
            Selects.new.select_pre_autorization(pre_autorizacao,var_accessor)
            
        end                
    end

end