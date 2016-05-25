class User < ActiveRecord::Base
  self.primary_key = 'uuid'

  def active?
    status != "inactive"
  end

  def self.from_oath(auth_hash)
    user = User.find_or_initialize_by(uuid: auth_hash["uid"])
    user.name           = auth_hash["info"]["name"]
    user.email          = auth_hash["info"]["email"]
    user.kind           = auth_hash["info"]["kind"]
    user.gender         = auth_hash["info"]["gender"]
    user.date_of_birth  = auth_hash["info"]["dob"]
    user.status         = auth_hash["info"]["status"]
    user
  end

  def encrypted_uuid
    cipher         =  OpenSSL::Cipher.new 'aes-256-cbc'
    cipher.encrypt
    cipher.key     =  ENV["CIPHER_KEY"]
    cipher.iv      =  ENV["CIPHER_IV"]
    cipher.padding =  1
    encrypted      =  cipher.update uuid
    encrypted << cipher.final
    encoded        =  Base64.urlsafe_encode64(encrypted).encode('utf-8')
  end
end
