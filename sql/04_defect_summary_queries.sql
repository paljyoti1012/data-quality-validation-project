-- 04_defect_summary_queries.sql

SELECT 'Duplicate Records' AS defect_type, COUNT(*) AS issue_count
FROM (
    SELECT patient_id
    FROM target_patient_treatments
    GROUP BY patient_id
    HAVING COUNT(*) > 1
) d
UNION ALL
SELECT 'Null Mandatory Fields', COUNT(*)
FROM target_patient_treatments
WHERE patient_id IS NULL
   OR patient_name IS NULL
   OR treatment_date IS NULL
   OR treatment_type IS NULL
   OR treatment_cost IS NULL
   OR hospital_code IS NULL
UNION ALL
SELECT 'Invalid Treatment Cost', COUNT(*)
FROM target_patient_treatments
WHERE treatment_cost <= 0
UNION ALL
SELECT 'Missing Records In Target', COUNT(*)
FROM source_patient_treatments s
LEFT JOIN target_patient_treatments t
    ON s.patient_id = t.patient_id
WHERE t.patient_id IS NULL;
