-- 03_validation_checks.sql

-- Record count validation
SELECT 'source_count' AS check_name, COUNT(*) AS record_count FROM source_patient_treatments
UNION ALL
SELECT 'target_count' AS check_name, COUNT(*) AS record_count FROM target_patient_treatments;

-- Duplicate records in target
SELECT patient_id, COUNT(*) AS duplicate_count
FROM target_patient_treatments
GROUP BY patient_id
HAVING COUNT(*) > 1;

-- Null mandatory fields
SELECT *
FROM target_patient_treatments
WHERE patient_id IS NULL
   OR patient_name IS NULL
   OR treatment_date IS NULL
   OR treatment_type IS NULL
   OR treatment_cost IS NULL
   OR hospital_code IS NULL;

-- Business rule validation
SELECT *
FROM target_patient_treatments
WHERE treatment_cost <= 0;

-- Reconciliation failures
SELECT
    s.patient_id,
    s.treatment_cost AS source_treatment_cost,
    t.treatment_cost AS target_treatment_cost
FROM source_patient_treatments s
JOIN target_patient_treatments t
    ON s.patient_id = t.patient_id
WHERE s.treatment_cost <> t.treatment_cost
   OR (s.treatment_cost IS NULL AND t.treatment_cost IS NOT NULL)
   OR (s.treatment_cost IS NOT NULL AND t.treatment_cost IS NULL);

-- Missing records in target
SELECT s.*
FROM source_patient_treatments s
LEFT JOIN target_patient_treatments t
    ON s.patient_id = t.patient_id
WHERE t.patient_id IS NULL;
