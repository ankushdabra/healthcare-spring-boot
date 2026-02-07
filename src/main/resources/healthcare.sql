CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('PATIENT', 'DOCTOR', 'ADMIN')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE doctors (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID UNIQUE NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    experience INT,
    consultation_fee NUMERIC(10,2),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE patients (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID UNIQUE NOT NULL,
    age INT,
    gender VARCHAR(10),
    blood_group VARCHAR(5),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE appointments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    doctor_id UUID NOT NULL,
    patient_id UUID NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('BOOKED', 'CANCELLED', 'COMPLETED')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE prescriptions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    appointment_id UUID UNIQUE NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE
);

CREATE TABLE medicines (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    prescription_id UUID NOT NULL,
    medicine_name VARCHAR(100) NOT NULL,
    dosage VARCHAR(50),
    duration VARCHAR(50),
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(id) ON DELETE CASCADE
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_appointments_doctor ON appointments(doctor_id);
CREATE INDEX idx_appointments_patient ON appointments(patient_id);

INSERT INTO users (id, name, email, password, role) VALUES
(gen_random_uuid(), 'Dr Amit Sharma', 'dr1@clinic.com', 'pass', 'DOCTOR'),
(gen_random_uuid(), 'Dr Neha Verma', 'dr2@clinic.com', 'pass', 'DOCTOR'),
(gen_random_uuid(), 'Dr Rajesh Gupta', 'dr3@clinic.com', 'pass', 'DOCTOR'),
(gen_random_uuid(), 'Dr Pooja Singh', 'dr4@clinic.com', 'pass', 'DOCTOR'),
(gen_random_uuid(), 'Dr Anil Mehta', 'dr5@clinic.com', 'pass', 'DOCTOR'),
(gen_random_uuid(), 'Rahul Kumar', 'p1@gmail.com', 'pass', 'PATIENT'),
(gen_random_uuid(), 'Amit Jain', 'p2@gmail.com', 'pass', 'PATIENT'),
(gen_random_uuid(), 'Neha Sharma', 'p3@gmail.com', 'pass', 'PATIENT'),
(gen_random_uuid(), 'Rohit Verma', 'p4@gmail.com', 'pass', 'PATIENT'),
(gen_random_uuid(), 'Priya Singh', 'p5@gmail.com', 'pass', 'PATIENT'),
(gen_random_uuid(), 'Kunal Mehta', 'p6@gmail.com', 'pass', 'PATIENT'),
(gen_random_uuid(), 'Anjali Gupta', 'p7@gmail.com', 'pass', 'PATIENT'),
(gen_random_uuid(), 'Suresh Yadav', 'p8@gmail.com', 'pass', 'PATIENT'),
(gen_random_uuid(), 'Pankaj Mishra', 'p9@gmail.com', 'pass', 'PATIENT'),
(gen_random_uuid(), 'Sunita Devi', 'p10@gmail.com', 'pass', 'PATIENT'),
(gen_random_uuid(), 'Vikas Chauhan', 'p11@gmail.com', 'pass', 'PATIENT'),
(gen_random_uuid(), 'Kavita Joshi', 'p12@gmail.com', 'pass', 'PATIENT'),
(gen_random_uuid(), 'Nitin Aggarwal', 'p13@gmail.com', 'pass', 'PATIENT'),
(gen_random_uuid(), 'Ritu Saxena', 'p14@gmail.com', 'pass', 'PATIENT'),
(gen_random_uuid(), 'Deepak Rawat', 'p15@gmail.com', 'pass', 'PATIENT');

INSERT INTO doctors (id, user_id, specialization, experience, consultation_fee)
SELECT gen_random_uuid(), id, specialization, experience, fee
FROM (
    SELECT id, 'Cardiologist', 10, 500 FROM users WHERE email='dr1@clinic.com'
    UNION ALL
    SELECT id, 'Dermatologist', 8, 400 FROM users WHERE email='dr2@clinic.com'
    UNION ALL
    SELECT id, 'Orthopedic', 12, 600 FROM users WHERE email='dr3@clinic.com'
    UNION ALL
    SELECT id, 'Pediatrician', 6, 350 FROM users WHERE email='dr4@clinic.com'
    UNION ALL
    SELECT id, 'Neurologist', 15, 800 FROM users WHERE email='dr5@clinic.com'
) d(id, specialization, experience, fee);

INSERT INTO patients (id, user_id, age, gender, blood_group)
SELECT gen_random_uuid(), id, age, gender, bg
FROM (
    SELECT id, 28, 'Male', 'O+' FROM users WHERE email='p1@gmail.com'
    UNION ALL SELECT id, 34, 'Male', 'A+' FROM users WHERE email='p2@gmail.com'
    UNION ALL SELECT id, 25, 'Female', 'B+' FROM users WHERE email='p3@gmail.com'
    UNION ALL SELECT id, 41, 'Male', 'AB+' FROM users WHERE email='p4@gmail.com'
    UNION ALL SELECT id, 29, 'Female', 'O-' FROM users WHERE email='p5@gmail.com'
    UNION ALL SELECT id, 36, 'Male', 'A-' FROM users WHERE email='p6@gmail.com'
    UNION ALL SELECT id, 31, 'Female', 'B-' FROM users WHERE email='p7@gmail.com'
    UNION ALL SELECT id, 48, 'Male', 'O+' FROM users WHERE email='p8@gmail.com'
    UNION ALL SELECT id, 39, 'Male', 'A+' FROM users WHERE email='p9@gmail.com'
    UNION ALL SELECT id, 52, 'Female', 'AB-' FROM users WHERE email='p10@gmail.com'
    UNION ALL SELECT id, 27, 'Male', 'O+' FROM users WHERE email='p11@gmail.com'
    UNION ALL SELECT id, 33, 'Female', 'B+' FROM users WHERE email='p12@gmail.com'
    UNION ALL SELECT id, 45, 'Male', 'A+' FROM users WHERE email='p13@gmail.com'
    UNION ALL SELECT id, 24, 'Female', 'O-' FROM users WHERE email='p14@gmail.com'
    UNION ALL SELECT id, 38, 'Male', 'B+' FROM users WHERE email='p15@gmail.com'
) p(id, age, gender, bg);

INSERT INTO prescriptions (id, appointment_id, notes)
SELECT
    gen_random_uuid(),
    id,
    'General checkup and medication advised'
FROM appointments
LIMIT 20;


INSERT INTO appointments (
    id,
    doctor_id,
    patient_id,
    appointment_date,
    appointment_time,
    status
)
SELECT
    gen_random_uuid(),
    d.id,
    p.id,
    DATE '2026-02-10'
        + ((ROW_NUMBER() OVER () % 5) * INTERVAL '1 day'),
    TIME '10:00'
        + ((ROW_NUMBER() OVER () * 30) * INTERVAL '1 minute'),
    'BOOKED'
FROM doctors d
JOIN patients p ON TRUE
LIMIT 20;


INSERT INTO medicines (id, prescription_id, medicine_name, dosage, duration)
SELECT gen_random_uuid(), id, 'Paracetamol', '500 mg', '5 days'
FROM prescriptions
LIMIT 20;

INSERT INTO medicines (id, prescription_id, medicine_name, dosage, duration)
SELECT gen_random_uuid(), id, 'Vitamin D', '60k IU', '1 week'
FROM prescriptions
LIMIT 20;

ALTER USER postgres WITH PASSWORD 'postgres';



UPDATE users
SET password = '$2a$10$Dow1F7fZ9qYwF0Y9JjM5nO0Jp0m6C3U1Z5D5ZpH9kF2zQm2QqX9lK';

ALTER TABLE doctors
ADD COLUMN name VARCHAR(100),
ADD COLUMN qualification VARCHAR(150),
ADD COLUMN about TEXT,
ADD COLUMN rating NUMERIC(2,1),
ADD COLUMN clinic_address VARCHAR(255),
ADD COLUMN profile_image VARCHAR(255);

ALTER TABLE doctors
ALTER COLUMN rating SET DEFAULT 4.0;

ALTER TABLE doctors
ADD CONSTRAINT chk_doctor_experience
CHECK (experience >= 0);

ALTER TABLE doctors
ADD CONSTRAINT chk_consultation_fee
CHECK (consultation_fee >= 0);

CREATE INDEX idx_doctors_specialization
ON doctors (specialization);

CREATE TABLE doctor_availability (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    doctor_id UUID NOT NULL,
    day VARCHAR(10) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    CONSTRAINT fk_doctor_availability_doctor
        FOREIGN KEY (doctor_id)
        REFERENCES doctors(id)
        ON DELETE CASCADE
);




-- Child tables first
DELETE FROM medicines;
DELETE FROM prescriptions;
DELETE FROM appointments;
DELETE FROM doctor_availability;

-- Parent tables
DELETE FROM doctors;
DELETE FROM patients;
DELETE FROM users;

INSERT INTO users (id, name, email, password, role, created_at) VALUES
('11111111-1111-1111-1111-111111111111', 'Dr Amit Sharma', 'amit@clinic.com', 'hashed_password_1', 'DOCTOR', NOW()),
('22222222-2222-2222-2222-222222222222', 'Rahul Verma', 'rahul@gmail.com', 'hashed_password_2', 'PATIENT', NOW());

INSERT INTO doctors (
  id, user_id, specialization, experience, consultation_fee,
  name, qualification, about, rating, clinic_address, profile_image
) VALUES (
  '33333333-3333-3333-3333-333333333333',
  '11111111-1111-1111-1111-111111111111',
  'Cardiology',
  12,
  800,
  'Dr Amit Sharma',
  'MBBS, MD (Cardiology)',
  'Experienced cardiologist with 12+ years of practice',
  4.7,
  'Delhi Heart Clinic, New Delhi',
  'profile.jpg'
);

INSERT INTO patients (id, user_id, age, gender, blood_group) VALUES (
  '44444444-4444-4444-4444-444444444444',
  '22222222-2222-2222-2222-222222222222',
  29,
  'MALE',
  'O+'
);

INSERT INTO doctor_availability (id, doctor_id, day, start_time, end_time) VALUES
('55555555-5555-5555-5555-555555555555', '33333333-3333-3333-3333-333333333333', 'MONDAY', '10:00', '13:00'),
('66666666-6666-6666-6666-666666666666', '33333333-3333-3333-3333-333333333333', 'WEDNESDAY', '14:00', '18:00');

SELECT pg_get_constraintdef(oid)
FROM pg_constraint
WHERE conname = 'appointments_status_check';


INSERT INTO appointments (
  id, doctor_id, patient_id, appointment_date,
  appointment_time, status, created_at
) VALUES (
  '77777777-7777-7777-7777-777777777777',
  '33333333-3333-3333-3333-333333333333',
  '44444444-4444-4444-4444-444444444444',
  CURRENT_DATE,
  '11:30',
  'BOOKED',
  NOW()
);

INSERT INTO prescriptions (id, appointment_id, notes, created_at) VALUES (
  '88888888-8888-8888-8888-888888888888',
  '77777777-7777-7777-7777-777777777777',
  'Patient advised regular exercise and medication',
  NOW()
);

INSERT INTO medicines (id, prescription_id, medicine_name, dosage, duration) VALUES
('99999999-9999-9999-9999-999999999999', '88888888-8888-8888-8888-888888888888', 'Aspirin', '75mg', '30 days'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '88888888-8888-8888-8888-888888888888', 'Atorvastatin', '10mg', '30 days');


























