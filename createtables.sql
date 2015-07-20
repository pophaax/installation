PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;

DROP TABLE IF EXISTS "configs";
CREATE TABLE configs (id INTEGER PRIMARY KEY AUTOINCREMENT,
	sc_cmd_clse INTEGER,
	sc_cmd_run INTEGER,

	rc_cmd_xtrm INTEGER,
	rc_cmd_mid INTEGER,

	cc_ang_tack INTEGER,
	cc_ang_sect INTEGER,

	ws_port VARCHAR,
	ws_baud INTEGER,
	mc_port VARCHAR,
	rs_chan INTEGER,
	rs_spd INTEGER,
	rs_acc INTEGER,
	ss_chan INTEGER,
	ss_spd INTEGER,
	ss_acc INTEGER,
	xb_send INTEGER,
	xb_recv INTEGER,
	flag_heading_compass INTEGER,
	sr_loop_time DOUBLE,
	scanning BOOLEAN,
	wp_inner_radius_ratio DOUBLE
);
INSERT INTO "configs" VALUES(1, 4400,5300, 7000,5520, 45,5,
	'/dev/ttyAMA0',4800,'/dev/ttyACM0',4,0,0,3,0,0,0,0,1,0.5,1,0.5);

DROP TABLE IF EXISTS "buffer_configs";
CREATE TABLE buffer_configs (id INTEGER PRIMARY KEY AUTOINCREMENT,
	compass INTEGER,
	true_wind INTEGER,
	windsensor INTEGER
);
INSERT INTO "buffer_configs" VALUES(1,5,100,10);

DROP TABLE IF EXISTS "waypoints";
CREATE TABLE waypoints (id INTEGER PRIMARY KEY AUTOINCREMENT, -- no autoincrement to ensure a correct order
	lat DOUBLE,
	lon DOUBLE,
	radius INTEGER,
	harvested BOOLEAN
);

DROP TABLE IF EXISTS "waypoint_index";
CREATE TABLE waypoint_index (
	id INTEGER PRIMARY KEY,
	i INTEGER,
	j INTEGER,

	-- not enforced: foreign_keys off (line 1)
	FOREIGN KEY(id) REFERENCES waypoints(id)
);

DROP TABLE IF EXISTS "waypoint_stationary";
CREATE TABLE waypoint_stationary (
	id INTEGER PRIMARY KEY,
	time INTEGER,

	-- not enforced: foreign_keys off (line 1)
	FOREIGN KEY(id) REFERENCES waypoints(id)
);

DROP TABLE IF EXISTS "datalogs";
CREATE TABLE datalogs (id INTEGER PRIMARY KEY, -- remove log after sync to minimize db size
	gps_time TIMESTAMP,
	gps_lat DOUBLE,
	gps_lon DOUBLE,
	gps_spd DOUBLE,
	gps_head DOUBLE,
	gps_sat INTEGER,
	sc_cmd INTEGER,
	rc_cmd INTEGER,
	ss_pos INTEGER,
	rs_pos INTEGER,

	cc_dtw DOUBLE,
	cc_btw DOUBLE,
	cc_cts DOUBLE,
	cc_tack BOOLEAN,
	cc_goingStarboard BOOLEAN,

	ws_dir INTEGER,
	ws_spd DOUBLE,
	ws_tmp DOUBLE,
	wpt_cur INTEGER,
	cps_head INTEGER,
	cps_pitch INTEGER,
	cps_roll INTEGER
);

-- only used in DBHandler::getLogs commented code, remove?
DROP TABLE IF EXISTS "messages";
CREATE TABLE messages (id INTEGER PRIMARY KEY AUTOINCREMENT, -- remove log after sync to minimize db size
	gps_time TIMESTAMP,
	type VARCHAR,
	msg VARCHAR,
	log_id INTEGER				-- FK
);

-- HTTPSync
DROP TABLE IF EXISTS "server";
CREATE TABLE server (id INTEGER PRIMARY KEY AUTOINCREMENT,
	boat_id VARCHAR,	-- ex: boat01
	boat_pwd VARCHAR,
	srv_addr VARCHAR
);

-- HTTPSync
DROP TABLE IF EXISTS "state";
CREATE TABLE state (id INTEGER PRIMARY KEY AUTOINCREMENT,
	cfg_rev VARCHAR,
	rte_rev VARCHAR
);

DROP TABLE IF EXISTS "mock";
CREATE TABLE mock (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	GPS BOOLEAN,
	Windsensor BOOLEAN,
	Compass BOOLEAN,
	Position BOOLEAN,
	Maestro BOOLEAN
);
INSERT INTO "mock" VALUES(1,1,1,1,1,1);

DROP TABLE IF EXISTS "scanning_measurements";
CREATE TABLE scanning_measurements (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	waypoint_id INTEGER,
	i INTEGER,
	j INTEGER,
	time_UTC TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	latitude DOUBLE,
	longitude DOUBLE,
	air_temperature DOUBLE,

	-- not enforced: foreign_keys off (line 1)
	FOREIGN KEY(waypoint_id) REFERENCES waypoints(id)
);

DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" VALUES('configs',1);
COMMIT;