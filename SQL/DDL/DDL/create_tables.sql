-- Experiments Table
CREATE TABLE experiments (
    experiment_id INT PRIMARY KEY,
    experiment_name VARCHAR(255),
    scientist_id INT,
    start_date TIMESTAMP,
    end_date TIMESTAMP
);

-- Process Types Table
CREATE TABLE process_type (
    process_type_id INT PRIMARY KEY,
    process_name VARCHAR(50),
    quantity INT 
    measurable_inputs_temperature JSONB,  -- Type-specific inputs (e.g., temperature)
    measurable_inputs_pressure JSONB,  -- Type-specific inputs (e.g., pressure)
    measurable_outputs JSONB  -- Type-specific outputs (e.g., carbon levels)
);

-- Processes Table
CREATE TABLE processes (
    process_id INT PRIMARY KEY,
    experiment_id INT REFERENCES experiments(experiment_id),
    process_type_id INT REFERENCES process_type(process_type_id),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    quantity INT,
    equipment_id INT REFERENCES equipment(equipment_id),
    input_description VARCHAR(50)
    output_description VARCHAR(50)
);

-- Equipment Table
CREATE TABLE equipment (
    equipment_id INT PRIMARY KEY,
    equipment_type VARCHAR(50),
    unique_identifier VARCHAR(50),
    location VARCHAR(50)
);

-- Samples Table
CREATE TABLE samples (
    sample_id INT PRIMARY KEY,
    process_id INT REFERENCES processes(process_id),
    sample_stage VARCHAR(10) CHECK (sample_stage IN ('start', 'middle', 'end')),
    collected_at TIMESTAMP
);

-- Instruments Table
CREATE TABLE instruments (
    instrument_id INT PRIMARY KEY,
    instrument_name VARCHAR(255),
    capabilities VARCHAR(255),
    last_calibration_date TIMESTAMP,
    calibration_frequency INT,  -- Days between calibrations
    next_calibration_date TIMESTAMP GENERATED ALWAYS AS (last_calibration_date + INTERVAL '1 DAY' * calibration_frequency)
);

-- Analyses Table
CREATE TABLE analyses (
    analysis_id INT PRIMARY KEY,
    sample_id INT REFERENCES samples(sample_id),
    instrument_id INT REFERENCES instruments(instrument_id),
    analysis_type VARCHAR(50),
    parameters JSONB,            -- Configurable parameters in JSON format
    structured_data JSONB,       -- Structured data (e.g., time series mass measurements)
    unstructured_data_url VARCHAR(255), -- URL to unstructured data (e.g., image file)
    result_data_type VARCHAR(10),  -- Specifies the type, e.g., "structured" or "unstructured", which can help with query filtering
    performed_at TIMESTAMP
);
