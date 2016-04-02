class CreateNewItem < Struct.new(:listener)

  attr_reader :new_item_form
  delegate :valid?, to: :new_item_form

  def call(new_item_form)
    @new_item_form = new_item_form

    return listener.on_create_failed(new_item_form) unless valid?

    listener.on_create_succeeded(new_item_form) if persist!

  rescue => e
    log_error(e)
    new_item_form.errors.add(:base, "#{e.class}: #{e.message}")
    return listener.on_create_failed(new_item_form)
  end

  private

  def persist!
    new_item_form.save!
  end

  def log_error(e)
    # Rails.logger.error(%Q{\
    Rails.logger.debug(%Q{\
[#{Time.zone.now}][CreateNewItem#call] Error creating new item: \
#{e.class}: #{e.message}

This means the item, or the list_item, or both have not been created properly.

#{e.backtrace.each { |line| puts line.inspect}}
})
  end
end

