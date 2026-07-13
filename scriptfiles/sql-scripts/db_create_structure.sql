-- Accounts.db
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "Accounts" (
	"Nickname"	TEXT,
	"Admin"	INT,
	"Password"	TEXT,
	"Serial"	TEXT,
	"Lang"	INT,
	"Skin"	INT,
	"Weather"	INT,
	"Hour"	INT,
	"Hud"	INT,
	"Fpsbar"	INT,
	"Dtbar"	INT,
	"Bottombar"	INT,
	"Hpbar"	INT,
	"Bell"	INT,
	"Killchat"	INT,
	"Dmginformer"	INT,
	"Togpm"	INT,
	"AttachSlot0"	INT,
	"AttachSlot1"	INT,
	"AttachSlot2"	INT,
	"AttachSlot3"	INT,
	"Lastip"	TEXT,
	"Lastlogin"	TEXT,
	"Lastcountry"	TEXT,
	"Lastcity"	TEXT,
	"Banned"	INT,
	"Muted"	INT,
	"Verified"	INT,
	"Discord"	TEXT,
	"Cookies"	INT,
	"Sfx"	INTEGER,
	PRIMARY KEY("Nickname")
);
--INSERT INTO "Accounts" VALUES ('Testaccount',0,'678AF675A790D8E65D7F9B30EB78FC1D4D9CAF72E5266CCF29E01C6692FF43ED','AC99484E4CDE4EDCDF8558E84CEE999FAC9C0C94',0,160,2,11,1,1,1,2,0,1137,1,1,0,50,-1,-1,-1,'127.0.0.1','2.12.2022 15:39','United States','Ashburn',0,0,1,NULL,0,1);
COMMIT;

-- Core.db
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "Clanlist" (
	"Clanname"	TEXT UNIQUE,
	"Country"	TEXT,
	"Tag"	TEXT,
	"Leader"	TEXT,
	"Webpage"	TEXT,
	"Year"	TEXT
);

CREATE TABLE IF NOT EXISTS "Banlist" (
	"Nickname"	text,
	"Serial"	text,
	"HwID"	text,
	"HwBan"	int DEFAULT 0,
	"HwMute"	int DEFAULT 0,
	"Forceac"	int DEFAULT 0,
	"IpBan"	int DEFAULT 0,
	"IP"	text,
	"Reason"	text DEFAULT 'N/A',
	"Date"	text
);

CREATE TABLE IF NOT EXISTS "Settings" (
	"Option"	text,
	"Value"	int
);

COMMIT;

-- Logs.db
BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "Adminactions" (
	"Datetime"	TEXT,
	"Action"	TEXT
);

CREATE TABLE IF NOT EXISTS "Kicklog" (
	"Nickname"	TEXT,
	"Date"	TEXT,
	"IP"	TEXT,
	"Reason"	TEXT
);

CREATE TABLE IF NOT EXISTS "Nicknameslog" (
	"Datetime"	TEXT,
	"Nickname"	TEXT,
	"NewNickname"	TEXT
);

CREATE TABLE IF NOT EXISTS "Connectionlog" (
	"Datetime"	TEXT,
	"Nickname"	TEXT,
	"IP"	TEXT,
	"Country"	TEXT,
	"City"	TEXT,
	"Serial"	TEXT,
	"Hwid"	TEXT
);

CREATE TABLE IF NOT EXISTS "CWlog" (
	"Datetime"	TEXT,
	"TeamNameG"	TEXT,
	"TeamNameB"	TEXT,
	"TeamColorG"	TEXT,
	"TeamColorB"	TEXT,
	"Map"	TEXT,
	"Hitbox"	TEXT,
	"Rounds"	TEXT,
	"TeamG"	TEXT,
	"TeamB"	TEXT,
	"TotalScore"	TEXT,
	"CAC"	TEXT,
	"AntiLag"	TEXT
);

COMMIT;