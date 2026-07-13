/*
	Filterscript: mapdebug
	Description: simple mapping debug toolkit
	Author: 1NS
	Homepage: ins1x.github.io/insanemapping
*/

#include <a_samp>
#include <streamer>
#tryinclude <foreach>

#define FILTERSCRIPT

#define DIALOG_CREATEOB 3000

new EDIT_OBJECTID[MAX_PLAYERS] = {-1, ...};
new EDIT_OBJECTMODELID[MAX_PLAYERS] = {-1, ...};

//main() {}

public OnFilterScriptInit()
{
	#if defined _streamer_included
	printf("Loaded dynamic objects \t[%i]", CountDynObjects());
	printf("Loaded dynamic pickups \t[%i]", CountDynPickups());
	#endif
	print("Type /mapdebug to show all available commands");
	return 1;
}

public OnFilterScriptExit()
{
	foreach(Player, i)
	{
		if(EDIT_OBJECTID[i] != 1) DestroyDynamicObject(EDIT_OBJECTID[i]);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_CREATEOB)
	{
		if(response)
		{
			#if defined _streamer_included
			new modelid = strval(inputtext);
			if(!IsValidObjectModel(modelid))
			{
				return SendClientMessage(playerid, -1, "Wrong objectid!");
			}
			
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x,y,z);
			EDIT_OBJECTID[playerid] = CreateDynamicObject(modelid, x+1, y+1, z+1, 0.0, 0.0, 0.0,
			GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			SetPVarInt(playerid, "Editmode", 2);
			EditDynamicObject(playerid, EDIT_OBJECTID[playerid]);
			#endif
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[128], tmp[128], idx;
	cmd = strtok(cmdtext, idx);
	if (!strcmp("/mapdebug", cmd, true))
	{
		SendClientMessage(playerid, -1, "/oadd <modelid> - createobject");
		SendClientMessage(playerid, -1, "/edit - edit object");
		SendClientMessage(playerid, -1, "/csel - select object (object info)");
		SendClientMessage(playerid, -1, "/odel - select and delete object");
		SendClientMessage(playerid, -1, "/lastdel - delete last object");
		SendClientMessage(playerid, -1, "/saveobj - save object");
	}
	if (!strcmp("/csel", cmd, true) || !strcmp("/sel", cmd, true))
	{
		SetPVarInt(playerid, "Editmode", 1);
		SelectObject(playerid);
		return true;
	}
	if (!strcmp("/edit", cmd, true))
	{
		SetPVarInt(playerid, "Editmode", 2);
		//SelectObject(playerid);
		EditDynamicObject(playerid, EDIT_OBJECTID[playerid]);
		return true;
	}
	if (!strcmp("/saveobject", cmd, true) || !strcmp("/saveobj", cmd, true))
	{
		SetPVarInt(playerid, "Editmode", 4);
		SelectObject(playerid);
		return true;
	}
	if (!strcmp("/odel", cmd, true) || !strcmp("/deleteobject", cmd, true))
	{
		SetPVarInt(playerid, "Editmode", 3);
		SelectObject(playerid);
		return true;
	}
	if (!strcmp("/lastdel", cmd, true))
	{
		DestroyDynamicObject(EDIT_OBJECTID[playerid]);
		EDIT_OBJECTID[playerid] = -1;		
		return true;
	}
	if(!strcmp("/oadd", cmd, true) || !strcmp("/object", cmd, true))
	{
		tmp = strtok(cmdtext, idx);
		new modelid = strval(tmp);
		if(!strlen(tmp))
		{
			new header[64];
			if(EDIT_OBJECTID[playerid] != -1)
			{
				format(header, sizeof(header), "Create object. Last object modelid: %d",
				EDIT_OBJECTMODELID[playerid]);
			}
			else format(header, sizeof(header), "Create object.");
			
			ShowPlayerDialog(playerid, DIALOG_CREATEOB, DIALOG_STYLE_INPUT, header,
			"{FFFFFF} Enter the model ID of the object to create it \n"\
			"The object will appear in front of you, then you will modify it\n\n"\
			"{FFD700}615-18300 [GTASA], 18632-19521 [SAMP]\n"\
			"{FFFFFF} The list of objects by category can be viewed:\n"\
			"on the site {00BFFF} https://dev.prineside.com/ru",
			"Create","Close");
		}
		
		#if defined _streamer_included
			if(!IsValidObjectModel(modelid))
			{
				return SendClientMessage(playerid, -1, "Wrong objectid!");
			}

			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x,y,z);
			EDIT_OBJECTID[playerid] = CreateDynamicObject(modelid, x+1, y+1, z+1, 0.0, 0.0, 0.0,
			GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
			SetPVarInt(playerid, "Editmode", 2);
			EditDynamicObject(playerid, EDIT_OBJECTID[playerid]);
		#endif
		
		return true;
	}
	return 0;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING)
	{
		SetPlayerPosFindZ(playerid, fX, fY, fZ); 
	}
    return 1;
}

#if defined _streamer_included
public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(response == EDIT_RESPONSE_FINAL || response == EDIT_RESPONSE_CANCEL)
	{
		CancelEdit(playerid);
		SetPVarInt(playerid, "Editmode", 0);
	}
	return 1;
}

