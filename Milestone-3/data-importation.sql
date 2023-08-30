/***********************************************************************
 *************** Loading in Data + Data Cleaning ***********************
 **********************************************************************/

/********* game_logs.csv ***********/
/* 
1. Import game_logs.csv using the LOAD DATA INFILE statement.
2. Change date to DATETIME format.
3. Change all the -1 into 0
4. Change all the positions from their number form to their string form.
5. Update the NULL h_league and v_league values to NA (which stands for National Association)
*/

CREATE TABLE IF NOT EXISTS game_logs (

	date INT,
    number_of_game INT,
    day_of_week VARCHAR(45), 
    v_name VARCHAR(45),
    v_league VARCHAR(45), 
    v_game_number VARCHAR(45),
    h_name VARCHAR(45),
    h_league VARCHAR(45),
    h_game_number INT,
    v_score INT,
    h_score INT,
    length_outs INT,
    day_night VARCHAR(45),
    completion VARCHAR(45),
    forefeit VARCHAR(45),
    protest VARCHAR(45),
    park_id VARCHAR(45),
    attendance INT,
    length_minutes INT,
    v_line_score VARCHAR(45),
    h_line_score VARCHAR(45),
    v_at_bats INT,
    v_hits INT,
    v_doubles INT,
    v_triples INT,
    v_homeruns INT,
    v_rbi INT,
    v_sacrifice_hits INT,
    v_sacrifice_flies INT,
    v_hit_by_pitch INT,
    v_walks INT,
    v_intentional_walks INT,
    v_strikeouts INT,
    v_stolen_bases INT,
    v_caught_stealing INT,
    v_grounded_into_double_play INT,
    v_first_catcher_interference INT,
    v_left_on_base INT,
    v_pitchers_used INT,
    v_individual_earned_runs INT,
    v_team_earned_runs INT,
    v_wild_pitches INT,
    v_balks INT,
    v_putouts INT,
    v_assists INT,
    v_errors INT,
    v_passed_balls INT,
    v_double_plays INT,
    v_triple_plays INT,
    h_at_bats INT,
    h_hits INT,
    h_doubles INT,
    h_triples INT,
    h_homeruns INT,
    h_rbi INT,
    h_sacrifice_hits INT,
    h_sacrifice_flies INT,
    h_hit_by_pitch INT,
    h_walks INT,
    h_intentional_walks INT,
    h_strikeouts INT,
    h_stolen_bases INT,
    h_caught_stealing INT,
    h_grounded_into_double_play INT,
    h_first_catcher_interference INT,
    h_left_on_base INT,
    h_pitchers_used INT,
    h_individual_earned_runs INT,
    h_team_earned_runs INT,
    h_wild_pitches INT,
    h_balks INT,
    h_putouts INT,
    h_assists INT,
    h_errors INT,
    h_passed_balls INT,
    h_double_plays INT,
    h_triple_plays INT,
    hp_umpire_id VARCHAR(45),
    hp_umpire_name VARCHAR(45),
    1b_umpire_id VARCHAR(45),
    1b_umpire_name VARCHAR(45),
    2b_umpire_id VARCHAR(45),
    2b_umpire_name VARCHAR(45),
    3b_umpire_id VARCHAR(45),
    3b_umpire_name VARCHAR(45),
    lf_umpire_id VARCHAR(45),
    lf_umpire_name VARCHAR(45),
    rf_umpire_id VARCHAR(45),
    rf_umpire_name VARCHAR(45),
    v_manager_id VARCHAR(45),
    v_manager_name VARCHAR(45),
    h_manager_id VARCHAR(45),
    h_manager_name VARCHAR(45),
    winning_pitcher_id VARCHAR(45),
    winning_pitcher_name VARCHAR(45),
    losing_pitcher_id VARCHAR(45),
    losing_pitcher_name VARCHAR(45),
    saving_pitcher_id VARCHAR(45),
    saving_pitcher_name VARCHAR(45),
    winning_rbi_batter_id VARCHAR(45),
    winning_rbi_batter_id_name VARCHAR(45),
    v_starting_pitcher_id VARCHAR(45),
    v_starting_pitcher_name VARCHAR(45),
    h_starting_pitcher_id VARCHAR(45),
    h_starting_pitcher_name VARCHAR(45),
    v_player_1_id VARCHAR(45),
    v_player_1_name VARCHAR(45),
    v_player_1_def_pos VARCHAR(45),
    v_player_2_id VARCHAR(45),
    v_player_2_name VARCHAR(45),
    v_player_2_def_pos VARCHAR(45),
    v_player_3_id VARCHAR(45),
    v_player_3_name VARCHAR(45),
    v_player_3_def_pos VARCHAR(45),
    v_player_4_id VARCHAR(45),
    v_player_4_name VARCHAR(45),
    v_player_4_def_pos VARCHAR(45),
    v_player_5_id VARCHAR(45),
    v_player_5_name VARCHAR(45),
    v_player_5_def_pos VARCHAR(45),
    v_player_6_id VARCHAR(45),
    v_player_6_name VARCHAR(45),
    v_player_6_def_pos VARCHAR(45),
    v_player_7_id VARCHAR(45),
    v_player_7_name VARCHAR(45),
    v_player_7_def_pos VARCHAR(45),
    v_player_8_id VARCHAR(45),
    v_player_8_name VARCHAR(45),
    v_player_8_def_pos VARCHAR(45),
    v_player_9_id VARCHAR(45),
    v_player_9_name VARCHAR(45),
    v_player_9_def_pos VARCHAR(45),
    h_player_1_id VARCHAR(45),
    h_player_1_name VARCHAR(45),
    h_player_1_def_pos VARCHAR(45),
    h_player_2_id VARCHAR(45),
    h_player_2_name VARCHAR(45),
    h_player_2_def_pos VARCHAR(45),
    h_player_3_id VARCHAR(45),
    h_player_3_name VARCHAR(45),
    h_player_3_def_pos VARCHAR(45),
    h_player_4_id VARCHAR(45),
    h_player_4_name VARCHAR(45),
    h_player_4_def_pos VARCHAR(45),
    h_player_5_id VARCHAR(45),
    h_player_5_name VARCHAR(45),
    h_player_5_def_pos VARCHAR(45),
    h_player_6_id VARCHAR(45),
    h_player_6_name VARCHAR(45),
    h_player_6_def_pos VARCHAR(45),
    h_player_7_id VARCHAR(45),
    h_player_7_name VARCHAR(45),
    h_player_7_def_pos VARCHAR(45),
    h_player_8_id VARCHAR(45),
    h_player_8_name VARCHAR(45),
    h_player_8_def_pos VARCHAR(45),
    h_player_9_id VARCHAR(45),
    h_player_9_name VARCHAR(45),
    h_player_9_def_pos VARCHAR(45),
    additional_info VARCHAR(45),
    acquisition_info VARCHAR(45)

);

