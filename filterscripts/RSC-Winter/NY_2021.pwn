/*
	Filterscript: New Year FS
	Created specifically for RSC server 
	CW/TG gamemode powered by Russian Sawn-off Community 2021-2022
	find us: https://vk.com/sawncommunity | http://sturmstaffel.ru/
	Author: 1NS 
*/
	
#include <a_samp>
#include <foreach>

public OnFilterScriptInit()
{ 
	new tmpobjid;
	// Main SF Airport snow mapping
	tmpobjid = CreateObject(10819, -1236.555053, -220.808181, -0.508050, 0.000000, 0.000000, 0.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 2, 10765, "airportgnd_sfse", "crackedgroundb", 0x00000000);
	SetObjectMaterial(tmpobjid, 5, 3922, "bistro", "mp_snow", 0x00000000);
	tmpobjid = CreateObject(11367, -1304.004760, -62.458889, -9.638379, 0.000000, 0.000000, 135.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "crackedgroundb", 0x00000000);
	SetObjectMaterial(tmpobjid, 1, 10765, "airportgnd_sfse", "crackedgroundb", 0x00000000);
	SetObjectMaterial(tmpobjid, 3, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 4, 10765, "airportgnd_sfse", "crackedgroundb", 0x00000000);
	tmpobjid = CreateObject(10816, -1369.270751, 96.233573, 12.111597, 0.000000, 0.000000, 45.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 4, 10765, "airportgnd_sfse", "crackedgroundb", 0x00000000);
	SetObjectMaterial(tmpobjid, 5, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 7, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 8, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 9, 10765, "airportgnd_sfse", "crackedgroundb", 0x00000000);
	tmpobjid = CreateObject(10817, -1563.319824, -189.016815, -0.486910, 0.000000, 0.000000, 45.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 7, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 8, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 9, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 10, 3922, "bistro", "mp_snow", 0x00000000);
	tmpobjid = CreateObject(10768, -1307.581420, -542.421447, -0.468364, 0.000000, 0.000000, 0.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 6, 3922, "bistro", "mp_snow", 0x00000000);
	tmpobjid = CreateObject(3814, -1217.141479, -67.133178, 19.779348, 0.000000, 0.000000, -45.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 1, 3922, "bistro", "mp_snow", 0x00000000);
	tmpobjid = CreateObject(3814, -1178.127197, -114.806457, 19.779348, 0.000000, 0.000000, -45.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 1, 3922, "bistro", "mp_snow", 0x00000000);
	tmpobjid = CreateObject(10814, -1146.631835, -145.353134, 17.196792, 0.000000, 0.000000, 45.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 2, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 3, 3922, "bistro", "mp_snow", 0x00000000);
	tmpobjid = CreateObject(10755, -1363.666870, -248.284454, 20.722877, 0.000000, 0.000000, 0.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 5, 3922, "bistro", "mp_snow", 0x00000000);
	tmpobjid = CreateObject(10763, -1255.824951, 47.256492, 45.940326, 0.000000, 0.000000, 0.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 1, 3922, "bistro", "mp_snow", 0x00000000);
	SetObjectMaterial(tmpobjid, 6, 3922, "bistro", "mp_snow", 0x00000000);
	// end mapping
    return 1; 
} 

public OnFilterScriptExit()
{ 
	return 1;
} 

public OnPlayerConnect(playerid)
{ 
	//SendClientMessage(playerid, 0xF5511CAA,
	//"The New Year event is running on the server. Take part and get unique costumes (/info)");
	return 1;
} 

public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[255], idx;
    cmd = strtok(cmdtext, idx);

	return false;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}


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