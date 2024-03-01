# bus schedule algorithm
# could do O(log n) using binary search since the bus schedule is sorted!

# return time in minutes
def bus_schedule_diff(bus_schedule, now)
    # remove colon for str comparison
    bus_times = bus_schedule.map {|bus_time| bus_time.gsub(':', '')}
    now = now.gsub(':', '')
    # compare each string
    bus_times.each_with_index do |bus_time, idx|
        # first bus hasnt left
        return -1 if idx == 0 && bus_time >= now
        # current bus hasnt left
        return 0 if bus_time == now
        # time after last bus
        return calculate_minutes(bus_time, now) if idx == bus_schedule.length - 1 && bus_time > now
        if bus_time < now && bus_times[idx+1] > now
            return calculate_minutes(bus_time, now)
        end
    end
end

def calculate_minutes(earlier_time, later_time)
    # convert to ints for calculation
    earlier_time = convert_time_str_to_ints(earlier_time)
    later_time = convert_time_str_to_ints(later_time)

    hours_to_minutes = (later_time[0] - earlier_time[0]) * 60
    minutes = later_time[1] - earlier_time[1]

    hours_to_minutes + minutes
end

def convert_time_str_to_ints(time)
    [time[0..1], time[2..3]].map(&:to_i)
end
