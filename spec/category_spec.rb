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
end