LOAD DATA LOCAL INFILE '/Users/kevincao/Desktop/COSC61/COSC61-Final-Project/Data/game_logs.csv'
INTO TABLE game_logs
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE game_logs ADD game_date DATE;

UPDATE game_logs
SET game_date = STR_TO_DATE(date, '%Y%m%d');

/*
ALTER TABLE game_logs
DROP COLUMN date, 
DROP COLUMN number_of_game, 
DROP COLUMN day_of_week, 
DROP COLUMN v_game_number, 
DROP COLUMN h_game_number, 
DROP COLUMN v_score, 
DROP COLUMN h_score, 
DROP COLUMN completion, 
DROP COLUMN forefeit, 
DROP COLUMN protest, 
DROP COLUMN v_first_catcher_interference, 
DROP COLUMN v_individual_earned_runs, 
DROP COLUMN v_sacrifice_flies, 
DROP COLUMN v_balks, 
DROP COLUMN v_putouts, 
DROP COLUMN v_wild_pitches, 
DROP COLUMN v_assists, 
DROP COLUMN v_passed_balls, 
DROP COLUMN v_double_plays, 
DROP COLUMN v_triple_plays, 
DROP COLUMN h_first_catcher_interference, 
DROP COLUMN h_individual_earned_runs, 
DROP COLUMN h_sacrifice_flies, 
DROP COLUMN h_balks, 
DROP COLUMN h_putouts, 
DROP COLUMN h_wild_pitches, 
DROP COLUMN h_assists, 
DROP COLUMN h_passed_balls, 
DROP COLUMN h_double_plays, 
DROP COLUMN h_triple_plays, 
DROP COLUMN lf_umpire_id, 
DROP COLUMN lf_umpire_name, 
DROP COLUMN rf_umpire_id, 
DROP COLUMN rf_umpire_name, 
DROP COLUMN winning_pitcher_id, 
DROP COLUMN winning_pitcher_name, 
DROP COLUMN losing_pitcher_id, 
DROP COLUMN losing_pitcher_name, 
DROP COLUMN saving_pitcher_id, 
DROP COLUMN saving_pitcher_name, 
DROP COLUMN winning_rbi_batter_id, 
DROP COLUMN winning_rbi_batter_id_name, 
DROP COLUMN additional_info, 
DROP COLUMN acquisition_info; 
*/

/*
ALTER TABLE game_logs
MODIFY v_player_1_def_pos VARCHAR(45),
MODIFY v_player_2_def_pos VARCHAR(45),
MODIFY v_player_3_def_pos VARCHAR(45),
MODIFY v_player_4_def_pos VARCHAR(45),
MODIFY v_player_5_def_pos VARCHAR(45),
MODIFY v_player_6_def_pos VARCHAR(45),
MODIFY v_player_7_def_pos VARCHAR(45),
MODIFY v_player_8_def_pos VARCHAR(45),
MODIFY v_player_9_def_pos VARCHAR(45),
MODIFY h_player_1_def_pos VARCHAR(45),
MODIFY h_player_2_def_pos VARCHAR(45),
MODIFY h_player_3_def_pos VARCHAR(45),
MODIFY h_player_4_def_pos VARCHAR(45),
MODIFY h_player_5_def_pos VARCHAR(45),
MODIFY h_player_6_def_pos VARCHAR(45),
MODIFY h_player_7_def_pos VARCHAR(45),
MODIFY h_player_8_def_pos VARCHAR(45),
MODIFY h_player_9_def_pos VARCHAR(45);
*/

