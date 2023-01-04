class SlotsController < ApplicationController

    def save_slots_and_capacity
        slot = Slot.new(new_params)
        begin
            if slot.valid?
                slot_duration = Constants::SLOT_DURATION
                total_minutes = (slot.end_time - slot.start_time).to_i/60
                slot_colletion_count = total_minutes/slot_duration
                capacity_per_slot = slot.total_capacity.to_f/slot_colletion_count.to_f
                arr_capacity_per_slot = capacity_per_slot.to_s.split(".")
                integer_division = arr_capacity_per_slot[0].to_i
                fraction_division = arr_capacity_per_slot[1].to_i
                if fraction_division.to_i > 0 
                    Rails.logger.info "extra capacity: Divide capacity to last slots"
                end
                if slot.save
                    pending_capacity = slot.total_capacity
                    slots_hash = Hash.new
                    integer_division.times do |asc_division|
                        
                        (1..slot_colletion_count).each do |slot_obj|
                            
                            slots_hash[slot_obj]=slots_hash[slot_obj].nil? ? 1 : (slots_hash[slot_obj]+1)
                            pending_capacity=pending_capacity-1
                        end
                    end
                    
                    if fraction_division!=0
                        slot_colletion_count.downto(1) do |slot_obj|
                            
                            if pending_capacity>0
                                slots_hash[slot_obj]=slots_hash[slot_obj]+1
                                pending_capacity=pending_capacity-1
                            end
                        end
                    end
                    slot_start_time = slot.start_time
                    slot_end_time = slot_start_time + 15.minutes # + 10*60
                    slots_hash.each do |slot_number, capacity_count|
                        SlotCollection.create(slots_id: slot.id, start_time: slot_start_time,end_time: slot_end_time, capacity: capacity_count)
                        slot_start_time = slot_end_time
                    end
                    slotcollections = SlotCollection.where(slots_id: slot.id)
                    render json: {slot: {id:slot.id, start_time:slot.start_time, end_time:slot.end_time, total_capacity: slot.total_capacity, slot_collections: slotcollections}}
                end
            else
                error = slot.errors.objects.first
                errormsg = error.attribute.to_s+' '+error.message
                render json: {message: errormsg}
            end
        rescue => e
            render json: {message: e.message}
        end
    end

    private
    def new_params
        params.require(:slot).permit(:start_time, :end_time, :total_capacity)
    end
end
