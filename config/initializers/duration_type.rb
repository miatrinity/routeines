# frozen_string_literal: true

# Adding new column type for storing durations
#
# Using ActiveRecord::Attributes to store ActiveSupport::Durations as ISO8601 strings.
# The advantage of using ActiveSupport::Duration over integers is that you can use them
# for date/time calculations right out of the box.
#
# You can do things like Time.now + 1.month and it's always correct.
class DurationType < ActiveRecord::Type::String
  def cast(value)
    return value if value.blank? || value.is_a?(ActiveSupport::Duration)

    ActiveSupport::Duration.build(value)
  end

  def serialize(duration)
    duration ? duration.iso8601 : nil
  end
end

ActiveRecord::Type.register(:duration, DurationType)
