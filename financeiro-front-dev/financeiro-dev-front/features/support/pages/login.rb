class Login

include Capybara::DSL

  def acesso_pagina
    visit($url)
    
    find(EL['login']).set($user)
    
    find(EL['senha']).set($password)
    
    
    # new_window = open_new_window
    # result = page.driver.browser.window_handles.last
    # page.driver.browser.switch_to.window(result)
    # visit 'https://homologacao.movida.com.br/qa/OP-SPRINT-10'
    
    # Metodos.new.save_reserv 
    
    binding.pry
    
    find(EL['ok']).click
    
    sleep 2

    find(EL['first_modal'], wait: 30).click

    find('#mmloja').click

    find('#filial_logon', wait: 20).click

    find('option', exact_text: 'SÃO PAULO - GUARULHOS AEROPORTO - (GRU)', wait: 20).click
    
    find('#dialog-filiais', wait: 20).all('input', wait: 20)[0].click
 
    $var = $var.to_s + "\n" + 'URL de Acesso' + ': ' + $url
    p $var
 
  end
end





