#include <a_samp>
// There is a bug (or a special feature) due to which OnClientCheckResponse is not called in the mod, but only in the last loaded fs. To do this, you need to load the following fs last!!
native SendClientCheck(playerid, type, arg, offset, size);
forward OnClientCheckResponse(playerid, type, arg, response);

/*
Calculates the checksum for an array of bytes to the specified address in gta_sa.exe memory, so every cheat can be detected: Cleos, s0beit, etc. Talking about the RakNet layer, when connecting to a server. which calls SendClientCheck, it sends an RPC (contains the address) of the action to the client and the client also responds with an RPC (contains the checksum).

// https://pawn-wiki.ru/index.php?/topic/48852-sendclientcheck-new/
Take a look at SendClientCheck's arguments:
playerid - which player will be requested
type - request type
arg - special argument
offset - read memory offset
size - number of bytes to read (always must be greater or equal 2)

And OnClientCheckResponse:
playerid - who sends a response
type - response type
arg - special argument
response - yet another special argument
*/

public OnPlayerConnect(playerid)
{
	// SendClientCheck(playerid, 72, 0, 0, 2);
	// Sobeit Check
	// new actionid = 0x5, memaddr = 0x5E8606, retndata = 0x4;
    // SendClientCheck(playerid, actionid, memaddr, 0, retndata);
	
	// SendClientCheck(playerid, 70, 1598, 0, 28); // 1598 - beachball
	new name[MAX_PLAYER_NAME], str[128];
	GetPlayerName(playerid, name, sizeof(name));
	SendClientCheck(playerid, 0x48, 0, 0, 2);
	
	if(GetPVarInt(playerid, "Android") > 0)	
	{
		format(str, sizeof(str), "%s(%d) connected from android!", name, playerid);
		SendClientMessageToAll(0xE10000AA, str);
	}

	return 1;
}

public OnClientCheckResponse(playerid, type, arg, response)
{
	//new str[128];
	switch(type)
	{
		case 0x48: // Android check
        {
			// https://github.com/Fairuz-Afdhal/IsPlayerUsingAndroid
            SetPVarInt(playerid, "Android", 0);	
        }
		/*
		case 72:
		{
			format(str, sizeof(str), "Your computer has been running for %s!", Convert(arg / 1000));
			SendClientMessage(playerid, -1, str);
		}
		*/
	}
	return 1;
}