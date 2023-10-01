WITH
    student AS (
        SELECT
            gen_random_uuid () AS id
        FROM
            GENERATE_SERIES(1, 1000)
    )
INSERT INTO
    exam (student_id, scoring_date, VALUE)
SELECT
    student.id,
    '2020-01-01'::date + (INTERVAL '1 day') * ROUND(RANDOM() * 365 * 2) AS scoring_date,
    (RANDOM() * 100)::INT
FROM
    student,
    GENERATE_SERIES(1, 1000);