UPDATE game_logs
SET 
	v_player_1_def_pos = CASE
		WHEN v_player_1_def_pos = '1.0' THEN 'SP'
        WHEN v_player_1_def_pos = '2.0' THEN 'C'
        WHEN v_player_1_def_pos = '3.0' THEN '1B'
        WHEN v_player_1_def_pos = '4.0' THEN '2B'
        WHEN v_player_1_def_pos = '5.0' THEN '3B'
        WHEN v_player_1_def_pos = '6.0' THEN 'SS'
        WHEN v_player_1_def_pos = '7.0' THEN 'LF'
        WHEN v_player_1_def_pos = '8.0' THEN 'CF'
        WHEN v_player_1_def_pos = '9.0' THEN 'RF'
        WHEN v_player_1_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	v_player_2_def_pos = CASE
		WHEN v_player_2_def_pos = '1.0' THEN 'SP'
        WHEN v_player_2_def_pos = '2.0' THEN 'C'
        WHEN v_player_2_def_pos = '3.0' THEN '1B'
        WHEN v_player_2_def_pos = '4.0' THEN '2B'
        WHEN v_player_2_def_pos = '5.0' THEN '3B'
        WHEN v_player_2_def_pos = '6.0' THEN 'SS'
        WHEN v_player_2_def_pos = '7.0' THEN 'LF'
        WHEN v_player_2_def_pos = '8.0' THEN 'CF'
        WHEN v_player_2_def_pos = '9.0' THEN 'RF'
        WHEN v_player_2_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	v_player_3_def_pos = CASE
		WHEN v_player_3_def_pos = '1.0' THEN 'SP'
        WHEN v_player_3_def_pos = '2.0' THEN 'C'
        WHEN v_player_3_def_pos = '3.0' THEN '1B'
        WHEN v_player_3_def_pos = '4.0' THEN '2B'
        WHEN v_player_3_def_pos = '5.0' THEN '3B'
        WHEN v_player_3_def_pos = '6.0' THEN 'SS'
        WHEN v_player_3_def_pos = '7.0' THEN 'LF'
        WHEN v_player_3_def_pos = '8.0' THEN 'CF'
        WHEN v_player_3_def_pos = '9.0' THEN 'RF'
        WHEN v_player_3_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	v_player_4_def_pos = CASE
		WHEN v_player_4_def_pos = '1.0' THEN 'SP'
        WHEN v_player_4_def_pos = '2.0' THEN 'C'
        WHEN v_player_4_def_pos = '3.0' THEN '1B'
        WHEN v_player_4_def_pos = '4.0' THEN '2B'
        WHEN v_player_4_def_pos = '5.0' THEN '3B'
        WHEN v_player_4_def_pos = '6.0' THEN 'SS'
        WHEN v_player_4_def_pos = '7.0' THEN 'LF'
        WHEN v_player_4_def_pos = '8.0' THEN 'CF'
        WHEN v_player_4_def_pos = '9.0' THEN 'RF'
        WHEN v_player_4_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	v_player_5_def_pos = CASE
		WHEN v_player_5_def_pos = '1.0' THEN 'SP'
        WHEN v_player_5_def_pos = '2.0' THEN 'C'
        WHEN v_player_5_def_pos = '3.0' THEN '1B'
        WHEN v_player_5_def_pos = '4.0' THEN '2B'
        WHEN v_player_5_def_pos = '5.0' THEN '3B'
        WHEN v_player_5_def_pos = '6.0' THEN 'SS'
        WHEN v_player_5_def_pos = '7.0' THEN 'LF'
        WHEN v_player_5_def_pos = '8.0' THEN 'CF'
        WHEN v_player_5_def_pos = '9.0' THEN 'RF'
        WHEN v_player_5_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	v_player_6_def_pos = CASE
		WHEN v_player_6_def_pos = '1.0' THEN 'SP'
        WHEN v_player_6_def_pos = '2.0' THEN 'C'
        WHEN v_player_6_def_pos = '3.0' THEN '1B'
        WHEN v_player_6_def_pos = '4.0' THEN '2B'
        WHEN v_player_6_def_pos = '5.0' THEN '3B'
        WHEN v_player_6_def_pos = '6.0' THEN 'SS'
        WHEN v_player_6_def_pos = '7.0' THEN 'LF'
        WHEN v_player_6_def_pos = '8.0' THEN 'CF'
        WHEN v_player_6_def_pos = '9.0' THEN 'RF'
        WHEN v_player_6_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	v_player_7_def_pos = CASE
		WHEN v_player_7_def_pos = '1.0' THEN 'SP'
        WHEN v_player_7_def_pos = '2.0' THEN 'C'
        WHEN v_player_7_def_pos = '3.0' THEN '1B'
        WHEN v_player_7_def_pos = '4.0' THEN '2B'
        WHEN v_player_7_def_pos = '5.0' THEN '3B'
        WHEN v_player_7_def_pos = '6.0' THEN 'SS'
        WHEN v_player_7_def_pos = '7.0' THEN 'LF'
        WHEN v_player_7_def_pos = '8.0' THEN 'CF'
        WHEN v_player_7_def_pos = '9.0' THEN 'RF'
        WHEN v_player_7_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	v_player_8_def_pos = CASE
		WHEN v_player_8_def_pos = '1.0' THEN 'SP'
        WHEN v_player_8_def_pos = '2.0' THEN 'C'
        WHEN v_player_8_def_pos = '3.0' THEN '1B'
        WHEN v_player_8_def_pos = '4.0' THEN '2B'
        WHEN v_player_8_def_pos = '5.0' THEN '3B'
        WHEN v_player_8_def_pos = '6.0' THEN 'SS'
        WHEN v_player_8_def_pos = '7.0' THEN 'LF'
        WHEN v_player_8_def_pos = '8.0' THEN 'CF'
        WHEN v_player_8_def_pos = '9.0' THEN 'RF'
        WHEN v_player_8_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	v_player_9_def_pos = CASE
		WHEN v_player_9_def_pos = '1.0' THEN 'SP'
        WHEN v_player_9_def_pos = '2.0' THEN 'C'
        WHEN v_player_9_def_pos = '3.0' THEN '1B'
        WHEN v_player_9_def_pos = '4.0' THEN '2B'
        WHEN v_player_9_def_pos = '5.0' THEN '3B'
        WHEN v_player_9_def_pos = '6.0' THEN 'SS'
        WHEN v_player_9_def_pos = '7.0' THEN 'LF'
        WHEN v_player_9_def_pos = '8.0' THEN 'CF'
        WHEN v_player_9_def_pos = '9.0' THEN 'RF'
        WHEN v_player_9_def_pos = '10.0' THEN 'DH'
END;
   
