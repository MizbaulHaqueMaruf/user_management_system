class User < ApplicationRecord
    has_secure_password

	# Verify that email field is not blank and that it doesn't already exist in the db (prevents duplicates):
	validates :email, presence: true, uniqueness: true

    # ############################
    enum status: { active: 0, blocked: 1 } # Define status enum

    def block!
        update(status: :blocked)
    end

    def unblock!
        update(status: :active)
    end

    before_create :set_registration_time

    def set_registration_time
        self.registration_time = Time.zone.now
    end

    def update_last_login_time
        self.last_login_time = Time.zone.now
        save
    end

end
