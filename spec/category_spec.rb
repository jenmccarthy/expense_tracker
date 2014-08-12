require 'spec_helper'

describe 'Category' do

  it 'will initialize a Category instance with attributes' do
    test_category = Category.new({'name' => 'food'})
    expect(test_category).to be_an_instance_of Category
  end

end
