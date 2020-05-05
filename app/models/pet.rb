class Pet < ApplicationRecord

  validates_presence_of :image,
                        :name,
                        :age,
                        :sex

  belongs_to :shelter

end
