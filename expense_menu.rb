require './lib/expense.rb'
require './lib/category.rb'
require 'pg'
require 'pry'
DB = PG.connect({:dbname => 'expense_organizer'})

def category_menu
  list_all_categories
  puts "\nPress [a] to enter the name of a new category:"
  puts "Press [e] to go to the expense menu"
  menu_choice = gets.chomp
  if menu_choice == 'a'
    create_category
  else
    expense_menu
  end
end

def list_all_categories
  if Category.all.empty?
    puts "Please add a category"
    create_category
  else
    Category.all.each_with_index do |cat, index|
      name = cat.name
      puts "[#{index + 1}] #{name}\n\n"
    end
  end
end

def list_all_expenses
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
end

def expense_menu
    list_all_expenses
    puts"\n\n"
    puts "Press [a] to add an expense"
    puts "Press [c] to view a category's spending"
    puts "Press [x] to exit"
    menu_choice = gets.chomp
    if menu_choice == 'a'
      add_expense
    elsif menu_choice == 'c'
      check_category
    elsif menu_choice == 'x'
      exit
      puts "Goodbye!"
    else
      puts "That is not a valid input, please choose again"
    end
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
  list_all_categories
  input_category = gets.chomp.to_i
  Category.all.each_with_index do |cat, index|
    if index == (input_category - 1)
      new_expense.add_cat(cat.id)
      break
    else
      puts "Sorry! Choose another option."
    end
  end
  puts "\nYour expense has been added\n\n"
end

def create_category
  puts "Please enter a new category type:"
  input_category = gets.chomp
  puts "Please enter a monthly budget for this category:"
  budget = gets.chomp
  new_category = Category.new({'name' => input_category, 'budget' => budget})
  new_category.save
  puts "Your category has been added!"
  puts "\n\n"
  category_menu
end

def check_category
  list_all_categories
  puts "Which category would you like to view?"
  cat_choice = gets.chomp.to_i
  Category.all.each_with_index do |cat, index|
    if index == (cat_choice - 1)
      results = cat.expenses
      results.each do |result|
        date = result.date
        description = result.description
        amount = result.amount
        puts "#{date} -- #{description} -- #{amount}"
        puts "******************************************************"
      break
      end
      break
    else
      puts "Sorry! Input a valid option."
      break
    end
  end
end

# check category
# show all in category with total
# delete an expense
# edit an expense


category_menu




