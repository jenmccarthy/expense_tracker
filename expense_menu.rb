require './lib/expense.rb'
require './lib/category.rb'
require 'pg'
DB = PG.connect({:dbname => 'expense_organizer'})
def main_menu
  loop do
    puts "Press [a] to add a category to your expense organizer"
    puts "Press [l] to list all your expense categories"
    puts "Press [x] to exit"
    if menu_choice == 'a'
      #add category method
    elsif menu_choice == 'l'
      #list category method
    elsif menu_choice == 'x'
      puts "Goodbye!"
    else
      puts "That is not a valid input, please choose again"
    end
  end
end
main_menu




