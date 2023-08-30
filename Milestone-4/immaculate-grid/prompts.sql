CREATE TABLE IF NOT EXISTS prompts (

    prompt_name VARCHAR(100) NOT NULL,
    sql_condition VARCHAR(100) NOT NULL,
    image_name VARCHAR(100),
    PRIMARY KEY (prompt_name),

);

INSERT INTO prompts (prompt_name, sql_condition, image_name)
VALUES
    ("Yankees", "franchise.franchise_name = 'New York Yankees'", "yankees"),
    ("Red Sox", "franchise.franchise_name = 'Boston Red Sox'", "redsox"),
    ("Blue Jays", "franchise.franchise_name = 'Toronto Blue Jays'", "bluejays"),
    ("Rays", "franchise.franchise_name = 'Tampa Bay Rays'", "rays"),
    ("Orioles", "franchise.franchise_name = 'Baltimore Orioles'", "orioles"),
    ("Royals", "franchise.franchise_name = 'Kansas City Royals'", "royals"),
    ("Guardians", "franchise.franchise_name = 'Cleveland Indians'", "guardians"),
    ("Twins", "franchise.franchise_name = 'Minnesota Twins'", "twins"),
    ("White Sox", "franchise.franchise_name = 'Chicago White Sox'", "whitesox"),
    ("Tigers", "franchise.franchise_name = 'Detroit Tigers'", "tigers"),
    ("Astros", "franchise.franchise_name = 'Houston Astros'", "astros"),
    ("Rangers", "franchise.franchise_name = 'Texas Rangers'", "rangers"),
    ("Angels", "franchise.franchise_name = 'Los Angeles Angels of Anaheim'", "angels"),
    ("Mariners", "franchise.franchise_name = 'Seattle Mariners'", "mariners"),
    ("Athletics", "franchise.franchise_name = 'Oakland Athletics'", "athletics"),
    ("Mets", "franchise.franchise_name = 'New York Mets'", "mets"),
    ("Phillies", "franchise.franchise_name = 'Philadelphia Phillies'", "phillies"),
    ("Marlins", "franchise.franchise_name = 'Florida Marlins'", "marlins"),
    ("Braves", "franchise.franchise_name = 'Atlanta Braves'", "braves"),
    ("Pirates", "franchise.franchise_name = 'Pittsburgh Pirates'", "pirates"),
    ("Brewers", "franchise.franchise_name = 'Milwaukee Brewers'", "brewers"),
    ("Cubs", "franchise.franchise_name = 'Chicago Cubs'", "cubs"),
    ("Cardinals", "franchise.franchise_name = 'St. Louis Cardinals'", "cardinals"),
    ("Reds", "franchise.franchise_name = 'Cincinnati Reds'", "reds"),
    ("Nationals", "franchise.franchise_name = 'Washington Nationals'", "nationals"),
    ("Dodgers", "franchise.franchise_name = 'Los Angeles Dodgers'", "dodgers"),
    ("Giants", "franchise.franchise_name = 'San Francisco Giants'", "giants"),
    ("Diamondbacks", "franchise.franchise_name = 'Arizona Diamondbacks'", "diamondbacks"),
    ("Padres", "franchise.franchise_name = 'San Diego Padres'", "padres"),
    ("Rockies", "franchise.franchise_name = 'Colorado Rockies'", "rockies"),
    ("30+ HR", "hitting_stats.home_runs >= 30", NULL),
    ("40+ HR", "hitting_stats.home_runs >= 40", NULL),
    ("150+ H", "hitting_stats.hits >= 150", NULL),
    ("200+ H", "hitting_stats.hits >= 200", NULL),
    ("25+ SB", "hitting_stats.stolen_bases >= 25", NULL),
    ("30+ SB", "hitting_stats.stolen_bases >= 30", NULL),
    ("30+ 2B", "hitting_stats.doubles >= 30", NULL),
    (".300+ BA", "hitting_stats.hits / hitting_stats.at_bats >= 0.3", NULL),
    ("100+ RBI", "hitting_stats.runs_batted_in >= 100", NULL),
    ("20+ W", "pitching_stats.wins >= 20", NULL),
    ("15+ W", "pitching_stats.wins >= 15", NULL),
    ("200+ K", "pitching_stats.strikeouts >= 200", NULL),
    ("200+ IP", "pitching_stats.outs_recorded / 3 >= 200", NULL),
    ("20+ SV", "pitching_stats.saves >= 20", NULL),
    ("30+ SV", "pitching_stats.saves >= 30", NULL),
    ("10+ L", "pitching_stats.losses >= 10", NULL),
    ("Sub-1.0 WHIP", "(pitching_stats.walks + pitching_stats.hits) / pitching_stats.outs_recorded <= 1", NULL),
    ("Sub-1.2 WHIP", "(pitching_stats.walks + pitching_stats.hits) / pitching_stats.outs_recorded <= 1.2", NULL),
    ("Sub-3.0 ERA", "pitching_stats.earned_runs / pitching_stats.outs_recorded * 27 <= 3", NULL),
    ("Sub-2.5 ERA", "pitching_stats.earned_runs / pitching_stats.outs_recorded * 27 <= 2.5", NULL);

/* There are issues when accessing a value from a key-value pair which contains a NULL,
so we are going to retroactively change all the NULLs to no_image */
UPDATE prompts
SET image_name = "no_image"
WHERE image_name IS NULL;