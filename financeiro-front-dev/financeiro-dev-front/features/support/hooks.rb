require 'yaml'
require 'pry'
require 'capybara/cucumber'
require 'report_builder'


Before do 
  page.driver.browser.manage.window.maximize
  @geradores = Geradores.new
  @selects = Selects.new
  @login = Login.new
end



After do |scn|
  puts $var
  puts 'As variaveis nao foram informadas. ' if $var.nil?
  $var = ''
end

at_exit do
  ReportBuilder.configure do |config|
    t = Time.now
    t.to_s
    config.input_path = 'data/reports'
    config.report_path = 'data/reports/REPORT_MOVIDA ' + t.strftime('%d_%m_%y') + ' ' + t.strftime('%H_%M_%S')
    config.report_types = [:html]
    config.report_title = 'REPORT MOVIDA '
    config.additional_info = { browser: 'Chrome', environment: 'Stage 5', Data_execução: t.strftime('%d/%m/%y'), Horário_Conclusão: t.strftime('%H:%M:%S') }
    config.include_images = true
  end
  ReportBuilder.build_report
end


AfterStep do |scn|
  target = "data/reports/imagens/telas_captura.png"
  page.save_screenshot(target)
  embed(target, 'image/png', 'Evidência')
end

After do |scn|
  file_name = scn.name.tr(' ', '_').downcase!
  target = "data/reports/imagens/#{file_name}.png"
  if scn.failed?
    page.save_screenshot(target)
    embed(target, 'image/png', 'Evidência')
  elsif scn.passed?
    page.save_screenshot(target)
    embed(target, 'image/png', 'Evidência')
  end
  page.driver.quit
end

After do
  page.driver.browser.manage.delete_all_cookies
 end
  
  After do |scn|
    if scn.failed?
      binding.pry
    end
 end