/*
	Description: simple ip command
	Created specifically for RSC server
	CW/TG gamemode powered by Russian Sawn-off Community
*/

#include <a_samp>

stock SearchEnd(const string[])
{
	for(new i = strlen(string) -1; i >- 1; i--)
	{
	    if (string[i] != '\r' && string[i] != '\n')
	    {
			return i +1;
	    }
	}
	return false;
}

// Rotate Camera at map change
SetPlayerCameraRotate(playerid, CwMaps[Map][2][0]+1, CwMaps[Map][2][1], CwMaps[Map][2][2]+70,0.0,100.0);

forward SetPlayerCameraRotate(playerid,Float:x,Float:y,Float:z,Float:angle,Float:a);
public SetPlayerCameraRotate(playerid,Float:x,Float:y,Float:z,Float:angle,Float:a)
{
    if(Camera[playerid] != -1) KillTimer(Camera[playerid]);
    Camera[playerid] = -1;
    SetPlayerCameraPos(playerid, x+a*floatcos(angle, degrees), y+a*floatsin(angle, degrees), z+0.2);
    SetPlayerCameraLookAt(playerid,x,y,z);
    Camera[playerid] = SetTimerEx("SetPlayerCameraRotate", 1, false, "d,f,f,f,f,f", playerid, x, y, z, angle+0.5,a);
}


Convert(number)
{
    new hours = 0, mins = 0, secs = 0, string[100];
    hours     = floatround(number / 3600);
    mins      = floatround((number / 60) - (hours * 60));
    secs      = floatround(number - ((hours * 3600) + (mins * 60)));
    if (hours > 0)
    {
        format(string, 100, "%d:%02dm:%02ds", hours, mins, secs);
    }
    else
    {
        format(string, 100, "%d:%02d", mins, secs);
    }
    return string;
}

#if !defined _INC_WEAPON_CONFIG
// https://github.com/oscar-broman/samp-weapon-config/blob/master/weapon-config.inc
stock IsBulletWeapon(weaponid)
{
	return (WEAPON_COLT45 <= weaponid <= WEAPON_SNIPER) || weaponid == WEAPON_MINIGUN;
}

stock IsMeleeWeapon(weaponid)
{
	return (WEAPON_UNARMED <= weaponid <= WEAPON_CANE) || weaponid == WEAPON_PISTOLWHIP;
}
#endif

stock IsPlayerAiming(playerid) {
	new anim = GetPlayerAnimationIndex(playerid);
	if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) ||
	(anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
    return 0;
}

stock Uppercase(string[]) {
    new 
        i = 0;
    while(EOS != string[i]) {
        if('a' <= string[i] <= 'z') string[i] -= 32; 
        ++i;
    }
    return string;
}

stock Crash(playerid)
{
	GameTextForPlayer(playerid, "вЂўВ¤В¶В§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 1000, 0);
	GameTextForPlayer(playerid, "вЂўВ¤В¶В§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 2000, 1);
	GameTextForPlayer(playerid, "вЂўВ¤В¶В§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 3000, 2);
	GameTextForPlayer(playerid, "вЂўВ¤В¶В§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 4000, 3);
	GameTextForPlayer(playerid, "вЂўВ¤В¶В§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 5000, 4);
	GameTextForPlayer(playerid, "вЂўВ¤В¶В§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 6000, 5);
	GameTextForPlayer(playerid, "вЂўВ¤В¶В§!$$%&'()*+,-./01~!@#$^&*()_-+={[}]:;'<,>.?/", 7000, 6);
	// variant 2
	//GetPlayerPos(player1,X,Y,Z);
	//new objectcrash = CreatePlayerObject(player1,11111111,X,Y,Z,0,0,0);
	//DestroyObject(objectcrash);
}