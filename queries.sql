SELECT * FROM animals WHERE name LIKE '%mon%'
SELECT name, EXTRACT(YEAR FROM date_of_birth) as year FROM animals WHERE date_of_birth >= to_date('2022', 'YYYY'); 
SELECT name, neutered, escape_attempts FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT name, date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT name, neutered FROM animals WHERE neutered=true;
SELECT name FROM animals WHERE name <> 'Gabumon';
SELECT name, weight_kg FROM animals WHERE weight_kg >= 10.5 AND weight_kg <= 17.3;

/*
 * Inside a transaction update the animals table by setting the species column to unspecified. 
 * Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
*/
BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*
 * Inside a transaction:
 * Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
 * Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
 * Commit the transaction.
 * Verify that change was made and persists after commit. 
*/
BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

/*
 * Inside a transaction delete all records in the animals table, then roll back the transaction.
 * After the rollback verify if all records in the animals table still exists.
*/
BEGIN TRANSACTION;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*
 * Inside a transaction:
 * Delete all animals born after Jan 1st, 2022.
 * Create a savepoint for the transaction.
 * Update all animals' weight to be their weight multiplied by -1.
 * Rollback to the savepoint
 * Update all animals' weights that are negative to be their weight multiplied by -1.
 * Commit transaction
*/
BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;

UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- Write queries to answer the following questions:
-- How many animals are there?
SELECT COUNT(id) number_of_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) number_of_animals_tried_to_escape FROM animals WHERE escape_attempts > 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) average_weight_of_animals FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg) maximum_weight, MIN(weight_kg) minimum_weight FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth
BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;