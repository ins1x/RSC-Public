/*
	Description: info about SAMPCAC Allowed mods/scripts/plugins
	Author: 1NS
	Created specifically for RSC server
	CW/TG gamemode powered by Russian Sawn-off Community
*/

#include <a_samp>
#include <sampcac>

#define FILTERSCRIPT
#define DIALOG_CACMODS 6666

#if defined _sampcac_included
static const CAC_AllowedMods[][] = 
{
	"Y-Axis_Sensitivity_Fix", "vehlightsfix", "sniperfix", "Fastload",
	"DwmComposition", "StreamMemFix", "mousefix", "radarrect", "Anticrasher",
	"flickr", "OutFitFix", "fix_blackroads", "MapZoom_ByDarkP1xel", "sprintBar",
	"HPHud", "interfaceEditor", "Noshadows", "FogDistance", "skygrad",
	"GammaFix","NoDustAndSandFx", "RefreshRateFix", "NormalMapFix"
};
#endif

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (!strcmp(cmdtext, "/cacmods", true))
	{
		new output[512], tmpstr[24];
		strcat(output, "{FFFFFF}");
		for(new i; i != sizeof(CAC_AllowedMods); i++)
		{
			format(tmpstr, sizeof(tmpstr), "%s\n", CAC_AllowedMods[i]);
			strcat(output, tmpstr);
		}
		ShowPlayerDialog(playerid, DIALOG_CACMODS, DIALOG_STYLE_LIST,
		"Allowed mods/scripts/plugins", output, "OK", "Cancel");
		return 1;
	}
	return 0;
}