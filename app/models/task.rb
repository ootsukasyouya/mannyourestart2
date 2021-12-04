class Task < ApplicationRecord
  validates :content, presence: true
  validates :title, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  enum status: {未着手:0,着手中:1,完了:2},_prefix: true
  enum priority: {高:0,中:1,低:2},_prefix: true

  scope :search_title,->(title_search){where("title LIKE?","%#{title_search}%")}
  scope :search_status,->(status_search){where(status:"#{status_search}")}
  # def self.search(keyword)
  #   if keyword != nil
  #     where("title like?", "%#{keyword}%")
  # end
end
