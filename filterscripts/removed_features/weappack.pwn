	if (dialogid == 150) // weap pack
	{
		if(response)
		{
			ResetWeaponsForAll();
			switch(listitem)
			{
				case 0: // lamo pack
				{
					weapdata[3] = 26;
					weapdata[4] = 32;
					SelectedWeapon = 26;
					for(new i = 0; i < MAX_PLAYER_ID; i++)
					{
						GivePlayerWeapon(i, 26, 9999);
						GivePlayerWeapon(i, 32, 9999);
					}
				}
				case 1: // lamo pack 2
				{
					weapdata[3] = 26;
					weapdata[4] = 28;
					SelectedWeapon = 26;
					for(new i = 0; i < MAX_PLAYER_ID; i++)
					{
						GivePlayerWeapon(i, 26, 9999);
						GivePlayerWeapon(i, 28, 9999);
					}
				}
				case 2: // +c pack
				{
					weapdata[2] = 24;
					weapdata[3] = 25;
					SelectedWeapon = 24;
					for(new i = 0; i < MAX_PLAYER_ID; i++)
					{
						GivePlayerWeapon(i, 24, 9999);
						GivePlayerWeapon(i, 25, 9999);
					}
				}
				case 3: // +c pack 2
				{
					weapdata[2] = 24;
					weapdata[3] = 27;
					SelectedWeapon = 24;
					for(new i = 0; i < MAX_PLAYER_ID; i++)
					{
						GivePlayerWeapon(i, 24, 9999);
						GivePlayerWeapon(i, 27, 9999);
					}
				}
				case 4: // pro pack
				{
					weapdata[2] = 24;
					weapdata[3] = 25;
					weapdata[6] = 34;
					SelectedWeapon = 24;
					for(new i = 0; i < MAX_PLAYER_ID; i++)
					{
						GivePlayerWeapon(i, 24, 9999);
						GivePlayerWeapon(i, 25, 9999);
						GivePlayerWeapon(i, 34, 9999);
					}
				}
				case 5: // sniper pack
				{
					weapdata[1] = 4;
					weapdata[6] = 34;
					SelectedWeapon = 34;
					for(new i = 0; i < MAX_PLAYER_ID; i++)
					{
						GivePlayerWeapon(i, 4, 1);
						GivePlayerWeapon(i, 34, 9999);
					}
				}
				case 6: // defender pack
				{
					weapdata[1] = 4;
					weapdata[2] = 23;
					weapdata[5] = 31;
					SelectedWeapon = 23;
					for(new i = 0; i < MAX_PLAYER_ID; i++)
					{
						GivePlayerWeapon(i, 4, 1);
						GivePlayerWeapon(i, 23, 9999);
						GivePlayerWeapon(i, 31, 9999);
					}
				}
			}
		} else {
			if(LAST_DIALOG[playerid] == 14) WEAPONSET_MENU(playerid);
		}
	}
	
						ShowPlayerDialog(playerid, 150, DIALOG_STYLE_TABLIST_HEADERS,
					"Weapon pack pre-set",
					"Pack\tdescription\n\
					Lamo pack\tSAWN-OFF + TEC-9\n\
					Lamo pack 2\tSAWN-OFF + TEC-9\n\
					+C pack\tDEAGLE + SHOTGUN\n\
					+C pack 2\tDEAGLE + SPAS12\n\
					Pro pack\tDEAGLE + SHOTGUN + SNIPER RIFLE\n\
					Sniper pack\tKNIFE + SNIPER RIFLE\n\
					Defender pack\tKNIFE + SILENCED + M4\n\
					{00FF00}Default{FFFFFF}\tSAWN-OFF\n",
					"Select", "Exit");