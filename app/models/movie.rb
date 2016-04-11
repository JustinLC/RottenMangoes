class Movie < ActiveRecord::Base

  has_attached_file :cover, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  validates :cover, 
    attachment_presence: true

  has_many :reviews

	validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  def review_average
    if reviews.size == 0
      return nil
    else
      reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

  # def self.search(search)
  #   if search
  #     find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
  #   else
  #     find(:all)
  #   end
  # end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end
