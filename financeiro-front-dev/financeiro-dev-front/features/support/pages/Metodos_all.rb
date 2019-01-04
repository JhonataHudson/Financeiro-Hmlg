class Metodos
  
    include Capybara::DSL
    
  
      def load_rapid(segundos)
          for e in (0..segundos) do 
              sleep 1
              p 'Aguarde...'
           end
      end
  
  
      def save_reserv
          numero_reserva = find('#login_barra').text
          File.open('data/reservas.txt', 'a') do |file|
              file.write("\n#{numero_reserva}")
          end
      end
  
      def save_text_all(var_accessor,produto,informacao)
          File.open('data/reports/contrato_reserva.txt', 'a') do |file|
          file.write("\nNumero #{produto}:#{informacao}\t\t\t")
          file.write(Time.now)
          end
      end
  
      def preenche_campos(elemento,conteudo)
        
        find(EL[elemento], wait: 10).set(conteudo)
        
      end
     
      def captura_status_contrato(var_accessor)
          var_accessor.status_contrato = within_frame('app') do
              find('#InfoGeral').find('tbody').all('td')[1].text
          end
          var_accessor.somente_num_status = var_accessor.status_contrato.delete('  Aberto')
          Metodos.new.save_text_all(var_accessor,'Contrato',var_accessor.somente_num_status)
      end
  
      def detecta_produto_adicional(var_accessor)
          if var_acessor.produto_adicional.include?('Bebê Conforto')
          
          elsif var_acessor.produto_adicional.include?('Booster')
          
          elsif var_acessor.produto_adicional.include?('Cadeira de Bebê')
          
          elsif var_acessor.produto_adicional.include?('GPS')
          
          elsif var_acessor.produto_adicional.include?('Movida WiFi')
          
          elsif var_acessor.produto_adicional.include?('Movida Connect')
          
          end
      
      end
  
      def alert_present
          alert_status = ''
          begin
            wait = Selenium::WebDriver::Wait.new(:timeout => 1)
            wait.until {
              begin
                page.driver.browser.switch_to.alert
                alert_status = true
              rescue Selenium::WebDriver::Error::NoSuchAlertError
                alert_status = false
              end
            }
          rescue Selenium::WebDriver::Error::TimeOutError
          end
          alert_status
        end
      
    def convert_value_pagamento(pagamento_atribuido) 
        
        if pagamento_atribuido == '2'
          pagamento_atribuido = 'Cartão de crédito 2x (Visa)'
        
        elsif pagamento_atribuido == '1' 
          pagamento_atribuido = 'Cartão de crédito 1x (Visa)'
        
        elsif pagamento_atribuido == '3' 
          pagamento_atribuido = 'Cartão de crédito 3x (Visa)'
        
        elsif pagamento_atribuido == '4' 
          pagamento_atribuido = 'Cartão de crédito 4x (Visa)'
        
        elsif pagamento_atribuido == '5' 
          pagamento_atribuido = 'Cartão de crédito 5x (Visa)'
        
        elsif pagamento_atribuido == '6' 
          pagamento_atribuido = 'Cartão de crédito 6x (Visa)'
        
        elsif pagamento_atribuido == '13' 
          pagamento_atribuido = 'Cartão de crédito 7x (Visa)'
        
        elsif pagamento_atribuido == '14' 
          pagamento_atribuido = 'Cartão de Crédito 8x (Visa)'
        
        elsif pagamento_atribuido == '15' 
          pagamento_atribuido = 'Cartão de Crédito 9x (Visa)'
        
        elsif pagamento_atribuido == '16' 
          pagamento_atribuido = 'Cartão de Crédito 10x (Visa)'
        
        elsif pagamento_atribuido == '9' 
          pagamento_atribuido = 'Dinheiro'
        
        elsif pagamento_atribuido == '7' 
          pagamento_atribuido = 'Cheque (Cliente Seguradoras)'
        
        elsif pagamento_atribuido == '8' 
          pagamento_atribuido = 'Débito'
        
        elsif pagamento_atribuido == '12' 
          pagamento_atribuido = 'Faturamento'
        end
      end  
      
      def captura_numero_de_serie(var_accessor,status_produto)
      
          within_frame('app') do 
              within_frame('equipamentos') do 
                  find('#BuscaTipo').find('option', text: var_accessor.produto_adicional).click
                      x = all("img[alt='status_produto']").count
                      y = rand(0..x)
                      z = all("img[alt='status_produto']")[y].click
                
                      var_accessor.numero_serie = find('#NroSerie').value   
              end
          end
      end
      def convert_value_tarifa(tarifa_atribuida)
    
        if tarifa_atribuida == '14905'
            tarifa_atribuida = '10IPIT - 10 - IPIRANGA 2016A (0)'
        
        elsif tarifa_atribuida == '2373' 
            tarifa_atribuida = 'CPSAB - CLUBE PORTO SEGURO AB (0)'
        
        elsif tarifa_atribuida == '13114' 
            tarifa_atribuida = 'CJSL18 - COLABORADOR JSL 2018 (0)'
        
        elsif tarifa_atribuida == '14890' 
            tarifa_atribuida = 'MB1104 - MOBILE 1104 (0)'
        
        elsif tarifa_atribuida == '6917' 
            tarifa_atribuida = 'MBE15 - MOBILE 15 (1)'
        
        elsif tarifa_atribuida == '6200' 
            tarifa_atribuida = 'PF1 - PESSOA FISICA 1 (1)'
        
        elsif tarifa_atribuida == '6229' 
            tarifa_atribuida = 'PF10 - PESSOA FISICA 10 (1)'
        
        elsif tarifa_atribuida == '6899' 
            tarifa_atribuida = 'PF11 - PESSOA FISICA 11 (1)'
        
        elsif tarifa_atribuida == '6900' 
            tarifa_atribuida = 'PF12 - PESSOA FISICA 12 (1)'
        
        elsif tarifa_atribuida == '6901' 
            tarifa_atribuida = 'PF13 - PESSOA FISICA 13 (1)'
        
        elsif tarifa_atribuida == '6902' 
            tarifa_atribuida = 'PF14 - PESSOA FISICA 14 (1)'
        
        elsif tarifa_atribuida == '6903' 
            tarifa_atribuida = 'PF15 - PESSOA FISICA 15 (1)'
        
        elsif tarifa_atribuida == '6234' 
            tarifa_atribuida = 'PF15 - PESSOA FISICA 16 (1)'
        
        elsif tarifa_atribuida == '6233' 
            tarifa_atribuida = 'PF15 - PESSOA FISICA 17 (1)'
        
        elsif tarifa_atribuida == '6232' 
            tarifa_atribuida = 'PF15 - PESSOA FISICA 18 (1)'
        
        elsif tarifa_atribuida == '6235' 
            tarifa_atribuida = 'PF15 - PESSOA FISICA 19 (1)'
    
        elsif tarifa_atribuida == '14924' 
            tarifa_atribuida = 'PF1AS - PESSOA FISICA 1A (0)'

        elsif tarifa_atribuida == '6158' 
            tarifa_atribuida = 'PF2 - PESSOA FISICA 2 (1)'

        elsif tarifa_atribuida == '6236' 
            tarifa_atribuida = 'PF20 - PESSOA FISICA 20 (1)'

        elsif tarifa_atribuida == '6395' 
            tarifa_atribuida = 'PF21 - PESSOA FISICA 21 (1)'

        elsif tarifa_atribuida == '6237' 
            tarifa_atribuida = 'PF23 - PESSOA FISICA 23 (1)'

        elsif tarifa_atribuida == '6238' 
            tarifa_atribuida = 'PF24 - PESSOA FISICA 24 (1)'

        elsif tarifa_atribuida == '6239' 
            tarifa_atribuida = 'PF25 - PESSOA FISICA 25 (1)'

        elsif tarifa_atribuida == '6905' 
            tarifa_atribuida = 'PF27 - PESSOA FISICA 27 (1)'

        elsif tarifa_atribuida == '6907' 
            tarifa_atribuida = 'PF29 - PESSOA FISICA 29 (1)'

        elsif tarifa_atribuida == '6201' 
            tarifa_atribuida = 'PF3 - PESSOA FISICA 3 (1)'

        elsif tarifa_atribuida == '6908' 
            tarifa_atribuida = 'PF30 - PESSOA FISICA 30 (1)'

        elsif tarifa_atribuida == '14906' 
            tarifa_atribuida = 'PF31T - PESSOA FISICA 31 (0)'

        elsif tarifa_atribuida == '9887' 
            tarifa_atribuida = 'PF32 - PESSOA FISICA 32 (0)'

        elsif tarifa_atribuida == '9888' 
            tarifa_atribuida = 'PF33 - PESSOA FISICA 33 (0)'

        elsif tarifa_atribuida == '9889' 
            tarifa_atribuida = 'PF34 - PESSOA FISICA 34 (0)'

        elsif tarifa_atribuida == '14908' 
            tarifa_atribuida = 'PF34T - PESSOA FISICA 34 (0)'

        elsif tarifa_atribuida == '9890' 
            tarifa_atribuida = 'PF35 - PESSOA FISICA 35 (0)'

        elsif tarifa_atribuida == '10060' 
            tarifa_atribuida = 'PF36 - PESSOA FISICA 36 (0)'

        elsif tarifa_atribuida == '11134' 
            tarifa_atribuida = 'PF37 - PESSOA FISICA 37 (0)'

        elsif tarifa_atribuida == '6202' 
            tarifa_atribuida = 'PF4 - PESSOA FISICA 4 (1)'

        elsif tarifa_atribuida == '6203' 
            tarifa_atribuida = 'PF5 - PESSOA FISICA 5 (1)'

        elsif tarifa_atribuida == '6394' 
            tarifa_atribuida = 'PF6 - PESSOA FISICA 6 (1)'
        
        elsif tarifa_atribuida == '6396' 
            tarifa_atribuida = 'PF7 - PESSOA FISICA 7 (1)'
            
        elsif tarifa_atribuida == '6231' 
            tarifa_atribuida = 'PF8 - PESSOA FISICA 8 (1)'
            
        elsif tarifa_atribuida == '6230' 
            tarifa_atribuida = 'PF9 - PESSOA FISICA 9 (1)'
        
        elsif tarifa_atribuida == '14913' 
            tarifa_atribuida = 'PF9B - PESSOA FISICA 9B (0)'
        
        elsif tarifa_atribuida == '14915' 
            tarifa_atribuida = 'PF9D - PESSOA FISICA 9D (0)'

        elsif tarifa_atribuida == '14916' 
            tarifa_atribuida = 'PF9E - PESSOA FISICA 9E (0)'

        elsif tarifa_atribuida == '14919' 
            tarifa_atribuida = 'PMT01 - PESSOA MARCIO TESTE1 (0)'

        elsif tarifa_atribuida == '14923' 
            tarifa_atribuida = 'PFSAP - PESSOA SAP (0)'
            
        elsif tarifa_atribuida == '14889' 
            tarifa_atribuida = 'PF1104 - PF 1104 (0)'
        
        elsif tarifa_atribuida == '14925' 
            tarifa_atribuida = 'TST09 - TARIFA TESTE 0911 (0)'

        end
    end  
  
  
end