require Impressionist::Engine.root.join('lib/impressionist/models/active_record/impression')

module ImpressionExtensions
  extend ActiveSupport::Concern

  def user
    User.find(user_id) if user_id
  end
end

Impression.send(:include, ImpressionExtensions)
