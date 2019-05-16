# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'action_view'

module CatMaker

  COLORS = %w(red green blue yellow purple mint green teal white black orange 
    pink grey maroon violet turquoise tan sky blue salmon plum orchid olive
    magenta lime ivory indigo gold fuchsia cyan azure lavender silver).freeze

  def get_color
    COLORS.sample
  end

  def colors
    COLORS
  end

  def get_bday
    y = rand(0..2018)
    m = rand(1..12)
    d = rand(1..28)

    "#{y}/#{m}/#{d}"
  end

  def get_sex
    ['M', 'F'].sample
  end

end


class Cat < ApplicationRecord
  extend CatMaker
  include ActionView::Helpers::DateHelper

  validates :color, inclusion: self.colors
  validates :sex, inclusion: %w(M F)
  validates :birth_date, :color, :name, :sex, presence: true

  # Remember, has_many is just a method where the first argument is
  # the name of the association, and the second argument is an options
  # hash.
  has_many :rental_requests,
    class_name: :CatRentalRequest,
    dependent: :destroy

  def age
    time_ago_in_words(birth_date)
  end
end
