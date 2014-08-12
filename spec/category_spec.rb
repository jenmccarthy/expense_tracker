require 'spec_helper'

describe 'Category' do

  it 'will initialize a Category instance with attributes' do
    test_category = Category.new({'name' => 'food', 'budget' => 100})
    expect(test_category).to be_an_instance_of Category
  end

  it 'will start with an empty array' do
    expect(Category.all).to eq []
  end

  it 'will save a new instance of Category' do
    test_category = Category.new({'name' => 'food', 'budget' => 100})
    test_category.save
    expect(Category.all).to eq [test_category]
  end

  it 'will be the same thing if it has the same name' do
    test_category1 = Category.new({'name' => 'food', 'budget' => 100})
    test_category2 = Category.new({'name' => 'food', 'budget' => 100})
    expect(test_category1).to eq test_category2
  end

  it 'will list out all expenses in the same category' do
    test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '2014-03-14'})
    test_expense.save
    test_expense1 = Expense.new({'description' => 'Drinks', 'amount' => 30.00, 'date' => '2014-05-15'})
    test_expense1.save
    test_expense2 = Expense.new({'description' => 'Shoes', 'amount' => 50.00, 'date' => '2014-05-12'})
    test_expense2.save
    test_category = Category.new({'name' => 'Dining', 'budget' => 100})
    test_category.save
    test_expense.add_cat(test_category.id)
    test_expense1.add_cat(test_category.id)
    expect(test_category.expenses).to eq [test_expense, test_expense1]
  end

  it 'will tell what percentage of all expenses are being spent in a category' do
    test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '2014-03-14'})
    test_expense.save
    test_expense1 = Expense.new({'description' => 'Drinks', 'amount' => 30.00, 'date' => '2014-03-23'})
    test_expense1.save
    test_expense2 = Expense.new({'description' => 'Shoes', 'amount' => 50.00, 'date' => '2014-05-12'})
    test_expense2.save
    test_category = Category.new({'name' => 'Dining', 'budget' => 100})
    test_category.save
    test_expense.add_cat(test_category.id)
    test_expense1.add_cat(test_category.id)
    expect(test_category.category_percent).to eq 45
  end

  it 'will list out all monies spent in a specific category' do
    test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '2014-03-14'})
    test_expense.save
    test_expense1 = Expense.new({'description' => 'Drinks', 'amount' => 30.00, 'date' => '2014-05-15'})
    test_expense1.save
    test_expense2 = Expense.new({'description' => 'Shoes', 'amount' => 50.00, 'date' => '2014-05-12'})
    test_expense2.save
    test_category = Category.new({'name' => 'Dining', 'budget' => 100})
    test_category.save
    test_expense.add_cat(test_category.id)
    test_expense1.add_cat(test_category.id)
    expect(test_category.money_spent).to eq 40.99
  end

  it 'will compare the money spent in a category to the budget and return the amount left over or overdrawn' do
    test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '2014-03-14'})
    test_expense.save
    test_expense1 = Expense.new({'description' => 'Drinks', 'amount' => 30.00, 'date' => '2014-05-15'})
    test_expense1.save
    test_expense2 = Expense.new({'description' => 'Shoes', 'amount' => 50.00, 'date' => '2014-05-12'})
    test_expense2.save
    test_category = Category.new({'name' => 'Dining', 'budget' => 100})
    test_category.save
    test_expense.add_cat(test_category.id)
    test_expense1.add_cat(test_category.id)
    expect(test_category.in_budget).to eq 59.01
  end

end
