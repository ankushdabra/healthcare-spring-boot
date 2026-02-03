# 🏥 Healthcare Backend (Spring Boot)

Backend service for the Healthcare application built using **Spring Boot**, **PostgreSQL**, and **JWT authentication**.

This service provides secure REST APIs for authentication, doctors, patients, appointments, and prescriptions.

---

## 🚀 Tech Stack

- Java 17+
- Spring Boot 3
- Spring Security (JWT)
- Spring Data JPA (Hibernate)
- PostgreSQL
- Swagger / OpenAPI
- Maven

---

## 📂 Project Structure

src/main/java/com/healthcare
│
├── auth
├── doctors
├── patients
├── appointments
├── prescriptions
├── config
├── dto
├── repository
├── service
└── controller

---

## 🔐 Authentication

Authorization: Bearer <JWT_TOKEN>

---

## 📌 Key API

GET /api/doctors

---

## ▶️ Run

mvn spring-boot:run

---

## 📖 Swagger

http://localhost:8080/swagger-ui/index.html
