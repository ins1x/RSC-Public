stock ALLACTIONS_MENU(playerid) 
{
	new tbtext[550];

	if(pData[playerid][pLang] == 1)
	{		
		format(tbtext, sizeof(tbtext),
		"Respawn all players\n"\
		"Remove jetpacks for all players\n"\
		"Unspec for all players\n"\
		"Unmute all players online\n"\
		"Teleport all players to you\n"\
		"Show/Hide markers for all\n"\
		"{FF0000}Disarm{FFFFFF} all players\n"\
		"{FF0000}Kick{FFFFFF} players without sampcac\n");
		if(GetPVarInt(playerid, "Admin") >= 2 || IsPlayerAdmin(playerid))
		{ 	
			ShowPlayerDialog(playerid, 54, DIALOG_STYLE_LIST,
			"All players Actions",tbtext, "Select", "Cancel");
		}
	} else {
		format(tbtext, sizeof(tbtext),
		"Р—Р°СЂРµСЃРїР°РІРЅРёС‚СЊ РІСЃРµС… РёРіСЂРѕРєРѕРІ\n"\
		"Р—Р°Р±СЂР°С‚СЊ РґР¶РµС‚РїР°РєРё Сѓ РІСЃРµС… РёРіСЂРѕРєРѕРІ\n"\
		"Р’С‹РІРµСЃС‚Рё РёР· РЅР°Р±Р»СЋРґРµРЅРёСЏ РІСЃРµС… РёРіСЂРѕРєРѕРІ\n"\
		"Р Р°Р·РіР»СѓС€РёС‚СЊ РІСЃРµС… РёРіСЂРѕРєРѕРІ РѕРЅР»Р°Р№РЅ\n"\
		"РўРµР»РµРїРѕСЂС‚РёСЂРѕРІР°С‚СЊ РІСЃРµС… РёРіСЂРѕРєРѕРІ Рє СЃРµР±Рµ\n"\
		"РџРѕРєР°Р·Р°С‚СЊ/СЃРїСЂСЏС‚Р°С‚СЊ РјР°СЂРєРµСЂС‹ РёРіСЂРѕРєРѕРІ\n"\
		"{FF0000}Р—Р°Р±СЂР°С‚СЊ{FFFFFF} РѕСЂСѓР¶РёРµ Сѓ РІСЃРµС… РёРіСЂРѕРєРѕРІ\n"\
		"{FF0000}РљРёРєРЅСѓС‚СЊ{FFFFFF} РёРіСЂРѕРєРѕРІ Р±РµР· sampcac\n");

		if(GetPVarInt(playerid, "Admin") >= 2 || IsPlayerAdmin(playerid))
		{ 	
			ShowPlayerDialog(playerid, 54, DIALOG_STYLE_LIST,
			"Р”РµР№СЃС‚РІРёСЏ РЅР°Рґ РІСЃРµРјРё РёРіСЂРѕРєР°РјРё", tbtext, "Р’С‹Р±СЂР°С‚СЊ", "Р’С‹Р№С‚Рё");
		}
	}
}

