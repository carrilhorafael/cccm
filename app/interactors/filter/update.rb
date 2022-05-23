class Filter::Update < Filter::Base

  def call
    assign_attributes
    filter.save!
  end

  def assign_attributes
    filter.assign_attributes(filter_params)
  end
end