UPDATE game_logs
SET 
	h_player_1_def_pos = CASE
		WHEN h_player_1_def_pos = '1.0' THEN 'SP'
        WHEN h_player_1_def_pos = '2.0' THEN 'C'
        WHEN h_player_1_def_pos = '3.0' THEN '1B'
        WHEN h_player_1_def_pos = '4.0' THEN '2B'
        WHEN h_player_1_def_pos = '5.0' THEN '3B'
        WHEN h_player_1_def_pos = '6.0' THEN 'SS'
        WHEN h_player_1_def_pos = '7.0' THEN 'LF'
        WHEN h_player_1_def_pos = '8.0' THEN 'CF'
        WHEN h_player_1_def_pos = '9.0' THEN 'RF'
        WHEN h_player_1_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	h_player_2_def_pos = CASE
		WHEN h_player_2_def_pos = '1.0' THEN 'SP'
        WHEN h_player_2_def_pos = '2.0' THEN 'C'
        WHEN h_player_2_def_pos = '3.0' THEN '1B'
        WHEN h_player_2_def_pos = '4.0' THEN '2B'
        WHEN h_player_2_def_pos = '5.0' THEN '3B'
        WHEN h_player_2_def_pos = '6.0' THEN 'SS'
        WHEN h_player_2_def_pos = '7.0' THEN 'LF'
        WHEN h_player_2_def_pos = '8.0' THEN 'CF'
        WHEN h_player_2_def_pos = '9.0' THEN 'RF'
        WHEN h_player_2_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	h_player_3_def_pos = CASE
		WHEN h_player_3_def_pos = '1.0' THEN 'SP'
        WHEN h_player_3_def_pos = '2.0' THEN 'C'
        WHEN h_player_3_def_pos = '3.0' THEN '1B'
        WHEN h_player_3_def_pos = '4.0' THEN '2B'
        WHEN h_player_3_def_pos = '5.0' THEN '3B'
        WHEN h_player_3_def_pos = '6.0' THEN 'SS'
        WHEN h_player_3_def_pos = '7.0' THEN 'LF'
        WHEN h_player_3_def_pos = '8.0' THEN 'CF'
        WHEN h_player_3_def_pos = '9.0' THEN 'RF'
        WHEN h_player_3_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	h_player_4_def_pos = CASE
		WHEN h_player_4_def_pos = '1.0' THEN 'SP'
        WHEN h_player_4_def_pos = '2.0' THEN 'C'
        WHEN h_player_4_def_pos = '3.0' THEN '1B'
        WHEN h_player_4_def_pos = '4.0' THEN '2B'
        WHEN h_player_4_def_pos = '5.0' THEN '3B'
        WHEN h_player_4_def_pos = '6.0' THEN 'SS'
        WHEN h_player_4_def_pos = '7.0' THEN 'LF'
        WHEN h_player_4_def_pos = '8.0' THEN 'CF'
        WHEN h_player_4_def_pos = '9.0' THEN 'RF'
        WHEN h_player_4_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	h_player_5_def_pos = CASE
		WHEN h_player_5_def_pos = '1.0' THEN 'SP'
        WHEN h_player_5_def_pos = '2.0' THEN 'C'
        WHEN h_player_5_def_pos = '3.0' THEN '1B'
        WHEN h_player_5_def_pos = '4.0' THEN '2B'
        WHEN h_player_5_def_pos = '5.0' THEN '3B'
        WHEN h_player_5_def_pos = '6.0' THEN 'SS'
        WHEN h_player_5_def_pos = '7.0' THEN 'LF'
        WHEN h_player_5_def_pos = '8.0' THEN 'CF'
        WHEN h_player_5_def_pos = '9.0' THEN 'RF'
        WHEN h_player_5_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	h_player_6_def_pos = CASE
		WHEN h_player_6_def_pos = '1.0' THEN 'SP'
        WHEN h_player_6_def_pos = '2.0' THEN 'C'
        WHEN h_player_6_def_pos = '3.0' THEN '1B'
        WHEN h_player_6_def_pos = '4.0' THEN '2B'
        WHEN h_player_6_def_pos = '5.0' THEN '3B'
        WHEN h_player_6_def_pos = '6.0' THEN 'SS'
        WHEN h_player_6_def_pos = '7.0' THEN 'LF'
        WHEN h_player_6_def_pos = '8.0' THEN 'CF'
        WHEN h_player_6_def_pos = '9.0' THEN 'RF'
        WHEN h_player_6_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	h_player_7_def_pos = CASE
		WHEN h_player_7_def_pos = '1.0' THEN 'SP'
        WHEN h_player_7_def_pos = '2.0' THEN 'C'
        WHEN h_player_7_def_pos = '3.0' THEN '1B'
        WHEN h_player_7_def_pos = '4.0' THEN '2B'
        WHEN h_player_7_def_pos = '5.0' THEN '3B'
        WHEN h_player_7_def_pos = '6.0' THEN 'SS'
        WHEN h_player_7_def_pos = '7.0' THEN 'LF'
        WHEN h_player_7_def_pos = '8.0' THEN 'CF'
        WHEN h_player_7_def_pos = '9.0' THEN 'RF'
        WHEN h_player_7_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	h_player_8_def_pos = CASE
		WHEN h_player_8_def_pos = '1.0' THEN 'SP'
        WHEN h_player_8_def_pos = '2.0' THEN 'C'
        WHEN h_player_8_def_pos = '3.0' THEN '1B'
        WHEN h_player_8_def_pos = '4.0' THEN '2B'
        WHEN h_player_8_def_pos = '5.0' THEN '3B'
        WHEN h_player_8_def_pos = '6.0' THEN 'SS'
        WHEN h_player_8_def_pos = '7.0' THEN 'LF'
        WHEN h_player_8_def_pos = '8.0' THEN 'CF'
        WHEN h_player_8_def_pos = '9.0' THEN 'RF'
        WHEN h_player_8_def_pos = '10.0' THEN 'DH'
END;

UPDATE game_logs
SET 
	h_player_9_def_pos = CASE
		WHEN h_player_9_def_pos = '1.0' THEN 'SP'
        WHEN h_player_9_def_pos = '2.0' THEN 'C'
        WHEN h_player_9_def_pos = '3.0' THEN '1B'
        WHEN h_player_9_def_pos = '4.0' THEN '2B'
        WHEN h_player_9_def_pos = '5.0' THEN '3B'
        WHEN h_player_9_def_pos = '6.0' THEN 'SS'
        WHEN h_player_9_def_pos = '7.0' THEN 'LF'
        WHEN h_player_9_def_pos = '8.0' THEN 'CF'
        WHEN h_player_9_def_pos = '9.0' THEN 'RF'
        WHEN h_player_9_def_pos = '10.0' THEN 'DH'
END;     

/*
ALTER TABLE game_logs
CHANGE COLUMN `v_intentional walks` v_intentional_walks VARCHAR(45);

ALTER TABLE game_logs
CHANGE COLUMN `h_intentional walks` h_intentional_walks VARCHAR(45);
*/

UPDATE game_logs
SET v_intentional_walks = 0 
WHERE v_intentional_walks = -1;

UPDATE game_logs
SET v_caught_stealing = 0
WHERE v_caught_stealing = -1;

UPDATE game_logs
SET v_grounded_into_double_play = 0
WHERE v_grounded_into_double_play = -1;

UPDATE game_logs
SET v_first_catcher_interference = 0
WHERE v_first_catcher_interference = -1;

UPDATE game_logs
SET h_intentional_walks = 0
WHERE h_intentional_walks = -1;

UPDATE game_logs
SET h_caught_stealing = 0
WHERE h_caught_stealing = -1;

UPDATE game_logs
SET h_grounded_into_double_play = 0
WHERE h_grounded_into_double_play = -1;

UPDATE game_logs
SET h_first_catcher_interference = 0
WHERE h_first_catcher_interference = -1;

UPDATE game_logs
SET v_league = "NA"
WHERE v_league IS NULL;

UPDATE game_logs
SET h_league = "NA"
WHERE h_league IS NULL;

UPDATE game_logs
SET length_outs = 27
WHERE length_outs = 0;

/********* People.csv *********/
/*
* 1. Note that certain player info is missing. These should be allowed to set to NULL. (namely the detes, birth states particularly for players born outside of US, and death locations for players who have not died.)
* 2. Merge the split year, month, day columns into just one datetime column
*/

CREATE TABLE people (

	playerID VARCHAR(45),
    birthYear INT,
    birthMonth INT,
    birthDay INT,
    birthCountry VARCHAR(45),
    birthState VARCHAR(45),
    birthCity VARCHAR(45),
    deathYear INT,
    deathMonth INT,
    deathDay INT,
    deathCountry VARCHAR(45),
    deathState VARCHAR(45),
    deathCity VARCHAR(45),
    nameFirst VARCHAR(45),
    nameLast VARCHAR(45),
    nameGiven VARCHAR(45),
    weight INT,
    height INT,
    bats VARCHAR(45),
    throws VARCHAR(45),
    debut DATETIME,
    finalGAME DATETIME,
    retroID VARCHAR(45),
    bbrefID VARCHAR(45)

);

