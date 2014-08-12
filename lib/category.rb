class Category

attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes['name']
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
    results = DB.exec("INSERT INTO categories (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_category)
    @name == another_category.name
  end
end
