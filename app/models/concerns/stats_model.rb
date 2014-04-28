module StatsModel
  extend ActiveSupport::Concern

  def daily_visits(viewable)
    created_at = 'DATE(created_at)'
    viewable.impressions.select(created_at).group(created_at).order(created_at).count
  end

  def country_visits(viewable)
    viewable
      .impressions
      .joins('INNER JOIN users ON user_id = users.id')
      .select(:country)
      .where.not('users.country' => nil, 'users.country' => '')
      .group(:country)
      .count
  end

  def age_visits(viewable)
    join = viewable.impressions.joins("INNER JOIN users ON user_id = users.id")
    labels = %w[ <13 13-17 18-24 25-34 35-44 45-54 55-64 >65 ]
    ranges = get_age_ranges
    ages = []
    (0..labels.length).each do |i|
      ages << age_row(join, labels[i], ranges[i])
    end

    ages
  end

  private
    def age_row(join, label, range)
      [
        label,
        join
          .where('users.birthdate' => range)
          .where.not('users.birthdate' => nil)
          .count
      ]
    end

    def get_age_ranges
      [
        13.years.ago..0.years.ago,
        17.years.ago..13.years.ago,
        24.years.ago..17.years.ago,
        34.years.ago..24.years.ago,
        44.years.ago..34.years.ago,
        54.years.ago..44.years.ago,
        64.years.ago..54.years.ago,
        90.years.ago..64.years.ago
      ]
    end
end
