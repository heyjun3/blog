DROP TABLE exam;

CREATE TABLE IF NOT EXISTS
    exam (
        id UUID DEFAULT gen_random_uuid (),
        student_id UUID DEFAULT gen_random_uuid (),
        scoring_date TIMESTAMP NOT NULL,
        VALUE INT NOT NULL,
        CONSTRAINT pk_id PRIMARY KEY (id)
    );