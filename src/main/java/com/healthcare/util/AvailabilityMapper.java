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
import java.util.stream.IntStream;

@Component
public class AvailabilityMapper {

    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("hh:mm a");
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public Map<String, List<TimeSlotDto>> map(List<DoctorAvailabilityEntity> availabilityEntities) {
        Map<DayOfWeekEnum, List<DoctorAvailabilityEntity>> availabilityByDay = availabilityEntities.stream()
                .collect(Collectors.groupingBy(DoctorAvailabilityEntity::getDay));

        LocalDate today = LocalDate.now();
        LocalTime now = LocalTime.now();

        return IntStream.range(0, 7)
                .mapToObj(today::plusDays)
                .filter(date -> hasAvailabilityForDate(date, availabilityByDay, today, now))
                .collect(Collectors.toMap(
                        date -> date.format(DATE_FORMATTER),
                        date -> getAvailableTimeSlots(date, availabilityByDay, today, now),
                        (v1, v2) -> v1,
                        LinkedHashMap::new
                ));
    }

    private boolean hasAvailabilityForDate(LocalDate date, Map<DayOfWeekEnum, List<DoctorAvailabilityEntity>> availabilityByDay, LocalDate today, LocalTime now) {
        DayOfWeekEnum dayOfWeek = DayOfWeekEnum.from(date.getDayOfWeek());
        if (!availabilityByDay.containsKey(dayOfWeek)) {
            return false;
        }
        
        if (date.isEqual(today)) {
            return availabilityByDay.get(dayOfWeek).stream()
                    .anyMatch(slot -> slot.getStartTime().isAfter(now));
        }
        
        return true;
    }

    private List<TimeSlotDto> getAvailableTimeSlots(LocalDate date, Map<DayOfWeekEnum, List<DoctorAvailabilityEntity>> availabilityByDay, LocalDate today, LocalTime now) {
        DayOfWeekEnum dayOfWeek = DayOfWeekEnum.from(date.getDayOfWeek());
        
        return availabilityByDay.get(dayOfWeek).stream()
                .filter(slot -> !date.isEqual(today) || slot.getStartTime().isAfter(now))
                .sorted(Comparator.comparing(DoctorAvailabilityEntity::getStartTime))
                .map(this::mapToTimeSlotDto)
                .collect(Collectors.toList());
    }

    private TimeSlotDto mapToTimeSlotDto(DoctorAvailabilityEntity entity) {
        return TimeSlotDto.builder()
                .startTime(entity.getStartTime().format(TIME_FORMATTER))
                .endTime(entity.getEndTime().format(TIME_FORMATTER))
                .build();
    }
}
