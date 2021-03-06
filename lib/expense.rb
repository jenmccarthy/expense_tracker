class Expense
  attr_accessor :description, :amount, :date

  def initialize(attributes)
    @description = attributes['description']
    @amount = attributes['amount'].to_f
    @date = attributes['date']
    @id = attributes['id']
  end

  def self.all
    expenses = []
    results = DB.exec("SELECT * FROM expenses;")
    results.each do |result|
      # binding.pry
      expenses << Expense.new(result)
    end
    expenses
  end

  def save
    results = DB.exec("INSERT INTO expenses (description, amount, date) VALUES ('#{@description}', #{@amount}, '#{@date}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def add_cat(id)
    DB.exec("INSERT into expenses_categories (expense_id, category_id) VALUES (#{@id}, #{id});")
  end

  def self.time_period(start_date, end_date)
    expenses = []
    results = DB.exec("SELECT * FROM expenses WHERE date BETWEEN '#{start_date}' AND '#{end_date}';")
    results.each do |result|
      expenses << Expense.new(result)
    end
    expenses
  end

  def delete_expense
    DB.exec("DELETE FROM expenses WHERE id = #{@id};")
    DB.exec("DELETE FROM expenses_categories WHERE expense_id = #{@id};")
  end

  def ==(another_expense)
    @description == another_expense.description && @amount == another_expense.amount && @date == another_expense.date
  end

end
