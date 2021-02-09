class JsonWebToken
 class << self
   def encode(payload, expire_in = 24.hours.from_now)
     payload[:exp] = expire_in.to_i

     JWT.encode(payload, ENV.fetch('SECRET_KEY_BASE'))
   end

   def decode(token)
     body = JWT.decode(token, ENV.fetch('SECRET_KEY_BASE'))[0]

     HashWithIndifferentAccess.new(body)
   rescue
     nil
   end
 end
end
