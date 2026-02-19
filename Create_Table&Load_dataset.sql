CREATE TABLE edtech_funnel (
    lead_id INT,
    lead_date DATE,
    source VARCHAR(50),
    region VARCHAR(50),
    trial VARCHAR(10),
    enrolled VARCHAR(10),
    retained VARCHAR(10),
    course_fee INT,
    discount INT,
    batch_type VARCHAR(20),
    parent_income_segment VARCHAR(20)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/edtech_dataset.csv'
INTO TABLE edtech_funnel
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'secure_file_priv';

