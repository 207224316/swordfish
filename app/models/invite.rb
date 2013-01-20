class Invite
  include Toy::Mongo
  adapter :mongo, Swordfish::Application.config.mongo['invites'], :safe => true

  attribute :team_id, BSON::ObjectId
  attribute :email,   String
  attribute :token,   String
  attribute :user_id, BSON::ObjectId

  before_create do
    self.token = SecureRandom.urlsafe_base64(12)
  end

  def self.from_token(token)
    first(:token => token) || raise(Toy::NotFound, "token=#{token}")
  end

  def self.to(team)
    all :team_id => team.id
  end

  def accept(user)
    !accepted? && update_attributes(:user_id => user.id)
  end

  def accepted?
    user_id?
  end
end
