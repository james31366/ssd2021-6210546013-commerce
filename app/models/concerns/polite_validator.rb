class PoliteValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if value.to_s.downcase.include?('bad')
      object.errors.add(attribute, "contains word 'bad'")
    end
  end
end
