class Person < ApplicationRecord
  attr_accessor :name, :string

  has_one :address, dependent: :destroy
  has_many :drives, class_name: :Drive, dependent: :destroy
  has_many :vehicles, through: :drives
end

class Address < ApplicationRecord
  attr_accessor :street, :string
  attr_accessor :city, :string
  attr_accessor :country, :string

  belongs_to :person
end

class Vehicle < ApplicationRecord
  attr_accessor :model, :integer
  attr_accessor :plate_number, :string

  has_many :drives, class_name: :Drive, dependent: :destroy
  has_many :persons, through: :drives
end

class Drive < ApplicationRecord
  attr_accessor :date, :datetime
  attr_accessor :distance, :integer
  
  belongs_to :person
  belongs_to :vehicle
end

class Student < Person
  attr_accessor :student_number, :integer
end

class Professor < Person
  attr_accessor :salary, :integer
end
