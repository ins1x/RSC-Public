/*
	Filterscript: Winter
	Description: Winter mode script
	Created specifically for RSC server 
	CW/TG gamemode powered by Russian Sawn-off Community 2022
	find us: https://dsc.gg/sawncommunity
	Credits:
		ShOoBy (SnowBall system)
		Boylett (xFireworks)
		1NS (mapping and inprovements)
*/

#include <a_samp>
#include <streamer>
#include <YSF>

#define COLOR_GREY 	0xAFAFAFAA
#define COLOR_COLD	0x83c7df00
#define MY_MAX_PLAYERS 50
#define KEY_AIM (128)

new SnowObject[MY_MAX_PLAYERS];
new SnowFight[MY_MAX_PLAYERS];
new SnowballObject[MY_MAX_PLAYERS];
new Charged[MY_MAX_PLAYERS];

//------------------------------------------------------------------------------

#define FILTERSCRIPT

public OnFilterScriptInit()
{
	new tmpobjid;
	tmpobjid = CreateObject(10817, -1563.319824, -189.016815, -0.486910,
	0.000000, 0.000000, 45.000000, 600.00); 
	SetObjectMaterial(tmpobjid, 7, 3922, "bistro", "mp_snow", 0x00000000);
	tmpobjid = CreateObject(10816, -1369.270751, 96.233573, 12.111597,
	0.000000, 0.000000, 45.000000, 600.00); 
	SetObjectMaterial(tmpobjid, 5, 3922, "bistro", "mp_snow", 0x00000000);
	CreateObject(3915, -1227.342407, -62.979492, 13.933238,
	0.000000, 0.000000, 135.100036, 600.00); 
	CreateObject(3915, -1188.040283, -111.682907, 13.723236,
	0.000000, 0.000000, 135.400085, 600.00); 
	CreateObject(3915, -1140.062255, -159.621582, 11.598214, 3.299999,
	0.000000, 135.400085, 600.00);
	tmpobjid = CreateObject(3814, -1217.1406, -67.1719, 19.7656,
	0.00, 0.00, -45.0, 600.00); 
	SetObjectMaterial(tmpobjid, 0, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 1, 3922, "bistro", "mp_snow", 0x00000000);
	tmpobjid = CreateObject(3814, -1178.1016, -114.8281, 19.7656,
	0.00, 0.00, -45.0, 600.00); 
	SetObjectMaterial(tmpobjid, 0, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 1, 3922, "bistro", "mp_snow", 0x00000000);
	
	tmpobjid = CreateObject(18763, -1231.206420, -34.009132, 16.618854,
	0.000000, 9.100001, 45.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 18835, "mickytextures", "red032", 0x00000000);
	tmpobjid = CreateObject(19790, -1228.356811, -41.107807, 12.722972,
	0.000000, 0.000000, 0.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper1", 0x00000000);
	tmpobjid = CreateObject(18763, -1232.822875, -35.667251, 13.068768,
	0.000000, 0.000000, 45.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 18835, "mickytextures", "red032", 0x00000000);
	tmpobjid = CreateObject(18766, -1231.750732, -34.580768, 14.577844,
	-10.800001, -90.000000, -45.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper4-2", 0x00000000);
	tmpobjid = CreateObject(18762, -1234.370727, -34.386852, 15.698507,
	90.000000, 0.000000, -45.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 18835, "mickytextures", "red032", 0x00000000);
	tmpobjid = CreateObject(18762, -1231.563110, -37.179912, 15.698507,
	90.000000, 0.000000, -45.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 18835, "mickytextures", "red032", 0x00000000);
	tmpobjid = CreateObject(18766, -1236.647216, -39.493209, 12.373988,
	-56.800018, -90.000000, -45.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "wrappingpaper4-2", 0x00000000);
	CreateObject(19054, -1236.850097, -33.148441, 14.268454, 0.000000, 0.000000, 0.000000, 600.00); 
	CreateObject(19055, -1238.762695, -31.625646, 14.146488, 0.000000, 0.000000, 0.000000, 600.00); 
	CreateObject(19076, -1237.587768, -32.068405, 13.209898, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(2464, -1238.260498, -32.932575, 14.088710, 0.000000, 0.000000, 149.200103, 300.00);  
	
	// Stadium
	tmpobjid = CreateObject(7416, 1347.8984, 2149.5547, 10.0156,
	0.00, 0.00, 0.00, 600.00); 
	SetObjectMaterial(tmpobjid, 0, 3922, "bistro", "mp_snow", 0x00000000);
	//SetObjectMaterial(tmpobjid, 1, 9557, "waterfall_sfw", "newaterfal1_256", 0xFFFFFFFF);
	SetObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "white", 0xFFFFFFFF);
	tmpobjid = CreateObject(7616, 1327.3906, 2133.2188, 9.0859,
	0.00, 0.00, 0.00, 600.00);
	SetObjectMaterial(tmpobjid, 3, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 5, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 6, 3922, "bistro", "mp_snow", 0x00000000);
	CreateObject(18268, 1356.631713, 2089.650878, 30.739864, 0.000000, 0.000000, -40.200084, 600.00); 
	CreateObject(18268, 1282.579711, 2112.928710, 33.039825, 0.000000, 0.000000, 69.700004, 600.00); 
	CreateObject(18268, 1279.434204, 2146.099609, 28.209768, 0.000000, 0.000000, 67.800033, 600.00); 
	
	// Gifts on class selection
	tmpobjid = CreateObject(854, 1411.531372, 2211.219482, 28.890953,
	0.000000, 0.000000, -34.800018, 20.00); 
	SetObjectMaterial(tmpobjid, 0, 3922, "bistro", "mp_snow", 0x00000000);
	tmpobjid = CreateObject(854, 1409.950927, 2212.961181, 28.890953,
	0.000000, 0.000000, -57.200008, 20.00); 
	SetObjectMaterial(tmpobjid, 0, 3922, "bistro", "mp_snow", 0x00000000);
	CreateObject(19055, 1409.291748, 2212.890380, 28.916418, 0.000000, 0.000000, 0.000000, 20.00); 
	CreateObject(19054, 1411.706176, 2210.612304, 28.946865, 0.000000, 0.000000, 0.000000, 20.00); 
	CreateObject(19064, 1411.120605, 2211.444824, 28.949920, 0.000000, 18.100002, -15.600000, 20.00); 
	CreateObject(350, 1410.560302, 2211.730712, 28.712188, 91.999916, 144.599990, 32.600013, 20.00); 
	CreateObject(19623, 1411.359863, 2211.052001, 29.496530, 0.000000, 0.000000, 151.499954, 20.00); 
	CreateObject(350, 1410.626953, 2211.993652, 28.693822, 89.899925, -63.700103, -13.399990, 20.00); 
	CreateObject(337, 1410.492431, 2213.202148, 29.519971, -13.800001, -170.599975, -13.199997, 20.00); 

	return 1;
}

public OnFilterScriptExit()
{
	// Restore Buildings
	CreateObject(7416, 1347.8984, 2149.5547, 10.0156, 0.00, 0.00, 0.00, 600.00); 
	CreateObject(7616, 1327.3906, 2133.2188, 9.0859, 0.00, 0.00, 0.00, 600.00);
	CreateObject(3814, -1217.1406, -67.1719, 19.7656, 0.00, 0.00, -45.0, 600.00);
	CreateObject(3814, -1178.1016, -114.8281, 19.7656, 0.00, 0.00, -45.0, 600.00); 
	return 1;
}

public OnPlayerConnect(playerid)
{
	// SF Airport 
	RemoveBuildingForPlayer(playerid, 3814, -1178.1016, -114.8281, 19.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 3814, -1217.1406, -67.1719, 19.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 3815, -1178.1016, -114.8281, 19.7656, 0.25);
	RemoveBuildingForPlayer(playerid, 3815, -1217.1406, -67.1719, 19.7656, 0.25);
	
	// Stadium
	RemoveBuildingForPlayer(playerid, 7416, 1347.8984, 2149.5547, 10.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 7727, 1347.8984, 2149.5547, 10.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 7616, 1327.3906, 2133.2188, 9.0859, 0.25);
	RemoveBuildingForPlayer(playerid, 7728, 1327.3906, 2133.2188, 9.0859, 0.25);
	
	// Stadium trees
	RemoveBuildingForPlayer(playerid, 713, 1376.1172, 1917.4766, 9.4922, 0.25);
	RemoveBuildingForPlayer(playerid, 707, 1268.7344, 2098.3516, 11.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1285.3125, 2081.1250, 15.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 3509, 1281.0547, 2085.0625, 10.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 645, 1289.4766, 2079.7500, 12.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1288.8438, 2085.4922, 15.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 645, 1270.8047, 2122.5625, 12.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1276.2344, 2122.2344, 15.0781, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1271.2813, 2128.9297, 14.4609, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1276.5078, 2101.4141, 15.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 3509, 1270.2656, 2112.3281, 7.4375, 0.25);
	RemoveBuildingForPlayer(playerid, 652, 1273.9688, 2168.0625, 11.8438, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1272.7813, 2158.2813, 14.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 652, 1269.8750, 2139.6953, 12.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 3509, 1274.7656, 2152.2422, 10.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 652, 1278.2734, 2114.0078, 13.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1280.5469, 2147.7109, 14.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1277.3438, 2128.2266, 15.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 3509, 1278.2734, 2163.4297, 9.8906, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1277.2109, 2174.6250, 13.2500, 0.25);
	RemoveBuildingForPlayer(playerid, 645, 1283.7656, 2147.1094, 12.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 652, 1288.7500, 2095.4219, 12.1875, 0.25);
	RemoveBuildingForPlayer(playerid, 3509, 1281.8594, 2133.5391, 10.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 616, 1438.3125, 2022.9688, 9.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3509, 1363.8828, 2077.3672, 9.1953, 0.25);
	RemoveBuildingForPlayer(playerid, 3509, 1351.3906, 2079.4766, 9.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 645, 1375.4297, 2079.8828, 11.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1340.5938, 2079.3281, 14.5781, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1335.7266, 2079.7813, 14.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 645, 1362.2031, 2087.7813, 12.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1350.7422, 2084.8281, 14.4766, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1358.7109, 2090.8516, 13.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1365.4141, 2084.4375, 14.0938, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1374.8906, 2086.1016, 13.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1367.7891, 2089.0703, 13.5156, 0.25);
	RemoveBuildingForPlayer(playerid, 645, 1323.4766, 2094.1797, 10.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1325.1406, 2091.7109, 13.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1374.2656, 2091.8828, 13.0078, 0.25);

	RandomMusicForPlayer(playerid);
	SnowFight[playerid] = 0;
	Charged[playerid] = 0;
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(!GetPVarInt(playerid, "firstspawn"))
	{
		SendClientMessage(playerid, COLOR_COLD, "Winter is coming. New cmds /toghat /snow");
		SendClientMessage(playerid, COLOR_COLD, "New new year costumes are available now, check /costumes");
	}
	StopAudioStreamForPlayer(playerid);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	DestroyObject(SnowObject[playerid]);
	return 1;
}

public OnPlayerSpawn(playerid)
{
    DestroyObject(SnowballObject[playerid]);
   	
	// Frosty breath
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		SetPlayerAttachedObject(playerid, 0, 18677, 2, -0.012000, 0.120999,	-1.622999,
		0.000000, 0.000000, 0.000000,  1.000000, 1.000000, 1.000000); // 18677
	}
	SetPVarInt(playerid, "firstspawn", 1);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/snow", true))
	{
		if(GetPVarInt(playerid, "Snow"))
		{
			DestroyObject(SnowObject[playerid]);
			SetPVarInt(playerid, "Snow", 0);
			SendClientMessage(playerid, COLOR_COLD,	"Toggle snowfall [OFF]");
		} else {
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			SnowObject[playerid] = CreateObject(18864, x, y, z, 0.00, 0.00, 1.00);
			#if defined _YSF_included
			for(new i = 0; i < MY_MAX_PLAYERS; i++)
			{
				if (IsPlayerConnected(i) && i != playerid)
				{
					HideObjectForPlayer(i, SnowObject[playerid]);
				}
			}
			#endif
			SetPVarInt(playerid, "Snow", 1);
			SendClientMessage(playerid, COLOR_COLD,	"Toggle snowfall [ON]");
		}
		return true;
	}
	/*if (strcmp("/snowball", cmdtext, true, 10) == 0)
	{
		if(SnowFight[playerid] == 0)
		{
			SnowFight[playerid] = 1;
			Charged[playerid] = 0;
			SendClientMessage(playerid, COLOR_COLD,
			"In this minigame, your goal is to hit as many players as you can, without being hit by them.");
			SendClientMessage(playerid, COLOR_COLD,"To throw an snowball press: AIM Key. Good Luck!");
		} else if(SnowFight[playerid] == 1) {
			SnowFight[playerid] = 0;
			SpawnPlayer(playerid);
		}
		return 1;
	}*/
	if (!strcmp(cmdtext, "/toghat", true))
	{
		if(GetPVarInt(playerid, "toghat"))
		{
			if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
			SendClientMessage(playerid, COLOR_COLD,	"Toggle santa hat [OFF]");
		} else {
			if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
			SetPlayerAttachedObject(playerid, 1, 19065, 2, 0.120000, 0.040000, -0.003500,
			0, 100, 100, 1.4, 1.4, 1.4);
			SetPVarInt(playerid, "toghat", 1);
			SendClientMessage(playerid, COLOR_COLD,	"Toggle santa hat [ON]");
		}
		return 1;
	}
	if (!strcmp(cmdtext, "/music", true))
	{
		RandomMusicForPlayer(playerid);
		SendClientMessage(playerid, COLOR_GREY,
		"To stop audio playback type /stop");
		return 1;
	}
	if (!strcmp(cmdtext, "/stop", true))
	{
		StopAudioStreamForPlayer(playerid);
		return 1;
	}
	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(SnowFight[playerid] == 1)
	{
		if(newkeys & KEY_AIM)
		{
			if(Charged[playerid])
			{
				return ThrowSnowball(playerid);
			} else {
				Charged[playerid] = 1;
				return ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0 );
			}
		}
	}
	return 1;
}

