# 🏥 Healthcare Management System (Spring Boot)

![Java](https://img.shields.io/badge/Java-17%2B-ED8B00?style=for-the-badge&logo=java&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-3.x-6DB33F?style=for-the-badge&logo=spring-boot&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![JWT](https://img.shields.io/badge/JWT-Auth-000000?style=for-the-badge&logo=json-web-tokens&logoColor=white)

A robust and scalable backend service for a comprehensive Healthcare Management System. Built with **Spring Boot**, **Spring Security**, and **PostgreSQL**, this application provides secure RESTful APIs for managing doctors, patients, appointments, and prescriptions.

---

## ✨ Key Features

*   **🔐 Secure Authentication**: Role-based access control (RBAC) using JWT (JSON Web Tokens) for Patients and Doctors.
*   **👨‍⚕️ Doctor Management**: 
    *   Detailed doctor profiles with specialization, experience, and consultation fees.
    *   Real-time availability management with slot booking.
    *   Search and filter doctors by specialization.
*   **👤 Patient Management**: 
    *   Comprehensive patient profiles including medical history.
    *   Easy registration and profile updates.
*   **📅 Appointment Scheduling**: 
    *   Book, reschedule, and cancel appointments.
    *   View upcoming and past appointments.
*   **💊 Prescription Management**: 
    *   Digital prescriptions linked to appointments.
    *   Secure access to medical records.
*   **📄 API Documentation**: Integrated Swagger UI for easy API exploration and testing.

---

## 🛠️ Tech Stack

*   **Language**: Java 17+
*   **Framework**: Spring Boot 3.x
*   **Security**: Spring Security, JWT
*   **Database**: PostgreSQL
*   **ORM**: Spring Data JPA (Hibernate)
*   **Build Tool**: Maven
*   **Documentation**: SpringDoc OpenAPI (Swagger UI)

---

## 🚀 Getting Started

### Prerequisites

*   Java 17 or higher installed.
*   Maven installed.
*   PostgreSQL installed and running.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/healthcare-spring-boot.git
    cd healthcare-spring-boot
    ```

2.  **Configure the Database:**
    Update `src/main/resources/application.properties` with your PostgreSQL credentials:
    ```properties
    spring.datasource.url=jdbc:postgresql://localhost:5432/healthcare_db
    spring.datasource.username=your_username
    spring.datasource.password=your_password
    ```

3.  **Build the project:**
    ```bash
    mvn clean install
    ```

4.  **Run the application:**
    ```bash
    mvn spring-boot:run
    ```

The application will start on `http://localhost:8080`.

---

## 📚 API Documentation

Explore the interactive API documentation using Swagger UI:

👉 **[http://localhost:8080/swagger-ui/index.html](http://localhost:8080/swagger-ui/index.html)**

### Key Endpoints

| Method | Endpoint | Description | Access |
| :--- | :--- | :--- | :--- |
| `POST` | `/api/auth/login` | User login (Patient/Doctor) | Public |
| `POST` | `/api/auth/register` | Register a new Patient | Public |
| `GET` | `/api/doctors` | Get list of all doctors | Patient |
| `GET` | `/api/doctors/{id}` | Get detailed doctor profile | Patient |
| `GET` | `/api/profile` | Get current user profile | Authenticated |
| `PUT` | `/api/profile` | Update user profile | Authenticated |
| `POST` | `/api/appointments` | Book an appointment | Patient |

---

## 📂 Project Structure

```
src/main/java/com/healthcare
├── config          # Security & App Configuration
├── controller      # REST Controllers
├── dto             # Data Transfer Objects
├── entity          # JPA Entities
├── enums           # Enumerations (Role, Status, etc.)
├── repository      # Data Access Layer
├── service         # Business Logic
└── util            # Utility Classes
```

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1.  Fork the project
2.  Create your feature branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
