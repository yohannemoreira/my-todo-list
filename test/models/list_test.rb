require "test_helper"

class ListTest < ActiveSupport::TestCase
  test "fixtures are valid" do
    assert lists(:one).valid?
    assert lists(:two).valid?
  end

  test "is invalid without name" do
    list = List.new
    assert_not list.valid?
    assert_includes list.errors[:name], "can't be blank"
  end

  test "has many todos from fixtures" do
    assert_respond_to lists(:one), :todos
    # fixtures define one todo for :one and one for :two
    assert_equal 1, lists(:one).todos.count
  end
end
