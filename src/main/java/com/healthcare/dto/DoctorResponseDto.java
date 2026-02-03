package com.healthcare.dto;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.util.UUID;

@Data
@Builder
public class DoctorResponseDto {
    private UUID id;
    private String name;
    private String specialization;
    private Integer experience;
    private BigDecimal consultationFee;
}