forward ThrowSnowball(playerid);
public ThrowSnowball(playerid)
{
	new Float:pX, Float:pY, Float:pZ, Float:tX, Float:tY, Float:tZ;
	new Float:FrontX, Float:FrontY;
	
	for(new p = 0; p < MY_MAX_PLAYERS; p++)
	{		
		GetXYInFrontOfPlayer(playerid, FrontX, FrontY, 5.0);

		if(p != playerid && IsPlayerInRangeOfPoint(p, 5.0, FrontX, FrontY, 14.0))
		{
			GetPlayerPos(playerid,pX,pY,pZ);
			GetPlayerPos(p,tX,tY,tZ);
			SnowballObject[p] = CreateObject(3003, pX, pY, pZ+0.5, 0.0, 0.0, 0.0, 30);
			MoveObject(SnowballObject[p], tX, tY, tZ-0.9, 25.0);
			GameTextForPlayer(playerid, "~R~Target ~w~Shoot~r~!~N~", 1000, 3);
			Charged[playerid] = 0;
			ApplyAnimation(playerid,"GRENADE","WEAPON_throw", 4.1, 0,1,1,1,1,1);
			ApplyAnimation(p,"BASEBALL","Bat_Hit_3", 4.1, 0,1,1,0,1,1);
		} else {
			GetPlayerPos(playerid,pX,pY,pZ);
			SnowballObject[p] = CreateObject(3003, FrontX+5.0, FrontY+5.0, pZ+0.5, 0.0, 0.0, 0.0, 30);
			MoveObject(SnowballObject[p], tX, tY, tZ-0.9, 25.0);
			ApplyAnimation(playerid,"GRENADE","WEAPON_throw", 4.1, 0,1,1,1,1,1);
			GameTextForPlayer(playerid,"~W~Miss ~R~!",1000,1);
			Charged[playerid] = 0;
		}		
	}
	return 1;
}

GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
    new Float:a;
    GetPlayerPos(playerid, x, y, a);
    GetPlayerFacingAngle(playerid, a);
    if(GetPlayerVehicleID(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
}

RandomMusicForPlayer(playerid)
{
	switch(random(5))
	{
		case 1: PlayAudioStreamForPlayer(playerid,
		"https://minty.club/artist/merry-christmas/white-christmas/merry-christmas-white-christmas.mp3");
		case 2: PlayAudioStreamForPlayer(playerid,
		"https://minty.club/artist/merry-christmas/winter-wonderland/merry-christmas-winter-wonderland.mp3");
		case 3: PlayAudioStreamForPlayer(playerid,
		"https://minty.club/artist/merry-christmas/all-i-want-for-christmas-is-you/merry-christmas-all-i-want-for-christmas-is-you.mp3");
		case 4: PlayAudioStreamForPlayer(playerid,
		"https://minty.club/artist/merry-christmas/joy-to-the-world/merry-christmas-joy-to-the-world.mp3");
		case 5: PlayAudioStreamForPlayer(playerid,
		"https://minty.club/artist/merry-christmas/here-comes-santa-claus/merry-christmas-here-comes-santa-claus.mp3");
		default: PlayAudioStreamForPlayer(playerid,
		"https://minty.club/artist/merry-christmas/jingle-bells/merry-christmas-jingle-bells.mp3");
	}
}