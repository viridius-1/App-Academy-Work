require 'byebug'

class EmailValidator < ActiveModel::EachValidator
  CRAZY_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def validate_each(record, attribute_name, value)
    unless value =~ CRAZY_EMAIL_REGEX
      # we can use `EachValidator#options` to access custom options
      # passed to the validator.
      message = options[:message] || 'is not an email'
      record.errors[attribute_name] << message
    end
  end
end