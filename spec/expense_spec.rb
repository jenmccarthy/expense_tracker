require 'spec_helper'

describe Expense do
  it 'will create a new instance of Expense' do
    test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '3/14/14'})
    expect(test_expense).to be_an_instance_of Expense
  end

  it 'will read out the attributes of the Expense instance' do
    test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '3/14/14'})
    expect(test_expense.description).to eq 'Pizza'
    expect(test_expense.amount).to eq 10.99
    expect(test_expense.date).to eq '3/14/14'
  end

  it 'will save a new Expense to an array' do
    test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '3/14/14'})
    test_expense.save
    expect(Expense.all).to eq [test_expense]
  end

  describe Expense.all do
    it 'will start out with an empty array' do
      expect(Expense.all).to eq []
    end
  end

  it 'will indicate that instances with the same attributes are the same' do
    test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '3/14/14'})
    test_expense1 = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '3/14/14'})
    expect(test_expense).to eq test_expense1
  end

  # it 'will list out all expenses in the same category' do
  #   test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '3/14/14', 'category' => 'Food'})


end

