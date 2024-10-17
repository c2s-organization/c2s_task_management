class Task < ApplicationRecord
  belongs_to :user, optional: true

  enum status: { pending: "pending", in_progress: "in_progress", completed: "completed", failed: "failed" }
  validates :title, :url, presence: true

  before_create :set_default_status

  private

  def set_default_status
    self.status = :pending
  end

end
