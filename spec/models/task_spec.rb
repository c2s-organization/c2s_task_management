require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'é válido com um título, status e URL' do
    task = build(:task)
    expect(task).to be_valid
  end

  it 'é inválido sem um título' do
    task = build(:task, title: nil)
    expect(task).not_to be_valid
  end

  it 'é inválido sem um status' do
    task = build(:task, status: nil)
    expect(task).not_to be_valid
  end

  it 'é inválido sem uma URL' do
    task = build(:task, url: nil)
    expect(task).not_to be_valid
  end
end
