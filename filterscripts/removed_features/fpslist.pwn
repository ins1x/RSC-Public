/*
	Description: colored simple fps dialog
	Created specifically for RSC server
	CW/TG gamemode powered by Russian Sawn-off Community
*/

#include <a_samp>

#define COLOR_GREY 			0xAFAFAFAA
#define DIALOG_FPSLIST 		3001
#define FILTERSCRIPT

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (!strcmp(cmdtext, "/fpslist", true) || !strcmp(cmdtext, "/packetloss", true))
	{
	    SimpleFpsDialog(playerid);
	    return true;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_FPSLIST) //fpsdialog
	{
		if (response)
		{
		    SimpleFpsDialog(playerid);
		}
		return true;
	}
	return 1;
}
	
stock SimpleFpsDialog(playerid)
{
    new string[1024];
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if (IsPlayerConnected(i))
  		{
		    new FPS = GetPVarInt(i, "fps");
			if (FPS > 87)
		    {
		        FPS = 64;
		    }
		    else if (FPS < 23)
		    {
		        FPS = 0;
		    }else{
		        FPS -= 23;
		    }
		    new color1 = 256*256*(255-FPS*255/64) +256*(FPS*255/64);
		    new FPSstr[7];
		    if (color1 < 0x10000)
		    {
		        format(FPSstr, sizeof(FPSstr), "00%x", color1);
		    }
		    else if (color1 < 0x100000)
		    {
		        format(FPSstr, sizeof(FPSstr), "0%x", color1);
		    }else{
		        format(FPSstr, sizeof(FPSstr), "%x", color1);
		    }
		    
		    new ping = GetPlayerPing(i);
		    if (ping < 20)
		    {
		        ping = 0;
		    }
		    else if (ping > 148)
		    {
		        ping = 128;
		    }else{
		        ping -= 20;
		    }
		    color1 = 256*256*(ping*255/128) +256*(255-ping*255/128);
		    new pingstr[7];
		    if (color1 < 0x10000)
		    {
		        format(pingstr, sizeof(pingstr), "00%x", color1);
		    }
		    else if (color1 < 0x100000)
		    {
		        format(pingstr, sizeof(pingstr), "0%x", color1);
		    }else{
		        format(pingstr, sizeof(pingstr), "%x", color1);
		    }
		    
		    new name[MAX_PLAYER_NAME];
		    GetPlayerName(i, name, sizeof(name));
		    if (GetPVarInt(i, "fps") < 10)
		    {
		        format(string, sizeof(string), "%s{FFFFFF}FPS: {%s}%d {FFFFFF}Ping: {%s}%d {FFFFFF}PL: {%s}%.1f\t{FFFFFF}%s(%d)\n",
				string, FPSstr, GetPVarInt(i, "fps"), pingstr, GetPlayerPing(i),pingstr,GetPVarFloat(i, "ploss"), name, i);
		    }else{
				format(string, sizeof(string), "%s{FFFFFF}FPS: {%s}%d {FFFFFF}Ping: {%s}%d {FFFFFF}PL: {%s}%.1f\t{FFFFFF}%s(%d)\n",
				string, FPSstr, GetPVarInt(i, "fps"), pingstr, GetPlayerPing(i),pingstr,GetPVarFloat(i, "ploss"), name, i);
			}
		}
	}
	ShowPlayerDialog(playerid, DIALOG_FPSLIST, DIALOG_STYLE_MSGBOX,
	"FPS and ping list.", string, "Refresh", "Hide");
}