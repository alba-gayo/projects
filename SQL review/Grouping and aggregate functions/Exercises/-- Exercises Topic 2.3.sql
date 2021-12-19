-- Exercises Topic 2.3
--- 2 create tables
CREATE TABLE line (
    colour VARCHAR(30) NOT NULL UNIQUE,
    lname VARCHAR(30) NOT NULL
);

CREATE TABLE be_compound_of (
    line VARCHAR(30) NOT NULL UNIQUE,
    station VARCHAR(30) NOT NULL,
    order_ int NOT NULL
);

CREATE TABLE station (
    sname VARCHAR(30) NOT NULL UNIQUE,
    accesible BOOLEAN NOT NULL,
    cercanias VARCHAR(30) NOT NULL
);

CREATE TABLE access (
    code VARCHAR(30) NOT NULL UNIQUE,
    aname VARCHAR(30) NOT NULL,
    belongs_to VARCHAR(30) NOT NULL
);

CREATE TABLE train (
    tcode int NOT NULL UNIQUE,
    model VARCHAR(30) NOT NULL,
    age INTEGER NOT NULL,
    run_on VARCHAR(30) NOT NULL,
    park_at int NOT NULL
);

CREATE TABLE garage (
    gcode int NOT NULL UNIQUE,
    address VARCHAR(300) NOT NULL,
    capacity int NOT NULL,
    assigned_to VARCHAR(30) NOT NULL
);

--- 3 insert data
INSERT INTO line VALUES('red', '2');
INSERT INTO line VALUES('blue', '1');
INSERT INTO line VALUES('yellow', '3');
INSERT INTO line VALUES('brown', '4');

--- 4 add constraints
ALTER TABLE be_compound_of 
ADD CONSTRAINT be_compound_of_fk0 
FOREIGN KEY (line) 
REFERENCES line(colour);

ALTER TABLE be_compound_of
ADD CONSTRAINT be_compound_of_fk1
FOREIGN KEY (station)
REFERENCES station(sname);

ALTER TABLE access
ADD CONSTRAINT access_fk0 
FOREIGN KEY (belongs_to)
REFERENCES station(sname);

ALTER TABLE train
ADD CONSTRAINT train_fk0 
FOREIGN KEY (run_on)
REFERENCES line(colour);

ALTER TABLE train
ADD CONSTRAINT train_fk1
FOREIGN KEY (park_at)
REFERENCES garage(gcode);

ALTER TABLE garage
ADD CONSTRAINT garage_fk0
FOREIGN KEY (assigned_to)
REFERENCES station(sname);