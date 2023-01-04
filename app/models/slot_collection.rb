class SlotCollection < ApplicationRecord
    #Association
    belongs_to :slot, optional: true

    validates :slots_id,
            :presence => true
end
