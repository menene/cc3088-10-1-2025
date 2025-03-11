CREATE TABLE day_of_week (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) UNIQUE NOT NULL
);

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE match_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE seasons (
    id SERIAL PRIMARY KEY,
    year INT UNIQUE NOT NULL
);

CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    season_id INT REFERENCES seasons(id),
    match_type_id INT REFERENCES match_types(id),
    day_of_week_id INT REFERENCES day_of_week(id),
    home_team_id INT REFERENCES teams(id),
    away_team_id INT REFERENCES teams(id),
    home_score INT,
    away_score INT,
    date DATE NOT NULL    
);
