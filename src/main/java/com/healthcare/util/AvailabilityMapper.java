package com.healthcare.util;

import com.healthcare.dto.TimeSlotDto;
import com.healthcare.entity.DoctorAvailabilityEntity;
import com.healthcare.enums.DayOfWeekEnum;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class AvailabilityMapper {

    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("hh:mm a");

    public Map<String, List<TimeSlotDto>> map(List<DoctorAvailabilityEntity> availabilityEntities) {
        Map<DayOfWeekEnum, List<DoctorAvailabilityEntity>> availabilityByDay = availabilityEntities.stream()
                .collect(Collectors.groupingBy(DoctorAvailabilityEntity::getDay));

        Map<String, List<TimeSlotDto>> result = new LinkedHashMap<>();
        LocalDate today = LocalDate.now();
        LocalTime now = LocalTime.now();
        DayOfWeekEnum todayEnum = DayOfWeekEnum.valueOf(today.getDayOfWeek().name().substring(0, 3));

        for (DayOfWeekEnum day : DayOfWeekEnum.values()) {
            if (availabilityByDay.containsKey(day)) {
                List<DoctorAvailabilityEntity> dayAvailability = availabilityByDay.get(day);
                List<TimeSlotDto> timeSlots;

                if (day == todayEnum) {
                    timeSlots = dayAvailability.stream()
                            .filter(availability -> availability.getStartTime().isAfter(now))
                            .sorted(Comparator.comparing(DoctorAvailabilityEntity::getStartTime))
                            .map(this::toTimeSlotDto)
                            .collect(Collectors.toList());
                } else {
                    timeSlots = dayAvailability.stream()
                            .sorted(Comparator.comparing(DoctorAvailabilityEntity::getStartTime))
                            .map(this::toTimeSlotDto)
                            .collect(Collectors.toList());
                }

                if (!timeSlots.isEmpty()) {
                    result.put(day.name(), timeSlots);
                }
            }
        }

        return result;
    }

    private TimeSlotDto toTimeSlotDto(DoctorAvailabilityEntity entity) {
        return TimeSlotDto.builder()
                .startTime(entity.getStartTime().format(TIME_FORMATTER))
                .endTime(entity.getEndTime().format(TIME_FORMATTER))
                .build();
    }
}
