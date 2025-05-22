require "test_helper"

class TodoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @todo = Todo.new(
      title: "Do project",
      description: "Complete the Rails project and submit it",
      status: "pending"
    )
  end

  test "is valid with valid attributes" do
    assert @todo.valid?
  end

  test "is invalid without a title" do
    @todo.title = nil
    assert_not @todo.valid?
    assert_includes @todo.errors[:title], "can't be blank"
  end

  test "is invalid without a description" do
    @todo.description = nil
    assert_not @todo.valid?
    assert_includes @todo.errors[:description], "can't be blank"
  end

  test "is invalid without a status" do
    @todo.status = nil
    assert_not @todo.valid?
    assert_includes @todo.errors[:status], "can't be blank"
  end

  
  test "is invalid if title is too short" do
    @todo.title = "Hi"
    assert_not @todo.valid?
    assert_includes @todo.errors[:title], "is too short (minimum is 3 characters)"
  end

  test "is invalid if title is too long" do
    @todo.title = "a" * 51
    assert_not @todo.valid?
    assert_includes @todo.errors[:title], "is too long (maximum is 50 characters)"
  end

  test "is invalid if description is too short" do
    @todo.description = "abc"
    assert_not @todo.valid?
    assert_includes @todo.errors[:description], "is too short (minimum is 4 characters)"
  end

  test "is invalid with duplicate description" do
    duplicate_todo = @todo.dup
    @todo.save
    assert_not duplicate_todo.valid?
    assert_includes duplicate_todo.errors[:description], "has already been taken"
  end

  test "is invalid with an invalid status" do
    @todo.status = "waiting"
    assert_not @todo.valid?
    valid_statuses = %w[pending ongoing completed]
    message = "waiting is not a valid status. the valid statuses are: #{valid_statuses.join(', ')}"
    assert_includes @todo.errors[:status], message
  end
end