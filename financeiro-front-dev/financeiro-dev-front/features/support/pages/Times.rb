class Times 

    include Capybara::DSL


    def gera_datas(var_accessor,ret,dev)

        if ret.include?('mensal') && dev.include?('mensal')

           ret = Time.now + 1000

           ret = Time.now.strftime('%d%m%Y %H%M')

           var_accessor.retirada = ret

           var_accessor.devolucao = Time.now + 2774400
           
           var_accessor.fds = var_accessor.devolucao.strftime('%A')
           
           self.detecta_fds(var_accessor)

        elsif ret.include?('aleatory') && dev.include?('aleatory')

            ret = Time.now + 1000
            ret = ret.strftime('%d%m%Y %H%M')
            
            var_accessor.retirada = ret

            var_accessor.devolucao = Time.now + 86700
            
            var_accessor.fds = var_accessor.devolucao.strftime('%A')
           
           self.detecta_fds(var_accessor)

        end
    end
     
    def detecta_fds(var_accessor)

        if var_accessor.fds == 'Sunday' 

            devolucao = Time.now - 86700
            
            var_accessor.devolucao = devolucao.strftime('%d%m%Y %H%M')

            if self.detecta_feriado(devolucao) == 'tem feriado'
                
                devolucao = Time.now - 86700
                
                var_accessor.devolucao = devolucao.strftime('%d%m%Y %H%M')
            
            else    

                var_accessor.devolucao = var_accessor.devolucao.strftime('%d%m%Y %H%M')
                
            end
            
        else
            
            var_accessor.devolucao = var_accessor.devolucao.strftime('%d%m%Y %H%M')

        end
    end

    def detecta_feriado(data)

        data = data.strftime('%Y, %m, %d')
      
        data = data.split(",")
      
        ano = data[0].to_i
          
        mes = data[1].to_i
          
        dia  = data[2].to_i
          
        feriado = Holidays.on(Date.civil(ano, mes, dia), :br)
                        
        if feriado.count == 0 
                
            p 'nao existe feriado'
                
        else
                
             p 'tem feriado'
                
        end
    end
      

    
end