require 'adapter/mongo_atomic'

class User
  include Toy::Mongo
  include Toy::Mongo::AtomicUpdates
  adapter :mongo_atomic, Swordfish::Application.config.mongo['users'], :safe => true

  self.include_root_in_json = false

  attribute :name,        String
  attribute :email,       String
  attribute :public_key,  String
  attribute :fingerprint, String

  before_create :set_fingerprint

  def team_ids
    Membership.all(:user_id => id).map(&:team_id)
  end

  def self.find_by_email!(email)
    first(:email => email) || raise(Toy::NotFound, "email=#{email}")
  end

private

  def set_fingerprint
    self.fingerprint = OpenSSL::PKey::RSA.new(public_key).fingerprint
  end

end
