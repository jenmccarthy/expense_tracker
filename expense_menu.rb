require './lib/expense.rb'
require './lib/category.rb'
require 'pg'
DB = PG.connect({:dbname => 'expense_organizer'})

def main_menu
  if Expense.all.empty?
    puts "Choose an option"
  else
    Expense.all.each do |exp|
      description = exp.description
      amount = exp.amount
      date = exp.date
      puts "#{date} -- #{description} -- #{amount}\n\n"
    end
  end
  # loop do
    puts "Press [a] to add an expense"
    puts "Press [x] to exit"
    menu_choice = gets.chomp
    if menu_choice == 'a'
      add_expense
    elsif menu_choice == 'x'
      exit
      puts "Goodbye!"
    else
      puts "That is not a valid input, please choose again"
    end
  # end
end



def add_expense
  @categories = []
  puts "Please enter the date of your purchase YYYY-MM-DD:"
  input_date = gets.chomp
  puts "Please enter the description of your purchase:"
  input_description = gets.chomp
  puts "Please enter the amount spent:"
  input_amount = gets.chomp
  new_expense = Expense.new({'date' => input_date, 'description' =>input_description, 'amount' => input_amount})
  new_expense.save
  puts "What category is this expense:"
  input_category = gets.chomp
  if @categories.include?(input_category)
    new_expense.add_cat(@categories.index(input_category))
  else
    new_category = Category.new(input_category)
    @categories << new_category

    new_expense.add_cat(new_category.id)
  end
  puts "\nYour expense has been added\n\n"
end


# check category
# show all in category with total
# delete an expense
# edit an expense


main_menu




