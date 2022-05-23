class Filter::Create < Filter::Base

  def call
    build_filter
    filter.save!
  end

  private

  def build_filter
    context.filter = user.filters.build(filter_params)
  end
end
