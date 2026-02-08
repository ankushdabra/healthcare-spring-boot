package com.healthcare.service;

import com.healthcare.dto.UserProfileDto;
import com.healthcare.entity.PatientEntity;
import com.healthcare.entity.UserEntity;
import com.healthcare.enums.Role;
import com.healthcare.repository.PatientRepository;
import com.healthcare.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ProfileService {

    private final UserRepository userRepository;
    private final PatientRepository patientRepository;

    public ProfileService(UserRepository userRepository, PatientRepository patientRepository) {
        this.userRepository = userRepository;
        this.patientRepository = patientRepository;
    }

    public UserProfileDto getUserProfile(String email) {
        UserEntity user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found for email: " + email));

        UserProfileDto.UserProfileDtoBuilder profileBuilder = UserProfileDto.builder()
                .id(user.getId())
                .name(user.getName())
                .email(user.getEmail())
                .role(user.getRole());

        if (user.getRole() == Role.PATIENT) {
            patientRepository.findByUser(user).ifPresent(patient -> profileBuilder
                    .age(patient.getAge())
                    .gender(patient.getGender())
                    .bloodGroup(patient.getBloodGroup()));
        }

        return profileBuilder.build();
    }
}