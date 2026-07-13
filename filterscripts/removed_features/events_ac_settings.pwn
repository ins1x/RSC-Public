	#if defined _nex_ac_included
	if(GetPVarInt(playerid, "Event") > 0)
	{
		// Disable false triggering to teleports from FS
		if(IsAntiCheatEnabled(2)) EnableAntiCheatForPlayer(playerid, 2, 0);
		// Disable false triggering to vehicles from FS
		if(IsAntiCheatEnabled(11)) EnableAntiCheatForPlayer(playerid, 11, 0);
		if(IsAntiCheatEnabled(5)) EnableAntiCheatForPlayer(playerid, 5, 0);
		// Disable false triggering to pickups from FS
		if(IsAntiCheatEnabled(6)) EnableAntiCheatForPlayer(playerid, 6, 0);
		// Anti ammo and weapon hacks
		if(IsAntiCheatEnabled(13)) EnableAntiCheatForPlayer(playerid, 13, 0);
		if(IsAntiCheatEnabled(15)) EnableAntiCheatForPlayer(playerid, 15, 0);
		if(IsAntiCheatEnabled(16)) EnableAntiCheatForPlayer(playerid, 16, 0);
		if(IsAntiCheatEnabled(17)) EnableAntiCheatForPlayer(playerid, 17, 0);
		if(IsAntiCheatEnabled(27)) EnableAntiCheatForPlayer(playerid, 27, 0);
		if(IsAntiCheatEnabled(47)) EnableAntiCheatForPlayer(playerid, 47, 0);
		if(IsAntiNOPEnabled(10)) EnableAntiNOPForPlayer(playerid, 10, 0);
		return true;
	}
	#endif