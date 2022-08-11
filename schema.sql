CREATE TABLE animals( 
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth date,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg NUMERIC(5,2),
    species VARCHAR(250)
);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(190),
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(190),
    PRIMARY KEY(id)
);

ALTER TABLE animals DROP COLUMN species
ALTER TABLE animals 
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_animals_species
FOREIGN KEY (species_id) 
REFERENCES species (id);

ALTER TABLE animals ADD COLUMN owner_id INT;

ALTER TABLE animals 
ADD CONSTRAINT fk_animal_owners
FOREIGN KEY(owner_id) 
REFERENCES owners(id);