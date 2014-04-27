class User < ActiveRecord::Base
  is_impressionable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :images
  has_many :comments, dependent: :destroy

  def visitors
    impressions.select(:user_id).group(:user_id)
  end

  def visits_by_day
    created_at = 'DATE(created_at)'
    impressions.select(created_at).group(created_at).order(created_at).count
  end

  def visits_by_country
     impressions.joins( 'INNER JOIN users ON user_id = users.id')
      .select(:country)
      .where('users.country IS NOT NULL')
      .group(:country)
      .count
  end
  
  def visits_by_age
	ages = Array.new(8) { Array.new(2) }
	ages[0][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
		.where("? > 0 AND ? < 13", age(birthdate), age(birthdate))
		.count
	ages[2][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
		.where("? >=13 AND ? < 18", age(birthdate), age(birthdate))
		.count
	ages[3][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
		.where("? >=18 AND ? < 25", age(birthdate), age(birthdate))
		.count
	ages[4][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
		.where("? >=25 AND ? < 35", age(birthdate), age(birthdate))
		.count
	ages[5][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
		.where("? >=35 AND ? < 45", age(birthdate), age(birthdate))
		.count
	ages[5][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
		.where("? >=45 AND ? < 55", age(birthdate), age(birthdate))
		.count
	ages[6][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
		.where("? >=55 AND ? < 65", age(birthdate), age(birthdate))
		.count
	ages[7][1] = impressions.joins( 'INNER JOIN users ON user_id = users.id')
		.where("? >=65", age(birthdate))
		.count
		
	ages
  end
  
  def age(dob)
    now = Time.now.utc.to_date
	oldness = -1
	if dob.nil?
		
	else
		oldness = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
	end
		
	oldness
  end
end
