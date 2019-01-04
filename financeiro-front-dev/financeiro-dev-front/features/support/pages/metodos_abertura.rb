class Abertura 
    
    include Capybara::DSL
    
    def select_pagamento_reserva(pagamento_reserva,var_accessor)

        find('#Forma', wait: 10).set(pagamento_reserva)

        pagamento_selecionado = find('#Forma').value

        $var = $var.to_s + "\n" + 'Pagamento' + ': ' + pagamento_selecionado

    end

    def select_num_voo(num_voo,companhia_aerea,var_accessor)
        if companhia_aerea == 'WALK-IN'
           
            p 'Cenario nao requer numero de voo !!'
       
        elsif companhia_aerea != 'WALK - IN'
           
            find('#Voo', wait: 20).set(num_voo)
        
            $var = $var.to_s + "\n" + 'Numero do Voo' + ': ' + num_voo

        end
        
    end

    def select_companhia_aerea(companhia_aerea,var_accessor)
        if companhia_aerea != 'voo_aleatory'
            
            find('#CompanhiaAerea', wait: 10 ).set(companhia_aerea)
  
            Metodos.new.load_rapid(1)

            find('#CompanhiaAerea', wait: 10 ).native.send_keys(:enter)
       
            voo_selecionado = find('#CompanhiaAerea', wait: 10 ).value

            $var = $var.to_s + "\n" + 'Compainha Aerea' + ': ' + voo_selecionado

        elsif companhia_aerea == 'voo_aleatory'
                
            Metodos.new.load_rapid(1)
            
            find('#CompanhiaAerea', wait: 20).set('  ')

            Metodos.new.load_rapid(0)
 
            within(EL['el_dropdown']) do 
            
                var_count = all(EL['li_dropdown'], wait: 10).count
            
                var_rand = rand(1..var_count)
            
                Metodos.new.load_rapid(2)
 
                var_click_rand = all('.ui-menu-item', wait: 10)[var_rand].click
                                
            end 
            voo_selecionado = find('#CompanhiaAerea').value
            $var = $var.to_s + "\n" + 'Compainha Aerea' + ': ' + voo_selecionado
        end       
    end

    def select_grupo_car_modal(var_accessor)
        
        find('#Grupo').click    
        
        Metodos.new.load_rapid(1)            

        name_frame = find('iframe')['name']
        
        within_frame(name_frame) do 

            var_count =  all('.true').count
        if var_count == 0 
        
            $var = $var.to_s + "\n" + 'Categoria Carro' + ': ' + 'Nao existe tarifas disponiveis ! '
            
            raise 'Nao existe tarifas disponiveis'
        
        else
            var_rand =  rand(1..var_count)

            Metodos.new.load_rapid(2)            
                
            var_select = all("li[class='true']", wait: 20)[var_rand].click

            @grupo_selecionado = find('.true.ActiveGrupo').text
            
            $var = $var.to_s + "\n" + 'Categoria Carro' + ': ' + @grupo_selecionado
            
            cont = 0 
            
            while has_selector?('.alert.alert-danger', wait: 10 ) == true 
                
                $var = $var.to_s + "\n" + 'Grupo selecionado com problemas de tarifa....'
                   
                var_count =  all('.true').count
                var_rand =  rand(1..var_count)

                Metodos.new.load_rapid(1)            

                var_select = all('.true')[var_rand].click

                @grupo_selecionado = find('.true.ActiveGrupo').text

                cont += 1

                raise "Não foi possivel encontrar, tarifas disponiveis !!" if cont == 4
            
                $var = $var.to_s + "\n" + 'Tarifa Carro' + ': ' + @grupo_selecionado

                end
            end                                  
            find("button[id='EscolherTarifa']").click
        end
    end
    
    def select_local_retirada(local_retirada,var_accessor)
        if local_retirada == 'local_retirada_aleatory'

          localRetirada = DATA['locais_retirada'].sample
          
          find('#Local_Retirada').set(localRetirada)
          
          locais_retirada_sample =  find(EL['el_dropdown'], wait: 10 ).all('a')[0].text            
          
          var_accessor.localRetirada = "#{locais_retirada_sample} - (#{localRetirada})"

          Metodos.new.load_rapid(1)            
          
          find('#Local_Retirada', wait: 10 ).native.send_keys(:enter)

            $var = $var.to_s + "\n" + 'Local de Retirada' + ': ' + locais_retirada_sample

        elsif local_retirada.include?('Local:')
            
            local =  locais_retirada.split(':')

            find('#Local_Retirada', wait: 10 ).set(local[1])

            Metodos.new.load_rapid(1)            
            
            find('#Local_Retirada', wait: 10 ).native.send_keys(:enter)
            
            $var = $var.to_s + "\n" + 'Local de Retirada' + ': ' + local_retirada

        elsif local_retirada == 'nil'

            p 'Cenario nao requer local de retirada !!'            
            $var = $var.to_s + "\n" + 'Local de Retirada' + ': ' + 'Cenario nao requer local de retirada !!'

        end
    end

    def select_reserva(reserva,var_accessor)
       
        if var_accessor.localRetirada != nil
            
            find('#mmloja').click
            
            find('#filial_logon', wait: 20).find('option', exact_text: var_accessor.localRetirada, wait: 20).click
            
            find('#dialog-filiais', wait: 20).all('input', wait: 20)[0].click
            
        end
        
        within_frame('app') do 
            
            if reserva == 'Numero_reserva_capturada'
                
                sleep 2
                
                if has_selector?('#ReservaID') == false

                    raise "Pagina em branco apos alterar filial !!"
                end
               
                find('#ReservaID', wait: 10 ).set(var_accessor.num_reserva)
                
                find('#ReservaID', wait: 10 ).native.send_keys(:tab)               
                    
                if has_selector?('.msg.warning', text:'aberto para este número de Reserva') == true 
                    
                end

                $var = $var.to_s + "\n" + 'Numero de Reserva' + ': ' + var_accessor.num_reserva
                
            elsif reserva.include?('Reserva:') == true 
                    
                    reserva_selecionada = reserva.split(':')
                    
                    find('#ReservaID', wait: 10 ).set(reserva_selecionada[1])
                    
                    $var = $var.to_s + "\n" + 'Numero de Reserva' + ': ' + reserva
                    
                    
            elsif reserva == 'nil'
                    
                    p 'Cenario nao requer reserva !!' 
                    
                    $var = $var.to_s + "\n" + 'Numero de Reserva' + ': ' + 'Cenario nao requer reserva !!'
                    
            end 
         end
    end
        
    def select_contrato(contrato,var_accessor)
        within_frame('app') do 
                
            if contrato == 'Numero_contrato_gerado'
                    
                find('#ContratoNro', wait: 10 ).set(var_accessor.somente_num_status)
                
                $var = $var.to_s + "\n" + 'Contrato' + ': ' + var_accessor.somente_num_status
                
                var_accessor.contrato_select = contrato
            
            elsif contrato.include?('Contrato:') == true 
            
                contrato_selecionado = contrato.split(':')

                find('#ContratoNro', wait: 10 ).set(contrato_selecionado[1])

                find('#ContratoNro', wait: 10 ).native.send_keys(:tab)

                var_accessor.contrato_select = contrato

                $var = $var.to_s + "\n" + 'Contrato' + ': ' + contrato

            elsif contrato == 'nil' 
            
                p 'Cenario nao requer contrato!!' 
                $var = $var.to_s + "\n" + 'Numero de Contrato' + ': ' + 'Cenario nao requer Contrato !!'

            elsif var_accessor.contratos_devolucao != nil 
                
                find('#ContratoNro', wait: 10 ).set(var_accessor.contratos_devolucao)

                
            
            
            
            end        
        end
    end

    def select_agencia(agencia,var_accessor)

        if agencia == 'agencia_aleatory'

            p 'informaçoes aleatorias'
        
        elsif agencia == 'nil'
            
            p 'Cenario nao requer agencia'
            
            $var = $var.to_s + "\n" + 'Agencia' + ': ' + 'Cenario nao requer Agencia !!'

        elsif agencia.include?('Agencia:')
            
            agencia_selecionada = agencia.split(':')

            find('#Agencia', wait: 10).set(agencia_selecionada[1])
            
            Metodos.new.load_rapid(1)           
           
            if has_selector?('.ui-menu-item') == false 
            
                1.times do 
                    find('#Agencia').native.send_keys(:backspace)
                end

                Metodos.new.load_rapid(1)           

                find('#Agencia', wait: 10).native.send_keys(:enter)
                
            else
                
                find('#Agencia', wait: 10).native.send_keys(:enter)
                
            end 
                
            agencia2 = find('#Agencia', wait: 10).value

            find('#Agencia', wait: 10).native.send_keys(:tab)

            var_accessor.agencia_select = agencia2
            
            $var = $var.to_s + "\n" + 'Agencia' + ': ' + var_accessor.agencia_select
        end

    end

    def select_empresa(empresa,var_accessor)
       if empresa == 'empresa_aleatory' 

        find('#Empresa', wait: 10).set('  ')


       elsif empresa == 'nil'
            
            p 'Cenario nao requer empresa !'
    
            $var = $var.to_s + "\n" + 'Empresa' + ': ' + 'Cenario nao requer empresa !'
        
       elsif empresa.include?('Empresa:')

            empresa_selecionada = empresa.split(':')
                        
            find('#Empresa', wait: 10).set(empresa_selecionada[1])
            
            Metodos.new.load_rapid(2)           

            if has_selector?('.ui-menu-item') == false 
            
                1.times do 
                    find('#Empresa').native.send_keys(:backspace)
                end

                find('#Empresa', wait: 10).native.send_keys(:enter)
                
            else
               
                find('#Empresa', wait: 10).native.send_keys(:enter)

            end 
        

            empresa2 = find('#Empresa', wait: 10).value

            find('#Empresa', wait: 10).native.send_keys(:tab)
        
            if has_selector?('#dialog') == true 
            
                click_button('Ciente')  

            end

            var_accessor.empresa_select = empresa2

           $var = $var.to_s + "\n" + 'Empresa' + ': ' + var_accessor.empresa_select

        end
    end

    def select_placa_com_reserva(var_accessor)
        
        within_frame('app') do 
            
            find('#Frota').set(' ')

            sleep 2

            if has_selector?('.ui-menu-item',text: 'Veículos não encontrado') == true 

                while has_selector?('.ui-menu-item',text: 'Veículos não encontrado') == true 

                    find('#GrupoID').click

                    var_count_option = find('#GrupoID', wait:10).all('option', wait: 10).count
                    
                    var_rand = rand(1..var_count_option)
                
                    Metodos.new.load_rapid(0)
                    
                    find('#GrupoID', wait:10).all('option', wait:20)[var_rand].click

                    Metodos.new.load_rapid(0)
            
                    if has_selector?('.highslide-html-content') == true 
                        
                        name_frame = find('iframe')['name'] 
                        
                        within_frame(name_frame) do 
                            find('#MotID').find('option', text: 'Indisponibilidade').click
                            
                            find('#OK', wait: 10 ).click
                        end
                    end
                    
                    find('#GrupoID').click

                    find('#Frota').set(' ')

                    break if has_selector?('.ui-menu-item',text: 'Veículos não encontrado') == false

                end
            
            else 

                find('#Frota').set(' ')

                var_count_option = find(EL['el_dropdown'], wait: 10).all(EL['li_dropdown'], wait: 10).count
            
                p var_count_option
        
                var_rand = rand(1..var_count_option)
            
                if var_count_option == 1 

                    within(EL['el_dropdown'], wait: 10, visible:true) do
                
                    all(EL['li_dropdown'], wait: 10)[0].click
                
                    end
            
                else                 
                
                    within(EL['el_dropdown'], wait: 10, visible:true) do
                
                        all(EL['li_dropdown'], wait: 10, match: :prefer_exact)[var_rand].click
                
                    end
                 end
            
            end
            placa_selecionada = find('#Frota').value
            
            var_accessor.placa_selecionada = placa_selecionada
            
            $var = $var.to_s + "\n" + 'Placa selecionada' + ': ' + var_accessor.placa_selecionada
            p $var
        
        end
    end

    def select_placa(placa,car,var_accessor)
        obj_selects = Selects.new
        if placa == 'placa_aleatory'
          find('#Frota').set(' ')
          
          cont = 0
            while cont < 4 && has_selector?('.ui-menu-item',text: 'Veículos não encontrado') == true 
                Abertura.new.select_group_cars(car,var_accessor)
            
                cont += 1
                
                find('#Frota').set(' ')
                
                raise 'Nao foi encontrado placas disponiveis nas ultimas 4 tentativas !!!' if cont == 4                
            end
            
          var_count_option = find(EL['el_dropdown'], wait: 10).all(EL['li_dropdown'], wait: 10).count - 1
        
          p var_count_option
       
          var_rand = rand(0..var_count_option)
          
        if var_count_option == 1 

            within(EL['el_dropdown'], wait: 10, visible:true) do
            
                all(EL['li_dropdown'], wait: 10)[0].click
            
                if has_selector?('#dialog') == true 
                    
                    find("span[class='ui-button-text']", text: 'CONTINUAR').click   
                end
            end
        
        else        
            
            within(EL['el_dropdown'], wait: 10, visible:true) do
            
                all(EL['li_dropdown'], wait: 10, visible:true)[var_rand].click
            end
            
            if has_selector?('#dialog') == true 
                
                find("span[class='ui-button-text']", text: 'CONTINUAR').click   
            end
        end
          
          placa_selecionada = find('#Frota').value
          
          var_accessor.placa_selecionada = placa_selecionada
          
          $var = $var.to_s + "\n" + 'Placa selecionada' + ': ' + var_accessor.placa_selecionada
          p $var

        elsif placa != 'placa_aleatory'

            find('#Frota').set(' ')

            if has_selector?('.ui-menu-item',text: 'Veículos não encontrado') == true 
          
                raise "Veiculos não encontrados para grupo: #{var_accessor.grupo_carro} !!"
              
            end
    
              find('#Frota').set(' ')
              
            if has_selector?(EL['el_dropdown'], wait: 10, text: placa) == false 
                 
                raise "Placa #{placa}. Não encontrada !!"

            end

            find(EL['el_dropdown'], wait: 10).find(EL['li_dropdown'], wait: 10, text: placa).click
            
            if has_selector?('#dialog') == true 
                    
                find("span[class='ui-button-text']", text: 'CONTINUAR').click   
            end
            
            placa_selecionada = find('#Frota')['old']
              
            var_accessor.placa_especifc = placa_selecionada
        
            $var = $var.to_s + "\n" + 'Placa selecionar' + ': ' + var_accessor.placa_especifc
            p $var
        
        end
    end
  
    def select_pagamento(pagamento,var_accessor)        
        if pagamento == 'pay_aleatory'
  
            find('#InfoFormaID').click #InfoFormaID
                
            var_count_option = find('#InfoFormaID').all('option').count - 1
            
            var_rand = rand(0..var_count_option)
                
            p var_rand 
            
            for i in (0..4) do 
                sleep 1 
                 p 'Aguarde...'
            end
                
            var_click_rand =  find('#InfoFormaID', wait: 10).all('option', wait: 10)[var_rand].click
        
            find('.ui-button-text', wait: 10).click
        
            type_pagamento = find('#InfoFormaID').value 
                    
            type_pagamento2 =  Metodos.new.convert_value_pagamento(type_pagamento)
                
            var_accessor.tipo_pagamento = type_pagamento2
        
            $var = $var.to_s + "\n" + 'Tipo de Pagamento' + ': ' + var_accessor.tipo_pagamento
            p $var

        elsif pagamento != 'pay_aleatory'
                
            if pagamento.include?('cartao') == true 
            
                find('#InfoFormaID').click
                
                forma_pagamento = pagamento.split('/')
        
                clicks = forma_pagamento[1].to_i 
                
                clicks.times do
                find('#InfoFormaID').native.send_keys(:down)
                end
            
                find('#InfoFormaID').native.send_keys(:enter)
                
                find('.ui-button-text', wait: 10).click

                type_pagamento = find('#InfoFormaID').value 
                    
                type_pagamento2 =  Metodos.new.convert_value_pagamento(type_pagamento)
                    
                var_accessor.pagamento_especifc = type_pagamento2
                
                $var = $var.to_s + "\n" + 'Tipo de Pagamento' + ': ' + var_accessor.pagamento_especifc
                p $var
                
            else 
                    
                find('#InfoFormaID').click
                    
                find('#InfoFormaID').find('option', text: pagamento).click

                find('.ui-button-text', wait: 10).click
                
                type_pagamento = find('#InfoFormaID').value 
                    
                type_pagamento2 =  Metodos.new.convert_value_pagamento(type_pagamento)
                    
                var_accessor.pagamento_especifc = type_pagamento2
                    
                $var = $var.to_s + "\n" + 'Tipo de Pagamento' + ': ' + var_accessor.pagamento_especifc
                p $var
             
            end
        end
    end

    def select_tarifas(tarifa,car,var_accessor)
    
        if tarifa == 'tarifa_aleatory'
                
            find('#TabelaID').click
        
            if has_selector?('#TabelaID', text: EL['tarifa_nao_aplicada']) == true 

                while has_selector?('#TabelaID', text: EL['tarifa_nao_aplicada']) == true
                    
                    Abertura.new.select_group_cars(car,var_accessor)
        
                    find('#TabelaID').click
                    break if has_selector?('#TabelaID', text: EL['tarifa_nao_aplicada']) == false
                end            
                    
                    var_count_option = find('#TabelaID').all('option').count

                    p var_count_option

                    var_rand = rand(0..var_count_option)
                    
                    p var_rand
                    
                    var_rand.times do 
                        find('#TabelaID').native.send_keys(:down)
                    end
                
                    find('#TabelaID').native.send_keys(:enter)

                    Metodos.new.load_rapid(0)           
 
                    tarifa_alterada = find('#TabelaID').value

                    tarifa_alterada2 = find("option[value= '#{tarifa_alterada}']").text

                    var_accessor.tarifa_aplicada = tarifa_alterada2
                    $var = $var.to_s + "\n" + 'Tarifa Aplicada' + ': ' + var_accessor.tarifa_aplicada
                    p $var 
    
            else  
               
                var_count_option = find('#TabelaID').all('option').count 
                 
                 var_rand = rand(0..var_count_option)
                 
                 p var_rand
                 
                 var_rand.times do 
                    
                    find('#TabelaID').native.send_keys(:down)
                
                end
                
                find('#TabelaID').native.send_keys(:enter)
                                
                tarifa_alterada = find('#TabelaID').text

                var_accessor.tarifa_aplicada = tarifa_alterada

                $var = $var.to_s + "\n" + 'Tarifa Aplicada' + ': ' + var_accessor.tarifa_aplicada
                p $var 
            end

         elsif tarifa != 'tarifa_aleatory' 
            
            find('#TabelaID').find('option', text: tarifa).click
                                    
            tarifa_alterada = find('#TabelaID').text
                    
            var_accessor.tarifa_aplicada = tarifa_alterada
            
            $var = $var.to_s + "\n" + 'Tarifa Aplicada' + ': ' + var_accessor.tarifa_aplicada
            p $var  
        end
    end
    
    def select_devolucao_retirada(retirada,devolucao,var_accessor)

        obj_simple = Metodos.new

        if retirada.include?('/') && devolucao.include?('/')
         
            obj_simple.preenche_campos('Id_retirada',retirada)
            obj_simple.preenche_campos('Id_devolucao',devolucao)

            $var = $var.to_s + "\n" + 'Data/Horário de retirada' + ': ' + retirada
            p $var 
            $var = $var.to_s + "\n" + 'Data/Horário de devolução' + ': ' + devolucao
            p $var 
        
        elsif retirada.include?('mensal') && devolucao.include?('mensal') 

            Times.new.gera_datas(var_accessor,retirada,devolucao)

            obj_simple.preenche_campos('Id_retirada',var_accessor.retirada)
            obj_simple.preenche_campos('Id_devolucao',var_accessor.devolucao)
           
            $var = $var.to_s + "\n" + 'Data/Horário de retirada' + ': ' + var_accessor.retirada
            p $var 
            $var = $var.to_s + "\n" + 'Data/Horário de devolução' + ': ' + var_accessor.devolucao
            p $var
       
        elsif retirada.include?('aleatory') && devolucao.include?('aleatory')
           
            Times.new.gera_datas(var_accessor,retirada,devolucao)
                                   
            obj_simple.preenche_campos('Id_retirada',var_accessor.retirada)
            obj_simple.preenche_campos('Id_devolucao',var_accessor.devolucao)

            $var = $var.to_s + "\n" + 'Data/Horário de retirada' + ': ' + var_accessor.retirada
            p $var 
            $var = $var.to_s + "\n" + 'Data/Horário de devolução' + ': ' + var_accessor.devolucao
            p $var
       
            
        end
    end

    def select_group_cars(car,var_accessor)

            if car == 'car_aleatory'
                
                find('#GrupoID').click

                var_count_option = find('#GrupoID', wait:10).all('option', wait: 10).count
                
                var_rand = rand(1..var_count_option)
               
                Metodos.new.load_rapid(0)
                
                var_click_rand = find('#GrupoID', wait:10).all('option', wait:20)[var_rand].click

                find('#GrupoID').click

                grupo_carro = find('#GrupoID').all('option')[var_rand].text
                
                var_accessor.grupo_carro = grupo_carro
            
                # find('#GrupoID').click

                $var = $var.to_s + "\n" + 'Grupo do Veiculo' + ': ' + var_accessor.grupo_carro
                p $var 

            elsif car != 'car_aleatory'
                
                find('#GrupoID').click

                if has_selector?('option', exact_text: car) == false 
                    
                    p "Carro nao encontrado. Selecionando disponivel..."
                
                    find('#GrupoID').click

                    var_count_option = find('#GrupoID').all('option').count
                
                    var_rand = rand(1..var_count_option)
                    
                    var_click_rand =  find('#GrupoID').all('option')[var_rand].click
                    
                    grupo_carro = find('#GrupoID').all('option')[var_rand] .text
                
                    var_accessor.car_especifc = grupo_carro
                    find('#GrupoID').click
                    
                    $var = $var.to_s + "\n" + 'Grupo do Veiculo' + ': ' + var_accessor.car_especifc
                        p $var 
        
                else
                    
                    find('#GrupoID').find('option',exact_text: car).click
                    
                    grupo_carro = find('#GrupoID').value 
                    var_accessor.car_especifc = grupo_carro
                    find('#GrupoID').click
                    
                    $var = $var.to_s + "\n" + 'Grupo do Veiculo' + ': ' + var_accessor.car_especifc
                        p $var 
        
                end
            end
    end

end


