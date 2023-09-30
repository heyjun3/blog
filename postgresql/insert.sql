WITH
    INSERT AS (
        INSERT INTO
            exam (student_id, scoring_date, VALUE)
        SELECT
            gen_random_uuid () AS student_id,
            '2020-01-01'::date + (INTERVAL '1 day') * ROUND(RANDOM() * 365 * 2) AS scoring_date,
            (RANDOM() * 100) AS VALUE
        FROM
            GENERATE_SERIES(1, 100)
        RETURNING
            student_id
    )
INSERT INTO
    exam (student_id, scoring_date, VALUE)
SELECT
    INSERT.student_id,
    '2020-01-01'::date + (INTERVAL '1 day') * ROUND(RANDOM() * 365 * 2) AS scoring_date,
    (RANDOM() * 100)::INT
FROM
    INSERT,
    GENERATE_SERIES(1, 100);
