package com.healthcare.repository;

import com.healthcare.entity.AppointmentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@Repository
public interface AppointmentRepository extends JpaRepository<AppointmentEntity, UUID> {
    boolean existsByDoctorIdAndAppointmentDateAndAppointmentTime(UUID doctorId, LocalDate appointmentDate, LocalTime appointmentTime);
    
    @Query("SELECT a FROM AppointmentEntity a WHERE a.patient.id = :patientId AND (a.appointmentDate > :currentDate OR (a.appointmentDate >= :currentDate AND a.appointmentTime >= :currentTime)) AND a.status = com.healthcare.enums.AppointmentStatus.BOOKED ORDER BY a.appointmentDate ASC, a.appointmentTime ASC")
    List<AppointmentEntity> findUpcomingAppointmentsForPatient(@Param("patientId") UUID patientId, @Param("currentDate") LocalDate currentDate, @Param("currentTime") LocalTime currentTime);

    @Query("SELECT a FROM AppointmentEntity a WHERE a.doctor.id = :doctorId AND (a.appointmentDate > :currentDate OR (a.appointmentDate >= :currentDate AND a.appointmentTime >= :currentTime)) AND a.status = com.healthcare.enums.AppointmentStatus.BOOKED ORDER BY a.appointmentDate ASC, a.appointmentTime ASC")
    List<AppointmentEntity> findUpcomingAppointmentsForDoctor(@Param("doctorId") UUID doctorId, @Param("currentDate") LocalDate currentDate, @Param("currentTime") LocalTime currentTime);

    @Query("SELECT a FROM AppointmentEntity a WHERE a.doctor.id = :doctorId AND a.appointmentDate = :currentDate AND a.appointmentTime >= :currentTime AND a.status = com.healthcare.enums.AppointmentStatus.BOOKED ORDER BY a.appointmentDate ASC, a.appointmentTime ASC")
    List<AppointmentEntity> findTodayAppointmentsForDoctor(@Param("doctorId") UUID doctorId, @Param("currentDate") LocalDate currentDate, @Param("currentTime") LocalTime currentTime);

}