if(dialogid == 54) // ALLACTIONS_MENU
	{
		if(response)
		{
			new stringru[128], stringen[128];
			switch(listitem)
			{
				case 0:
				{
					if (score[0] == Roundkills || score[1] == Roundkills)
					{
						SendClientMessageEx(playerid, COLOR_GREY, "РЎРµР№С‡Р°СЃ Р’С‹ РЅРµ РјРѕР¶РµС‚Рµ РёСЃРїРѕР»СЊР·РѕРІР°С‚СЊ РґР°РЅРЅСѓСЋ С„СѓРЅРєС†РёСЋ.", "You can't use this function right now.");
						return true;
					}
					for(new i = 0; i < MAX_PLAYER_ID; i++)
					{
						if (IsPlayerConnected(i))
						{
							if (GetPlayerState(i) == PLAYER_STATE_ONFOOT)
							{
								if (!GetPVarInt(i, "UnBug"))
								{
									ReSpawnPlayer(i);
								}
							}
						}
					}
					format(stringru, sizeof(stringru), "%s(%d) Р·Р°СЂРµСЃРїР°РІРЅРёР» РІСЃРµС… РёРіСЂРѕРєРѕРІ",
					PlayerName(playerid), playerid);
					format(stringen, sizeof(stringen), "%s(%d) respawn all players",
					PlayerName(playerid), playerid);
					SendClientMessageToAllEx(COLOR_GREY, stringru, stringen);
				}
				case 1:
				{
					foreach(Player, i)
					{
						if (GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK)
						{
							ReSpawnPlayer(i);
						}
					}
					format(stringru, sizeof(stringru), "%s(%d) Р·Р°Р±СЂР°Р» Сѓ РІСЃРµС… РґР¶РµС‚РїР°РєРё",
					PlayerName(playerid), playerid);
					format(stringen, sizeof(stringen), "%s(%d) remove jetpacks",
					PlayerName(playerid), playerid);
					SendClientMessageToAllEx(COLOR_GREY, stringru, stringen);
					AdminActionsLog(stringen);
				}
				case 2:
				{
					if (speconly)
					{
						SendClientMessageEx(playerid, COLOR_GREY,
						"Р’ РґР°РЅРЅС‹Р№ РјРѕРјРµРЅС‚ РЅР°Р±Р»СЋРґР°С‚РµР»Рё РѕР±СЏР·Р°РЅС‹ РѕСЃС‚Р°РІР°С‚СЊСЃСЏ РІ СЂРµР¶РёРјРµ РЅР°Р±Р»СЋРґРµРЅРёСЏ.(speconly)",
						"Spectators are required to use spectate mode right now. (speconly)");
						if(pData[playerid][pVerified])
						{
							SendClientMessageEx(playerid, COLOR_GREY,
							"Р’С‹ РјРѕР¶РµС‚Рµ РїРµСЂРµР№С‚Рё РІ РґСЂСѓРіРѕР№ РІРёСЂС‚СѓР°Р»СЊРЅС‹Р№ РјРёСЂ Рё РёРіСЂР°С‚СЊ С‚Р°Рј (/world <id>)",
							"You can go to another virtual world and play there (/world <id>)");
						}
						return true;
					}
					
					foreach(Player, i)
					{
						if (GetPlayerState(i) == PLAYER_STATE_SPECTATING)
						{
							SpecOff(i);
						}
					}
					format(stringru, sizeof(stringru), "%s(%d) РІС‹РІРµР» РІСЃРµС… РёР· РЅР°Р±Р»СЋРґРµРЅРёСЏ",
					PlayerName(playerid), playerid);
					format(stringen, sizeof(stringen), "%s(%d) specoff for all spectators",
					PlayerName(playerid), playerid);
					SendClientMessageToAllEx(COLOR_GREY, stringru, stringen);
					AdminActionsLog(stringen);
				}
				case 3:
				{
					if (GetPVarInt(playerid, "Admin") >= 3 || IsPlayerAdmin(playerid)) 
					{
						foreach(Player, i)
						{
							if(pData[i][pMuted] > 0) pData[i][pMuted] = 0;
						}
						format(stringru, sizeof(stringru), "%s(%d) СЂР°Р·РіР»СѓС€РёР» РІСЃРµС… РёРіСЂРѕРєРѕРІ",
						PlayerName(playerid), playerid);
						format(stringen, sizeof(stringen), "%s(%d) has unmuted all players",
						PlayerName(playerid), playerid);
						SendClientMessageToAllEx(COLOR_GREY, stringru, stringen);
						AdminActionsLog(stringen);
					} else { 
						SendClientMessageEx(playerid, COLOR_GREY,
						"Р”Р»СЏ РёСЃРїРѕР»СЊР·РѕРІР°РЅРёСЏ СЌС‚РёС… С„СѓРЅРєС†РёР№ Р’С‹ РґРѕР»Р¶РЅС‹ Р±С‹С‚СЊ Р°РґРјРёРЅРёСЃС‚СЂР°С‚РѕСЂРѕРј 3+ СѓСЂРѕРІРЅСЏ!",
						"To use these functions you need to have 3+ level admin rights!");
					}
				}
				case 4:
				{
					if (GetPVarInt(playerid, "Admin") >= 2 || IsPlayerAdmin(playerid)) 
					{
						foreach(Player, i)
						{
							if(i != playerid)
							{
								new Float:x, Float:y, Float:z;
								GetPlayerPos(i, x, y, z);
								SetPlayerPos(playerid, x+random(4), y+random(4), z);
							}
						}
						format(stringru, sizeof(stringru), "%s(%d) С‚РµР»РµРїРѕСЂС‚РёСЂРѕРІР°Р» РІСЃРµС… РёРіСЂРѕРєРѕРІ Рє СЃРµР±Рµ.",
						PlayerName(playerid), playerid);
						format(stringen, sizeof(stringen), "%s(%d) has teleported all players to himself.",
						PlayerName(playerid), playerid);
						SendClientMessageToAllEx(COLOR_GREY, stringru, stringen);
						AdminActionsLog(stringen);
					} else { 
						SendClientMessageEx(playerid, COLOR_GREY,
						"Р”Р»СЏ РёСЃРїРѕР»СЊР·РѕРІР°РЅРёСЏ СЌС‚РёС… С„СѓРЅРєС†РёР№ Р’С‹ РґРѕР»Р¶РЅС‹ Р±С‹С‚СЊ Р°РґРјРёРЅРёСЃС‚СЂР°С‚РѕСЂРѕРј 2+ СѓСЂРѕРІРЅСЏ!",
						"To use these functions you need to have 2+ level admin rights!");
					}
				}
				case 5:
				{
					if (Marker)
					{
						TogglePlayerMarkers(false);
						Marker = false;
						format(stringru, sizeof(stringru),
						"%s(%d) РѕС‚РєР»СЋС‡РёР» РѕС‚РѕР±СЂР°Р¶РµРЅРёРµ РёРіСЂРѕРєРѕРІ РЅР° СЂР°РґР°СЂРµ.", PlayerName(playerid), playerid);
						format(stringen, sizeof(stringen),
						"%s(%d) has hidden player markers on map.", PlayerName(playerid), playerid);
					} else {
						TogglePlayerMarkers(true);
						Marker = true;
						format(stringru, sizeof(stringru),
						"%s(%d) РІРєР»СЋС‡РёР» РѕС‚РѕР±СЂР°Р¶РµРЅРёРµ РёРіСЂРѕРєРѕРІ РЅР° СЂР°РґР°СЂРµ.", PlayerName(playerid), playerid);
						format(stringen, sizeof(stringen),
						"%s(%d) has shown player markers on map.", PlayerName(playerid), playerid);
					}
					SendClientMessageToAllEx(COLOR_GREY, stringru, stringen);
					AdminActionsLog(stringen);
				}
				case 6:
				{
					if (GetPVarInt(playerid, "Admin") >= 2)
					{
						ResetWeaponsForAll();
						format(stringen, sizeof(stringen),
						"%s(%d) has reset weapons for all.",
						PlayerName(playerid), playerid);
						format(stringru, sizeof(stringru),
						"%s(%d) Р·Р°Р±СЂР°Р» РѕСЂСѓР¶РёРµ Сѓ РІСЃРµС….",
						PlayerName(playerid), playerid);
						SendClientMessageToAllEx(COLOR_GREY, stringru, stringen);
						AdminActionsLog(stringen);
					} else {
						SendClientMessageEx(playerid, COLOR_RED,
						"РўРѕР»СЊРєРѕ Р°РґРјРёРЅРёСЃС‚СЂР°С‚РѕСЂС‹ РјРѕРіСѓС‚ РёСЃРїРѕР»СЊР·РѕРІР°С‚СЊ СЌС‚Сѓ РєРѕРјР°РЅРґСѓ!",
						"Only administrators can use this command");
					}
				}
				case 7:
				{
					#if defined _sampcac_included
					if (GetPVarInt(playerid, "Admin") >= 2)
					{
						foreach(Player, i)
						{
							if (IsPlayerConnected(i))
							{
								new major, minor, patch;
								CAC_GetClientVersion(i, major, minor, patch);
								if(CAC_GetStatus(i) == 0 ) KickPlayerEx(i, "SAMPCAC is not installed");
								if(minor != 10) KickPlayerEx(i, "SAMPCAC is outdated");
							}
						}
					}else{
						SendClientMessageEx(playerid, COLOR_RED,
						"РўРѕР»СЊРєРѕ Р°РґРјРёРЅРёСЃС‚СЂР°С‚РѕСЂС‹ РјРѕРіСѓС‚ РёСЃРїРѕР»СЊР·РѕРІР°С‚СЊ СЌС‚Сѓ РєРѕРјР°РЅРґСѓ!",
						"Only administrators can use this command");
					}
					#else
						SendClientMessageEx(playerid, COLOR_GREY,
						"Р¤СѓРЅРєС†РёСЏ РЅРµРґРѕСЃС‚СѓРїРЅР° Р±РµР· SAMPCAC","Feature not available without SAMPCAC");
					#endif
				}
			}
		} else {
			if(LAST_DIALOG[playerid] == 32)
			{
				if(GetPVarInt(playerid, "Admin") >= 2 || IsPlayerAdmin(playerid))
				{
					ADMIN_MENU(playerid);
				}
			}
		}
	}