public OnPlayerSelectDynamicObject(playerid, objectid, modelid, Float:x, Float:y, Float:z)
{ 
	EDIT_OBJECTMODELID[playerid] = modelid;
	EDIT_OBJECTID[playerid] = objectid;
	new Float:rx, Float:ry, Float:rz;
	GetDynamicObjectRot(objectid, rx, ry, rz);
	
	new tmpstr[256];
	format(tmpstr, sizeof(tmpstr),
	"~w~Model: ~g~%i~n~\
	~w~x: ~g~%.3f ~w~y: ~g~%.3f ~w~z: ~g~%.3f~n~\
	~w~rx: ~g~%.3f ~w~ry: ~g~%.3f ~w~rz: ~g~%.3f",
	modelid, x, y, z, rx, ry, rz); 

	GameTextForPlayer(playerid, tmpstr, 3000, 5);
	printf("modelid: %i, x:%.3f, y:%.3f, z:%.3f, rx:%.3f, ry:%.3f, rz:%.3f",
	modelid, x, y, z, rx, ry, rz); 
	
	switch(GetPVarInt(playerid, "Editmode"))
	{
		case 2: EditDynamicObject(playerid, objectid);
		case 3:
		{
			DestroyDynamicObject(objectid);
			EDIT_OBJECTID[playerid] = -1;
			CancelEdit(playerid);
		}
		case 4:
		{
			printf("CreateDynamicObject(%i, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %i, %i);",
			modelid, x, y, z, rx, ry, rz, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)); 
			CancelEdit(playerid);
		}
	}
	return 1;
}
#endif

