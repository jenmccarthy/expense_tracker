require 'spec_helper'

describe 'Category' do

  it 'will initialize a Category instance with attributes' do
    test_category = Category.new({'name' => 'food'})
    expect(test_category).to be_an_instance_of Category
  end

  it 'will start with an empty array' do
    expect(Category.all).to eq []
  end

  it 'will save a new instance of Category' do
    test_category = Category.new({'name' => 'food'})
    test_category.save
    expect(Category.all).to eq [test_category]
  end

  it 'will be the same thing if it has the same name' do
    test_category1 = Category.new({'name' => 'food'})
    test_category2 = Category.new({'name' => 'food'})
    expect(test_category1).to eq test_category2
  end

  it 'will list out all expenses in the same category' do
    test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '3/14/14'})
    test_expense.save
    test_expense1 = Expense.new({'description' => 'Drinks', 'amount' => 30.00, 'date' => '5/15/14'})
    test_expense1.save
    test_expense2 = Expense.new({'description' => 'Shoes', 'amount' => 50.00, 'date' => '5/12/14'})
    test_expense2.save
    test_category = Category.new({'name' => 'Dining'})
    test_category.save
    test_expense.add_cat(test_category.id)
    test_expense1.add_cat(test_category.id)
    expect(test_category.expenses).to eq [test_expense, test_expense1]
  end

  it 'will tell what percentage of all expenses are being spent in a category' do
    test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '3/14/14'})
    test_expense.save
    test_expense1 = Expense.new({'description' => 'Drinks', 'amount' => 30.00, 'date' => '5/15/14'})
    test_expense1.save
    test_expense2 = Expense.new({'description' => 'Shoes', 'amount' => 50.00, 'date' => '5/12/14'})
    test_expense2.save
    test_category = Category.new({'name' => 'Dining'})
    test_category.save
    test_expense.add_cat(test_category.id)
    test_expense1.add_cat(test_category.id)
    expect(test_category.category_percent).to eq 45
  end

end
