CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50),
    date_of_birth date
);

CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR(20),
    
    CONSTRAINT medical_histories_patients_fk 
    FOREIGN KEY(patient_id) REFERENCES patients(id),

);

CREATE TABLE treatments (
    id PRIMARY KEY INT GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(50),
    name VARCHAR(50)
);

CREATE TABLE invoice_item (
    id PRIMARY KEY INT GENERATED ALWAYS AS IDENTITY,
    unit_price DECIMAL(8,2),
    quantity INT,
    total_price DECIMAL(8,2),
    invoice_id INT,
    treatment_id INT,

    CONSTRAINT invoice_item_invoices_fk 
    FOREIGN KEY(invoice_id) REFERENCES invoices(id),

    CONSTRAINT invoice_item_treatment_fk 
    FOREIGN KEY(treatment_id) REFERENCES treatments(id)

);

CREATE TABLE invoices (
    id PRIMARY KEY INT GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL(8,2),
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,

    CONSTRAINT medical_histories_invoices_fk 
    FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id)

);

CREATE TABLE treatments_medical_histories (
    id PRIMARY KEY INT GENERATED ALWAYS AS IDENTITY,
    medical_histories_id INT,
    treatment_id INT,

    CONSTRAINT medical_histories_id_fk 
    FOREIGN KEY(medical_histories_id) REFERENCES medical_histories(id),

    CONSTRAINT treatment_id_fk 
    FOREIGN KEY(treatment_id) REFERENCES treatments(id)
);

CREATE INDEX patient_id_asc ON medical_histories (patient_id ASC);
DROP INDEX patient_id_asc;

CREATE INDEX invoice_id_asc ON invoice_item (invoice_id ASC);
DROP INDEX invoice_id_asc;

CREATE INDEX treatment_id_asc ON invoice_item (treatment_id ASC);
DROP INDEX treatment_id_asc;

CREATE INDEX medical_history_id_asc ON invoices (medical_history_id ASC);
DROP INDEX medical_history_id_asc;

CREATE INDEX medical_histories_id_asc ON treatments_medical_histories (medical_histories_id ASC);
DROP INDEX medical_histories_id_asc;

CREATE INDEX treatment_id_asc ON treatments_medical_histories (treatment_id ASC);
DROP INDEX treatment_id_asc;