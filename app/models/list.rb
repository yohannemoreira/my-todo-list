class List < ApplicationRecord
  belongs_to :user, optional: true
  has_many :todos, dependent: :destroy

  validates :name, presence: true

  def completed_todos_count
    todos.where(completed: true).count
  end

  def pending_todos_count
    todos.where(completed: [ false, nil ]).count
  end

  def total_todos_count
    todos.count
  end

  def completion_percentage
    return 0 if total_todos_count.zero?
    (completed_todos_count.to_f / total_todos_count * 100).round
  end

  def all_completed?
    total_todos_count.positive? && pending_todos_count.zero?
  end
end
