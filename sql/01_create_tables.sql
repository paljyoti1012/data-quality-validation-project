-- 01_create_tables.sql
CREATE TABLE source_patient_treatments (
    patient_id INT,
    patient_name VARCHAR(100),
    treatment_date DATE,
    treatment_type VARCHAR(100),
    treatment_cost DECIMAL(10,2),
    hospital_code VARCHAR(20)
);

CREATE TABLE target_patient_treatments (
    patient_id INT,
    patient_name VARCHAR(100),
    treatment_date DATE,
    treatment_type VARCHAR(100),
    treatment_cost DECIMAL(10,2),
    hospital_code VARCHAR(20)
);
