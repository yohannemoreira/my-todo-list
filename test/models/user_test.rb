require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email_address: "test@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "email_address should be present" do
    @user.email_address = "   "
    assert_not @user.valid?
    assert_includes @user.errors[:email_address], "não pode ficar em branco"
  end

  test "email_address should be unique" do
    duplicate_user = @user.dup
    @user.save!
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email_address], "já está em uso"
  end

  test "email_address should be case insensitive" do
    @user.email_address = "Test@Example.COM"
    @user.save!
    assert_equal "test@example.com", @user.email_address
  end

  test "email_address should accept valid formats" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email_address = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email_address should reject invalid formats" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email_address = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "password should be present for new users" do
    @user.password = @user.password_confirmation = "   "
    assert_not @user.valid?
  end

  test "password should have minimum length" do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
    assert_includes @user.errors[:password], "é muito curta (mínimo de 8 caracteres)"
  end

  test "password should accept valid length" do
    @user.password = @user.password_confirmation = "a" * 8
    assert @user.valid?
  end

  test "password should not be too long" do
    @user.password = @user.password_confirmation = "a" * 73
    @user.save
    # has_secure_password truncates at 72 characters
    assert @user.authenticate("a" * 72)
  end

  test "password_confirmation should match password" do
    @user.password = "password123"
    @user.password_confirmation = "different123"
    assert_not @user.valid?
  end

  test "should authenticate with correct password" do
    @user.save!
    assert @user.authenticate("password123")
  end

  test "should not authenticate with incorrect password" do
    @user.save!
    assert_not @user.authenticate("wrongpassword")
  end

  test "should have many sessions" do
    assert_respond_to @user, :sessions
  end

  test "should have many lists" do
    assert_respond_to @user, :lists
  end

  test "should destroy associated sessions when user is destroyed" do
    @user.save!
    @user.sessions.create!(ip_address: "127.0.0.1", user_agent: "Test")
    assert_difference "Session.count", -1 do
      @user.destroy
    end
  end

  test "should destroy associated lists when user is destroyed" do
    @user.save!
    @user.lists.create!(name: "Test List")
    assert_difference "List.count", -1 do
      @user.destroy
    end
  end

  test "email_address should be normalized" do
    mixed_case_email = "TeSt@ExAmPlE.CoM"
    @user.email_address = mixed_case_email
    @user.save!
    assert_equal mixed_case_email.downcase, @user.reload.email_address
  end

  test "email_address should be stripped of whitespace" do
    @user.email_address = "  test@example.com  "
    @user.save!
    assert_equal "test@example.com", @user.reload.email_address
  end

  test "password validation should not run on update if password is not changed" do
    @user.save!
    @user.email_address = "newemail@example.com"
    assert @user.valid?
  end
end
