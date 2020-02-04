# frozen_string_literal: true

# Thanks to Carlos Ramirez III
#
# A validator and RSpec matcher for requiring an attachment using Active Storage
#
# https://gist.github.com/carlosramireziii/73f2c7b12dd6716482e41a3cd8e0a94d#file-attached_validator-rb
class AttachedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :attached, options) unless value.attached?
  end
end
