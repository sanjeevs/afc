class Producer < ActiveRecord::Base
   validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
   before_save { |producer| producer.name = name.titleize }

   has_many :production_run, dependent: :destroy

end
