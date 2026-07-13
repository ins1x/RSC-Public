-- Add admin account to accounts.db (admin rights 3 level)
-- As login and password use: root
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
INSERT INTO "Accounts" ("Nickname","Admin","Password","Serial","Lang","Skin","Weather","Hour","Hud","Fpsbar","Dtbar","Bottombar","Hpbar","Bell","Killchat","Dmginformer","Togpm","AttachSlot0","AttachSlot1","AttachSlot2","AttachSlot3","Lastip","Lastlogin","Lastcountry","Lastcity","Banned","Muted","Verified","Discord","Cookies","Sfx") VALUES ('root',3,'678AF675A790D8E65D7F9B30EB78FC1D4D9CAF72E5266CCF29E01C6692FF43ED','AC99484E4CDE4EDCDF8558E84CEE999FAC9C0C94',0,23,2,11,1,1,0,2,0,1137,1,1,0,-1,-1,-1,-1,'127.0.0.1','12.7.2024 00:00','Ashburn','USA',0,0,1,'',0,1);
COMMIT;