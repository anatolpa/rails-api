class Task < ActiveRecord::Base
  validates :user, presence: true
  validates :image, presence: true
  validates_inclusion_of :status, in: ['new', 'process', 'done']
  validates_inclusion_of :operation, in: ['blur', 'negate', 'rotate', 'contrast']

  belongs_to :user
  has_one :image

  def process_image!
    self.status = 'process'
    self.save!
    options = {
        body: self
    }
    url = ENV['IMAGE_PROCESSING_HOST'] + '/tasks'
    HTTParty.post(url, options)
  end
end
