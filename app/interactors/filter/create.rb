class Filter::Create < Filter::Base

  def call
    build_filter
    validate_model
    filter.save!
  end

  private

  def build_filter
    context.filter = user.filters.build(filter_params)
  end

  def filter_params
    context.filter_params || { source: 'users' }
  end

  def validate_model
    context.fail!(error: user.errors.full_messages.join(". ")) unless filter.valid?
  end
end
