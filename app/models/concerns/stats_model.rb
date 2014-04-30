module StatsModel
  extend ActiveSupport::Concern

  def daily_visits(viewable)
    all_days = get_days_hash
    created_at = 'DATE(created_at)'
    visits = viewable.impressions.select(created_at)
              .where(created_at: 30.days.ago..Time.now).group(created_at)
              .order(created_at).count
    all_days.merge(visits)
  end

  def country_visits(viewable)
    views = viewable.impressions
    user_visits = views
                    .joins('INNER JOIN users ON user_id = users.id')
                    .select(:country)
                    .where.not('users.country' => nil, 'users.country' => '')
                    .group(:country)
                    .count
    user_visits['Unknown'] = views.where(user_id: nil).count
    user_visits
  end

  def age_visits(viewable)
    join = viewable.impressions.joins("INNER JOIN users ON user_id = users.id")
    labels = %w[ <13 13-17 18-24 25-34 35-44 45-54 55-64 >65 ]
    ranges = get_age_ranges
    ages = {}

    (0...labels.length).each do |i|
      ages[labels[i]] = age_count(join, ranges[i])
    end

    ages
  end

  private
    def age_count(join, range)
      join
        .where('users.birthdate' => range)
        .where.not('users.birthdate' => nil)
        .count
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

    def get_days_hash
      hash = {}
      30.downto(0).each do |i|
        # same date format as Rails uses for storing dates
        date = i.days.ago.to_date.strftime
        hash[date] = 0
      end
      hash
    end
end
