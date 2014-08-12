require 'spec_helper'

describe Expense do
  it 'will create a new instance of Expense' do
    test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '2014-03-14'})
    expect(test_expense).to be_an_instance_of Expense
  end

  it 'will read out the attributes of the Expense instance' do
    test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '2014-03-14'})
    expect(test_expense.description).to eq 'Pizza'
    expect(test_expense.amount).to eq 10.99
    expect(test_expense.date).to eq '2014-03-14'
  end

  it 'will save a new Expense to an array' do
    test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '2014-03-14'})
    test_expense.save
    expect(Expense.all).to eq [test_expense]
  end

  describe Expense.all do
    it 'will start out with an empty array' do
      expect(Expense.all).to eq []
    end
  end

  it 'will indicate that instances with the same attributes are the same' do
    test_expense = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '2014-03-14'})
    test_expense1 = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '2014-03-14'})
    expect(test_expense).to eq test_expense1
  end

describe 'self.time_period' do
  it 'will return all the expenses for a certain time period' do
    test_expense1 = Expense.new({'description' => 'Pizza', 'amount' => 10.99, 'date' => '2014-03-14'})
    test_expense1.save
    test_expense2 = Expense.new({'description' => 'Burgers', 'amount' => 12.39, 'date' => '2014-03-23'})
    test_expense2.save
    test_expense3 = Expense.new({'description' => 'Groceries', 'amount' => 5.78, 'date' => '2014-04-12'})
    test_expense3.save
    expect(Expense.time_period('3/1/2014', '3/31/2014')).to eq [test_expense1, test_expense2]
  end
end
end

