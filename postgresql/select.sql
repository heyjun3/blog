EXPLAIN
ANALYZE
SELECT
    student_id,
    scoring_date,
    VALUE
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
    );

EXPLAIN
ANALYZE
SELECT
    exam.student_id,
    exam.scoring_date,
    exam.value
FROM
    exam
    INNER JOIN (
        SELECT
            student_id,
            MAX(scoring_date) AS latest
        FROM
            exam
        GROUP BY
            student_id
    ) ex ON exam.student_id = ex.student_id
    AND exam.scoring_date = ex.latest;

SELECT
    student_id,
    scoring_date,
    VALUE
FROM
    exam
WHERE
    student_id = '914a47da-1974-4e23-a012-bc9397d2e073'
ORDER BY
    scoring_date DESC
LIMIT
    1;