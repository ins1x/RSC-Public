/*
	Filterscript: ResponseChecker
	Description: Example how to use SA-MP threaded HTTP/1.0 client for pawn		
*/
 
#include <a_samp>
#include <a_http>

#define FILTERSCRIPT

forward ResponseChecker(player_id, response_code, data[]);
 
public OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp("/respchecker",cmdtext,true))
    {
		// call SA-MP threaded HTTP/1.0 client for pawn
        HTTP(playerid, HTTP_GET, "samp.com", "", "ResponseChecker");
        return 1;
    }
    return 0;
}
 
public ResponseChecker(player_id, response_code, data[])
{
	// rsponse_code : https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
	// data : received data from HTTP request
    new buffer[128];
    if(response_code == 200) 
    {
        format(buffer, sizeof(buffer), "The URL replied: %s", data);
		SendClientMessage(player_id, -1, buffer);
    } else {
        format(buffer, sizeof(buffer), "The request failed! The response code was: %d", response_code);
		SendClientMessage(player_id, -1, buffer);
    }
}

