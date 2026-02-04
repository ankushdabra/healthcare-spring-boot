package com.healthcare.dto;

import lombok.Data;

@Data
public class DoctorAvailabilityDto {
    private String day;
    private String startTime;
    private String endTime;
}
