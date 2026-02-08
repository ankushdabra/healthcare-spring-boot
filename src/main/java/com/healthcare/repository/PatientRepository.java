package com.healthcare.repository;

import com.healthcare.entity.PatientEntity;
import com.healthcare.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface PatientRepository extends JpaRepository<PatientEntity, UUID> {
    Optional<PatientEntity> findByUser(UserEntity user);
    Optional<PatientEntity> findByUserId(UUID userId);
}