class User < ActiveRecord::Base

	SUCCESS = 1
	ERR_BAD_CREDENTIALS = -1
	ERR_USER_EXISTS = -2
	ERR_BAD_USERNAME = -3
	ERR_BAD_PASSWORD = -4

	MAX_FIELD_LENGTH = 128

	def self.add(username, password)

		if username.empty? or username.length > MAX_FIELD_LENGTH
			return ERR_BAD_USERNAME
		end
		if password.length > MAX_FIELD_LENGTH
			return ERR_BAD_PASSWORD
		end

		userInQuestion = User.find_by_user(username)
		if userInQuestion != nil
			return ERR_USER_EXISTS
		end
		
		newUser = User.new(user: username, password: password, count: 1)
		newUser.save!
		return newUser.count
	end

	def self.login(username, password)
		userInQuestion = User.find_by_user(username)
		if userInQuestion != nil and userInQuestion.password == password
			userInQuestion.increment!(:count)
			return userInQuestion.count
		end
		return ERR_BAD_CREDENTIALS
	end

	def self.TESTAPI_resetFixture()
		User.delete_all()
		return SUCCESS
	end
end
