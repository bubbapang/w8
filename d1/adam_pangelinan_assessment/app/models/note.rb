# == Schema Information
#
# Table name: notes
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :string
#  secret      :boolean
#  author_id   :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Note < ApplicationRecord
    validates :title, :description, presence: true

    belongs_to :author,
        foreign_key: :author_id,
        class_name: :User
end
