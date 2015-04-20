PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE configs (id INTEGER PRIMARY KEY AUTOINCREMENT,
	sc_cmd_clse INTEGER,
	sc_cmd_beam INTEGER,
	sc_cmd_brd INTEGER,
	sc_cmd_run INTEGER,
	sc_ang_beam INTEGER,
	sc_ang_brd INTEGER,
	sc_ang_run INTEGER,
	rc_cmd_xtrm INTEGER,
	rc_cmd_med INTEGER,
	rc_cmd_sml INTEGER,
	rc_cmd_mid INTEGER,
	rc_ang_med INTEGER,
	rc_ang_sml INTEGER,
	rc_ang_mid INTEGER,
	cc_ang_tack INTEGER,
	cc_ang_sect INTEGER,
	ws_modl VARCHAR,
	ws_chan INTEGER,
	ws_port VARCHAR,
	ws_baud INTEGER,
	ws_buff INTEGER,
	mc_port VARCHAR,
	rs_chan INTEGER,
	rs_spd INTEGER,
	rs_acc INTEGER,
	ss_chan INTEGER,
	ss_spd INTEGER,
	ss_acc INTEGER
);
INSERT INTO "configs" VALUES(1,7424,6600,6200,5824,120,80,40,7616,7000,6500,5984,60,30,10,45,5,'CV7',5,'/dev/ttyAMA0',4800,10,'/dev/ttyACM0',0,0,0,1,0,0);
CREATE TABLE waypoints (id INTEGER PRIMARY KEY, -- no autoincrement to ensure a correct order
	lat DOUBLE,
	lon DOUBLE
);
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
	cc_tack INTEGER,
	ws_dir INTEGER,
	ws_spd DOUBLE,
	ws_tmp INTEGER,
	wpt_cur INTEGER
	cps_head INTEGER,
	cps_pitch INTEGER,
	cps_roll INTEGER
);
CREATE TABLE messages (id INTEGER PRIMARY KEY AUTOINCREMENT, -- remove log after sync to minimize db size
	gps_time TIMESTAMP,
	type VARCHAR,
	msg VARCHAR,
	log_id INTEGER				-- FK
);
CREATE TABLE server (id INTEGER PRIMARY KEY AUTOINCREMENT,
	boat_id VARCHAR,	-- ex: boat01
	boat_pwd VARCHAR,
	srv_addr VARCHAR
);
CREATE TABLE state (id INTEGER PRIMARY KEY AUTOINCREMENT,
	cfg_rev VARCHAR,
	rte_rev VARCHAR
);
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" VALUES('configs',1);
COMMIT;
