CREATE TABLE events (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL CHECK (LENGTH(name) > 5),
    date_planned TIMESTAMP NOT NULL,
    image VARCHAR(255),
    description TEXT NOT NULL,
    max_participants INTEGER CHECK (max_participants > 0),
    min_age INTEGER CHECK (min_age > 0)
);