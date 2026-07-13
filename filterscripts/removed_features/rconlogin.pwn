/*
	Description: rcon login guard
	Created specifically for RSC server
	CW/TG gamemode powered by Russian Sawn-off Community
*/

#include <a_samp>

#define COLOR_GREY 				0xAFAFAFAA
#define FILTERSCRIPT

public OnRconLoginAttempt(ip[], password[], success)
{
	// protect RCON admin sub-system
	// write to log last rcon login data, ip, serial
	new pip[16];
	#if defined RCON_DISABLE
	printf("[FAIL] RCON login by IP %s reason:(RCON DISABLE)",ip);
	foreach(Player,i) //Loop through all players
    {
		GetPlayerIp(i, pip, sizeof(pip));
        if(!strcmp(ip, pip, true)) //If a player's IP is the IP that failed the login
        {
			KickPlayerEx(i, "RCON fail" ); 
        }
	}
	#else
	new serial[41];
	if(success)
	{
		foreach(Player,i)
		{
			GetPlayerIp(i, pip, sizeof(pip));
			if(!strcmp(ip, pip, true)) //If a player's IP is the IP the login
			{
				gpci(i,serial,40);
				SetPVarInt(i, "Admin", 3);
				printf("IP: %s Serial: %s logged as RCON!", ip, serial);
				SendClientMessage(i, COLOR_GREY,
				"Press Y to open adminmenu. Type /rcon cmdlist to see a list of RCON commands.");
				break;
			}
		}
	}
	else
	{ // This message will be received by all accounts with the same IP (All twins)
        foreach(Player,i)
        {
            GetPlayerIp(i, pip, sizeof(pip));
            if(!strcmp(ip, pip, true)) //If a player's IP is the IP that failed the login
            {
				gpci(i,serial,40);
				printf("[FAIL] RCON login by IP: %s Serial: %s using password %s",ip, serial, password);
                KickPlayerEx(i, "RCON fail" );
				break; 
            }
        }
	}
	#endif
	return 1;
}