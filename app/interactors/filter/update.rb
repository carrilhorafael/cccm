class Filter::Update < Filter::Base

  def call
    assign_attributes
    validate_model
    filter.save!
  end

  def assign_attributes
    filter.assign_attributes(filter_params)
  end

  def filter_params
    context.filter_params || {}
  end

  def validate_model
    context.fail!(error: user.errors.full_messages.join(". ")) unless filter.valid?
  end
end
