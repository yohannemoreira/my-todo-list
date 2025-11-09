require "test_helper"

class ListTest < ActiveSupport::TestCase
  test "fixtures are valid" do
    assert lists(:one).valid?
    assert lists(:two).valid?
  end

  test "is invalid without name" do
    list = List.new
    assert_not list.valid?
    assert_includes list.errors[:name], "não pode ficar em branco"
  end

  test "has many todos from fixtures" do
    assert_respond_to lists(:one), :todos
    assert_equal 1, lists(:one).todos.count
  end

  test "destroys dependent todos when list is destroyed" do
    list = lists(:one)
    todo_ids = list.todos.pluck(:id)
    
    assert_difference "Todo.count", -list.todos.count do
      list.destroy
    end
    
    todo_ids.each do |id|
      assert_nil Todo.find_by(id: id)
    end
  end

  test "completed_todos_count returns count of completed todos" do
    list = List.create!(name: "Test List")
    list.todos.create!(name: "Todo 1", completed: true)
    list.todos.create!(name: "Todo 2", completed: true)
    list.todos.create!(name: "Todo 3", completed: false)
    
    assert_equal 2, list.completed_todos_count
  end

  test "completed_todos_count returns zero when no todos exist" do
    list = List.create!(name: "Empty List")
    assert_equal 0, list.completed_todos_count
  end

  test "completed_todos_count returns zero when all todos are pending" do
    list = List.create!(name: "Test List")
    list.todos.create!(name: "Todo 1", completed: false)
    list.todos.create!(name: "Todo 2", completed: false)
    
    assert_equal 0, list.completed_todos_count
  end

  test "pending_todos_count returns count of pending todos" do
    list = List.create!(name: "Test List")
    list.todos.create!(name: "Todo 1", completed: false)
    list.todos.create!(name: "Todo 2", completed: false)
    list.todos.create!(name: "Todo 3", completed: true)
    
    assert_equal 2, list.pending_todos_count
  end

  test "pending_todos_count includes nil completed values" do
    list = List.create!(name: "Test List")
    list.todos.create!(name: "Todo 1", completed: nil)
    list.todos.create!(name: "Todo 2", completed: false)
    list.todos.create!(name: "Todo 3", completed: true)
    
    assert_equal 2, list.pending_todos_count
  end

  test "pending_todos_count returns zero when all todos are completed" do
    list = List.create!(name: "Test List")
    list.todos.create!(name: "Todo 1", completed: true)
    list.todos.create!(name: "Todo 2", completed: true)
    
    assert_equal 0, list.pending_todos_count
  end

  test "total_todos_count returns correct count of all todos" do
    list = List.create!(name: "Test List")
    list.todos.create!(name: "Todo 1", completed: true)
    list.todos.create!(name: "Todo 2", completed: false)
    list.todos.create!(name: "Todo 3", completed: true)
    
    assert_equal 3, list.total_todos_count
  end

  test "total_todos_count returns zero for empty list" do
    list = List.create!(name: "Empty List")
    assert_equal 0, list.total_todos_count
  end

  test "completion_percentage returns correct percentage" do
    list = List.create!(name: "Test List")
    list.todos.create!(name: "Todo 1", completed: true)
    list.todos.create!(name: "Todo 2", completed: true)
    list.todos.create!(name: "Todo 3", completed: false)
    list.todos.create!(name: "Todo 4", completed: false)
    
    assert_equal 50, list.completion_percentage
  end

  test "completion_percentage returns 0 for empty list" do
    list = List.create!(name: "Empty List")
    assert_equal 0, list.completion_percentage
  end

  test "completion_percentage returns 100 when all todos are completed" do
    list = List.create!(name: "Test List")
    list.todos.create!(name: "Todo 1", completed: true)
    list.todos.create!(name: "Todo 2", completed: true)
    
    assert_equal 100, list.completion_percentage
  end

  test "completion_percentage returns 0 when no todos are completed" do
    list = List.create!(name: "Test List")
    list.todos.create!(name: "Todo 1", completed: false)
    list.todos.create!(name: "Todo 2", completed: false)
    
    assert_equal 0, list.completion_percentage
  end

  test "completion_percentage rounds to nearest integer" do
    list = List.create!(name: "Test List")
    list.todos.create!(name: "Todo 1", completed: true)
    list.todos.create!(name: "Todo 2", completed: false)
    list.todos.create!(name: "Todo 3", completed: false)
    
    assert_equal 33, list.completion_percentage
  end

  test "all_completed? returns true when all todos are completed" do
    list = List.create!(name: "Test List")
    list.todos.create!(name: "Todo 1", completed: true)
    list.todos.create!(name: "Todo 2", completed: true)
    
    assert list.all_completed?
  end

  test "all_completed? returns false when some todos are pending" do
    list = List.create!(name: "Test List")
    list.todos.create!(name: "Todo 1", completed: true)
    list.todos.create!(name: "Todo 2", completed: false)
    
    assert_not list.all_completed?
  end

  test "all_completed? returns false for empty list" do
    list = List.create!(name: "Empty List")
    assert_not list.all_completed?
  end

  test "all_completed? returns false when all todos are pending" do
    list = List.create!(name: "Test List")
    list.todos.create!(name: "Todo 1", completed: false)
    list.todos.create!(name: "Todo 2", completed: false)
    
    assert_not list.all_completed?
  end
end