LOAD DATA LOCAL INFILE '/Users/kevincao/Desktop/COSC61/COSC61-Final-Project/Data/baseballdatabank-2023.1/core/People.csv'
INTO TABLE people
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

UPDATE people
SET birthMonth = 1
WHERE birthMonth = 0;

UPDATE people
SET birthDay = 1
WHERE birthDay = 0;

UPDATE people
SET deathYEAR = NULL
WHERE deathYEAR = 0 OR deathDay = 0 OR deathMonth = 0 OR deathYear = NULL OR deathDay = NULL OR deathMonth = NULL;

UPDATE people
SET deathDay = NULL
WHERE deathYEAR = 0 OR deathDay = 0 OR deathMonth = 0 OR deathYear = NULL OR deathDay = NULL OR deathMonth = NULL;

UPDATE people
SET deathMonth = NULL
WHERE deathYEAR = 0 OR deathDay = 0 OR deathMonth = 0 OR deathYear = NULL OR deathDay = NULL OR deathMonth = NULL;

ALTER TABLE people
ADD COLUMN birth_day DATETIME,
ADD COLUMN death_day DATETIME;

UPDATE people
SET birth_day = STR_TO_DATE(CONCAT(birthYear, "-", birthMonth, "-", birthDay), "%Y-%m-%d");

UPDATE people
SET death_day = STR_TO_DATE(CONCAT(deathYear, "-", deathMonth, "-", deathDay), "%Y-%m-%d");

ALTER TABLE people
DROP COLUMN birthDay,
DROP COLUMN birthYear,
DROP COLUMN birthMonth,
DROP COLUMN deathDay, 
DROP COLUMN deathYear, 
DROP COLUMN deathMonth;

ALTER TABLE people
CHANGE COLUMN birth_day birthday DATETIME;

ALTER TABLE people
CHANGE COLUMN death_day deathday DATETIME;

/* We need to keep some value for here, though the database prevents certain operations when the date is not reasonable. We
pick an arbitrary time to set the value to, and then we will modify this later when we can. */
UPDATE people
SET debut = "2000-01-01"
WHERE debut < "1000-01-01";

UPDATE people
SET finalGame = "2000-01-01"
WHERE finalGame < "1000-01-01";

/* It is debatable whether we want to represent non-existing/missing values as NULL or "" */

/*
UPDATE people
SET birthState = NULL
WHERE birthState = "";

UPDATE people
SET deathCountry = NULL
WHERE deathCountry = "";

UPDATE people
SET deathCity = NULL
WHERE deathCity = "";

UPDATE people
SET deathState = NULL
WHERE deathState = "";

*/


/***** Teams.csv ******/
/*
* 1. Fix some inconsistencies between the teamID and their names/franchises, in addition to parkIDs
*/
CREATE TABLE Teams 
(

	yearID INT,
    lgID VARCHAR(45),
    teamID VARCHAR(45),
    franchID VARCHAR(45),
    divID VARCHAR(45),
    standings_rank INT,
    G INT,
    Ghome INT,
    W INT,
    L INT,
    DivWin VARCHAR(45),
    WCWin VARCHAR(45),
    LgWin VARCHAR(45),
    WSWin VARCHAR(45),
    R INT,
    AB INT,
    H INT,
    doubles INT,
    triples INT,
    HR INT,
    BB INT,
    SO INT,
    SB INT,
    CS INT,
    HBP INT,
    SF INT,
    RA INT,
    ER INT,
    ERA INT,
    CG INT,
    SHO INT,
    SV INT,
    IPouts INT,
    HA  INT,
    HRA INT,
    BBA INT,
    SOA INT,
    E INT, 
    DP INT,
    FP INT,
    name VARCHAR(45),
    park VARCHAR(45),
    attendance INT,
    BPF INT,
    PPF INT,
    teamIDBR VARCHAR(45),
    teamIDlahman45 VARCHAR(45),
    teamIDretro VARCHAR(45)

);

LOAD DATA LOCAL INFILE '/Users/kevincao/Desktop/COSC61/COSC61-Final-Project/Data/baseballdatabank-2023.1/core/Teams.csv'
INTO TABLE Teams
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

UPDATE Teams
SET name = "Boston Braves"
WHERE teamIDretro = "BSN";

UPDATE Teams
SET name = "Chicago Cubs"
WHERE teamIDretro = "CHN";

UPDATE Teams
SET name = "Louisville Colonels"
WHERE teamIDretro = "LS2";

UPDATE Teams
SET franchID = "PHA"
WHERE teamIDretro = "PH4";

UPDATE Teams
SET name = "St. Louis Browns"
WHERE teamIDretro = "SL4";

UPDATE Teams
SET name = "New York Giants"
WHERE teamIDretro = "NY1";

UPDATE Teams
SET name = "Philadelphia Phillies"
WHERE teamIDretro = "PHI";

UPDATE Teams
SET name = "Brooklyn Bridegrooms"
WHERE teamIDretro = "BR3";

UPDATE Teams
SET name = "Pittsburgh Pirates"
WHERE teamIDretro = "PIT";

UPDATE Teams
SET name = "Brooklyn Dodgers"
WHERE teamIDretro = "BRO";

UPDATE Teams
SET name = "Cincinnati Reds"
WHERE teamIDretro = "CIN";

UPDATE Teams
SET name = "St. Louis Cardinals"
WHERE teamIDretro = "SLN";

UPDATE Teams
SET name = "Boston Red Sox"
WHERE teamIDretro = "BOS";

UPDATE Teams
SET name = "Cleveland Indians"
WHERE teamIDretro = "CLE";

UPDATE Teams
SET name = "New York Yankees"
WHERE teamIDretro = "NYA";

UPDATE Teams
SET name = "Buffalo Blues"
WHERE teamIDretro = "BUF";

UPDATE Teams
SET name = "Chicago Whales"
WHERE teamIDretro = "CHF";

UPDATE Teams
SET name = "Houston Astros"
WHERE teamIDretro = "HOU";

UPDATE Teams
SET name = "Los Angeles Angels of Anaheim"
WHERE teamIDretro = "ANA";