stock IsValidObjectModel(modelid)
{
	if(modelid >= 321 && modelid <= 328 || modelid >= 330 && modelid <= 331) return 1;
	else if(modelid >= 333 && modelid <= 339 || modelid >= 341 && modelid <= 373) return 1;
	else if(modelid >= 615 && modelid <= 661 || modelid == 664) return 1; 
	else if(modelid >= 669 && modelid <= 698 || modelid >= 700 && modelid <= 792)  return 1;
	else if(modelid >= 800 && modelid <= 906 || modelid >= 910 && modelid <= 964) return 1;
	else if(modelid >= 966 && modelid <= 998 || modelid >= 1000 && modelid <= 1193) return 1;
	else if(modelid >= 1207 && modelid <= 1325 || modelid >= 1327 && modelid <= 1572) return 1;
	else if(modelid >= 1574 && modelid <= 1698 || modelid >= 1700 && modelid <= 2882) return 1;
	else if(modelid >= 2885 && modelid <= 3135 || modelid >= 3167 && modelid <= 3175) return 1;
	else if(modelid == 3178 || modelid == 3187 || modelid == 3193 || modelid == 3214) return 1;
	else if(modelid == 3221 || modelid >= 3241 && modelid <= 3244) return 1;
	else if(modelid == 3246 || modelid >= 3249 && modelid <= 3250) return 1;
	else if(modelid >= 3252 && modelid <= 3253 || modelid >= 3255 && modelid <= 3265) return 1;
	else if(modelid >= 3267 && modelid <= 3347 || modelid >= 3350 && modelid <= 3415) return 1;
	else if(modelid >= 3417 && modelid <= 3428 || modelid >= 3430 && modelid <= 3609) return 1;
	else if(modelid >= 3612 && modelid <= 3783 || modelid >= 3785 && modelid <= 3869) return 1;
	else if(modelid >= 3872 && modelid <= 3882 || modelid >= 3884 && modelid <= 3888) return 1;
	else if(modelid >= 3890 && modelid <= 3973 || modelid >= 3975 && modelid <= 4541) return 1;
	else if(modelid >= 4550 && modelid <= 4762 || modelid >= 4806 && modelid <= 5084) return 1;
	else if(modelid >= 5086 && modelid <= 5089 || modelid >= 5105 && modelid <= 5375) return 1;
	else if(modelid >= 5390 && modelid <= 5682 || modelid >= 5703 && modelid <= 6010) return 1;
	else if(modelid >= 6035 && modelid <= 6253 || modelid >= 6255 && modelid <= 6257) return 1;
	else if(modelid >= 6280 && modelid <= 6347 || modelid >= 6349 && modelid <= 6525) return 1;
	else if(modelid >= 6863 && modelid <= 7392 || modelid >= 7415 && modelid <= 7973) return 1;
	else if(modelid >= 7978 && modelid <= 9193 || modelid >= 9205 && modelid <= 9267) return 1;
	else if(modelid >= 9269 && modelid <= 9478 || modelid >= 9482 && modelid <= 10310) return 1;
	else if(modelid >= 10315 && modelid <= 10744 || modelid >= 10750 && modelid <= 11417) return 1;
	else if(modelid >= 11420 && modelid <= 11753 || modelid >= 12800 && modelid <= 13563) return 1;
	else if(modelid >= 13590 && modelid <= 13667 || modelid >= 13672 && modelid <= 13890) return 1;
	else if(modelid >= 14383 && modelid <= 14528 || modelid >= 14530 && modelid <= 14554) return 1;
	else if(modelid == 14556 || modelid >= 14558 && modelid <= 14643) return 1;
	else if(modelid >= 14650 && modelid <= 14657 || modelid >= 14660 && modelid <= 14695) return 1;
	else if(modelid >= 14699 && modelid <= 14728 || modelid >= 14735 && modelid <= 14765) return 1;
	else if(modelid >= 14770 && modelid <= 14856 || modelid >= 14858 && modelid <= 14883) return 1;
	else if(modelid >= 14885 && modelid <= 14898 || modelid >= 14900 && modelid <= 14903) return 1;
	else if(modelid >= 15025 && modelid <= 15064 || modelid >= 16000 && modelid <= 16790) return 1;
	else if(modelid >= 17000 && modelid <= 17474 || modelid >= 17500 && modelid <= 17974) return 1;
	else if(modelid == 17976 || modelid == 17978 || modelid >= 18000 && modelid <= 18036) return 1;
	else if(modelid >= 18038 && modelid <= 18102 || modelid >= 18104 && modelid <= 18105) return 1;
	else if(modelid == 18109 || modelid == 18112 || modelid >= 18200 && modelid <= 18859) return 1;
	else if(modelid >= 18860 && modelid <= 19274 || modelid >= 19275 && modelid <= 19595) return 1;
	else if(modelid >= 19596 && modelid <= 19999) return 1; 
	else return 0;
}

#if defined _streamer_included
stock CountDynObjects(worldid = -1)
{
	new dynnumobject = CreateDynamicObject(0,0,0,0,0,0,0,worldid); 
    DestroyDynamicObject(dynnumobject); 
	return dynnumobject-1; 
}

stock CountDynPickups()
{
	new dynpicknumobject = CreateDynamicPickup(0, 0, 0,0,0, 0, 0, 0, 0, -1, 0); 
    DestroyDynamicPickup(dynpicknumobject); 
	return dynpicknumobject-1; 
}
#endif

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}