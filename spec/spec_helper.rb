require 'rspec'
require 'expense'
require 'pg'
require 'pry'

DB = PG.connect({:dbname => 'expense_organizer_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM expenses * ;")
  end
end
