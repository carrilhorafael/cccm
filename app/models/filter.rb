class Filter < ApplicationRecord
  belongs_to :user

  def to_query
    return "SELECT id FROM users" if self.restriction.blank?
    count = 0
    query = "SELECT users.id FROM users"

    if self.restriction.has_key?("ministeries")
      if self.restriction["ministeries"]["filter_types"] == ['no-ministeries', 'choosen-ministeries']
       query << " LEFT JOIN memberships ON memberships.user_id = users.id WHERE (memberships.user_id is NULL"
       if self.restriction['ministeries'].has_key?("choosed_ministeries_ids")
        query << " OR memberships.ministery_id IN (#{self.restriction['ministeries']['choosed_ministeries_ids'].map{ |e| "'#{e}'" }.join(', ')}))"
      else
        query << ")"
       end
      elsif self.restriction["ministeries"]["filter_types"] == ['no-ministeries']
        query << " LEFT JOIN memberships ON memberships.user_id = users.id WHERE memberships.user_id is NULL"
      elsif self.restriction["ministeries"]["filter_types"] == ['choosen-ministeries'] && self.restriction['ministeries'].has_key?("choosed_ministeries_ids")
        query << " LEFT JOIN memberships ON memberships.user_id = users.id WHERE memberships.ministery_id IN (#{self.restriction['ministeries']['choosed_ministeries_ids']&.map{ |e| "'#{e}'" }&.join(', ')})"
      else
        count -= 1
      end

      count += 1
    end

    query << " WHERE" if count == 0

    if self.restriction.has_key?("name")
      query << " AND" if count > 0
      query << " LOWER(users.name) LIKE LOWER('%#{restriction['name']}%')"
      count += 1
    end

    if self.restriction.has_key?("titles")
      query << " AND" if count > 0
      query << " LOWER(users.title) IN (#{self.restriction['titles'].map{ |title| "'#{title.downcase}'" }.join(", ")})"
      count += 1
    end

    if self.restriction.has_key?("is_baptized")
      query << " AND" if count > 0
      query << " users.is_baptized = #{self.restriction['is_baptized']}"
      count += 1
    end

    if self.restriction.has_key?("system_access")
      query << " AND" if count > 0
      query << " users.access_garantied_at IS NOT NULL"
    end

    return query
  end
end
