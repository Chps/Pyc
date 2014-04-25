class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  is_impressionable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :images
  has_many :comments, dependent: :destroy

  # impressions made by this user
  has_many :impressions

  # impressions on this user
  def views(options = { select: '*' })
    Impression
      .select(options[:select])
      .where( "impressionable_type = 'User' and impressionable_id = ?", id)
  end
end
