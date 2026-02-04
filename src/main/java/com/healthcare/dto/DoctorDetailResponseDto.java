package com.healthcare.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Data
public class DoctorDetailResponseDto {

    private UUID id;
    private String name;
    private String specialization;
    private String qualification;
    private Integer experience;
    private BigDecimal rating;
    private BigDecimal consultationFee;
    private String about;
    private String clinicAddress;
    private String profileImage;

    private List<DoctorAvailabilityDto> availability;
}
