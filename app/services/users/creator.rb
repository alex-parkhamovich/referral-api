module Users
  class Creator
    def initialize(email:, password:)
      self.email = email
      self.password = password
    end

    def create
    end

    private

    attr_accessor :email, :password    
  end
end
