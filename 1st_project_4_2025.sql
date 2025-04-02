-- Creating tables with data for exploration

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    birth_date DATE,
    city VARCHAR(50)
);

INSERT INTO patients VALUES
(1, 'John', 'Doe', 'Male', '1985-03-15', 'New York'),
(2, 'Jane', 'Smith', 'Female', '1990-07-22', 'Chicago'),
(3, 'Mike', 'Johnson', 'Male', '1978-11-05', 'Houston'),
(4, 'Emily', 'Davis', 'Female', '1989-05-30', 'Los Angeles'),
(5, 'David', 'Wilson', 'Male', '1995-09-18', 'Miami');

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialization VARCHAR(50)
);

INSERT INTO doctors VALUES
(101, 'Sarah', 'Brown', 'Cardiology'),
(102, 'James', 'Lee', 'Neurology'),
(103, 'Lisa', 'Taylor', 'Pediatrics');

CREATE TABLE admissions (
    admission_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    admission_date DATE,
    discharge_date DATE,
    diagnosis VARCHAR(100),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

INSERT INTO admissions VALUES
(1001, 1, 101, '2023-01-10', '2023-01-15', 'Heart Disease'),
(1002, 2, 102, '2023-02-05', '2023-02-10', 'Migraine'),
(1003, 3, 103, '2023-03-12', '2023-03-18', 'Pneumonia'),
(1004, 4, 101, '2023-04-20', '2023-04-25', 'Hypertension'),
(1005, 5, 102, '2023-05-15', '2023-05-20', 'Concussion');

-- Selecting all patients from New York City
SELECT *
FROM patients
WHERE city = 'New York';

-- Using COUNT and GROUP BY functions to count patients by gender
SELECT gender, COUNT(*) AS patient_count
FROM patients 
GROUP BY gender;

-- Using JOIN statements to match patients with doctors
SELECT 
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    a.diagnosis
FROM admissions a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;

-- Calculating the total cost of treatments for patients
SELECT 
    p.first_name,
    p.last_name,
    SUM(t.cost) AS total_treatment_cost
FROM treatments t
JOIN admissions a ON t.admission_id = a.admission_id
JOIN patients p ON a.patient_id = p.patient_id
GROUP BY p.patient_id;

-- identifying patients with longest stays
SELECT 
    p.first_name,
    p.last_name,
    DATEDIFF(a.discharge_date, a.admission_date) AS days_hospitalized
FROM admissions a
JOIN patients p ON a.patient_id = p.patient_id
ORDER BY days_hospitalized DESC;