UPDATE Teams
SET name = "Tampa Bay Rays"
WHERE teamIDretro = "TBA";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "STL04")
WHERE park = "Union Base-Ball Grounds";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "NYC01")
WHERE park = "Union Grounds (Brooklyn)";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "NEW02")
WHERE park = "Hamilton Field";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "BUF02")
WHERE park = "Olympics Grounds" OR park = "Nationals Grounds";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CHI02")
WHERE park = "23rd Street Grounds";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "PHI02")
WHERE park = "Centennial Grounds";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "BOS02")
WHERE park = "Red Stocking Baseball Park";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CLE01")
WHERE park = "Jacobs Field";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "BAL03")
WHERE park = "Oriole Park";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "MIN01")
WHERE park = "Newell Park";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "NYC03")
WHERE park = "Polo Grounds I";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "NYC03")
WHERE park = "Polo Grounds I West Diamond";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CIN04")
WHERE park = "League Park I in Cincinnati";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "IND02")
WHERE park = "Seventh Street Park";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "PHI05")
WHERE park = "";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CHI06")
WHERE park = "West Side Park I";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CLE02")
WHERE park = "National League Park II";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "RCK01")
WHERE park = "Allen Pasture";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "WAS05")
WHERE park = "Swampdoodle Grounds";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "PHI04")
WHERE park = "Philadelphia Baseball Grounds";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "KAN02")
WHERE park = "Association Park I";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "NYC04")
WHERE park = "Polo Grounds II";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "BAL09")
WHERE park = "Oriole Park";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "NYC18")
WHERE park = "Ridgewood Park";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CIN04")
WHERE park = "League Park I in Cincinnati";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "MIL03")
WHERE park = "Athletic Field";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "BOS04")
WHERE park = "South End Grounds II / Congress Street Ground";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CIN04")
WHERE park = "League Park II in Cincinnati";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "BOS07")
WHERE park = "Huntington Avenue Grounds";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "PIT06")
WHERE park = "Forbes Field" OR park = "Forbes Field/Three Rivers Stadium";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "STL03")
WHERE park = "Sportsman's Park IV" OR park = "Robison Field/Sportsman's Park IV" OR park = "Sportsman's Park IV/Busch Stadium II";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CHI10")
WHERE park = "South Side Park II/Comiskey Park" OR park = "Comiskey Park";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "NYC09")
WHERE park = "Polo Grounds III/Polo Grounds IV";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "WAS09")
WHERE park = "Griffith Stadium I" OR park = "Griffith Stadium II";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "BOS07")
WHERE park = "Fenway Park I" OR park = "Fenway Park I / Braves Field" OR park = "Fenway Park II";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "DET04")
WHERE park = "Navin Field" OR park = "Briggs Stadium";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CLE07")
WHERE park = "League Park II/Cleveland Stadium";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "PHI11")
WHERE park = "Baker Bowl/Shibe Park" OR park = "Connie Mack Stadium";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "KAN05")
WHERE park = "Municipal Stadium I" OR park = "Municipal Stadium II";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "WAS10")
WHERE park = "R.F.K. Stadium";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "ANA01")
WHERE park = "Anaheim Stadium" OR park = "Edison International Field" OR park = "Angels Stadium of Anaheim" OR park = "Angel Stadium" OR park = "Wrigley Field (LA)" OR park = "Anaheim Stadium";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "OAK01")
WHERE park = "Network Associates Coliseum" OR park = "McAfee Coliseum" OR park = "O.co Coliseum" OR park = "Oakland Coliseum";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "MON01")
WHERE park = "Jarry Park";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "SAN02")
WHERE park = "Jack Murphy Stadium";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "SEA01")
WHERE park = "Sicks Stadium";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "KAN05")
WHERE park = "Royals Stadium";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CIN07")
WHERE park = "Crosley Field/Riverfront Stadium" OR park = "Riverfront Stadium";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "MIN03")
WHERE park = "Hubert H Humphrey Metrodome";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "TOR02")
WHERE park = "Exhibition Stadium /Skydome" OR park = "Skydome";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CHI10")
WHERE park = "Comiskey Park II";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "FLO")
WHERE park = "Joe Robbie Stadium" OR park = "Pro Player Stadium" OR park = "Dolphin Stadium";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "ARL02")
WHERE park = "The Ballpark at Arlington" OR park = "Ameriquest Field" OR park = "Globe Life Park in Arlington" OR park = "Globe Life Field";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "SFO02")
WHERE park = "3Com Park";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "SFO03")
WHERE park = "PacBell Park" OR park = "SBC Park" OR park = "Oracle Park";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "PHO01")
WHERE park = "Bank One Ballpark";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "SEA92")
WHERE park = "Kingdome / Safeco Field" OR park = "T-Mobile Park";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "HOU02")
WHERE park = "Enron Field";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CHI12")
WHERE park = "U.S. Cellular Field";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CIN09")
WHERE park = "Great American Ball park";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "MON02")
WHERE park = "Stade Olympique/Hiram Bithorn Stadium";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "NYC21")
WHERE park = "Yankee Stadium III";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "BUF01")
WHERE park = "Sahlen Field";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "PHI05")
WHERE park IS NULL;

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CLE01")
WHERE park = "Kennard Street Park";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CHI01")
WHERE park = "Lake Front Park I/Lake Front Park II";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "KAN01")
WHERE park = "Athletic Park I" OR park = "Athletic Park II";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CHI06")
WHERE park = "West Side Park II";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "PIT05")
WHERE park = "Exposition Park/Forbes Field";

UPDATE Teams
SET park = 
	(SELECT park_name
    FROM park 
    WHERE park_id = "CLE01")
WHERE park = "National League Park";

/*
ALTER TABLE Teams
DROP COLUMN G,
DROP COLUMN Ghome,
DROP COLUMN W,
DROP COLUMN L,
DROP COLUMN DivWin,
DROP COLUMN WCWIN,
DROP COLUMN R,
DROP COLUMN AB,
DROP COLUMN H,
DROP COLUMN doubles,
DROP COLUMN triples,
DROP COLUMN HR,
DROP COLUMN BB,
DROP COLUMN SO,
DROP COLUMN SB,
DROP COLUMN CS,
DROP COLUMN HBP,
DROP COLUMN SF,
DROP COLUMN RA,
DROP COLUMN ER,
DROP COLUMN ERA,
DROP COLUMN CG,
DROP COLUMN SHO,
DROP COLUMN SV,
DROP COLUMN IPouts,
DROP COLUMN HA,
DROP COLUMN HRA,
DROP COLUMN BBA,
DROP COLUMN SOA,
DROP COLUMN E,
DROP COLUMN DP,
DROP COLUMN FP,
DROP COLUMN name,
DROP COLUMN park,
DROP COLUMN attendance,
DROP COLUMN BPF,
DROP COLUMN PPF;
*/

