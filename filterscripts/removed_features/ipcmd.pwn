/*
	Description: simple ip command
	Created specifically for RSC server
	CW/TG gamemode powered by Russian Sawn-off Community
*/

#include <a_samp>

#define COLOR_GREY 				0xAFAFAFAA
#define FILTERSCRIPT


public OnPlayerCommandText(playerid, cmdtext[])
{
	if (!strcmp(cmdtext, "/ip", true))
	{
		SendClientMessage(playerid, COLOR_GREY, "Use: /ip [ID/IP address]");
		return true;
	}
	if (!strcmp(cmdtext, "/ip ", true, 4))
	{
		if (!cmdtext[4])
		{
			SendClientMessage(playerid, COLOR_GREY, "Use: /ip [ID/IP address]");
			return true;
		}
		new len = strlen(cmdtext[4]), counter;
		for(new i = 0; i < len; i++)
		{
			if (cmdtext[4 +i] == '.')
			{
				counter++;
			}
		}
		new string[64], ip[16];
		if (counter == 0)
		{
			format(string, 5, "%s", cmdtext[4]);
			new PARAM = strval(string);
			if (!IsPlayerConnected(PARAM))
			{
				SendClientMessage(playerid, COLOR_GREY, "This player isn't connected.");
				return true;
			}

			GetPlayerIp(PARAM, ip, sizeof(ip));
			format(string, sizeof(string),
			"  These players are connected with IP address %s:", ip);
			SendClientMessage(playerid, -1, string);
			format(string, sizeof(string), "ip/%s", ip);
			new File: file = fopen(string, io_read);
			if (file)
			{
				while(fread(file, string, 26))
				{
					SendClientMessage(playerid, COLOR_GREY, string);
				}
				fclose(file);
			}
			return true;
		}
		if (counter == 3)
		{

			format(string, sizeof(string), "ip/%s", cmdtext[4]);
			if (fexist(string))
			{
				format(string, sizeof(string),
				"  These players are connected with IP address %s:", ip);
				SendClientMessage(playerid, -1, string);
				format(string, sizeof(string), "ip/%s", cmdtext[4]);
				new File: file = fopen(string, io_read);
				if (file)
				{
					while(fread(file, string, 26))
					{
						SendClientMessage(playerid, COLOR_GREY, string);
					}
					fclose(file);
				}
			}else{
				
				format(string, sizeof(string),
				"  Till now nobody connected with IP address %s.", cmdtext[4]);
				SendClientMessage(playerid, -1, string);
			}
			return true;
		}
		SendClientMessage(playerid, COLOR_GREY, "Use: /ip [ID/IP adress]");
		return true;
	}
	return 0;
}
