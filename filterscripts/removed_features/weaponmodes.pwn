/*
	Filterscript: 
	Description: 
	Author: 
*/

#include <a_samp>

#define FILTERSCRIPT
#define DIALOG_WEAPONMODES 3001
// ----------------------------------------------------------------------------
#define KickPlayerEx(%0) SetTimerEx("KickPlayer", 500, 0, "d", %0)

// Y_Less foreach macro
#tryinclude <foreach>
#if !defined foreach
	#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
	#define __SSCANF_FOREACH__
#endif

#if !defined _samp_included
	#error "Please include a_samp or a_npc before foreach"
#endif

#if !defined isnull
	#define isnull(%0) ((!(%0[0])) || (((%0[0]) == '\1') && (!(%0[1]))))
#endif
// ----------------------------------------------------------------------------

//main() {}

new IsAnimLoop[MAX_PLAYERS]; // anim loop flag
new Skill[11] = {999, ...}; //Max skill pre-set for all weapons

public OnFilterScriptInit()
{
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	switch (GetPVarInt(playerid, "WeaponMode"))
    {
		case 2:
		{
			if(fX != 0 && fY != 0 && fZ != 0 && hittype != BULLET_HIT_TYPE_PLAYER)
			{
				SetPlayerPos(playerid, fX, fY, fZ+1);
				PlayerPlaySound(playerid, 40405, 0.0, 0.0, 0.0); // TEMPEST_PICKUP
			}
		}
		case 3:
		{
			if(fX != 0 && fY != 0 && fZ != 0 )
			{
				//https://sampwiki.blast.hk/wiki/CreateExplosion
				if(hittype == BULLET_HIT_TYPE_PLAYER)
				{
					new Float:x, Float:y, Float:z;
					GetPlayerPos(hitid, x,y,z);
					CreateExplosion(x, y, z, 12, 5);
				} 
				else CreateExplosion(fX, fY, fZ, 12, 5);
			}
		}
		case 4:
		{
			if(fX != 0 && fY != 0 && fZ != 0 && hittype == BULLET_HIT_TYPE_PLAYER)
			{
				ApplyAnimation(hitid, "CRACK","crckdeth2",4.1, 0, 0, 0, 1, 0, 1);
				PlayerPlaySound(playerid, 6003, 0.0, 0.0, 0.0); // SHOOT_CONTROLS
				PlayerPlaySound(hitid, 6003, 0.0, 0.0, 0.0); // SHOOT_CONTROLS
				IsAnimLoop[hitid] = 1;
			}
		}
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_WEAPONMODES) //weaponmode
	{
		if(response)
		{
			switch(listitem)
			{
				case 0: //disable
				{
					SetPVarInt(playerid, "WeaponMode", 0);
					new i;
					for(i = 0; i < sizeof(Skill); i++)
					{
						SetPlayerSkillLevel(playerid, i, Skill[i]);
					}
				}
				case 1:
				{
					// https://wiki.pro-pawn.ru/wiki/SetPlayerSkillLevel
					SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 0);
					SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 0);
					SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 0);
					SetPVarInt(playerid, "WeaponMode", 1); // onehand
				}
				case 2: SetPVarInt(playerid, "WeaponMode", 2); //teleporteer
				case 3: SetPVarInt(playerid, "WeaponMode", 3); //explode
				case 4: SetPVarInt(playerid, "WeaponMode", 4); //tazer
			}
		}
	}
	return 1;
}
