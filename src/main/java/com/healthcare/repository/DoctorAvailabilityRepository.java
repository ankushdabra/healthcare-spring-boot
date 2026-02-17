package com.healthcare.repository;

import com.healthcare.entity.DoctorAvailabilityEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface DoctorAvailabilityRepository extends JpaRepository<DoctorAvailabilityEntity, UUID> {
    List<DoctorAvailabilityEntity> findByDoctorId(UUID doctorId);
    List<DoctorAvailabilityEntity> findByDoctorIdIn(List<UUID> doctorIds);
    Optional<DoctorAvailabilityEntity> findTopByDoctorIdOrderByDayAscStartTimeAsc(UUID doctorId);
    @Modifying
    void deleteByDoctorId(UUID doctorId);
}
