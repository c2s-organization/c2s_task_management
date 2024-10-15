class Task < ApplicationRecord
  enum status: { pending: "pending", in_progress: "in_progress", completed: "completed", failed: "failed" }
  validates :title, :status, :url, presence: true

end
