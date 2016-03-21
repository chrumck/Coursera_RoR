class ChangeBirthYearToNumberInProfile < ActiveRecord::Migration
  def change
    change_column :profiles, :birth_year, :integer
  end
end
