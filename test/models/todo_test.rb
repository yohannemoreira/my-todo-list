require "test_helper"

class TodoTest < ActiveSupport::TestCase
  test "fixtures are valid" do
    assert todos(:one).valid?
    assert todos(:two).valid?
  end

  test "is invalid without list" do
    todo = Todo.new(name: "No list")
    assert_not todo.valid?
    assert_not_empty todo.errors[:list]
  end

  test "belongs to list and list includes todo" do
    todo = todos(:one)
    assert_respond_to todo, :list
    assert_equal lists(:one), todo.list
    assert_includes todo.list.todos, todo
  end

  test "completed value from fixtures" do
    assert_equal false, todos(:one).completed
  end
end
