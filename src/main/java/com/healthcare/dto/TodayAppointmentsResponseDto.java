package com.healthcare.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TodayAppointmentsResponseDto {
    private List<AppointmentResponseDto> appointments;
    private BigDecimal totalEarnings;
}