/**** TeamsFranchises ****/
CREATE TABLE TeamsFranchises (

	franchID VARCHAR(45),
    franchName VARCHAR(45)

);

LOAD DATA LOCAL INFILE '/Users/kevincao/Desktop/COSC61/COSC61-Final-Project/Data/baseballdatabank-2023.1/core/TeamsFranchises.csv'
INTO TABLE TeamsFranchises
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

/***** Parks.csv *****/
CREATE TABLE Parks 
(

	park_id VARCHAR(45),
    park_name VARCHAR(45),
    park_alias VARCHAR(45),
    city VARCHAR(45),
    state VARCHAR(45),
    country VARCHAR(45)

);

LOAD DATA LOCAL INFILE '/Users/kevincao/Desktop/COSC61/COSC61-Final-Project/Data/baseballdatabank-2023.1/core/Parks.csv'
INTO TABLE Parks
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE Parks
DROP COLUMN park_alias;

/***** Batting_clean.csv *****/
CREATE TABLE Batting
(

		randomColumn INT,
        yearID VARCHAR(45),
        stint INT,
        teamID VARCHAR(45),
        lgID VARCHAR(45),
        G INT,
        AB INT,
        R INT,
        H INT,
        doubles INT,
        triples INT,
        HR INT,
        RBI INT,
        SB INT,
        CS INT,
        BB INT,
        SO INT,
        IBB INT,
        HBP INT,
        SH INT,
        SF INT,
        GIDP INT,
        playerID VARCHAR(45)

);

LOAD DATA LOCAL INFILE '/Users/kevincao/Desktop/COSC61/COSC61-Final-Project/Data/baseballdatabank-2023.1/core/Batting_clean.csv'
INTO TABLE Batting
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE Batting
DROP COLUMN randomColumn;

UPDATE Batting
SET teamID = 'MLN'
WHERE teamID = 'ML1';

UPDATE Batting
SET teamID = "MLU"
WHERE teamID = "ML4";

/****** Pitching_clean.csv ******/
CREATE TABLE Pitching
(

	randomColumn INT,
    yearID INT,
    stint INT,
    teamID VARCHAR(45),
    lgID VARCHAR(45),
    W INT,
    L INT,
    G INT,
    GS INT,
    CG INT,
    SHO INT,
    SV INT,
    IPouts INT,
    H INT,
    ER INT,
    HR INT,
    BB INT,
    SO INT,
    BAOpp DECIMAL(4,3),
    ERA DECIMAL(4,3),
    IBB INT,
    WP INT,
    HBP INT,
    BK INT,
    BFP INT,
    GF INT,
    R INT,
    SH INT,
    SF INT,
    GIDP INT,
    playerID VARCHAR(45)

);

LOAD DATA LOCAL INFILE '/Users/kevincao/Desktop/COSC61/COSC61-Final-Project/Data/baseballdatabank-2023.1/core/Pitching_clean.csv'
INTO TABLE Pitching
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE Pitching
DROP COLUMN RandomColumn;

UPDATE Pitching
SET teamID = 'MLN'
WHERE teamID = 'ML1';

UPDATE Pitching
SET teamID = "MLU"
WHERE teamID = "ML4";

/****** Fielding_clean.csv ******/

CREATE TABLE Fielding
(

	randomColumn INT,
    yearID INT,
    stint INT,
    teamID VARCHAR(45),
    lgID VARCHAR(45),
    POS VARCHAR(45),
    G INT,
    GS INT,
    InnOuts INT,
    PO INT,
    A INT,
    E INT,
    DP INT,
    PB INT,
    WP INT,
    SB INT,
    CS INT,
    ZR INT,
    playerID VARCHAR(45)

);

LOAD DATA LOCAL INFILE '/Users/kevincao/Desktop/COSC61/COSC61-Final-Project/Data/baseballdatabank-2023.1/core/Fielding_clean.csv'
INTO TABLE Fielding
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

ALTER TABLE Fielding
DROP COLUMN RandomColumn;

UPDATE Fielding
SET teamID = 'MLN'
WHERE teamID = 'ML1';

UPDATE Fielding
SET teamID = "MLU"
WHERE teamID = "ML4";

/***********************************************************************
 *************** Inserting Data to the Tables *****************************
 **********************************************************************/

/* franchise */
INSERT INTO franchise (franchise_id, franchise_name)
SELECT franchID, franchName
FROM TeamsFranchises;

/* team */
INSERT INTO team (team_id, team_name, franchise_id)
SELECT DISTINCT teamIDretro, name, franchID
FROM Teams;

/* park */
INSERT INTO park (park_id, park_name, city, state, country)
SELECT * FROM Parks;

/* league */

# Note that a subquery won't work here because we need to manually input the names of the leagues, which are not given in the dataset
INSERT INTO league (league_id, league_name) VALUES
	('NA', 'National Association'),
    ('NL', 'National League'),
    ('AA', 'American Association'),
    ('UA', 'Union Association'),
    ('PL', 'Players League'),
    ('AL', 'American League'),
    ('FL', 'Federal League');

/* team_season */
INSERT INTO team_season (team_id, season, park_id, league_id, division, standings_rank, wins, losses, league_championship, world_series)
SELECT DISTINCT teamIDretro, yearID, MAX(park_id) AS park_id, lgID, divID, standings_rank, W, L, LgWin, WSWIN
FROM Teams JOIN park ON park = park_name
GROUP BY teamIDretro, yearID, lgID, divID, standings_rank, W, L, LgWin, WSWIN
ORDER BY yearID, teamIDretro;

/* playermanager */
INSERT INTO playermanager (playermanager_id, first_name, last_name, birthday, birth_country, birth_state, birth_city, death_date, death_country, death_state, death_city, weight, height, bat_hand, throw_hand, debut, final_game)
SELECT retroID, nameFirst, nameLast, birthday, birthCountry, birthState, birthCity, deathday, deathCountry, deathState, deathCity, weight, height, bats, throws, debut, finalGAME
FROM people
WHERE retroID <> "";

/* stint */
INSERT INTO stint (playermanager_id, season, team_number, team_id)
(SELECT playerID, yearID, stint, teamID FROM Batting)
UNION
(SELECT playerID, yearID, stint, teamID FROM Fielding)
UNION
(SELECT playerID, yearID, stint, teamID FROM Pitching);

