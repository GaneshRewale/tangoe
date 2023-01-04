class Slot < ActiveRecord::Base
    #Association
    has_many :slot_collections

    #Validations 
    # validates :start_time, :presence => true, comparison: { greater_than: -> { Date.today } }
    # validates :end_time, :presence => true, comparison: { greater_than: :starttime }
    validates :total_capacity, :presence => true, numericality: { only_integer: true }
    validate :start_must_not_be_in_past

    def start_must_not_be_in_past
        errors.add(:start_time, "should not be in the past") unless
        start_time > Time.now
        errors.add(:end_time, "should be greater than #{:start_time}") unless
        start_time < end_time
        errors.add("minimun difference between #{:start_time} and #{:end_time}" ,"should be #{Constants::SLOT_DURATION} minutes.") unless
        (end_time - start_time).to_i/60 >= Constants::SLOT_DURATION
    end 
end
