-- Fill default settings on core.db
BEGIN TRANSACTION;

INSERT INTO "Settings" VALUES ('ac_sprinthook_delay',9);
INSERT INTO "Settings" VALUES ('ac_sprinthook_speed',50);
INSERT INTO "Settings" VALUES ('ac_sprinthook_kickafter',5);
INSERT INTO "Settings" VALUES ('map',2);
INSERT INTO "Settings" VALUES ('max_fps',105);
INSERT INTO "Settings" VALUES ('max_ping',1488);
INSERT INTO "Settings" VALUES ('min_fps',20);
INSERT INTO "Settings" VALUES ('kick_lagers',0);
INSERT INTO "Settings" VALUES ('spawnkill_delay',5);
INSERT INTO "Settings" VALUES ('ac_distancebug',1);
INSERT INTO "Settings" VALUES ('ac_cbug',0);
INSERT INTO "Settings" VALUES ('ac_slide',0);
INSERT INTO "Settings" VALUES ('fpsunlock',1);
INSERT INTO "Settings" VALUES ('host',1);
INSERT INTO "Settings" VALUES ('nologin_delay',90);
INSERT INTO "Settings" VALUES ('teamsautobalance',0);
INSERT INTO "Settings" VALUES ('syncmode',0);
INSERT INTO "Settings" VALUES ('togglenametags',1);
INSERT INTO "Settings" VALUES ('ac_pedifp',1);
INSERT INTO "Settings" VALUES ('ac_cleo',0);
INSERT INTO "Settings" VALUES ('max_packetloss',88);
INSERT INTO "Settings" VALUES ('ac_rapid',0);
INSERT INTO "Settings" VALUES ('showenemybar',1);
INSERT INTO "Settings" VALUES ('useproxychecker',2);
INSERT INTO "Settings" VALUES ('autoteamspec',0);
INSERT INTO "Settings" VALUES ('spawnlock',1);
INSERT INTO "Settings" VALUES ('ac_autoscroll',1);
INSERT INTO "Settings" VALUES ('ac_only',0);
INSERT INTO "Settings" VALUES ('serverlock',0);

COMMIT;