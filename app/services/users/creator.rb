module Users
  class Creator
    def initialize(params:)
      self.params = params
    end

    def create
      puts ' ' * 80
      puts "USER CREATED: #{user.id}"
      puts ' ' * 80

      user.update_attributes(referrer: referrer) if referrer
      puts ' ' * 80
      puts "REFERRER ASSISGNED: #{referrer.id}" if referrer
      puts ' ' * 80

      user
    end

    private

    attr_accessor :params

    def referrer
      @referrer ||= User.find_by_id(params[:referrer_id])
    end

    def user
      @user ||= User.create!(
        email: params[:email],
        password: params[:password]
      )
    end
  end
end