/* hitting_stats */
INSERT INTO hitting_stats (stint_id, games, at_bats, runs, hits, doubles, triples, home_runs, runs_batted_in, stolen_bases, caught_stealing, walks, intentional_walks, strikeouts, hit_by_pitch, grounded_into_double_play)
SELECT stint_id, G, AB, R, H, doubles, triples, HR, RBI, SB, CS, BB, IBB, SO, HBP, GIDP
FROM Batting JOIN stint ON playermanager_id = playerID AND yearID = season AND stint = team_number;

/* fielding_stats */
INSERT INTO fielding_stats (stint_id, pos, games, outs_recorded, putouts, assists, fielding_errors, double_plays)
SELECT stint_id, POS, G, InnOuts, PO, A, E, DP
FROM Fielding JOIN stint ON playermanager_id = playerID AND yearID = season AND stint = team_number;

/* pitching_stats */
INSERT INTO pitching_stats (stint_id, wins, losses, games, complete_games, shutouts, saves, outs_recorded, hits, earned_runs, homeruns, walks, strikeouts, opponent_batting_average, wild_pitches, hit_by_pitch)
SELECT stint_id, W, L, G, CG, SHO, SV, IPouts, H, ER, HR, BB, SO, BAOpp, WP, HBP
FROM Pitching JOIN stint ON playermanager_id = playerID AND yearID = season AND stint = team_number;

/* umpire */
INSERT IGNORE INTO umpire (umpire_id, first_name, last_name)
(SELECT hp_umpire_id, LEFT(hp_umpire_name, LOCATE(' ', hp_umpire_name) - 1), SUBSTRING(hp_umpire_name, LOCATE(' ', hp_umpire_name) + 1) FROM game_logs)
UNION DISTINCT
(SELECT `1b_umpire_id`, LEFT(`1b_umpire_name`, LOCATE(' ', `1b_umpire_name`) - 1), SUBSTRING(`1b_umpire_name`, LOCATE(' ', `1b_umpire_name`) + 1) FROM game_logs)
UNION DISTINCT
(SELECT `2b_umpire_id`, LEFT(`2b_umpire_name`, LOCATE(' ', `2b_umpire_name`) - 1), SUBSTRING(`2b_umpire_name`, LOCATE(' ', `2b_umpire_name`) + 1) FROM game_logs)
UNION DISTINCT
(SELECT `3b_umpire_id`, LEFT(`3b_umpire_name`, LOCATE(' ', `3b_umpire_name`) - 1), SUBSTRING(`3b_umpire_name`, LOCATE(' ', `3b_umpire_name`) + 1) FROM game_logs);

/* game */
INSERT INTO game (date, visit_team_id, home_team_id, visit_game_number, home_game_number, length_outs, day_night, attendance, length_minutes, umpire_hp_id, umpire_1b_id, umpire_2b_id, umpire_3b_id)
SELECT game_date, v_name, h_name, v_game_number, h_game_number, length_outs, day_night, attendance, length_minutes, hp_umpire_id, `1b_umpire_id`, `2b_umpire_id`, `3b_umpire_id` FROM game_logs;

/* game_stats */
INSERT IGNORE INTO game_stats (game_id, team_id, at_bats, hits, doubles, triples, home_runs, runs_batted_in, sac_hits, hit_by_pitch, walks, intentional_walks, strikeouts, stolen_bases, caught_stealing, grounded_into_double_play, left_on_base, pitchers_used, earned_runs, fielding_errors, line_score)
(SELECT game_id, visit_team_id, v_at_bats, v_hits, v_doubles, v_triples, v_homeruns, v_rbi, v_sacrifice_hits, v_hit_by_pitch, v_walks, v_intentional_walks, v_strikeouts, v_stolen_bases, v_caught_stealing, v_grounded_into_double_play, v_left_on_base, v_pitchers_used, v_team_earned_runs, v_errors, v_line_score 
FROM game JOIN game_logs ON game.date = game_date AND visit_game_number = v_game_number AND home_game_number = h_game_number)
UNION
(SELECT game_id, home_team_id, h_at_bats, h_hits, h_doubles, h_triples, h_homeruns, h_rbi, h_sacrifice_hits, h_hit_by_pitch, h_walks, h_intentional_walks, h_strikeouts, h_stolen_bases, h_caught_stealing, h_grounded_into_double_play, h_left_on_base, h_pitchers_used, h_team_earned_runs, h_errors, h_line_score 
FROM game JOIN game_logs ON game.date = game_date AND visit_game_number = v_game_number AND home_game_number = h_game_number);

/* game_lineup */
INSERT IGNORE INTO game_lineup (game_id, team_id, manager_id, SP_id, p1_id, p1_pos, p2_id, p2_pos, p3_id, p3_pos, p4_id, p4_pos, p5_id, p5_pos, p6_id, p6_pos, p7_id, p7_pos, p8_id, p8_pos, p9_id, p9_pos)
(SELECT game_id, visit_team_id, v_manager_id, v_starting_pitcher_id, v_player_1_id, v_player_1_def_pos, v_player_2_id, v_player_2_def_pos, v_player_3_id, v_player_3_def_pos, v_player_4_id, v_player_4_def_pos, v_player_5_id, v_player_5_def_pos, v_player_6_id, v_player_6_def_pos, v_player_7_id, v_player_7_def_pos, v_player_8_id, v_player_8_def_pos, v_player_9_id, v_player_9_def_pos
FROM game JOIN game_logs ON game.date = game_date AND visit_game_number = v_game_number AND home_game_number = h_game_number)
UNION
(SELECT game_id, home_team_id, h_manager_id, h_starting_pitcher_id, h_player_1_id, h_player_1_def_pos, h_player_2_id, h_player_2_def_pos, h_player_3_id, h_player_3_def_pos, h_player_4_id, h_player_4_def_pos, h_player_5_id, h_player_5_def_pos, h_player_6_id, h_player_6_def_pos, h_player_7_id, h_player_7_def_pos, h_player_8_id, h_player_8_def_pos, h_player_9_id, h_player_9_def_pos
FROM game JOIN game_logs ON game.date = game_date AND visit_game_number = v_game_number AND home_game_number = h_game_number);

# These columns can now be removed now that they have helped the creation of the game_stats table
ALTER TABLE game
DROP COLUMN visit_game_number,
DROP COLUMN home_game_number;

# We can now also drop the helper tables that were generated from the .csv files
DROP TABLE Batting;
DROP TABLE Fielding;
DROP TABLE Pitching;
DROP TABLE game_logs;
DROP TABLE Parks;
DROP TABLE people;
DROP TABLE Teams;
DROP TABLE TeamsFranchises;




