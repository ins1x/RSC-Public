"[>] РћСЂСѓР¶РµР№РЅС‹Рµ РЅР°РІС‹РєРё\t\n"\
	if(GetPVarInt(playerid, "Admin") >= 3)
	{
		strcat(tbtext, "{00bfff}>> Event heavy weapon fight\t\n");
		strcat(tbtext, "{ff00ff}>> Event dildo party fight\t\n");
	}
	
					case 2:
				{
					if(GetPVarInt(playerid, "Admin") >= 3)
					{
						if(!CWmode)
						{
							ShowPlayerDialog(playerid, 211, DIALOG_STYLE_LIST, "Weapon skills",
							"{00FF00}Restore default\n\
							One hand\n\
							Teleport mode\n\
							Explode mode\n\
							Tazer mode\n",
							"Select", "Exit");
						}
					} else { 
						return SendClientMessageEx(playerid, COLOR_RED,
						"Р”Р»СЏ РёСЃРїРѕР»СЊР·РѕРІР°РЅРёСЏ СЌС‚РёС… С„СѓРЅРєС†РёР№ Р’С‹ РґРѕР»Р¶РЅС‹ Р±С‹С‚СЊ Р°РґРјРёРЅРёСЃС‚СЂР°С‚РѕСЂРѕРј 3+ СѓСЂРѕРІРЅСЏ!",
						"To use these functions you need to have 3+ level admin rights!");
					}
				}
				
								case 6:
				{
					if(GetPVarInt(playerid, "Admin") >= 3)
					{
						if(!CWmode)
						{
							foreach(Player, i)
							{
								PlayerPlaySound(i, 1139, 0.0, 0.0, 0.0); 
								GivePlayerWeapon(i, 35, 10);
							}
							SetTimerEx("GiveDefaultWeaponsForAll", 10000, false, "i", -1);
							GameTextForAll("~r~HEAVY ~y~GUNS ~w~FIGHT!", 2000, 3);
							SendInfoGametext(playerid, "~r~10~w~ seconds of anarchy", 1);
						} else {
							SendClientMessageEx(playerid, COLOR_GREY,
							"РќРµРґРѕСЃС‚СѓРїРЅРѕ РІРѕ РІСЂРµРјСЏ РїСЂРѕРІРµРґРµРЅРёСЏ РјР°С‚С‡Р°", "Not available during CW match");
						}
					} else {
						SendClientMessageEx(playerid, COLOR_GREY,
						"Р”Р»СЏ РёСЃРїРѕР»СЊР·РѕРІР°РЅРёСЏ СЌС‚РёС… С„СѓРЅРєС†РёР№ Р’С‹ РґРѕР»Р¶РЅС‹ Р±С‹С‚СЊ Р°РґРјРёРЅРёСЃС‚СЂР°С‚РѕСЂРѕРј 3+ СѓСЂРѕРІРЅСЏ!",
						"To use these functions you need to have 3+ level admin rights!");
					}
				}
				case 7:
				{
					if(GetPVarInt(playerid, "Admin") >= 3)
					{
						if(!CWmode)
						{
							foreach(Player, i)
							{							
								PlayerPlaySound(i, 1139, 0.0, 0.0, 0.0); 
								GivePlayerWeapon(i, 10, 1);
							}
							SetTimerEx("GiveDefaultWeaponsForAll", 10000, false, "i", -1);
							GameTextForAll("~p~DILDO ~y~PARTY ~w~FIGHT!", 2000, 3);
							SendInfoGametext(playerid, "~r~10~w~ seconds of anarchy", 1);
						} else {
							SendClientMessageEx(playerid, COLOR_GREY,
							"РќРµРґРѕСЃС‚СѓРїРЅРѕ РІРѕ РІСЂРµРјСЏ РїСЂРѕРІРµРґРµРЅРёСЏ РјР°С‚С‡Р°", "Not available during CW match");
						}
					} else {
						SendClientMessageEx(playerid, COLOR_GREY,
						"Р”Р»СЏ РёСЃРїРѕР»СЊР·РѕРІР°РЅРёСЏ СЌС‚РёС… С„СѓРЅРєС†РёР№ Р’С‹ РґРѕР»Р¶РЅС‹ Р±С‹С‚СЊ Р°РґРјРёРЅРёСЃС‚СЂР°С‚РѕСЂРѕРј 3+ СѓСЂРѕРІРЅСЏ!",
						"To use these functions you need to have 3+ level admin rights!");
					}
				}
				
				