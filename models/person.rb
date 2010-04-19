class Person < Sequel::Model
  def validate
    errors.add(:name, "can't be empty") if name.nil? || name.empty?
  end
end