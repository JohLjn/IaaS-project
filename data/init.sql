CREATE TABLE poems (
    id serial PRIMARY KEY,
    name text NOT NULL,
    age INT NOT NULL,
    password text UNIQUE NOT NULL,
    poemtext text NOT NULL,
    publishdate text NOT NULL
);

INSERT INTO poems (name, age, password, poemtext, publishdate) VALUES ('Bert', 1996, 'secret', 'Initialize', 'Initialize date');
INSERT INTO poems (name, age, password, poemtext, publishdate) VALUES ('Göran', 1921, 'supersecret', 'Database', 'Initialize date');
