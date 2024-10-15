class Task < ApplicationRecord
  enum status: { pending: "pendente", in_progress: "em progresso", completed: "concluída", failed: "falha" }
  validates :title, :status, :url, presence: true
end
