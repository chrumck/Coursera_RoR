class Profile < ActiveRecord::Base
  belongs_to :user

  validates :gender, inclusion: { in: %w(male female), message: "%{value} is not a valid size" }
  validate :must_give_first_or_last, :male_cannot_be_sue

  def must_give_first_or_last
    return unless first_name.nil? && last_name.nil?
    errors.add(:first_name, "last name and first name cannot be both nil")
  end

  def male_cannot_be_sue
    return unless first_name == "Sue" && gender == "male"
    errors.add(:first_name, "cannot be Sue if gender is male")
  end

  def self.get_all_profiles(min_year, max_year)
    Profile.where("birth_year BETWEEN :min_year AND :max_year", min_year: min_year, max_year: max_year)
           .order(:birth_year)
  end
end
