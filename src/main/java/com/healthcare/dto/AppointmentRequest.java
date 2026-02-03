package com.healthcare.dto;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

@Data
public class AppointmentRequest {

    private UUID doctorId;
    private UUID patientId;
    private LocalDate appointmentDate;
    private LocalTime appointmentTime;
}
