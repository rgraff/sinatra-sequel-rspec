class Person < Sequel::Model
  def self.rand
    count = Person.count
    Person.limit(1, Kernel.rand(count) ).first if (count > 0)
  end
  
  def validate
    errors.add(:name, "can't be empty") if name.nil? || name.empty?
  end
end