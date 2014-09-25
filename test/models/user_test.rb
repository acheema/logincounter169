require 'test_helper'

class UserTest < ActiveSupport::TestCase

	#Login tests
	test "Login in as an unadded user returns error" do
		assert User.login("a","b") == User::ERR_BAD_CREDENTIALS
	end

	test "The count function properly works" do
		testuser = User.new(user: "testuser", password: "testpass", count: 8)
		testuser.save!
		assert User.login("testuser", "testpass") == 9
	end

	test "Feeding bad login credentials" do
		assert User.login("", "") == User::ERR_BAD_CREDENTIALS
	end
	test "Feeding bad login credentials 2" do
		assert User.login(" ", "") == User::ERR_BAD_CREDENTIALS
	end
	test "Feeding bad login credentials 3" do
		assert User.login("", " ") == User::ERR_BAD_CREDENTIALS
	end
	test "Feeding bad login credentials 4" do
		assert User.login(" ", " ") == User::ERR_BAD_CREDENTIALS
	end

	test "Feeding edge login credentials empty pass" do
		User.add("b","")
		assert User.login("b", "") == 2
	end

	test "Feeding edge login credentials blank pass" do
		testuser2 = User.new(user: "b", password: " ", count: 6578)
		testuser2.save!
		assert User.login("b", " ") == 6579
	end

	test "Feeding edge login credentials blank username" do
		User.add(" ","")
		assert User.login(" ", "") == 2
	end

	test "Feeding wrong password returns error" do
		User.add("Kappa", "Keepo")
		assert User.login("Kappa", "DansGame") == User::ERR_BAD_CREDENTIALS
	end

	#Add tests
	test "Adding normal user works" do
		assert User.add("testuser1", "testpass1") == User::SUCCESS
	end

	test "Adding same user returns error" do
		User.add("testuser1", "testpass1")
		assert User.add("testuser1", "testpass1") == User::ERR_USER_EXISTS
	end

	test "Adding  more than max length username returns error" do
		assert User.add("v" * 129, "blah") == User::ERR_BAD_USERNAME
	end
	test "Adding more than max length password returns error" do
		assert User.add("Kappa", "v" * 129) == User::ERR_BAD_PASSWORD
	end

	test "Adding max length username is fine" do
		assert User.add("v" * 128, "blah") == User::SUCCESS
	end
	test "Adding max length password is fine" do
		assert User.add("Kappa", "v" * 128) == User::SUCCESS
	end

	test "Adding empty username returns error" do
		assert User.add("", "kappa") == User::ERR_BAD_USERNAME
	end
	test "Adding blank username is fine" do
		assert User.add(" ", "kappa") == User::SUCCESS
	end

	test "Adding empty password is fine" do
		assert User.add("b", "") == User::SUCCESS
	end
	test "Adding blank password is fine" do
		assert User.add("b", " ") == User::SUCCESS
	end

	#Reset tests
	test "The reset function properly works" do
		assert User.TESTAPI_resetFixture() == User::SUCCESS
	end

	test "The reset function actually wiped records" do
		User.add("testuser1", "testpass1")
		User.TESTAPI_resetFixture()
		assert User.login("testuser1", "testpass1") == User::ERR_BAD_CREDENTIALS
	end

end
