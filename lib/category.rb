class Category

attr_accessor :name, :id, :budget

  def initialize(attributes)
    @name = attributes['name']
    @budget = attributes['budget']
    @id = attributes['id'].to_i
  end

  def self.all
    categories = []
    results = DB.exec("SELECT * FROM categories;")
    results.each do |result|
      categories << Category.new(result)
    end
    categories
  end

  def save
    results = DB.exec("INSERT INTO categories (name, budget) VALUES ('#{@name}', #{@budget}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def expenses
    @expenses =[]
    results = DB.exec("SELECT expenses.* FROM categories
      JOIN expenses_categories on (categories.id = expenses_categories.category_id)
      JOIN expenses on (expenses_categories.expense_id = expenses.id) WHERE categories.id = #{self.id};")
    results.each do |result|
      @expenses << Expense.new(result)
    end
    @expenses
  end

  def category_percent
    expenses = []
    all_expenses =[]
    results = DB.exec("SELECT expenses.* FROM categories
                      JOIN expenses_categories on (categories.id = expenses_categories.category_id)
                      JOIN expenses on (expenses_categories.expense_id = expenses.id) WHERE categories.id = #{self.id};")
    results.each do |result|
      amount = result['amount'].to_f
      expenses << amount
    end
    category_total = expenses.inject{|sum, x| sum + x}
    Expense.all.each do |expense|
        # binding.pry
      amount = expense.amount
      all_expenses << amount
    end
    total_expenses = all_expenses.inject{|sum, x| sum + x}
    decimal = category_total/total_expenses
    percentage = (decimal * 100).to_i
  end

  def ==(another_category)
    @name == another_category.name
  end

  def money_spent
    money = []
    self.expenses.each do |expense|
      money << expense.amount
    end
    total = money.inject{|sum, x| sum + x}
  end
end
