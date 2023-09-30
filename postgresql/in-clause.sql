SELECT
    *
FROM
    exam
WHERE
    (student_id, scoring_date) IN (
        SELECT
            student_id,
            MAX(scoring_date)
        FROM
            exam
        GROUP BY
            student_id
    )
;