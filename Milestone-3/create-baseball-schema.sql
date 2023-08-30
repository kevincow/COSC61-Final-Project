CREATE DATABASE IF NOT EXISTS baseball;
USE baseball;

CREATE TABLE IF NOT EXISTS franchise (

	franchise_id VARCHAR(45) NOT NULL,
    franchise_name VARCHAR(45) NOT NULL,
    PRIMARY KEY (franchise_id)
    
);
    
CREATE TABLE IF NOT EXISTS league (

	league_id VARCHAR(45) NOT NULL,
    league_name VARCHAR(45) NOT NULL,
    PRIMARY KEY (league_id)
    
);

CREATE TABLE IF NOT EXISTS park (

	park_id VARCHAR(45) NOT NULL,
    park_name VARCHAR(45) NOT NULL,
    city VARCHAR(45) NOT NULL,
    state VARCHAR(45) NOT NULL,
    country VARCHAR(45) NOT NULL,
    PRIMARY KEY (park_id)
    
);

CREATE TABLE IF NOT EXISTS team (

	team_id VARCHAR(45) NOT NULL,
    team_name VARCHAR(45) NOT NULL,
    franchise_id VARCHAR(45) NOT NULL,
    PRIMARY KEY (team_id),
    FOREIGN KEY (franchise_id) REFERENCES franchise (franchise_id)
    
);

CREATE TABLE IF NOT EXISTS team_season (

	team_id VARCHAR(45) NOT NULL,
    season INT NOT NULL,
    park_id VARCHAR(45) NOT NULL,
    league_id VARCHAR(45) NOT NULL,
    division VARCHAR(45) NOT NULL,
    standings_rank INT NOT NULL,
    wins INT NOT NULL,
    losses INT NOT NULL,
    league_championship VARCHAR(1) NOT NULL,
    world_series VARCHAR(1),
    PRIMARY KEY (team_id, season),
    FOREIGN KEY (team_id) REFERENCES team (team_id),
    FOREIGN KEY (park_id) REFERENCES park (park_id),
    FOREIGN KEY (league_id) REFERENCES league (league_id)
    
);

CREATE TABLE IF NOT EXISTS playermanager (

	playermanager_id VARCHAR(45) NOT NULL,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    birthday DATETIME NOT NULL,
    birth_country VARCHAR(45) NOT NULL,
    birth_state VARCHAR(45) NOT NULL,
    birth_city VARCHAR(45) NOT NULL,
    death_date DATETIME,
    death_country VARCHAR(45),
    death_state VARCHAR(45),
    death_city VARCHAR(45),
    weight INT NOT NULL,
    height INT NOT NULL,
    bat_hand VARCHAR(1) NOT NULL,
    throw_hand VARCHAR(1) NOT NULL,
    debut DATETIME NOT NULL,
    final_game DATETIME,
    PRIMARY KEY (playermanager_id)
    
);

CREATE TABLE IF NOT EXISTS stint (

	stint_id INT NOT NULL AUTO_INCREMENT,
    playermanager_id VARCHAR(45) NOT NULL,
    season INT NOT NULL,
    team_number INT NOT NULL,
    team_id VARCHAR(45) NOT NULL,
    PRIMARY KEY (stint_id),
    FOREIGN KEY (playermanager_id) REFERENCES playermanager (playermanager_id),
    FOREIGN KEY (team_id) REFERENCES team (team_id)
    
);

CREATE TABLE IF NOT EXISTS hitting_stats (

	stint_id INT NOT NULL,
    games INT NOT NULL,
    at_bats INT NOT NULL,
    runs INT NOT NULL,
    hits INT NOT NULL,
    doubles INT NOT NULL,
    triples INT NOT NULL,
    home_runs INT NOT NULL,
    runs_batted_in INT NOT NULL,
    stolen_bases INT NOT NULL,
    caught_stealing INT NOT NULL,
    walks INT NOT NULL,
    intentional_walks INT NOT NULL,
    strikeouts INT NOT NULL,
    hit_by_pitch INT NOT NULL,
    grounded_into_double_play INT NOT NULL,
    PRIMARY KEY (stint_id),
    FOREIGN KEY (stint_id) REFERENCES stint (stint_id)

);

CREATE TABLE IF NOT EXISTS pitching_stats (

	stint_id INT NOT NULL,
    wins INT NOT NULL,
    losses INT NOT NULL,
    games INT NOT NULL,
    complete_games INT NOT NULL,
    shutouts INT NOT NULL,
    saves INT NOT NULL,
    outs_recorded INT NOT NULL,
    hits INT NOT NULL,
    earned_runs INT NOT NULL,
    homeruns INT NOT NULL,
    walks INT NOT NULL,
    strikeouts INT NOT NULL,
    opponent_batting_average DECIMAL(4,3) NOT NULL,
    wild_pitches INT NOT NULL,
    hit_by_pitch INT NOT NULL,
    PRIMARY KEY (stint_id),
    FOREIGN KEY (stint_id) REFERENCES stint (stint_id)

);

CREATE TABLE IF NOT EXISTS fielding_stats (

	stint_id INT NOT NULL,
    pos VARCHAR(2) NOT NULL,
    games INT NOT NULL,
    outs_recorded INT NOT NULL,
    putouts INT NOT NULL,
    assists INT NOT NULL,
    fielding_errors INT NOT NULL,
    double_plays INT NOT NULL,
    PRIMARY KEY (stint_id, pos),
    FOREIGN KEY (stint_id) REFERENCES stint (stint_id)

);

