-- Active: 1747673903675@@127.0.0.1@5432@conservation_db@public
CREATE DATABASE conservation_db;

-- Create rangers table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    region VARCHAR(40) NOT NULL
);

-- Create species table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(40) NOT NULL,
    scientific_name VARCHAR(60),
    discovery_date DATE,
    conservation_status VARCHAR(50) NOT NULL
);

-- Create sightings table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers (ranger_id),
    species_id INT REFERENCES species (species_id),
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(80) NOT NULL,
    notes TEXT
);

-- Insert into rangers
INSERT INTO
    rangers (name, region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    );

-- Insert into species
INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

-- Insert into sightings
INSERT INTO
    sightings (
        ranger_id,
        species_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        'Peak Ridge',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen'
    ),
    (
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        2,
        1,
        'Snowfall Pass',
        '2024-05-18 18:30:00',
        NULL
    );

SELECT * FROM rangers;

SELECT * FROM species;

SELECT * FROM sightings;

-- problem - 1
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- problem - 2
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- problem - 3
SELECT * FROM sightings WHERE location LIKE '%Pass';

-- problem - 4
SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
    LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY
    r.ranger_id
ORDER BY r.name;

-- problem - 5
SELECT common_name
FROM species
WHERE
    species_id NOT IN (
        SELECT species_id
        FROM sightings
    );

-- problem - 6
SELECT sp.common_name, s.sighting_time, r.name
FROM
    sightings s
    JOIN species sp ON s.species_id = sp.species_id
    JOIN rangers r ON s.ranger_id = r.ranger_id
LIMIT 2;

-- problem - 7
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    discovery_date < '1800-01-01';

-- problem - 8
SELECT
    sighting_id,
    CASE
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) < 12 THEN 'Morning'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) BETWEEN 12 AND 17  THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;

-- problem - 9
DELETE FROM rangers
WHERE ranger_id NOT IN (
  SELECT DISTINCT ranger_id FROM sightings
);

