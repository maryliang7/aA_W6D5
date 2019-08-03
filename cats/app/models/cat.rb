class Cat < ApplicationRecord
  validates :name, :color, :sex, :description, :birth_date, presence: true
  validate :sex_validation, :color_validation
  attr_accessor :age

  $COLORS = ["black", "grey", "white", "brown", "yellow"]

  def sex_validation
    race = ["M", "F"]
    if !race.include?(self.sex)
      errors[:sex] << "Invalid Sex"
    end
  end

  def color_validation
    if !COLORS.include?(self.color)
      errors[:color] << "Invalid Color"
    end
  end

  def age
    # debugger
    @age = Date.today.year - self.birth_date.year 
    if Date.today.month < self.birth_date.month
      @age -= 1
    elsif Date.today.month == self.birth_date.month
      if Date.today.day < self.birth_date.day
        @age -= 1
      end
    end
    @age

  end

  has_many :cat_rental_requests,
    dependent: :destroy

end

#cat1 = Cat.create!(name: "Henry", color: "yellow", 
  #birth_date: Date.new(2001,2,3), sex: "M", description: "very cute" )