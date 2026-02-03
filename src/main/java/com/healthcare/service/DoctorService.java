package com.healthcare.service;

import com.healthcare.dto.DoctorResponseDto;
import com.healthcare.entity.Role;
import com.healthcare.repository.DoctorRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DoctorService {

    private final DoctorRepository doctorRepository;

    public DoctorService(DoctorRepository doctorRepository) {
        this.doctorRepository = doctorRepository;
    }

    public List<DoctorResponseDto> getAllDoctors() {
        return doctorRepository.findAll()
                .stream()
                .filter(doctor -> doctor.getUserEntity().getRole().equals(Role.DOCTOR))
                .map(doctor -> DoctorResponseDto.builder()
                        .id(doctor.getId())
                        .name(doctor.getUserEntity().getName())
                        .specialization(doctor.getSpecialization())
                        .experience(doctor.getExperience())
                        .consultationFee(doctor.getConsultationFee())
                        .build())
                .toList();
    }
}