CREATE TABLE IF NOT EXISTS umpire (

	umpire_id VARCHAR(45) NOT NULL,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    PRIMARY KEY (umpire_id)

);

CREATE TABLE IF NOT EXISTS game (

	game_id INT NOT NULL AUTO_INCREMENT,
    date DATETIME NOT NULL,
    visit_team_id VARCHAR(45) NOT NULL,
    home_team_id VARCHAR(45) NOT NULL,
    visit_game_number INT, # not included in final table, but necessary for table construction (will be dropped once used)
    home_game_number INT, # not included in final table, but necessary for table construction (will be dropped once used)
    length_outs INT NOT NULL,
    day_night VARCHAR(1) NOT NULL,
    attendance INT,
    length_minutes INT,
    umpire_hp_id VARCHAR(45) NOT NULL,
    umpire_1b_id VARCHAR(45),
    umpire_2b_id VARCHAR(45),
    umpire_3b_id VARCHAR(45),
    PRIMARY KEY (game_id),
    FOREIGN KEY (visit_team_id) REFERENCES team (team_id),
    FOREIGN KEY (home_team_id) REFERENCES team (team_id),
    FOREIGN KEY (umpire_hp_id) REFERENCES umpire (umpire_id),
    FOREIGN KEY (umpire_1b_id) REFERENCES umpire (umpire_id),
    FOREIGN KEY (umpire_2b_id) REFERENCES umpire (umpire_id),
    FOREIGN KEY (umpire_3b_id) REFERENCES umpire (umpire_id)

);

CREATE TABLE IF NOT EXISTS game_stats (

	game_id INT NOT NULL,
    team_id VARCHAR(45) NOT NULL,
    at_bats INT NOT NULL,
    hits INT NOT NULL,
    doubles INT NOT NULL,
    triples INT NOT NULL,
    home_runs INT NOT NULL,
    runs_batted_in INT NOT NULL,
    sac_hits INT NOT NULL,
    hit_by_pitch INT NOT NULL,
    walks INT NOT NULL,
    intentional_walks INT NOT NULL,
    strikeouts INT NOT NULL,
    stolen_bases INT NOT NULL,
    caught_stealing INT NOT NULL,
    grounded_into_double_play INT NOT NULL,
    left_on_base INT NOT NULL,
    pitchers_used INT NOT NULL,
    earned_runs INT NOT NULL,
    fielding_errors INT NOT NULL,
    line_score VARCHAR(45) NOT NULL,
    PRIMARY KEY (game_id, team_id),
    FOREIGN KEY (game_id) REFERENCES game (game_id),
    FOREIGN KEY (team_id) REFERENCES team (team_id)

);

CREATE TABLE IF NOT EXISTS game_lineup (

	game_id INT NOT NULL,
    team_id VARCHAR(45) NOT NULL,
    manager_id VARCHAR(45) NOT NULL,
    SP_id VARCHAR(45) NOT NULL,
    p1_id VARCHAR(45) NOT NULL,
    p1_pos VARCHAR(2) NOT NULL,
    p2_id VARCHAR(45) NOT NULL,
    p2_pos VARCHAR(2) NOT NULL,
    p3_id VARCHAR(45) NOT NULL,
    p3_pos VARCHAR(2) NOT NULL,
    p4_id VARCHAR(45) NOT NULL,
    p4_pos VARCHAR(2) NOT NULL,
    p5_id VARCHAR(45) NOT NULL,
    p5_pos VARCHAR(2) NOT NULL,
    p6_id VARCHAR(45) NOT NULL,
    p6_pos VARCHAR(2) NOT NULL,
    p7_id VARCHAR(45) NOT NULL,
    p7_pos VARCHAR(2) NOT NULL,
    p8_id VARCHAR(45) NOT NULL,
    p8_pos VARCHAR(2) NOT NULL,
    p9_id VARCHAR(45) NOT NULL,
    p9_pos VARCHAR(2) NOT NULL,
    PRIMARY KEY (game_id, team_id),
    FOREIGN KEY (game_id) REFERENCES game (game_id),
    FOREIGN KEY (team_id) REFERENCES team (team_id),
    FOREIGN KEY (manager_id) REFERENCES playermanager (playermanager_id),
    FOREIGN KEY (SP_id) REFERENCES playermanager (playermanager_id),
    FOREIGN KEY (p1_id) REFERENCES playermanager (playermanager_id),
    FOREIGN KEY (p2_id) REFERENCES playermanager (playermanager_id),
    FOREIGN KEY (p3_id) REFERENCES playermanager (playermanager_id),
    FOREIGN KEY (p4_id) REFERENCES playermanager (playermanager_id),
    FOREIGN KEY (p5_id) REFERENCES playermanager (playermanager_id),
    FOREIGN KEY (p6_id) REFERENCES playermanager (playermanager_id),
    FOREIGN KEY (p7_id) REFERENCES playermanager (playermanager_id),
    FOREIGN KEY (p8_id) REFERENCES playermanager (playermanager_id),
    FOREIGN KEY (p9_id) REFERENCES playermanager (playermanager_id)
    
);