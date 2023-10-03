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
    student_id = '01ce6220-5a58-47d0-90b7-d75d5082cc99'
ORDER BY
    scoring_date DESC
LIMIT
    1;

SELECT
    ex.student_id,
    ex.scoring_date,
    ex.VALUE
FROM
    (
        SELECT
            student_id,
            scoring_date,
            VALUE,
            ROW_NUMBER() OVER (
                PARTITION BY
                    student_id
                ORDER BY
                    scoring_date DESC
            ) AS RANK
        FROM
            exam
    ) ex
WHERE
    RANK = 1;

SELECT DISTINCT
    ON (student_id) student_id,
    scoring_date,
    VALUE
FROM
    exam
ORDER BY
    student_id,
    scoring_date DESC;

CREATE INDEX idx_student_id_and_scoring_date ON exam (student_id, scoring_date DESC);

EXPLAIN
ANALYZE
SELECT DISTINCT
    ON (student_id) student_id,
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
    )
ORDER BY
    student_id,
    scoring_date,
    VALUE DESC;

WITH
    latest AS (
        SELECT DISTINCT
            ON (student_id) id
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
        ORDER BY
            student_id,
            scoring_date,
            VALUE
    )
SELECT DISTINCT
    ON (student_id) student_id,
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
        WHERE
            id NOT IN (
                SELECT
                    id
                FROM
                    latest
            )
        GROUP BY
            student_id
    )
ORDER BY
    student_id,
    scoring_date,
    VALUE;

EXPLAIN
ANALYZE
SELECT
    student_id,
    array_value[1],
    array_value[2],
    array_value[3]
FROM
    (
        SELECT
            student_id,
            ARRAY_AGG(
                VALUE
                ORDER BY
                    scoring_date DESC
            ) AS array_value
        FROM
            exam
        GROUP BY
            student_id
    ) tmp;

CREATE MATERIALIZED VIEW
    exam_view AS
SELECT
    student_id,
    ARRAY_AGG(
        VALUE
        ORDER BY
            scoring_date DESC
    ) AS array_value
FROM
    exam
GROUP BY
    student_id;

EXPLAIN
ANALYZE
SELECT
    student_id,
    array_value[1],
    array_value[2],
    array_value[3]
FROM
    exam_view;