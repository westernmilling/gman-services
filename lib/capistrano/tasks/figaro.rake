require 'figaro'

namespace :figaro do
  task :load do
    Figaro.application = Figaro::Application.new(path: 'config/application.yml')
    Figaro.load
  end
end
