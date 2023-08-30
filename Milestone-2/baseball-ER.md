# Entity-Relationship Diagram Documentation

## Description of Attributes
Here, we further clarify what certain attributes represent.

### game
* umpire_hp_id - Refers to the id of the home-plate umpire
* umpire_1b_id - Refers to the id of the first-base umpire
* umpire_2b_id - Refers to the id of the second-base umpire
* umpire_3b_id - Refers to the id of the third-base umpire

### game_stats
* line_score - A string that contains the number of runs a team scores in each inning (e.g. 100012305 or 1(12)0002300)

### game_lineup
* playerN_id (where N is a number 1..9) - Refers to the id of the Nth player in the starting lineup (batting order)
* playerN_pos (where N is a number 1..9) - Refers to the position the Nth player in the starting lineup is playing

### playermanager
* playermanager_id - Refers to the id of a player or manager
* bat_hand - Whether a player hits left (L), right (R), or switch (S) handed
* throw_hand - Whether a player throws left (L), right (R), or switch (S) handed

### team_season
* league_championship - Refers to whether a team won its league championship
* world_series - Refers to whether a team won the World Series

### stint
* stint_id - The id of a player's stint, which is defined as a player's time with a specific team within a season (e.g. Aaron Judge's 2022 season with the New York Yankees qualifies as a stint since he spent the entire season for the Yankees; Justin Verlander's 2017 season with the Detroit Tigers and his 2017 season with the Houston Astros are 2 separate stints since he was traded in the middle of the season; Derek Jeter spent 20 seasons with only the New York Yankees, thus he has 20 stints). This is very helpful to the database because player stats across their careers are usually reported as individual stints. 
* team_number - Represents whether a team is the first or second (or possibly third, etc.) team a player plays for in a season in which the player gets traded. For example, for the entry that represents Justin Verlander's 2017 season with the Detroit Tigers, the team_number = 0, and to represent his time with the Houston Astros that year after he was traded, the team_number = 1. 

## ER Logic and Justification
The ER diagram was made taking into account different factors. I attempted to maximize the amount of nonrepetitive information, so much of the diagram is influenced by what the dataset actually contains and how its structured -- including its limitations in its current form. Here, I explain and justify why certain design decisions were made. 

### playermanager
The dataset has the same levels of biographical information for players and managers. Note that the player table also contains manager biographical info. This is why players and managers are grouped together in the same table (and to be fair, pretty much all managers in MLB history were players as well).

### umpire
Ideally, umpire could be grouped with player into one entity called people, but unlike the players and managers there is no biographical information about the umpires besides their names in the dataset.

### stint
As explained earlier, the hitting, pitching, and fielding statistics are reported in individual stints instead of just the aggregate career values. Therefore, it is helpful to create a table that simply maps individual stint_ids to each of every single player's stints. It's also worth noting that these values cannot be derived from game_stats since game_stats does not go in depth regarding individual player performance per game. 

### team_season
While it may seem unnecessary to have wins and losses reported for each team's season (since intuitively it can be derived from the game_log data for each team), I found that in a few seasons, particularly those in the late 1800s and early 1900s, there existed forfeits (and other peculiar scenarios), so it isn't accurate to say that the number of times a team wins in a season is equal to the number of times a team outscores their opponent in a game. 

### pitching_stats
The number of times a pitcher wins or loses is not equal to the number of times a pitcher's team wins the game. While this may be common knowledge to those familiar with baseball, this can be very confusing to those not too familiar with the sport. Therefore, using similar logic as in team_season, I opted to include individual pitcher win and loss stats.

### Individual player stats in general (hitting, pitching, and fielding)
Without looking at the dataset, it might seem that it should be possible to derived individual stats for each game a player plays from perhaps the game_log. However, the dataset does not go that in depth; in other words, the dataset does not make it possible to know how any individual performed in a particular game. Instead, the game_log only reports the aggregate team performance per game. We do, though, have the help of auxiliary .csv files that compile hitting, pitching, and fielding stats for each stint of each player, so these individual stats can go into their separate table without being redundant in any way. 

### manager_stats
There originally was planned to be a manager_stats table that shows certain stats of a manager, but this can actually be derived from the game_log, unlike individual player performance.

### One line per relationship
Some sources suggest to have multiple lines connecting two different entities if one entity has multiple foreign keys referencing another entity. I opted not to do this, as it made the diagram too cluttered.

### park_id, league_id, and division in team_season instead of team
Teams can change where they play, the league that they play in, and the division they play in (though this change cannot happen in the middle of a season). For example, the Astros used to play in the Astrodome, but now they play at Minute Maid Park; they used to be in the National League, but now they play in the American league; they used to play in the Central division, but now they are in the West. 

### fielding_stats
The fielding stats are reported in stints, but are also further broken down into each player's time at each position that they played. Hence, the existence of a composite primary key with stint_id and pos.