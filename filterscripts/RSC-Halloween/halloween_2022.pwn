/*
	Filterscript: Halloween Quest
	Created specifically for RSC server 
	CW/TG gamemode powered by Russian Sawn-off Community 2022
	find us: https://dsc.gg/sawncommunity
	Author: 1NS 
	Description: Halloween 2022 Quest
*/

// The script uses some of the features of the RSC gamemode through CallRemoteFunction
// They can be disabled, this will affect the visual component but not the functional
// Sounds stream: https://minty.club/artist/jason-graves/dead-space-theme
// This version is compatible with SA-MP server 0.3.7 R1 and higher.

#include <a_samp>
#include <foreach>
#include <streamer>

// ignore literal array/string passed to a non-const parameter
#pragma warning disable 239
#define MY_MAX_PLAYERS 100

new QWorld = 660; 
new QuestTimer; // Update timer (Replace OnPlayerUpdate on this FS)
new QuestTick; // Used to count seconds on QuestTimer
new QuestActors[20], QuestVehicles[35], QuestPickups[25];
new rocks[32], dynrock[2], fireobj[11], dyndoor[2], bloodtext;

new Text: TDQuestInfo[MY_MAX_PLAYERS]; 
new Text: TDCustomHud[MY_MAX_PLAYERS]; 

public OnFilterScriptInit()
{ 
	QuestTimer = SetTimer("QuestUpdate", 1000, true);

	for(new i = 0; i < MY_MAX_PLAYERS; i++) 
	{
		TDQuestInfo[i] = TextDrawCreate(300.0, 390.0, " ");
		TextDrawUseBox(TDQuestInfo[i], 0);
		TextDrawBoxColor(TDQuestInfo[i], 0x00000066);
		TextDrawLetterSize(TDQuestInfo[i], 0.215, 1.0);
	    TextDrawFont(TDQuestInfo[i], 1);
	    TextDrawSetOutline(TDQuestInfo[i], 1);
		TextDrawAlignment(TDQuestInfo[i], 2);
		
		TDCustomHud[i] = TextDrawCreate(499.0, 97.0, " ");
		TextDrawBoxColor(TDCustomHud[i], 0x00000066);
		TextDrawLetterSize(TDCustomHud[i], 0.198, 0.8);
	    TextDrawFont(TDCustomHud[i], 1);
	    TextDrawSetOutline(TDCustomHud[i], 1);
    }
	
	// Vehicles
	QuestVehicles[0] = CreateVehicle(453,-494.4821,2198.7551,40.2494,228.6068,-1,-1,600); 
	QuestVehicles[1] = CreateVehicle(453,-534.5273,2150.5349,40.2155,299.1819,-1,-1,600); 
	QuestVehicles[2] = CreateVehicle(453,-573.8928,2256.4058,40.2565,233.0136,-1,-1,600); 
	QuestVehicles[3] = CreateVehicle(473,-524.3650,2172.7937,40.3322,304.2978,-1,-1,600); 
	QuestVehicles[4] = CreateVehicle(473,-528.7546,2224.5413,40.3123,298.1333,-1,-1,600); 
	QuestVehicles[5] = CreateVehicle(473,-598.0732,2193.0347,40.3099,296.4703,-1,-1,600); 
	QuestVehicles[6] = CreateVehicle(473,-462.7600,2177.9392,46.3778,78.7203,-1,-1,600);
	QuestVehicles[7] = CreateVehicle(453,-563.3710,2206.0110,40.2598,248.5735,-1,-1,600);
	QuestVehicles[8] = CreateVehicle(605,-424.8228,2128.3005,45.8337,327.4416,-1,-1,600);
	QuestVehicles[9] = CreateVehicle(478,-518.3322,2360.8513,72.2014,97.2926,-1,-1,600);
	QuestVehicles[10] = CreateVehicle(508,-409.2562,2274.5105,42.1982,287.437,-1,-1,600);
	QuestVehicles[11] = CreateVehicle(542,-715.3190,2338.6516,126.2370,220.6979,-1,-1,600);
	QuestVehicles[12] = CreateVehicle(531,-410.3776,2246.3359,42.3183,152.6922,-1,-1,600);
	QuestVehicles[13] = CreateVehicle(442,-347.0089,2204.0083,42.2102,88.6480,0,0,600);
	QuestVehicles[14] = CreateVehicle(599,-648.0296,2311.2622,135.7065,321.4227,0,1,600);
	QuestVehicles[15] = CreateVehicle(509,-420.9096,2203.6956,41.9134,175.9551,-1,-1,600);
	QuestVehicles[16] = CreateVehicle(509,-436.2509,2243.3572,41.9421,359.8430,-1,-1,600);
	QuestVehicles[17] = CreateVehicle(505,-397.1150,2184.9426,42.0171,0.4802,-1,-1,600);
	QuestVehicles[18] = CreateVehicle(593,-784.4122,2408.6331,157.4614,183.9921,-1,-1, 600);
	QuestVehicles[19] = CreateVehicle(406,-718.5621,2416.4153,129.4579,219.0718,-1,-1, 600);
	QuestVehicles[20] = CreateVehicle(403,-691.9107,2351.4604,128.3570,335.5016,-1,-1, 600);
	QuestVehicles[21] = CreateVehicle(578,-717.6216,2376.3689,128.2358,154.1315,-1,-1, 600);
	QuestVehicles[22] = CreateVehicle(473,-529.1179,2180.8079,40.0619,81.2471,-1,-1, 600);
	SetVehicleVirtualWorld(QuestVehicles[22], QWorld+1);
	
	QuestPickups[0] = CreateDynamicPickup(11746, 3, -406.7735,2311.9021,49.7344, QWorld, -1);
	QuestPickups[1] = CreateDynamicPickup(11745, 3, -313.8056,2290.9790,69.3911, QWorld, -1);
	QuestPickups[2] = CreateDynamicPickup(11712, 3, -339.3000,2231.4312,42.4923, QWorld, -1);
	QuestPickups[3] = CreateDynamicPickup(19921, 3, -425.5473,2127.0669,46.1461, QWorld, -1);
	QuestPickups[4] = CreateDynamicPickup(19904, 3, -462.4138,2174.3965,47.3934, QWorld, -1);
	QuestPickups[5] = CreateDynamicPickup(2819, 3, -406.8090,2211.3274,42.4297, QWorld, -1);
	QuestPickups[6] = CreateDynamicPickup(19631, 3, -325.1116,2148.1528,48.1717, QWorld, -1);
	QuestPickups[7] = CreateDynamicPickup(19623, 3, -412.8585,2276.0823,41.9584, QWorld, -1);
	QuestPickups[8] = CreateDynamicPickup(19942, 3, -384.5049,2207.5339,45.6711, QWorld, -1);
	QuestPickups[9] = CreateDynamicPickup(19995, 3, -399.4354,2181.9219,41.6255, QWorld, -1);
	QuestPickups[10] = CreateDynamicPickup(19347, 3, -416.2312,2185.9795,46.9127, QWorld, -1);
	QuestPickups[11] = CreateDynamicPickup(18634, 3, -462.1479,2238.1860,43.9069, QWorld, -1);
	QuestPickups[12] = CreateDynamicPickup(18641, 3, -409.3816,2245.8989,42.4297, QWorld, -1);
	QuestPickups[13] = CreateDynamicPickup(19792, 3, -308.7887,2208.3682,50.9639, QWorld, -1);
	QuestPickups[14] = CreateDynamicPickup(2034, 3, -375.6571,2243.8386,47.3517, QWorld, -1);
	QuestPickups[15] = CreateDynamicPickup(2894, 3, 681.3010,-457.1140,-25.6172, QWorld, 1);
	QuestPickups[16] = CreateDynamicPickup(19776, 3, -434.0036,2209.9651,42.4297, QWorld, -1);
	QuestPickups[17] = CreateDynamicPickup(19773, 3, -436.5126,2180.6140,42.4823, QWorld, -1);
	QuestPickups[18] = CreateDynamicPickup(11746, 3, -741.7330,2387.3384,127.1263, QWorld, -1);
	QuestPickups[19] = CreateDynamicPickup(357, 3, 304.7248,310.1558,999.1484, QWorld, -1);
	QuestPickups[20] = CreateDynamicPickup(11738, 3, -773.0833,2424.6819,157.0939, QWorld, -1);
	QuestPickups[21] = CreateDynamicPickup(11738, 3, -744.6031,2375.0547,127.0531, QWorld, -1);
	QuestPickups[22] = CreateDynamicPickup(1654, 3, -507.0535,2367.3384,71.5788, QWorld, -1);
	QuestPickups[23] = CreateDynamicPickup(342, 3, -674.3094,2319.2825,134.7367, QWorld, -1);
	QuestPickups[24] = CreateDynamicPickup(342, 3, -674.3094,2319.2825,134.7367, QWorld, -1);
	// Damaged cars generate
	new panels, doors, lights, tires;
	GetVehicleDamageStatus(QuestVehicles[9], panels, doors, lights, tires);
	// SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective)
	SetVehicleParamsEx(QuestVehicles[9], 0, 0, 0, 0, 0, 1, 0);
	UpdateVehicleDamageStatus(QuestVehicles[9], panels,
	(doors | 0b00000111_00000111_0000000_00000000), lights, 15);
	GetVehicleDamageStatus(QuestVehicles[14], panels, doors, lights, tires);
	//SetVehicleParamsEx(QuestVehicles[14], 0, 0, 0, 0, 1, 0, 1);
	UpdateVehicleDamageStatus(QuestVehicles[14], panels,
	(doors | 0b00000111_00000111_0000111_00000111), lights, tires);
	for(new i = 0; i < sizeof(QuestVehicles); i++) SetVehicleVirtualWorld(QuestVehicles[i], QWorld);
	
	// actors
	QuestActors[0] = CreateDynamicActor(91, -1227.9746,-60.9235,26.2922,57.6229, 1, 100.0, 0);
	ApplyDynamicActorAnimation(QuestActors[0], "GRAVEYARD", "MRNF_LOOP", 4.1, 1, 0, 0, 0, 0);
	SetDynamicActorVirtualWorld(QuestActors[0], 0);
	QuestActors[1] = CreateDynamicActor(285, -1204.3008,-49.1836,28.5887,138.05, 1, 100.0, 0);
	ApplyDynamicActorAnimation(QuestActors[1], "CRACK", "CRCKIDLE1", 4.1, 1, 0, 0, 0, 0);
	SetDynamicActorVirtualWorld(QuestActors[1], 0);
	QuestActors[2] = CreateDynamicActor(128, -232.1690,2337.9797,109.3195,165.2469, 1, 100.0, QWorld);
	//ApplyDynamicActorAnimation(QuestActors[2], "DEALER", "DEALER_IDLE", 4.1, 1, 0, 0, 0, 0);
	ApplyDynamicActorAnimation(QuestActors[2], "KNIFE", "knife_IDLE", 4.1, 1, 0, 0, 0, 0);
	SetDynamicActorVirtualWorld(QuestActors[2], QWorld+1);
	QuestActors[3] = CreateDynamicActor(91, -231.1690,2337.9797,109.3195,165.2469, 1, 100.0, QWorld);
	ApplyDynamicActorAnimation(QuestActors[3], "PED", "WOMAN_WALKSEXY", 4.1, 1, 0, 0, 0, 0);
	SetDynamicActorVirtualWorld(QuestActors[3], QWorld);
	QuestActors[4] = CreateDynamicActor(91, 302.0576,305.8484,999.1484,359.2281, 1, 100.0, QWorld, -1);
	ApplyDynamicActorAnimation(QuestActors[4], "CRACK", "crckidle2", 4.1, 1, 0, 0, 0, 0);
	SetDynamicActorVirtualWorld(QuestActors[4], QWorld);	
	QuestActors[5] = CreateDynamicActor(128, 302.6109,302.6460,999.1484,174.1553, 1, 250.0, QWorld, -1);
	//ApplyDynamicActorAnimation(QuestActors[2], "DEALER", "DEALER_IDLE", 4.1, 1, 0, 0, 0, 0);
	ApplyDynamicActorAnimation(QuestActors[5], "KNIFE", "knife_IDLE", 4.1, 1, 0, 0, 0, 0);
	SetDynamicActorVirtualWorld(QuestActors[5], QWorld);
	SetDynamicActorInvulnerable(QuestActors[5], 0);
	
	QuestActors[6] = CreateDynamicActor(68,-339.9353,2232.4368,42.4844,201.0994, 1, 100.0, QWorld+1); 
	ApplyDynamicActorAnimation(QuestActors[5], "GRAVEYARD", "prst_loopa", 4.1, 1, 0, 0, 0, 0);
	QuestActors[7] = CreateDynamicActor(129,-341.4174,2230.6584,42.4918,289.1819, 1, 100.0, QWorld+1);
	ApplyDynamicActorAnimation(QuestActors[7], "GRAVEYARD", "MRNF_LOOP", 4.1, 1, 0, 0, 0, 0);
	QuestActors[8] = CreateDynamicActor(131,-338.6212,2233.4807,42.4844,154.2542, 1, 100.0, QWorld+1);
	ApplyDynamicActorAnimation(QuestActors[8], "GRAVEYARD", "MRNF_LOOP", 4.1, 1, 0, 0, 0, 0);
	QuestActors[9] = CreateDynamicActor(133,-341.3096,2232.4312,42.4844,231.7803, 1, 100.0, QWorld+1);
	ApplyDynamicActorAnimation(QuestActors[9], "GRAVEYARD", "mrnM_loop", 4.1, 1, 0, 0, 0, 0);
	QuestActors[10] = CreateDynamicActor(132,-336.9344,2230.0857,42.4931,69.7194, 1, 100.0, QWorld+1); 
	ApplyDynamicActorAnimation(QuestActors[10], "GRAVEYARD", "mrnM_loop", 4.1, 1, 0, 0, 0, 0);
	QuestActors[11] = CreateDynamicActor(134,-345.7543,2228.3960,42.4918,265.3476, 1, 100.0, QWorld+1);
	ApplyDynamicActorAnimation(QuestActors[11], "PLAYIDLES", "time", 4.1, 1, 0, 0, 0, 0);
	
	QuestActors[12] = CreateDynamicActor(77,-795.2108,2412.0723,156.8243,6.5983, 1, 100.0, QWorld-1); 
	ApplyDynamicActorAnimation(QuestActors[12], "GRAVEYARD", "prst_loopa", 4.1, 1, 0, 0, 0, 0);
	QuestActors[13] = CreateDynamicActor(68,-799.6036,2415.2261,156.8109,313.8145, 1, 100.0, QWorld-1); 
	ApplyDynamicActorAnimation(QuestActors[13], "GRAVEYARD", "prst_loopa", 4.1, 1, 0, 0, 0, 0);
	QuestActors[14] = CreateDynamicActor(162,-800.4299,2418.7886,156.9028,262.3505, 1, 100.0, QWorld-1); 
	ApplyDynamicActorAnimation(QuestActors[14], "GRAVEYARD", "prst_loopa", 4.1, 1, 0, 0, 0, 0);
	QuestActors[15] = CreateDynamicActor(128,-793.7433,2414.2048,156.8937,28.7014, 1, 100.0, QWorld-1); 
	ApplyDynamicActorAnimation(QuestActors[15], "GRAVEYARD", "prst_loopa", 4.1, 1, 0, 0, 0, 0);
	
	// mapping section
	new tmpobjid; 
	// LoadSpawn
	tmpobjid = CreateDynamicObject(8131, -1203.189208, -58.746143, 21.355493, 0.00, 0.00, -45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(3814, -1217.142456, -67.128684, 19.776548, 0.00, 0.00, -45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10023, "bigwhitesfe", "forestfloor3", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(18766, -1199.231079, -49.163867, 32.763046, -90.00, 0.00, -45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, -1208.834594, -53.218898, 26.082027, 0.00, 0.00, -45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(18765, -1202.886240, -52.931112, 22.628675, -90.00, 0.00, 45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, -1203.213500, -58.840423, 26.082027, 0.00, 0.00, -45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, -1198.171508, -51.297054, 29.968713, 0.00, 0.00, 45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, -1201.315917, -48.157436, 29.988740, 0.00, 0.00, 45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, -1203.239135, -47.625652, 27.502058, 0.00, 0.00, -45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, -1197.602050, -53.261333, 27.502058, 0.00, 0.00, -45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, -1205.968872, -55.994125, 25.685911, 0.00, 90.00, -45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(18763, -1206.584838, -56.609317, 25.235900, 0.00, 90.00, -45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(18765, -1202.896240, -52.921112, 22.618675, -90.00, 0.00, -45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(19604, -1199.776000, -49.711009, 27.298667, 90.00, 0.00, -45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18901, "matclothes", "bandanaredish", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, -1212.885375, -45.160743, 24.080499, 167.500122, 0.00, 45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(18765, -1203.212280, -53.252925, 22.588674, -90.00, 0.00, -45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(18762, -1196.256713, -59.338764, 24.437448, -174.599777, 0.00, 45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateDynamicObject(8131, -1208.783569, -53.152893, 21.355493, 0.00, 0.00, -45.0); 
	SetDynamicObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	
	//CreateDynamicObject(2869, -1210.659790, -54.643566, 26.221759, 0.000000, 0.000000, -65.899780); 
	CreateDynamicObject(16052, -1197.869995, -53.544586, 29.318674, 0.000000, 0.000000, 135.000000); 
	CreateDynamicObject(16410, -1214.973022, -47.499721, 26.753421, 0.000000, -13.800004, -40.699981); 
	CreateDynamicObject(16410, -1230.659912, -62.745304, 25.506395, -7.799998, -13.800004, -40.699981); 
	CreateDynamicObject(16410, -1197.799560, -62.271602, 26.944553, 0.000000, 6.799995, -40.699981); 
	CreateDynamicObject(16410, -1210.319580, -76.614334, 25.790956, -6.799996, 6.799995, -40.699981); 
	//CreateDynamicObject(2869, -1204.668212, -60.534030, 26.221759, 0.000000, 0.000000, -105.699783); 
	CreateDynamicObject(16052, -1203.500732, -47.915981, 29.318674, 0.000000, 0.000000, 135.000000); 
	CreateDynamicObject(16630, -1199.480224, -56.411128, 28.098543, 0.000000, 0.000000, 45.0); 
	CreateDynamicObject(16630, -1206.387817, -49.495555, 28.098543, 0.000000, 0.000000, 45.0); 
	CreateDynamicObject(734, -1212.403808, -40.587703, 20.421321, 0.000000, 0.000000, 0.000000); 
	CreateDynamicObject(734, -1233.924316, -62.177654, 22.231328, 0.000000, 0.000000, 30.399999); 
	CreateDynamicObject(734, -1194.603393, -61.317707, 21.311323, 0.000000, 0.000000, 0.000000); 
	CreateDynamicObject(734, -1213.355224, -82.147926, 23.961326, 0.000000, 0.000000, 8.399992);
	
	// Diner interior
	CreateDynamicObject(19376, 681.873657, -450.489471, -26.617187, 0.000000, 0.000000, 90.600021, -1, -1); 
	CreateDynamicObject(19836, 680.014221, -459.903472, -26.607187, 0.000000, 0.000000, 0.000000, -1, -1); 
	CreateDynamicObject(2906, 680.127014, -459.903137, -26.657188, 0.000000, 0.000000, -93.899978, -1, -1); 
	CreateDynamicObject(11711, 678.197509, -465.416351, -23.307168, 0.000000, 0.000000, 0.000000, -1, -1); 
	
	// Village
	tmpobjid = CreateDynamicObject(19078, -387.779785, 2218.948242, 46.029232,
	4.600030, -90.499977, -71.800010); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19477, -393.151428, 2228.148925, 41.463741, 0.000000, -89.500000, 0.000000, QWorld); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	bloodtext = CreateDynamicObject(19477, -397.627777, 2225.707519, 43.319625, 11.700001, 0.000000, 14.299999, QWorld); 
	SetDynamicObjectMaterialText(bloodtext, 0, "Arco del oeste", 40, "Comic Sans MS", 25, 1, 0xF4400000, 0x00000000, 0);
	CreateDynamicObject(12957, -396.845092, 2184.647949, 41.671051, -3.199999, 0.000000, -179.699966, QWorld+1); 
	//////////
	CreateDynamicObject(3250, -446.736694, 2208.123779, 41.348613, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(11427, -305.599090, 2277.451171, 75.701728, 0.000000, 0.000000, 8.199997, -1); 
	CreateDynamicObject(16410, -323.887023, 2224.285644, 44.471904, -6.599997, -30.100006, 0.000000, -1); 
	CreateDynamicObject(16690, -318.639862, 2156.286621, 49.345859, -0.000000, 0.399999, -54.799964, -1); 
	CreateDynamicObject(3250, -416.356445, 2208.123779, 41.348613, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(3276, -453.973449, 2212.757080, 42.423141, 0.000000, 0.000000, 105.299957, -1); 
	CreateDynamicObject(16053, -413.379455, 2181.058105, 44.113937, -1.399999, 0.000000, -176.400024, -1); 
	CreateDynamicObject(16627, -350.703826, 2245.476806, 41.784904, -3.600001, -5.399995, -74.300056, -1); 
	CreateDynamicObject(337, -345.589355, 2228.213134, 42.079586, 161.099899, -8.400001, 19.700010, -1); 
	CreateDynamicObject(1243, -674.177734, 2241.871582, 38.584091, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(11457, -315.429168, 2299.448974, 66.248298, 0.000000, 0.000000, 45.899959, -1); 
	CreateDynamicObject(1457, -462.027618, 2174.243896, 47.724185, 0.000000, 0.000000, -119.999992, -1); 
	CreateDynamicObject(1243, -748.807434, 2166.063720, 38.584091, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(1451, -436.101318, 2181.057617, 42.208164, 0.000000, 0.000000, 139.999969, -1); 
	CreateDynamicObject(1458, -388.606933, 2185.239746, 41.152545, 40.300018, 0.400000, 44.100028, -1); 
	CreateDynamicObject(16285, -475.774414, 2187.608154, 40.391963, -1.099999, 0.000000, -88.900001, -1); 
	CreateDynamicObject(1243, -840.417663, 2191.066162, 38.184089, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(3364, -476.454345, 2214.611083, 46.185554, 6.699997, 10.499998, 20.499980, -1); 
	CreateDynamicObject(1428, -383.825256, 2201.283203, 42.745563, -12.699997, 0.000000, 11.700001, -1); 
	CreateDynamicObject(3276, -437.072631, 2138.945800, 46.003059, 0.000000, 2.099998, 60.799915, -1); 
	CreateDynamicObject(3276, -427.969909, 2148.468261, 45.236900, 0.000000, 4.099997, 35.299903, -1); 
	CreateDynamicObject(3276, -415.743408, 2154.364501, 44.420410, 0.000000, 2.699998, 18.399896, -1); 
	CreateDynamicObject(3276, -406.296325, 2178.992675, 41.227085, -0.099999, -0.300002, 10.299901, -1); 
	CreateDynamicObject(16104, -740.097290, 2205.375488, 34.464477, 0.000000, 0.000000, -82.999931, -1); 
	CreateDynamicObject(12961, -342.427551, 2239.636474, 41.833942, 0.000000, -0.399998, 18.900003, -1); 
	CreateDynamicObject(16410, -333.704925, 2243.361572, 44.813816, 11.800000, -26.799991, 0.000000, -1); 
	CreateDynamicObject(12961, -331.921081, 2217.652343, 41.853664, 0.000000, -0.399998, 18.900003, -1); 
	CreateDynamicObject(3403, -431.565734, 2210.187011, 43.295665, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(1440, -407.670532, 2211.712158, 41.902053, 0.000000, 0.000000, 81.199989, -1); 
	CreateDynamicObject(16281, -384.224273, 2157.491210, 44.152194, 0.000000, 0.000000, -66.799987, -1); 
	CreateDynamicObject(16627, -338.029846, 2214.891357, 42.041347, 0.000000, 1.600000, -83.699996, -1); 
	CreateDynamicObject(3275, -367.800140, 2235.905273, 42.328987, 0.000000, 0.000000, 105.800018, -1); 
	CreateDynamicObject(16627, -336.766052, 2210.513671, 42.030685, 0.000000, 1.599998, 114.700012, -1); 
	CreateDynamicObject(16630, -339.832763, 2221.947021, 42.109497, 0.000000, 0.000000, -79.000000, -1); 
	CreateDynamicObject(734, -326.219543, 2235.927978, 42.942405, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(735, -347.785064, 2185.934326, 36.924510, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(16116, -441.256958, 2280.838867, 34.838520, -0.799997, 0.000000, 3.000003, -1); 
	CreateDynamicObject(16119, -350.960998, 2340.334716, 25.544107, 0.000000, 0.000000, -5.299996, -1); 
	CreateDynamicObject(3275, -427.731933, 2186.992675, 41.948989, 0.000000, 0.000000, 2.100019, -1); 
	CreateDynamicObject(3276, -432.317443, 2202.175537, 42.123161, 0.000000, 0.000000, -177.700012, -1); 
	CreateDynamicObject(14873, -434.192657, 2213.215332, 42.184009, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(14873, -428.782714, 2207.381103, 42.184009, 0.000000, 0.000000, -179.800003, -1); 
	CreateDynamicObject(3276, -430.164306, 2226.313964, 42.203189, 0.000000, 0.000000, -177.700012, -1); 
	CreateDynamicObject(3275, -399.274749, 2219.091308, 42.189002, 0.000000, 0.000000, 89.100006, -1); 
	CreateDynamicObject(769, -406.720214, 2301.187988, 38.027996, 0.000000, 0.000000, 25.800012, -1); 
	CreateDynamicObject(735, -480.107635, 2264.259033, 41.064552, 0.000000, 0.000000, -28.299993, -1); 
	CreateDynamicObject(16627, -349.293090, 2240.511962, 42.005737, -3.600001, -1.099997, -74.300056, -1); 
	CreateDynamicObject(16630, -347.362335, 2226.779785, 42.009841, -5.599997, -1.500000, -79.000000, -1); 
	CreateDynamicObject(16627, -344.641845, 2224.481689, 42.012020, 0.000000, 1.600000, 4.700003, -1); 
	CreateDynamicObject(16627, -348.159759, 2231.880615, 41.827182, 0.000000, -4.300000, -84.900032, -1); 
	CreateDynamicObject(16139, -310.986206, 2216.142578, 31.662151, 0.000000, 0.000000, 34.100017, -1); 
	CreateDynamicObject(16133, -332.751800, 2328.608642, 54.865692, 9.499997, 0.000000, -124.499931, -1); 
	CreateDynamicObject(3275, -357.957885, 2199.286132, 42.328987, 0.000000, 0.000000, -78.999977, -1); 
	CreateDynamicObject(8131, -359.044616, 2222.307128, 37.995388, 0.000000, 0.000000, 91.499984, -1); 
	CreateDynamicObject(3275, -405.831237, 2269.049560, 41.609115, 0.000000, 2.199999, 13.100021, -1); 
	CreateDynamicObject(16403, -395.100555, 2200.450195, 38.594379, 0.000000, 0.000000, 108.600036, -1); 
	CreateDynamicObject(16403, -412.431182, 2163.851074, 38.394367, 0.000000, 0.000000, 108.600036, -1); 
	CreateDynamicObject(16403, -449.279296, 2223.557128, 38.824440, 0.000000, 0.000000, 108.600036, -1); 
	CreateDynamicObject(16403, -364.420227, 2184.470458, 38.774433, 0.000000, 0.000000, 108.600036, -1); 
	CreateDynamicObject(16403, -452.554534, 2132.084960, 44.602268, 9.299999, 0.599999, 108.600036, -1); 
	CreateDynamicObject(3275, -405.458587, 2204.718017, 41.948989, 0.000000, 0.000000, -6.499979, -1); 
	CreateDynamicObject(3275, -369.207183, 2269.449462, 41.798984, 0.000000, 0.000000, -13.899979, -1); 
	CreateDynamicObject(3275, -379.627716, 2272.011474, 41.559143, 0.000000, 2.100000, 166.199981, -1); 
	CreateDynamicObject(769, -463.328308, 2209.505615, 42.948001, 0.000000, 0.000000, -29.399999, -1); 
	CreateDynamicObject(735, -452.695251, 2167.544677, 37.594470, 0.000000, 0.000000, 47.499996, -1); 
	CreateDynamicObject(735, -464.534790, 2235.736328, 29.174594, 0.000000, 0.000000, -27.899988, -1); 
	CreateDynamicObject(769, -350.779022, 2155.352294, 41.488002, 0.000000, 0.000000, -29.399999, -1); 
	CreateDynamicObject(3276, -415.355651, 2239.348876, 42.133190, 0.000000, 0.000000, -177.700012, -1); 
	CreateDynamicObject(1457, -407.034118, 2211.719726, 42.939098, 0.000000, 0.000000, 175.600036, -1); 
	CreateDynamicObject(764, -422.399261, 2164.541992, 41.938453, 0.000000, 0.000000, 25.499994, -1); 
	CreateDynamicObject(764, -406.292358, 2225.873779, 34.328479, 0.000000, 0.000000, 25.499994, -1); 
	CreateDynamicObject(769, -438.126190, 2251.797119, 39.518009, 0.000000, 0.000000, 24.600011, -1); 
	CreateDynamicObject(735, -373.722015, 2296.517089, 32.264518, 0.000000, 0.000000, -38.499988, -1); 
	CreateDynamicObject(14872, -399.747161, 2200.200439, 41.830707, 0.000000, 0.000000, -178.500045, -1); 
	CreateDynamicObject(1463, -443.599639, 2203.645263, 42.100852, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(3408, -373.100067, 2233.271484, 41.272533, 0.000000, 0.000000, -76.999984, -1); 
	CreateDynamicObject(917, -404.621582, 2260.191894, 42.033897, 0.000000, 0.000000, -26.400001, -1); 
	CreateDynamicObject(2096, -404.710174, 2259.478515, 41.879508, 0.000000, 0.000000, 95.500000, -1); 
	CreateDynamicObject(1486, -404.654876, 2260.162841, 42.072223, 0.000000, 0.000000, 172.800064, -1); 
	CreateDynamicObject(3275, -360.317687, 2231.341552, 42.328987, 0.000000, 0.000000, -78.999977, -1); 
	CreateDynamicObject(3275, -364.381683, 2251.240966, 42.328987, 0.000000, 0.000000, -78.099990, -1); 
	CreateDynamicObject(1441, -369.706359, 2246.487792, 42.112144, 0.000000, 0.000000, 104.599990, -1); 
	CreateDynamicObject(1462, -362.955627, 2209.360351, 41.551578, 7.499994, 0.000000, -174.499969, -1); 
	CreateDynamicObject(933, -356.873046, 2245.790527, 41.425415, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(3275, -382.921447, 2186.119628, 41.948989, 0.000000, 0.000000, -80.699951, -1); 
	CreateDynamicObject(3250, -386.459259, 2173.775390, 41.048645, -1.299999, 0.799999, 101.299980, -1); 
	CreateDynamicObject(3275, -395.528228, 2168.608154, 42.129009, 0.000000, 1.800000, 11.100040, -1); 
	CreateDynamicObject(769, -406.965972, 2170.953369, 39.037990, 0.000000, 0.000000, -174.500000, -1); 
	CreateDynamicObject(764, -304.179504, 2217.771972, 45.438491, 0.000000, 0.000000, 25.499994, -1); 
	CreateDynamicObject(16404, -347.056335, 2204.517333, 42.798538, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(335, -399.275695, 2228.581298, 43.000049, -3.899999, 96.100021, 0.000000, -1); 
	CreateDynamicObject(18632, -481.416320, 2182.364501, 40.970748, -0.000003, 102.499954, 0.000000, -1); 
	CreateDynamicObject(18890, -435.418914, 2206.263427, 42.283058, -12.100003, 0.000000, 0.000000, -1); 
	CreateDynamicObject(17000, -353.248291, 2255.400878, 37.106918, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(1483, -406.534484, 2186.115966, 42.330890, 0.000000, 0.000000, 92.899978, -1); 
	CreateDynamicObject(1454, -404.544799, 2185.903808, 41.303447, 0.000000, 0.000000, -8.799999, -1); 
	CreateDynamicObject(14875, -407.982727, 2186.072265, 41.563446, 0.000000, 0.000000, -175.599990, -1);
	CreateDynamicObject(3872, -376.225006, 2240.291503, 39.865821, 1.099999, 0.000000, 0.000000, QWorld); 
	CreateDynamicObject(3872, -377.884857, 2245.916992, 39.973712, 3.699999, 0.000000, 0.000000, QWorld); 
	CreateDynamicObject(1739, -393.469451, 2227.987060, 42.179672, 0.000000, 0.000000, 169.199996, -1);
	CreateDynamicObject(2680, -361.319793, 2221.890380, 42.785900, 14.700004, -11.500000, -61.400016, QWorld);
	// Village fire
	CreateDynamicObject(18691, -359.720214, 2224.478515, 41.491203, 0.0, 0.0, 0.0, QWorld+1); 
	CreateDynamicObject(18691, -359.720214, 2221.669189, 44.561218, 0.0, 0.0, 0.0, QWorld+1); 
	CreateDynamicObject(18691, -352.650177, 2221.669189, 47.091262, 0.0, 0.0, 0.0, QWorld+1); 
	CreateDynamicObject(18691, -351.960052, 2225.052490, 44.731277, 0.0, 0.0, 0.0, QWorld+1);
	CreateDynamicObject(18691, -391.759857, 2227.551513, 45.491180, 0.0, 0.0, 0.0, QWorld+1);  
	CreateDynamicObject(18691, -399.469726, 2248.592773, 42.731189, 0.0, 0.0, 0.0, QWorld+1);  
	CreateDynamicObject(18691, -393.539916, 2248.592773, 39.241176, 0.0, 0.0, 0.0, QWorld+1);  
	CreateDynamicObject(18691, -399.899902, 2241.453613, 43.451179, 0.0, 0.0, 0.0, QWorld+1);  
	CreateDynamicObject(18691, -398.249908, 2227.842285, 43.451179, 0.0, 0.0, 0.0, QWorld+1);  
	CreateDynamicObject(18691, -376.949707, 2239.482421, 43.861171, 0.0, 0.0, 0.0, QWorld+1);  
	CreateDynamicObject(18691, -376.859863, 2242.225097, 40.441169, 0.0, 0.0, 0.0, QWorld+1);  
	CreateDynamicObject(18691, -378.109832, 2248.085937, 41.371139, 0.0, 0.0, 0.0, QWorld+1);  
	CreateDynamicObject(18691, -387.169769, 2217.047119, 40.381145, 0.0, 0.0, 0.0, QWorld+1);  
	CreateDynamicObject(18691, -385.349792, 2207.416259, 43.871147, 0.0, 0.0, 0.0, QWorld+1);  
	CreateDynamicObject(18691, -392.069732, 2207.416259, 45.931156, 0.0, 0.0, 0.0, QWorld+1);  
	// rocks 1st explode
	rocks[0]=CreateDynamicObject(1305, -591.495544, 2355.004394, 97.351554, 0.0, 0.0, 0.0, QWorld); 
	rocks[1]=CreateDynamicObject(1305, -592.225524, 2358.177490, 97.721534, 0.0, 0.0, 0.0, QWorld);
	rocks[2]=CreateDynamicObject(1305, -594.265869, 2359.564208, 97.721534, 0.0, 0.0, 0.0, QWorld); 
	rocks[3]=CreateDynamicObject(1305, -594.265869, 2361.586181, 96.171546, 0.0, 0.0, 0.0, QWorld); 
	rocks[4]=CreateDynamicObject(1305, -592.415771, 2359.454101, 96.171546, 0.0, 0.0, 0.0, QWorld);	
	rocks[5]=CreateDynamicObject(1305, -591.225219, 2359.293945, 94.501564, 0.0, 0.0, 0.0, QWorld);
	rocks[6]=CreateDynamicObject(1305, -591.225219, 2358.152832, 95.561561, 0.0, 0.0, 0.0, QWorld); 
	rocks[7]=CreateDynamicObject(1305, -592.944335, 2361.306640, 95.031570, 0.0, 0.0, 0.0, QWorld); 
	rocks[8]=CreateDynamicObject(1305, -591.063720, 2360.275634, 92.441581, 0.0, 0.0, 0.0, QWorld); 
	rocks[9]=CreateDynamicObject(1305, -592.343994, 2361.496826, 93.261528, 0.0, 0.0, 0.0, QWorld); 
	rocks[10]=CreateDynamicObject(1305, -594.374023, 2362.777587, 93.741516, 0.0, 0.0, 0.0, QWorld); 
	//x2 1st explode
	rocks[11]=CreateDynamicObject(1305, -591.495544+0.2, 2355.004394, 97.351554, 0.0, 0.0, 0.0, QWorld); 
	rocks[12]=CreateDynamicObject(1305, -592.225524+0.2, 2358.177490, 97.721534, 0.0, 0.0, 0.0, QWorld); 
	rocks[13]=CreateDynamicObject(1305, -594.265869+0.2, 2359.564208, 97.721534, 0.0, 0.0, 0.0, QWorld); 
	rocks[14]=CreateDynamicObject(1305, -594.265869+0.2, 2361.586181, 96.171546, 0.0, 0.0, 0.0, QWorld); 
	rocks[15]=CreateDynamicObject(1305, -592.415771+0.2, 2359.454101, 96.171546, 0.0, 0.0, 0.0, QWorld); 
	rocks[16]=CreateDynamicObject(1305, -591.225219+0.2, 2359.293945, 94.501564, 0.0, 0.0, 0.0, QWorld); 
	rocks[17]=CreateDynamicObject(1305, -591.225219+0.2, 2358.152832, 95.561561, 0.0, 0.0, 0.0, QWorld); 
	rocks[18]=CreateDynamicObject(1305, -592.944335+0.2, 2361.306640, 95.031570, 0.0, 0.0, 0.0, QWorld); 
	rocks[19]=CreateDynamicObject(1305, -591.063720+0.2, 2360.275634, 92.441581, 0.0, 0.0, 0.0, QWorld); 
	rocks[20]=CreateDynamicObject(1305, -592.343994+0.2, 2361.496826, 93.261528, 0.0, 0.0, 0.0, QWorld); 
	rocks[21]=CreateDynamicObject(1305, -594.374023+0.2, 2362.777587, 93.741516, 0.0, 0.0, 0.0, QWorld); 
	// 1st dynamite pos
	rocks[22]=CreateDynamicObject(1305, -657.324279, 2451.458496, 109.441520, 0.0, 0.0, 0.0, QWorld);
	rocks[23]=CreateDynamicObject(1305, -657.324279, 2451.458496, 111.481491, 0.0, 0.0, 0.0, QWorld);
	rocks[24]=CreateDynamicObject(1305, -657.164184, 2451.696777, 113.657211, -1.3, 29.8, 37.3, QWorld);
	// 2st dynamite pos
	rocks[25]=CreateDynamicObject(1305, -798.145874, 2312.252441, 142.143875, 0.0, 0.0, 0.0, QWorld);
	rocks[26]=CreateDynamicObject(1305, -797.044921, 2310.281005, 141.583877, 0.0, 0.0, 0.0, QWorld);
	rocks[27]=CreateDynamicObject(1305, -799.825866, 2309.751953, 142.143875, 0.0, 0.0, 0.0, QWorld);
	rocks[28]=CreateDynamicObject(1305, -777.395263, 2309.751953, 135.903976, 0.0, 0.0, 0.0, QWorld);
	rocks[29]=CreateDynamicObject(1305, -777.395263, 2307.611572, 135.903976, 0.0, 0.0, 0.0, QWorld);
	rocks[30]=CreateDynamicObject(1305, -777.395263, 2305.381103, 135.903976, 0.0, 0.0, 0.0, QWorld);
	rocks[31]=CreateDynamicObject(1305, -777.645507, 2312.011230, 135.903976, 0.0, 0.0, 0.0, QWorld);
	// Mountains
	tmpobjid = CreateDynamicObject(3585, -673.666381, 2317.484375, 134.775146,
	-13.599986, -9.100003, -77.300079, QWorld); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18250, "cw_junkbuildcs_t", "Was_scrpyd_rustmetal", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18250, "cw_junkbuildcs_t", "Was_scrpyd_rustmetal", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 18250, "cw_junkbuildcs_t", "Was_scrpyd_rustmetal", 0x00000000);
	tmpobjid = CreateDynamicObject(3585, -667.965698, 2334.486572, 135.731567,
	-7.099985, -40.299964, -37.600036, QWorld); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18250, "cw_junkbuildcs_t", "Was_scrpyd_rustmetal", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18250, "cw_junkbuildcs_t", "Was_scrpyd_rustmetal", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 18250, "cw_junkbuildcs_t", "Was_scrpyd_rustmetal", 0x00000000);
	tmpobjid =  CreateDynamicObject(18248, -735.530090, 2464.121582, 130.849868, 0.000000, 9.199999, 0.000000, QWorld);
	SetDynamicObjectMaterial(tmpobjid, 0, 18250, "cw_junkbuildcs_t", "Was_scrpyd_rustmetal", 0x00000000);
		
	// shaht
	CreateDynamicObject(12957, -693.9895, 2327.6879, 128.6908, 0.0000, 0.0000, 0.0000, -1);
	CreateDynamicObject(16667, -793.749084, 2303.217773, 142.473785, 17.9, 8.69, 47.20, QWorld); 
	CreateDynamicObject(16667, -797.607727, 2319.222167, 139.279998, 12.8, -0.50, -139.59, QWorld); 
	CreateDynamicObject(16667, -819.062805, 2311.604736, 146.761093, 17.9, 8.69, 165.10, QWorld); 
	CreateDynamicObject(16667, -818.906433, 2324.812500, 143.390640, 17.9, 34.89, 95.40, QWorld);
	// dynaamite destroy rocks
	dynrock[0]=CreateDynamicObject(16667, -659.065124, 2445.905761, 113.540023, 17.9, 8.69, 84.79, QWorld);
	dynrock[1]=CreateDynamicObject(16667, -666.288208, 2446.145019, 113.918487, 17.9, 8.69, 84.79, QWorld);
	
	CreateDynamicObject(16406, -681.231628, 2445.096923, 114.662956, 6.900000, 3.499999, 78.800003, -1); 
	CreateDynamicObject(16113, -690.402587, 2445.180908, 106.193305, 0.000000, 0.000000, 19.600048, -1);
	CreateDynamicObject(16406, -409.591796, 2319.273437, 47.675029, 0.000000, 3.099999, -67.399986, -1);
	CreateDynamicObject(16113, -515.807250, 2391.089843, 69.818664, 0.000000, 0.000000, -115.200012, -1);
	CreateDynamicObject(16113, -550.553222, 2382.608398, 67.498672, 0.000000, 0.000000, -164.799972, -1);
	CreateDynamicObject(16406, -501.304138, 2371.576660, 73.403816, 0.000000, 0.599999, -143.499923, -1);
	CreateDynamicObject(16113, -255.551589, 2198.021484, 51.777420, 0.000000, 0.000000, 140.899978, -1);
	CreateDynamicObject(16113, -258.185699, 2240.250976, 52.497413, 0.000000, 0.000000, 133.099884, -1);
	CreateDynamicObject(16444, -292.247650, 2091.628173, 30.515417, 0.000000, 6.099998, 0.000000, -1);
	CreateDynamicObject(16444, -292.804626, 2087.434326, 30.843555, -7.200001, 6.900000, -28.799997, -1);
	CreateDynamicObject(16318, -760.057739, 2462.479248, 128.480377, 0.000000, 0.000000, -131.700057, -1);
	CreateDynamicObject(16318, -678.598327, 2406.696289, 136.520385, 0.000000, 0.000000, -24.100072, -1);
	CreateDynamicObject(16481, -621.825134, 2408.992187, 104.323852, 0.000000, -15.099998, 124.800018, -1);
	CreateDynamicObject(16481, -638.631774, 2437.481201, 111.532997, 6.799997, 12.200001, 47.600017, -1);
	CreateDynamicObject(16314, -637.547180, 2426.288818, 119.903884, 0.000000, 0.000000, -134.799957, -1);
	// Mountains buildings
	CreateDynamicObject(16319, -658.494140, 2339.740722, 138.726837, 0.000000, 0.000000, -163.699951, -1); 
	CreateDynamicObject(841, -795.979492, 2418.821533, 156.539871, -49.499977, -23.099992, 0.000000, -1); 
	CreateDynamicObject(841, -795.959655, 2417.996582, 156.430923, -61.499984, -23.099992, 150.200027, -1); 
	CreateDynamicObject(841, -795.282409, 2418.652832, 156.410446, -61.499984, -23.099992, -110.000061, -1); 
	CreateDynamicObject(734, -730.705078, 2410.410400, 125.462860, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(18259, -743.879089, 2380.024414, 126.000801, 0.000000, -0.699999, 138.500030, -1); 
	CreateDynamicObject(734, -757.095214, 2358.600585, 119.902885, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(734, -761.114929, 2306.210449, 120.682914, 0.000000, 0.000000, 19.300003, -1); 
	CreateDynamicObject(734, -674.824829, 2423.841064, 129.462799, 0.000000, 0.000000, 83.299995, -1); 
	CreateDynamicObject(16403, -721.117980, 2331.696533, 123.662170, 0.000000, -1.299999, 51.300014, -1); 
	CreateDynamicObject(16406, -662.339965, 2339.253662, 140.671386, 0.000000, 0.000000, -90.000000, -1); 
	CreateDynamicObject(3350, -664.053527, 2313.705078, 137.525177, 0.000000, 4.599999, -113.299972, -1); 
	CreateDynamicObject(3302, -675.247131, 2321.902099, 134.906188, -78.899971, 0.000000, 0.000000, -1); 
	CreateDynamicObject(1457, -699.562683, 2311.877685, 130.258453, 0.000000, 0.000000, 176.199996, -1); 
	CreateDynamicObject(3275, -706.538635, 2320.658447, 127.729469, 0.000000, 0.300000, 47.100002, -1); 
	CreateDynamicObject(13367, -705.848693, 2367.723144, 137.200897, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(3362, -780.634338, 2436.996337, 155.657470, 0.000000, 0.000000, -127.099967, -1); 
	CreateDynamicObject(3250, -721.299377, 2313.630859, 126.312614, 0.000000, 0.400000, 139.099975, -1); 
	CreateDynamicObject(3253, -719.561584, 2334.928222, 125.907058, -2.200000, 0.000000, 51.099967, -1); 
	CreateDynamicObject(734, -710.254699, 2302.858642, 120.402915, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(3275, -688.285583, 2348.715820, 127.840255, 0.000000, -0.500000, 64.899993, -1); 
	CreateDynamicObject(16411, -705.868225, 2401.740722, 128.240966, -5.399998, 7.799997, 170.300018, -1); 
	CreateDynamicObject(16403, -753.186706, 2349.079101, 121.357589, -0.399999, -1.399999, 51.300014, -1); 
	CreateDynamicObject(16403, -713.483276, 2396.712158, 125.308372, -2.799999, -2.199999, 51.300014, -1); 
	CreateDynamicObject(16411, -698.587524, 2428.795654, 127.022949, -5.399998, 7.799997, 92.900062, -1); 
	CreateDynamicObject(3275, -728.224060, 2340.981445, 125.574752, 0.000000, -1.499999, 34.000015, -1); 
	CreateDynamicObject(3275, -798.093872, 2376.199707, 152.306991, 0.000000, -10.500000, 66.199989, -1); 
	CreateDynamicObject(17055, -686.135498, 2309.211669, 131.567214, 0.000000, 0.000000, 85.499977, -1); 
	CreateDynamicObject(3302, -737.155334, 2372.018066, 124.493453, -161.799758, -0.600000, -45.699996, -1); 
	CreateDynamicObject(13435, -732.095703, 2385.465087, 127.777297, 0.000000, 2.999999, 49.399997, -1); 
	CreateDynamicObject(16154, -748.470214, 2378.082031, 125.889976, 0.000000, 0.000000, 51.599994, -1); 
	CreateDynamicObject(9362, -742.184326, 2387.516601, 126.855895, 0.000000, 0.000000, 48.999988, -1); 
	CreateDynamicObject(942, -738.263305, 2381.150634, 128.227737, 0.000000, 0.000000, 50.499996, -1); 
	CreateDynamicObject(964, -741.828735, 2376.057861, 125.955909, 0.000000, 0.000000, -129.699981, -1); 
	CreateDynamicObject(1497, -740.160766, 2376.497802, 126.177139, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(851, -795.851318, 2418.894775, 156.139755, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(3092, -795.836120, 2418.346679, 158.430007, 0.000000, 0.000000, 159.599945, -1); 
	CreateDynamicObject(3459, -795.754516, 2418.611816, 152.364440, 0.000000, 0.000000, 156.500030, -1); 
	CreateDynamicObject(18691, -795.182189, 2418.856201, 155.008926, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(18691, -796.422241, 2417.394775, 155.008926, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(18691, -796.422241, 2419.126464, 155.008926, 0.000000, 0.000000, 0.000000, -1); 
	CreateDynamicObject(16121, -808.760986, 2366.675781, 114.161239, 0.000000, 0.000000, -22.899997, -1); 
	CreateDynamicObject(16121, -752.806701, 2297.858398, 121.421249, 0.000000, 0.000000, 64.299987, -1);
	// Finalint
	
	tmpobjid = CreateDynamicObject(19480, 304.494384, 309.370330, 1002.324707, 0.000000, 90.000000, 90.000000, -1); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(19480, 304.494384, 304.090515, 1002.324707, 0.000000, 90.000000, 90.000000, -1); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(2745, 306.430816, 304.184448, 1002.595153, -24.500001, -0.500000, -89.799980, -1); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2589, "ab_ab", "ab_carcass", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 2589, "ab_ab", "ab_carcass", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 5, 2589, "ab_ab", "ab_carcass", 0x00000000);
	tmpobjid = CreateDynamicObject(19480, 304.494384, 302.520294, 998.153076, 0.000000, 90.000000, 90.000000, -1);
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(19480, 307.214202, 307.520080, 998.223144, 0.000000, 90.000000, 90.000000, -1);
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	dyndoor[0] = CreateDynamicObject(1497, 299.486877, 312.045898, 998.148437, 0.000000, 0.000000, -0.199999, -1);
	
	///////
	CreateDynamicObject(1497, 299.410461, 308.727111, 1002.304687, 0.000000, 0.000000, 89.899993, -1);
	CreateDynamicObject(2805, 305.461639, 308.146759, 1005.746032, 0.000000, 0.000000, 0.000000, -1);
	CreateDynamicObject(2803, 310.678039, 305.177001, 1002.614929, 0.000000, 0.000000, -13.899999, -1);
	CreateDynamicObject(2803, 310.968627, 306.351501, 1002.725036, 0.000000, 0.000000, -66.599998, -1);
	CreateDynamicObject(18963, 304.349517, 304.146484, 1003.246765, 0.000000, -4.699998, 0.000000, -1);
	CreateDynamicObject(2805, 305.461639, 309.226745, 1004.325195, 0.000000, 0.000000, -43.800003, -1);
	CreateDynamicObject(19087, 305.469573, 309.239959, 1007.035644, 0.000000, 0.000000, 0.000000, -1);
	CreateDynamicObject(2805, 303.125427, 310.705780, 1004.805114, 0.000000, 0.000000, -151.800003, -1);
	CreateDynamicObject(19087, 303.049713, 310.669921, 1007.035644, 0.000000, 0.000000, 0.000000, -1);
	CreateDynamicObject(2805, 307.649841, 306.408020, 1005.775695, 0.000000, 0.000000, -43.800003, -1);
	CreateDynamicObject(19087, 307.789550, 306.420196, 1008.906738, 0.000000, 0.000000, 0.000000, -1);
	CreateDynamicObject(2805, 304.155975, 305.726135, 1006.336181, 0.000000, 0.000000, -72.999984, -1);
	CreateDynamicObject(19087, 304.169708, 305.760375, 1008.906738, 0.000000, 0.000000, 0.000000, -1);
	CreateDynamicObject(2803, 310.993499, 304.037902, 1002.614929, 0.000000, 0.000000, 67.199989, -1);
	CreateDynamicObject(19086, 309.769805, 300.285644, 1002.654968, 0.000000, 0.000000, 78.199996, -1);
	CreateDynamicObject(18693, 299.916168, 303.415527, 1001.728271, 0.000000, 0.000000, 0.000000, -1);
	CreateDynamicObject(19585, 299.938446, 303.613922, 1003.879333, 0.000000, 0.000000, 0.000000, -1);
	CreateDynamicObject(2908, 299.908508, 303.361541, 1003.783386, 39.299983, 0.000000, 0.000000, -1);
	CreateDynamicObject(1739, 302.248138, 304.977081, 998.938964, 0.000000, 0.000000, -91.000007, -1);
	CreateDynamicObject(14578, 302.722534, 302.921356, 1001.847717, 0.000000, 0.000000, 0.000000, -1);
	CreateDynamicObject(19631, 305.585174, 311.407623, 999.049316, 0.000000, 92.700012, 43.099994, -1);
	
	// Fire lastint
	fireobj[0]=CreateDynamicObject(18691, 305.246826, 307.154388, 997.398132-200, 0.0, 0.0, 0.0, -1);
	fireobj[1]=CreateDynamicObject(18691, 305.246826, 304.274414, 997.818237-200, 0.0, 0.0, 0.0, -1);
	fireobj[2]=CreateDynamicObject(18691, 303.406829, 302.454559, 997.818237-200, 0.0, 0.0, 0.0, -1);
	fireobj[3]=CreateDynamicObject(18691, 300.376831, 302.454559, 997.818237-200, 0.0, 0.0, 0.0, -1);
	fireobj[4]=CreateDynamicObject(18691, 300.036865, 305.274505, 997.818237-200, 0.0, 0.0, 0.0, -1);
	fireobj[5]=CreateDynamicObject(18691, 300.036865, 307.994506, 997.818237-200, 0.0, 0.0, 0.0, -1);
	fireobj[6]=CreateDynamicObject(18691, 302.972320, 314.825866, 998.678588-200, 0.0, 0.0, 0.0, -1);
	fireobj[7]=CreateDynamicObject(18691, 308.192260, 314.825866, 1001.919311-200, 0.0, 0.0, 0.0, -1);
	fireobj[8]=CreateDynamicObject(18691, 306.032501, 311.015991, 1001.919311-200, 0.0, 0.0, 0.0, -1);
	fireobj[9]=CreateDynamicObject(18691, 309.092498, 306.476074, 1001.919311-200, 0.0, 0.0, 0.0, -1);
	fireobj[10]=CreateDynamicObject(18691, 303.282531, 304.456115, 1001.919311-200, 0.0, 0.0, 0.0, -1);
	// end mapping
    return true; 
} 

public OnFilterScriptExit()
{ 
	// Destroy textdraws, actors, pickups
	KillTimer(QuestTimer);
	for(new i = 0; i < MY_MAX_PLAYERS; i++) 
	{
		TextDrawDestroy(TDQuestInfo[i]);
		TextDrawDestroy(TDCustomHud[i]);
		DeletePVar(i, "Event");
		DeletePVar(i, "EventPart");
		Streamer_Update(i, -1);
		StopAudioStreamForPlayer(i);
		EndQuest(i, 0);
	}
	for(new veh = 0; veh < sizeof(QuestVehicles); veh++) DestroyVehicle(QuestVehicles[veh]);
	for(new pickup = 0; pickup < sizeof(QuestPickups); pickup++) DestroyDynamicPickup(QuestPickups[pickup]);
	return true;
} 

public OnPlayerConnect(playerid)
{ 

	RemoveBuildingForPlayer(playerid, 16395, -763.632, 2307.479, 136.882, 0.250);
	RemoveBuildingForPlayer(playerid, 16630, -341.453, 2225.500, 42.015, 0.250);
	RemoveBuildingForPlayer(playerid, 16635, -339.687, 2221.129, 42.015, 0.250);
	RemoveBuildingForPlayer(playerid, 16636, -340.125, 2228.129, 42.007, 0.250);
	RemoveBuildingForPlayer(playerid, 16631, -335.523, 2229.610, 42.007, 0.250);
	RemoveBuildingForPlayer(playerid, 16632, -329.796, 2231.689, 42.421, 0.250);
	RemoveBuildingForPlayer(playerid, 16629, -337.914, 2215.229, 42.015, 0.250);
	RemoveBuildingForPlayer(playerid, 16634, -336.296, 2211.510, 41.968, 0.250);
	RemoveBuildingForPlayer(playerid, 16628, -331.117, 2211.479, 42.382, 0.250);
	RemoveBuildingForPlayer(playerid, 16633, -327.265, 2213.060, 43.062, 0.250);
	RemoveBuildingForPlayer(playerid, 16627, -322.898, 2214.820, 44.343, 0.250);
	
	// Pvar pre-set
	SetPVarInt(playerid, "EventPart", -1);
	SetPVarInt(playerid, "EventTime", 0);
	SetPVarInt(playerid, "EventKeys", 0);
	SetPVarInt(playerid, "EventDynamite", 0);
	SetPVarInt(playerid, "Event", 0);
	
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
	
	SendClientMessage(playerid, 0xF5511CAA,
	"The Halloween event is running on the server. Take part and get unique Halloween costumes (/info)");
	
	SendClientMessage(playerid, 0xF5511CAA,
	"Halloween Is Coming! Type /quest if you are ready pass the quest");
	return true;
} 

public OnPlayerDeath(playerid, killerid, reason)
{
	if(GetPVarInt(playerid, "EventPart") >= 1)
	{
		GameTextForPlayer(playerid, "~r~ YOU DIE!", 5000, 5);
		SetPVarInt(playerid, "EventKeys", 0);
		if(IsPlayerAttachedObjectSlotUsed(playerid, 0)) RemovePlayerAttachedObject(playerid, 0);
		
		if(GetPVarInt(playerid, "EventPart") == 5)
		{
			if(GetPVarInt(playerid, "DoorDamage")) EndQuest(playerid, 2);
			else EndQuest(playerid, 3);
		}
		if(GetPVarInt(playerid, "EventPart") == 6)
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) EndQuest(playerid, 1);
		}
		if(GetPVarInt(playerid, "EventPart") == 7)
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) EndQuest(playerid, 4);
		}
		if(GetPVarInt(playerid, "EventPart") > 0) DisablePlayerCheckpoint(playerid);
		//PlayerPlaySound(playerid, 31202, 0.0, 0.0, 0.0); // LOSE
	}
	return true;
}

public OnPlayerSpawn(playerid)
{
	if(GetPVarInt(playerid, "EventPart") == 1)
	{
		SetPlayerPos(playerid, -471.8662,2194.5991,46.0527);
		SetPlayerFacingAngle(playerid, 266.56);
		GameTextForPlayer(playerid, "~w~Chapter 1: Arrival", 5000, 4);
		SetPlayerVirtualWorld(playerid, QWorld);
		TextDrawSetString(TDCustomHud[playerid],
		"~w~Find main street of the village");
		TextDrawShowForPlayer(playerid, TDCustomHud[playerid]);
	}
	if(GetPVarInt(playerid, "EventPart") == 2)
	{
		SetPlayerVirtualWorld(playerid, QWorld);
		SetPlayerPos(playerid, -377.9211,2242.1951,42.6185);
		//SetPlayerFacingAngle(playerid, 266.56);
		GameTextForPlayer(playerid, "~w~Chapter 2~n~Explore the area", 5000, 4);
	}
	if(GetPVarInt(playerid, "EventPart") == 3)
	{
		SetPlayerVirtualWorld(playerid, QWorld);
		SetPlayerPos(playerid, -385.9279,2228.6819,42.3544);
		SetPlayerFacingAngle(playerid, 103.9206);
		GameTextForPlayer(playerid, "~w~Chapter 3~n~Let's climb the mountains", 5000, 4);
		TextDrawSetString(TDCustomHud[playerid], "~w~Let's climb the mountains"); 
	}
	if(GetPVarInt(playerid, "EventPart") == 4)
	{
		SetPlayerVirtualWorld(playerid, QWorld);
		SetPlayerPos(playerid, 	-715.7057,2435.6230,126.7399);
		GameTextForPlayer(playerid, "~w~Chapter 4~n~Cursed place", 5000, 4);
		TextDrawSetString(TDCustomHud[playerid], "~w~Need to look around here"); 
		SendMessageTD(playerid,	"Need to look around here");
		StopAudioStreamForPlayer(playerid);
		PlayAudioStreamForPlayer(playerid,"http://minty.club/artist/jason-graves/the-shadow-of-the-mountain-main-theme/jason-graves-the-shadow-of-the-mountain-main-theme.mp3");
		SetVehicleParamsEx(QuestVehicles[11], 0, 0, 0, 0, 0, 1, 0);
	}
	if(GetPVarInt(playerid, "EventPart") == 5)
	{
		SetPVarInt(playerid, "EventPart", 5);
		GameTextForPlayer(playerid, "~w~Chapter 5~n~Terrible Truth", 5000, 4);
		TextDrawSetString(TDCustomHud[playerid], "~w~"); 
		SendMessageTD(playerid,	"What the hell.. Should have taken a weapon instead of a camera");
		StopAudioStreamForPlayer(playerid);
		PlayAudioStreamForPlayer(playerid,"https://minty.club/artist/jason-graves/apoplexia/jason-graves-apoplexia.mp3");
		SetPlayerPos(playerid, 303.8141,309.6032,1003.3047);
		SetPlayerInterior(playerid, 4);
		SetPlayerVirtualWorld(playerid, QWorld);
		SetDynamicObjectRot(dyndoor[0], 0.000000, 0.000000, -90);
	}
	if(GetPVarInt(playerid, "EventPart") == 6)
	{
		GameTextForPlayer(playerid, "~w~Chapter 6~n~Run away", 5000, 4);
		TextDrawSetString(TDCustomHud[playerid], "~w~Run away from the maniac"); 
		SendMessageTD(playerid,	"What the hell.. Should have taken a weapon instead of a camera");
		StopAudioStreamForPlayer(playerid);
		PlayAudioStreamForPlayer(playerid,"https://minty.club/artist/jason-graves/the-nexus/jason-graves-the-nexus.mp3");
		SetPlayerPos(playerid, -784.8062,2431.7668,157.1398);
		SetPlayerFacingAngle(playerid, 164.2925);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, QWorld);
	}
	if(GetPVarInt(playerid, "EventPart") == 7)
	{
		SetPVarInt(playerid, "EventPart", 7);
		GameTextForPlayer(playerid, "~w~Chapter 7~n~Leave the village", 5000, 4);
		TextDrawSetString(TDCustomHud[playerid], "~w~Find a way to leave the village"); 
		StopAudioStreamForPlayer(playerid);
		PlayAudioStreamForPlayer(playerid,"https://minty.club/artist/jason-graves/credits/jason-graves-credits.mp3");
		SetPlayerPos(playerid, -408.1884,2315.4243,50.9399);
		SetPlayerFacingAngle(playerid, 200.1921);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, QWorld+1);
		SetPlayerCheckpoint(playerid, -480.3841,2190.2603,41.8672, 2.0);
		SetVehicleVirtualWorld(QuestVehicles[22], QWorld+1);
	}
	return true;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/info", true))
	{
		SendClientMessage(playerid, 0xF5511CAA, "You are a journalist who goes to the small village of LAS BRUJAS");
		SendClientMessage(playerid, 0xF5511CAA, "located near the mountain range EL CATILLIO DEL DIABLO.");
		SendClientMessage(playerid, 0xF5511CAA, "Your task is to find out more information about the mysterious disappearance of people.");
		SendClientMessage(playerid, 0xF5511CAA, "Mystical disappearance has been going on for several days.");
		SendClientMessage(playerid, 0xF5511CAA, "Your informant Scoot Wilson will be waiting at the high street diner.");
		SendClientMessage(playerid, 0xF5511CAA, "The weather forecast is for a storm, so hurry up."); 
		//SendClientMessage(playerid, 0xF5511CAA, "Type /quest if you are ready");
		//GameTextForPlayer(playerid, "~w~Type ~g~/quest~w~ if you are ready", 5000, 4);
		return true;
	}
	if(!strcmp(cmdtext, "/quest", true))
	{
		if(GetPVarInt(playerid, "Event") < 1)
		{
			new client_version[10];
			GetPlayerVersion(playerid, client_version, sizeof(client_version));
			if(strfind(client_version, "R", true) != -1 || strfind(client_version, "DL", true) != -1)
			{
				SetPVarInt(playerid, "NewClient", 1);
			}	
			SetPVarInt(playerid, "Event", 1);
			SetPVarInt(playerid, "EventPart", 0);
			SetPVarInt(playerid, "EventKeys", 0);
			SpawnPlayer(playerid);
			OnPlayerCommandText(playerid, "/info");
			SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 1);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 1);
			SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 1);
			ResetPlayerWeapons(playerid);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, QWorld);
			SetPlayerWeather(playerid, 8); 
			SetPlayerTime(playerid, 23,0);
			SetPlayerSkin(playerid, 295);
			SetPlayerPos(playerid, -861.3973,2168.9724,40.2300);
			//SetDynamicObjectPos(ghostdoor_object, -389.587890, 2227.922363, 42.907699);
			SetPlayerFacingAngle(playerid, 263);
			SetPlayerCheckpoint(playerid, -472.9079,2194.5254,46.0527, 2.0);
			foreach(Player, i) SetPlayerMarkerForPlayer(playerid, 1, 0xFFFFFF00);
			Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_PICKUP, false);
		} else {
			//SendClientMessage(playerid, 0xF5511CAA, "Type /info to view information about all stages");
			SendClientMessage(playerid, -1, "Type /exit to leave the quest. (All progress will be lost)");
		}
		return true;
	}
	if (!strcmp(cmdtext, "/quest ", true, 7))
	{
		// tests quest (/quest id)
		if (strlen(cmdtext) < 7) return true;
		if (GetPVarInt(playerid, "Admin") < 3) return false;
		new PARAM = strval(cmdtext[7]);
		if(PARAM > -1 && PARAM < 8)	{
			SetPVarInt(playerid, "EventPart", PARAM);
			SendClientMessage(playerid, -1, "Quest skipped. Type /kill to respawn");
			DisablePlayerCheckpoint(playerid);
			Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_PICKUP, true);
		}
		if(PARAM == 3) SetPVarInt(playerid, "EventKeys", 7);
		
		return true;
	}
	if(!strcmp(cmdtext, "/exit", true))
	{
		EndQuest(playerid, 0);
		return true;
	}
	return false;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(vehicleid != GetPVarInt(playerid, "Vehicle"))
	{
		if(GetVehicleModel(vehicleid) != 593 && GetVehicleModel(vehicleid) != 473)
		{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			SetPlayerPos(playerid,x,y,z);
			RemovePlayerFromVehicle(playerid);
			PlayerPlaySound(playerid, 24600, 0.0, 0.0, 0.0);
		}
	}
	return true;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	if(GetPVarInt(playerid, "EventPart") > -1)
	{
		return false;
	}
	return true;
}

public OnPlayerUpdate(playerid)
{
	// Moved to global timer QuestUpdate()
	return true;
}

forward QuestUpdate();
public QuestUpdate()
{	
	new hour, minute, second;
	gettime(hour, minute, second);
	new gametext[256];
	
	if(QuestTick < 60) QuestTick++; else QuestTick = 0;
	
	if((QuestTick % 2) == 0) // every 2 sec
	{
		switch(random(8))
		{
			case 1: SetDynamicActorPos(QuestActors[3],-395.0708,2181.5857,41.8712);
			case 2: SetDynamicActorPos(QuestActors[3],-385.3194,2109.9753,68.3878);
			case 3: SetDynamicActorPos(QuestActors[3],-305.9721,2277.3745,75.8468);
			case 4: SetDynamicActorPos(QuestActors[3],-344.1533,2245.2520,42.4844);
			case 5: SetDynamicActorPos(QuestActors[3],-406.2796,2210.8728,42.4297);
			case 6: SetDynamicActorPos(QuestActors[3],-468.1410,2232.3545,44.9159);
			case 7: SetDynamicActorPos(QuestActors[3],-471.2192,2312.2908,63.5368);
			case 8: SetDynamicActorPos(QuestActors[3],-303.6975,2173.9463,112.0383);
		}
		ApplyDynamicActorAnimation(QuestActors[3], "PED", "WOMAN_WALKSEXY", 4.1, 1, 1, 1, 1, 0);
		SetDynamicActorPos(QuestActors[2], -232.1690,2337.9797,109.3195);
	}
	if((QuestTick % 10) == 0)
	{
		SetVehicleParamsEx(QuestVehicles[17], 0, 0, 0, 0, 0, 0, 0);
	}
	if((QuestTick % 20) == 0)
	{
		SetDynamicObjectPos(rocks[0], -591.495544, 2355.004394, 97.351554); 
		SetDynamicObjectPos(rocks[1], -592.225524, 2358.177490, 97.721534); 
		SetDynamicObjectPos(rocks[2], -594.265869, 2359.564208, 97.721534);  
		SetDynamicObjectPos(rocks[3], -594.265869, 2361.586181, 96.171546);  
		SetDynamicObjectPos(rocks[4], -592.415771, 2359.454101, 96.171546); 	
		SetDynamicObjectPos(rocks[5], -591.225219, 2359.293945, 94.501564); 
		SetDynamicObjectPos(rocks[6], -591.225219, 2358.152832, 95.561561);  
		SetDynamicObjectPos(rocks[7], -592.944335, 2361.306640, 95.031570);  
		SetDynamicObjectPos(rocks[8], -591.063720, 2360.275634, 92.441581);  
		SetDynamicObjectPos(rocks[9], -592.343994, 2361.496826, 93.261528);  
		SetDynamicObjectPos(rocks[10], -594.374023, 2362.777587, 93.741516);  
		//x2
		SetDynamicObjectPos(rocks[11], -591.495544+0.2, 2355.004394, 97.351554);  
		SetDynamicObjectPos(rocks[12], -592.225524+0.2, 2358.177490, 97.721534);  
		SetDynamicObjectPos(rocks[13], -594.265869+0.2, 2359.564208, 97.721534);  
		SetDynamicObjectPos(rocks[14], -594.265869+0.2, 2361.586181, 96.171546);  
		SetDynamicObjectPos(rocks[15], -592.415771+0.2, 2359.454101, 96.171546);  
		SetDynamicObjectPos(rocks[16], -591.225219+0.2, 2359.293945, 94.501564);  
		SetDynamicObjectPos(rocks[17], -591.225219+0.2, 2358.152832, 95.561561);  
		SetDynamicObjectPos(rocks[18], -592.944335+0.2, 2361.306640, 95.031570);  
		SetDynamicObjectPos(rocks[19], -591.063720+0.2, 2360.275634, 92.441581);  
		SetDynamicObjectPos(rocks[20], -592.343994+0.2, 2361.496826, 93.261528);  
		SetDynamicObjectPos(rocks[21], -594.374023+0.2, 2362.777587, 93.741516);
	}
	
	foreach(Player, playerid)
	{
		new Float:x, Float:y, Float:z, Float:health, Float:armour;
		GetPlayerPos(playerid, x,y,z);
		GetPlayerHealth(playerid, health);
		GetPlayerArmour(playerid, armour);
		if(GetPVarInt(playerid, "EventPart") != -1)
		{
			if(GetPVarInt(playerid, "AFKTime") > 120)
			{
				SetPVarInt(playerid, "EventPart", -1);
				SetPVarInt(playerid, "EventTime", 0);
				SetPVarInt(playerid, "EventKeys", 0);
				SetPVarInt(playerid, "Event", -1);
				CallRemoteFunction("Hud", "ib", playerid, true);
				CallRemoteFunction("FirstPersonMode", "ib", playerid, false);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 999);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 999);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 999);
				DestroyVehicle(GetPVarInt(playerid, "Vehicle"));
				SetPlayerWeather(playerid, 1); 
				SetPlayerTime(playerid, 12, 0);
				SetPlayerPos(playerid, -1200.0552, -49.9265, 28.6187);
				SetPlayerVirtualWorld(playerid, 0);
				StopAudioStreamForPlayer(playerid);
				TextDrawHideForPlayer(playerid, TDCustomHud[playerid]);
				TextDrawHideForPlayer(playerid, TDQuestInfo[playerid]);
				SetPlayerHealth(playerid, 0.0);
				SendClientMessage(playerid, 0xF4400000, "You died suddenly..sleeping here is a bad idea");
			}
			
			if(GetPVarInt(playerid, "EventPart") > -1) {
				if(GetPVarInt(playerid, "EventPart") < 4) SetPlayerWeather(playerid, 8);
				else SetPlayerWeather(playerid, 9);
				SetPlayerTime(playerid, 23, 0);
			}
			
			if((QuestTick % 30) == 0)
			{
				if(!IsPlayerInVehicle(playerid, GetPVarInt(playerid, "Vehicle")))
				{
					DestroyVehicle(GetPVarInt(playerid, "Vehicle"));
				}
			}
			
			if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
			{
				GameTextForPlayer(playerid, "~r~It was a bad idea!", 5000, 4);
				SpawnPlayer(playerid);
			}
			GetDynamicActorPos(QuestActors[3], x, y, z);
			if(IsPlayerInRangeOfPoint(playerid, 5, x, y, z))
			{
				switch(random(3))
				{
					case 1: SendMessageTD(playerid, "What the .. i definitely saw a ghost", 7);
					case 2: SendMessageTD(playerid, "It's impossible, but I saw it with my own eyes", 7);
					case 3: SendMessageTD(playerid, "What could it be?", 7);
					default: SendMessageTD(playerid, "Are you okay? What the..", 7);
				}
				ApplyAnimation(playerid, "PED", "FightA_block" ,4.1,0,0,0,0,0,0);
				//PlayerPlaySound(playerid, 2204, 0.0, 0.0, 0.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 3, -296.6298,2091.7979,32.6097))
			{
				SendMessageTD(playerid,	"oh the devil, how many corpses are there!");
				GameTextForPlayer(playerid, "~g~SECRET ~w~FOUND", 5000, 4);
				//PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				SetPVarInt(playerid, "FinalWeapon", 26);
			}
		}
		
		//Spawn to quests teleport
		if(IsPlayerInRangeOfPoint(playerid, 5, -1200.0552, -49.9265, 28.6187))
		{
			GameTextForPlayer(playerid, "~w~Type ~g~/quest~w~ if you are ready", 5000, 4);
			//GameTextForPlayer(playerid, "~w~Type ~g~/costume~w~ to choose a new costume", 5000, 4);
		}
		if(GetPVarInt(playerid, "EventPart") == 0)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2, -861.3973,2168.9724,40.2300))
			{
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER){
					CallRemoteFunction("SpawnVehicle", "ii", playerid, 453);
					CallRemoteFunction("Hud", "ib", playerid, false);
				}
				if(QuestTick % 5) SendMessageTD(playerid, "Moving to the Las Brujas");
				TextDrawSetString(TDCustomHud[playerid],
				"~w~Moving to the Las Brujas"); 
				TextDrawShowForPlayer(playerid, TDCustomHud[playerid]);
				SetVehicleZAngle(GetPlayerVehicleID(playerid), 274.4542);
			}
			if(IsPlayerInRangeOfPoint(playerid, 20, -915.0491,2247.2219,40.2690))
			{
				GameTextForPlayer(playerid, "~r~WRONG WAY", 5000, 4);
			}
			if(IsPlayerInRangeOfPoint(playerid, 20, -623.1167,2212.0618,40.1842))
			{
				PlayerPlaySound(playerid, 6200, 0.0, 0.0, 0.0);
				SendMessageTD(playerid, "hmm.. Too many boats here");
			}
			if(IsPlayerInRangeOfPoint(playerid, 15, -517.2346,2192.0999,40.2219))
			{
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER){ 
					SetVehicleParamsEx(GetPlayerVehicleID(playerid), 0, 0, 0, 0, 0, 0, 0);
				}
				SendMessageTD(playerid,
				"Find more about the mystical disappearances of people in the village");
			}
  			if(IsPlayerInRangeOfPoint(playerid, 15, -472.1184,2194.3560,46.0527))
			{
				GameTextForPlayer(playerid, "~w~Chapter 1: Arrival", 5000, 4);
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid,
				"http://minty.club/artist/jason-graves/dead-space-theme/jason-graves-dead-space-theme.mp3");
				SendMessageTD(playerid, "Find main street of the village, and talk with villagers");
//				CallRemoteFunction("FirstPersonMode", "ib", playerid, true);
				SetPVarInt(playerid, "EventPart", 1);
				SetVehiclePos(QuestVehicles[15], -420.9096,2203.6956,41.9134);
				SetVehicleZAngle(QuestVehicles[15], 175.9551);
			}
		}
		// Chapter 1
		if(GetPVarInt(playerid, "EventPart") == 1)
		{	
			TextDrawSetString(TDCustomHud[playerid],
			"~w~Find main street of the village");
			TextDrawShowForPlayer(playerid, TDCustomHud[playerid]);			
			
			if(IsPlayerInRangeOfPoint(playerid, 15, -459.5185,2291.3589,56.6419))
			{
				SendMessageTD(playerid, "I should definitely explore the village first");
				SetPlayerFacingAngle(playerid, 208.09);
			}
			if(IsPlayerInRangeOfPoint(playerid, 15, -264.1015,2228.1223,58.4318))
			{
				SendMessageTD(playerid, "I should definitely explore the village first");
				SetPlayerFacingAngle(playerid, 100.35);
			}
			if(IsPlayerInRangeOfPoint(playerid, 4, -421.4906,2218.3823,42.4297))
			{
				SendMessageTD(playerid, "All the details point to the presence of people, but where is everyone?");
			}
			if(IsPlayerInRangeOfPoint(playerid, 6, -412.3985,2194.7019,42.3567))
			{
				SendMessageTD(playerid,
				"It's not night now, but there is no light in the houses anymore");
			}
			if(IsPlayerInRangeOfPoint(playerid, 5, -376.1369,2206.0764,42.0938))
			{
				SendMessageTD(playerid, "No one on the streets, let's see in the diner");
				SetPlayerCheckpoint(playerid, -377.9211,2242.1951,42.6185, 2.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 5, -382.1338,2233.2451,42.0938))
			{
				SendMessageTD(playerid, "Maybe all people here");
				//QuestCheckpoint[1] = CreateDynamicCP(-380.5898,2241.0920,42.4162, 2.0, QWorld);
			}
			if(IsPlayerInRangeOfPoint(playerid, 3, -363.5422,2222.2666,42.4844))
			{
				SendMessageTD(playerid, "I don't need confession");
			}
			if(IsPlayerInRangeOfPoint(playerid, 2, -377.9211,2242.1951,42.6185))
			{
				GameTextForPlayer(playerid, "~w~Chapter 2~n~Explore the area", 5000, 4);
				//SendMessageTD(playerid, "Closed, try to find the key");
				SendMessageTD(playerid, "Need to explore the countryside, try to find out more");
				SetPVarInt(playerid, "EventPart", 2);
				
				if(GetPVarInt(playerid, "NewClient") == 1)
				{
					SetPlayerPos(playerid, 678.4554,-459.5266,-25.8172);
					SetPlayerInterior(playerid, 1);
					SetPlayerFacingAngle(playerid, 178.72);
					StopAudioStreamForPlayer(playerid);
					PlayAudioStreamForPlayer(playerid,
					"https://minty.club/artist/jason-graves/first-blood/jason-graves-first-blood.mp3");
				} else {
					SendMessageTD(playerid, "Diner ~r~locked");
					PlayerPlaySound(playerid, 1135, 0.0,0.0,0.0);
				}
				SetVehicleParamsEx(QuestVehicles[13], 0, 0, 0, 0, 0, 0, 0);
				Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_PICKUP, true);
				//PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) {
					if(GetPVarInt(playerid, "Vehicle")) DestroyVehicle(GetPVarInt(playerid, "Vehicle"));
				}
			}
		}
		// Chapter 2
		if(GetPVarInt(playerid, "EventPart") == 2)
		{
			if(GetPVarInt(playerid, "EventKeys") != -1 && GetPVarInt(playerid, "EventKeys") < 8)
			{
				format(gametext, sizeof(gametext), 
				"~w~Explore the village find evidence~n~Collected evidence ~g~%d/8~w~",
				GetPVarInt(playerid, "EventKeys"));
				TextDrawSetString(TDCustomHud[playerid], gametext); 
				TextDrawShowForPlayer(playerid, TDCustomHud[playerid]);
			}
			
			if(GetPVarInt(playerid, "EventKeys") >= 8)
			{
				//PlayerPlaySound(playerid, 6002, 0.5, 0.5, 0.5);
				SendMessageTD(playerid,
				"All right. I've gathered enough evidence, it's time to head back the diner");
				TextDrawSetString(TDCustomHud[playerid], "~w~Time to head back the diner"); 
				SetPlayerCheckpoint(playerid, -386.9844,2228.3418,42.3958, 2.0);
				SetDynamicObjectPos(bloodtext, -389.469207, 2227.789306, 43.319625);
			}
			
			if(IsPlayerInRangeOfPoint(playerid, 1.5, 678.0609,-465.0172,-25.6172))
			{
				SetPlayerPos(playerid, -381.2145,2240.5601,42.3440);
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, QWorld);
				SetPlayerFacingAngle(playerid, 102.48);
				SetVehicleParamsEx(QuestVehicles[13], 0, 1, 0, 0, 0, 0, 0);
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid,
				"http://minty.club/artist/jason-graves/dead-space-theme/jason-graves-dead-space-theme.mp3");
			}
			if(GetPlayerInterior(playerid) == 1)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2, 684.6785,-454.4262,-25.6172))
				{
					SendMessageTD(playerid, "Is anybody here?");
				}
				if(IsPlayerInRangeOfPoint(playerid, 1, 678.2054,-462.8816,-25.6172))
				{
					SendMessageTD(playerid, "No swiming? Ok");
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 1, -361.7435,2222.2737,43.0078))
			{
				SendMessageTD(playerid, "Church ~r~locked");
				PlayerPlaySound(playerid, 1135, 0.0,0.0,0.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 5, -345.3675,2214.6577,42.4844))
			{
				SendMessageTD(playerid, "Are there too many graves for a small village?",10);
			}
			if(IsPlayerInRangeOfPoint(playerid, 15, -459.5185,2291.3589,56.6419))
			{
				SendMessageTD(playerid, "I should definitely explore the village first");
				SetPlayerFacingAngle(playerid, 208.09);
				GameTextForPlayer(playerid, "~r~WRONG WAY", 5000, 4);
			}
			if(IsPlayerInRangeOfPoint(playerid, 15, -264.1015,2228.1223,58.4318))
			{
				SendMessageTD(playerid, "I should definitely explore the village first");
				SetPlayerFacingAngle(playerid, 100.35);
				GameTextForPlayer(playerid, "~r~WRONG WAY", 5000, 4);
			}
			if(IsPlayerInRangeOfPoint(playerid, 5, -425.3524,2135.2771,45.6189))
			{
				SendMessageTD(playerid, "The car has definitely survived many accidents");
				//PlayerPlaySound(playerid, 6002, 0.5, 0.5, 0.5);
				PlayerPlaySound(playerid, 1140, x+2,y+2,z-2);
			}
			if(IsPlayerInRangeOfPoint(playerid, 2, -351.6727,2207.3240,42.4844))
			{
				SendMessageTD(playerid, "Who turned on the headlights? Anybody here?");
				PlayerPlaySound(playerid, 2201, 0.0, 0.0, 0.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 2, -399.2897,2186.0264,41.885))
			{
				SetVehicleParamsEx(QuestVehicles[17], 0, 0, 1, 0, 0, 0, 0);
				SendMessageTD(playerid, "damn it");
			}
			if(IsPlayerInRangeOfPoint(playerid, 2, -382.3897,2196.5068,42.4141))
			{
				SendMessageTD(playerid, "Let's see what's on the roof");
			}
			if(IsPlayerInRangeOfPoint(playerid, 3, -433.9363,2184.2710,42.3573))
			{
				PlayerPlaySound(playerid, 6200, 0.0, 0.0, 0.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 4, -358.0026,2215.3257,42.4844))
			{
				PlayerPlaySound(playerid, 1101, 0.0, 0.0, 0.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 5, -411.4034,2234.9304,42.4297))
			{
				SetVehiclePos(QuestVehicles[15], -417.9808,2207.4709,46.3440);
				PlayerPlaySound(playerid, 1101, 0.0, 0.0, 0.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 3, 312.9401,2273.1226,69.7747))
			{
				PlayerPlaySound(playerid, 1101, 0.0, 0.0, 0.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 5, -316.1828,2275.7852,69.8917))
			{
				PlayerPlaySound(playerid, 1101, 0.0, 0.0, 0.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 2, -429.8037,2237.0261,42.4297))
			{
				//PlayerPlaySound(playerid, 2034, 0.0, 0.0, 0.0);// EL CASTILLO DEL DIABLO
				PlayerPlaySound(playerid, 2002, 0.0, 0.0, 0.0);// ARCO DEL OESTE
			}
			if(IsPlayerInRangeOfPoint(playerid, 10, -382.0712,2240.6841,42.1380))
			{
				PlayerPlaySound(playerid, 1101, -391.7376,2226.9802,42.4258);
			}
 			if(IsPlayerInRangeOfPoint(playerid, 4, -389.1913,2227.9333,42.4297))
			{
				SendMessageTD(playerid, "Oh shit, what the fuck!");
				SetPVarInt(playerid, "EventPart", 3);
				GameTextForPlayer(playerid, "~w~Chapter 3~n~Let's climb the mountains", 5000, 4);
				TextDrawSetString(TDCustomHud[playerid], "~w~Let's climb the mountains"); 
				SendMessageTD(playerid,
				"Arco del oeste .. it's a mountainous area nearby");
				PlayerPlaySound(playerid, 2206, 0.0, 0.0, 0.0);
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid,"http://minty.club/artist/jason-graves/the-shadow-of-the-mountain-main-theme/jason-graves-the-shadow-of-the-mountain-main-theme.mp3");
				SetPVarInt(playerid, "EventKeys", -1);
				SetPlayerCheckpoint(playerid, -460.7714,2296.2290,57.1626, 2.0);
			}
		}
		// Chapter 3
		if(GetPVarInt(playerid, "EventPart") == 3)
		{
			if(IsPlayerInRangeOfPoint(playerid, 7, -480.4099,2194.2107,41.8599))
			{
				PlayerPlaySound(playerid, 32402, 0,0,0);
				SetPlayerHealth(playerid, 0);
				SetPlayerAttachedObject(playerid, 0, 18668, 1, 0.000000, 0.201000,
				0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0); // 18668 
			}
			if(IsPlayerInRangeOfPoint(playerid, 3, -504.5175,2369.0361,75.8454))
			{
				if(GetPVarInt(playerid, "FinalKey") > 0)
				{
					SendMessageTD(playerid, "Good thing I found the key earlier");
					SetPlayerPos(playerid, -680.5634,2448.1501,116.9608);
					SetPlayerFacingAngle(playerid, 347.7801);
				} else {
					SendMessageTD(playerid, "Find the key, it must be somewhere nearby");
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 8, -518.0287,2358.5205,71.8915))
			{
				SendMessageTD(playerid, "Oh this car will not take me to the mountains");
			}
			if(IsPlayerInRangeOfPoint(playerid, 4, -538.9906,2357.0210,74.4718))
			{
				SendMessageTD(playerid, "Unfortunately you have to climb the mountains on foot");
			}
			if(IsPlayerInRangeOfPoint(playerid, 6, -573.2458,2366.0593,79.2342))
			{
				//CreateExplosion(-594.265869, 2361.586181, 96.171546, 2, 15.0);
				CreateExplosion(-591.495544, 2355.004394, 97.351554, 2, 15.0);
				if(!GetPVarInt(playerid, "EventDynamite"))
				{
					SendMessageTD(playerid, "Rock avalanche.. just fucking wonderful");
				} else {
					SendMessageTD(playerid, "Rock avalanche.. again?");
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 6, -456.7357,2294.7239,55.7801))
			{
				SendMessageTD(playerid,"I dont know what awaits me there, but lets go to the mountains");
				SetPlayerCheckpoint(playerid, -718.1666,2440.9080,126.0664, 2.0);
				SetDynamicObjectPos(bloodtext, -397.627777, 2225.707519, 43.319625);
			}
			if(IsPlayerInRangeOfPoint(playerid, 5,-646.3658,2443.4087,105.9889))
			{
				if(GetPVarInt(playerid, "EventDynamite") == 1)
				{
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -655.2972,2448.3833,109.0164, 2.0);
					SendMessageTD(playerid, "Come closer and plant dynamite");
				} else if(GetPVarInt(playerid, "EventDynamite") == 2) {
					SetDynamicObjectPos(dynrock[0],-659.065124, 2445.905761, 113.540023-200);
					SetDynamicObjectPos(dynrock[1],-666.288208, 2446.145019, 113.918487-200);
					CreateExplosion(-655.2972,2448.3833,109.0164, 2, 15.0);
					SetPlayerCheckpoint(playerid, -718.1666,2440.9080,126.0664, 2.0);
					SendMessageTD(playerid, "Passage is clear, move on");
					SetPVarInt(playerid, "EventDynamite",3);
				} else {
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -507.0535,2367.3384,71.5788, 2.0);
					SendMessageTD(playerid,
					"Need dynamite to blow up these mountains, somewhere I saw dynamite nearby");
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2, -655.2972,2448.3833,109.0164))
			{
				if(GetPVarInt(playerid, "EventDynamite") == 1)
				{
					DisablePlayerCheckpoint(playerid);
					SendMessageTD(playerid, "Run away now it will explode!!");
					SetPVarInt(playerid, "EventDynamite",2);
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 5, -674.3439,2461.5950,114.5046))
			{
				SendMessageTD(playerid, "These mines were closed many years ago..");
			}
			if(IsPlayerInRangeOfPoint(playerid, 20, -715.7057,2435.6230,126.7399))
			{
				//SendMessageTD(playerid, "Oh shit, what the fuck!");
				SetPVarInt(playerid, "EventPart", 4);
				GameTextForPlayer(playerid, "~w~Chapter 4~n~Cursed place", 5000, 4);
				TextDrawSetString(TDCustomHud[playerid], "~w~Need to look around here"); 
				SendMessageTD(playerid,	"Need to look around here");
				SetDynamicObjectPos(dynrock[0],-659.065124, 2445.905761, 113.540023);
				SetDynamicObjectPos(dynrock[1],-666.288208, 2446.145019, 113.918487);				
				SetDynamicObjectPos(rocks[22], -657.324279, 2451.458496, 109.441520);
				SetDynamicObjectPos(rocks[23], -657.324279, 2451.458496, 111.481491);
				SetDynamicObjectPos(rocks[24], -657.164184, 2451.696777, 113.657211);
				SetVehicleParamsEx(QuestVehicles[11], 0, 0, 0, 0, 0, 1, 0);
				SetPlayerCheckpoint(playerid, -783.7548,2433.2034,157.1274, 2.0);
			}
		}
		// Chapter 4
		if(GetPVarInt(playerid, "EventPart") == 4)
		{
			if((QuestTick % 5) == 0)
			{
				SetDynamicActorVirtualWorld(QuestActors[12], QWorld-1);
				SetDynamicActorVirtualWorld(QuestActors[13], QWorld-1);
				SetDynamicActorVirtualWorld(QuestActors[14], QWorld-1);
				SetDynamicActorVirtualWorld(QuestActors[15], QWorld-1);
			}
			
			if(IsPlayerInRangeOfPoint(playerid, 5, -688.4217,2332.8640,130.9399))
			{
				SendMessageTD(playerid, "Heavy legacy of industrial history");
				SetVehicleParamsEx(QuestVehicles[11], 0, 0, 0, 0, 0, 1, 0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 1.5, -717.8851,2341.6113,126.5856))
			{
				SetVehicleParamsEx(QuestVehicles[11], 0, 0, 0, 0, 0, 0, 0);
			}
/* 			if(IsPlayerInRangeOfPoint(playerid, 4, -753.7021,2329.6235,125.0120))
			{
				SendMessageTD(playerid, "Oh no, please!");
			} */
			if(IsPlayerInRangeOfPoint(playerid, 2, -665.5904,2314.9294,138.7191))
			{
				PlayerPlaySound(playerid, 3200, 0, 0, 0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 4, -646.5292,2308.7495,135.1596))
			{
				SendMessageTD(playerid, "Sheriff's rancher, maybe i find something inside.. oh yeah it's a shotgun");
				SetPlayerAttachedObject(playerid, 2, 349, 1, 0.204999, -0.120999, -0.106000, -29.299983, -156.300003, 0.000000,  1.000000, 1.000000, 1.000000); // 349
				GameTextForPlayer(playerid, "~g~SECRET ~w~FOUND", 5000, 4);
				//PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				SetPVarInt(playerid, "FinalWeapon", 25);
			}
			if(IsPlayerInRangeOfPoint(playerid, 4, -742.7574,2316.8237,129.9031))
			{
				SendMessageTD(playerid, "There is no way back, only up!");
			}
			if(IsPlayerInRangeOfPoint(playerid, 4, -810.2864,2364.7285,151.4670))
			{
				PlayerPlaySound(playerid, 2200, 0.0, 0.0, 0.0); //kilkillkill
			}
			if(IsPlayerInRangeOfPoint(playerid, 4, -800.9335,2397.7776,155.3655))
			{
				SendMessageTD(playerid, "OH NO! no-no-no... please..");
				SetDynamicActorVirtualWorld(QuestActors[12], QWorld);
				SetDynamicActorVirtualWorld(QuestActors[13], QWorld);
				SetDynamicActorVirtualWorld(QuestActors[14], QWorld);
				SetDynamicActorVirtualWorld(QuestActors[15], QWorld);
			}
			if(IsPlayerInRangeOfPoint(playerid, 3, -796.6382,2415.1780,156.8356))
			{
				SendMessageTD(playerid, "Sheriff is dead!");
			}
			if(IsPlayerInRangeOfPoint(playerid, 4, -774.0326,2419.4551,157.0963))
			{
				PlayerPlaySound(playerid, 2222, 0.0, 0.0, 0.0); //kilkillkill
			}
			if(IsPlayerInRangeOfPoint(playerid, 1.5, -782.3727,2434.9351,157.2514))
			{
				SetPVarInt(playerid, "EventPart", 5);
				SetPVarInt(playerid, "QuestManiacHealth",250);
				GameTextForPlayer(playerid, "~w~Chapter 5~n~Terrible Truth", 5000, 4);
				TextDrawSetString(TDCustomHud[playerid], "~w~"); 
				SendMessageTD(playerid,	"What the hell.. Should have taken a weapon instead of a camera");
				SetPlayerPos(playerid, 303.8141,309.6032,1003.3047);
				SetPlayerInterior(playerid, 4);
				StopAudioStreamForPlayer(playerid);
				PlayAudioStreamForPlayer(playerid,"http://minty.club/artist/jason-graves/apoplexia/jason-graves-apoplexia.mp3");
				SetDynamicObjectRot(dyndoor[0], 0.000000, 0.000000, -90.0);
				SetDynamicActorVirtualWorld(QuestActors[4], QWorld);
			}
		}
		// Chapter 5
		if(GetPVarInt(playerid, "EventPart") == 5)
		{
			if(GetPVarInt(playerid, "FireDamage")) SetPlayerHealth(playerid, health-1.0);
			
			if(GetPVarInt(playerid, "FireDamage") > 0 && GetPVarInt(playerid, "QuestManiacHealth") > 1)
			{
				GetPlayerPos(playerid, x,y,z);
				if((QuestTick % 5) == 0 && z >= 1001.0)
				{
					SetDynamicActorPos(QuestActors[5], x+1,y+1,z);
					GetPlayerHealth(playerid, health);
					SetPlayerHealth(playerid, health-1.5);
					PlayerPlaySound(playerid, 1130, 0.0,0.0,0.0);
					
					switch(random(5))
					{
						case 0: SendMessageTD(playerid,	"Not again!!");
						case 1: SendMessageTD(playerid,	"Fuck off!!");
						case 2: SendMessageTD(playerid,	"Go to Hell!!");
						case 3: SendMessageTD(playerid,	"Aaauu!");
						case 4: SendMessageTD(playerid,	"Get away from me!");
						default: SendMessageTD(playerid, "Go ahead!");
					}
				}
			}
			
			if(IsPlayerInRangeOfPoint(playerid, 1.5, 302.0576,305.8484,999.1484))
			{
				if(GetPVarInt(playerid, "FireDamage") != 1)
				{
					SendMessageTD(playerid, "Hey! are you okay?");
					SetDynamicActorVirtualWorld(QuestActors[4], QWorld-1);
					SetDynamicActorPos(QuestActors[5], 301.1249,309.4857,1003.3047);
					SetDynamicActorFacingAngle(QuestActors[5], -90.0);
					SetDynamicObjectPos(fireobj[0], 305.246826, 307.154388, 997.398132);
					SetDynamicObjectPos(fireobj[1], 305.246826, 304.274414, 997.818237);
					SetDynamicObjectPos(fireobj[2], 303.406829, 302.454559, 997.818237);
					SetDynamicObjectPos(fireobj[3], 300.376831, 302.454559, 997.818237);
					SetDynamicObjectPos(fireobj[4], 300.036865, 305.274505, 997.818237);
					SetDynamicObjectPos(fireobj[5], 300.036865, 307.994506, 997.818237);
					SetDynamicObjectPos(fireobj[6], 302.972320, 314.825866, 998.678588);
					SetDynamicObjectPos(fireobj[7], 308.192260, 314.825866, 1001.919311);
					SetDynamicObjectPos(fireobj[8], 306.032501, 311.015991, 1001.919311);
					SetDynamicObjectPos(fireobj[9], 309.092498, 306.476074, 1001.919311);
					SetDynamicObjectPos(fireobj[10], 303.282531, 304.456115, 1001.919311);
					SetDynamicObjectRot(dyndoor[0], 0.000000, 0.000000, -0.19);
					TextDrawSetString(TDCustomHud[playerid], "~w~Get out of here - shoot at the door");
					SetPVarInt(playerid, "DoorDamage", 0);
					if(GetPVarInt(playerid, "FinalWeapon") == 26) GivePlayerWeapon(playerid, 26, 64);
					if(GetPVarInt(playerid, "FinalWeapon") == 25) GivePlayerWeapon(playerid, 25, 64);
					if(GetPVarInt(playerid, "FinalWeapon") == 24) GivePlayerWeapon(playerid, 24, 64);
					SetPVarInt(playerid, "FireDamage",1);
					SetPlayerCheckpoint(playerid, 300.0914,313.3493,999.1484, 2.0);
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 1, 302.4042,301.5909,999.1484)
			|| IsPlayerInRangeOfPoint(playerid, 1, 303.2656,314.8608,1000.5327)
			|| IsPlayerInRangeOfPoint(playerid, 1, 309.0540,306.5614,1003.3047))
			{
				if(GetPVarInt(playerid, "FireDamage") > 0)
				{
					GetPlayerPos(playerid, x,y,z);
					CreateExplosionForPlayer(playerid, x,y,z, 1, 5.0);
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2, 299.7797,310.0469,1003.3047))
			{
				if(GetPVarInt(playerid, "FireDamage") > 0)
				{
					DeletePVar(playerid, "FireDamage");
					DeletePVar(playerid, "DoorDamage");
					SetPVarInt(playerid, "EventPart", 6);
					GameTextForPlayer(playerid, "~w~Chapter 6~n~Run away", 5000, 4);
					TextDrawSetString(TDCustomHud[playerid],
					"~w~Run away from the maniac"); 
					SendMessageTD(playerid,
					"What the hell.. Should have taken a weapon instead of a camera");
					StopAudioStreamForPlayer(playerid);
					PlayAudioStreamForPlayer(playerid,"https://minty.club/artist/jason-graves/the-nexus/jason-graves-the-nexus.mp3");
					SetPlayerPos(playerid, -784.8062,2431.7668,157.1398);
					SetPlayerFacingAngle(playerid, 164.2925);
					SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld(playerid, QWorld);
					SetDynamicActorVirtualWorld(QuestActors[4], QWorld);
					SetDynamicObjectPos(rocks[25], -798.145874, 2312.252441, 142.143875);
					SetDynamicObjectPos(rocks[26], -797.044921, 2310.281005, 141.583877);
					SetDynamicObjectPos(rocks[27], -799.825866, 2309.751953, 142.143875);
					SetDynamicObjectPos(rocks[28], -777.395263, 2309.751953, 135.903976);
					SetDynamicObjectPos(rocks[29], -777.395263, 2307.611572, 135.903976);
					SetDynamicObjectPos(rocks[30], -777.395263, 2305.381103, 135.903976);
					SetDynamicObjectPos(rocks[31], -777.645507, 2312.011230, 135.903976);
				}
			}
		}
		// Chapter 6
		if(GetPVarInt(playerid, "EventPart") == 6)
		{
			if((QuestTick % 20) == 0 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
			{
				GetPlayerPos(playerid, x,y,z);
				SetDynamicActorPos(QuestActors[2], x+1,y+1,z);
				GetPlayerHealth(playerid, health);
				SetPlayerHealth(playerid, health-5.0);
				PlayerPlaySound(playerid, 1130, 0.0,0.0,0.0);
				
				switch(random(5))
				{
					case 0: SendMessageTD(playerid,	"Not again!!");
					case 1: SendMessageTD(playerid,	"Fuck off!!");
					case 2: SendMessageTD(playerid,	"Go to Hell!!");
					case 3: SendMessageTD(playerid,	"Aaauu!");
					case 4: SendMessageTD(playerid,	"Get away from me!");
					default: SendMessageTD(playerid, "Go ahead!");
				}
			}
			SetVehicleVirtualWorld(QuestVehicles[18], QWorld);
			
			if(IsPlayerInRangeOfPoint(playerid, 1.5, -782.3727,2434.9351,157.2514))
			{
				SendMessageTD(playerid,	"I will never go back to this place!");
			}
			if(IsPlayerInRangeOfPoint(playerid, 6, -787.2824,2430.8315,157.1527))
			{
				SendMessageTD(playerid,	"Time to make the hard choice. Fly away or continue the story", 10);
			}
			if(IsPlayerInRangeOfPoint(playerid, 2, -780.6089,2410.9917,157.0999))
			{
				SendMessageTD(playerid,	"Haven't flown this thing in a long time");
			}
			if(IsPlayerInRangeOfPoint(playerid, 6, -800.6015,2395.3735,155.1161))
			{
				//SendMessageTD(playerid,	"Something is calling me back to the village");
				SendMessageTD(playerid,	"Gotta find a way to leave this accursed place");
				DisablePlayerCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, -656.8154,2324.6335,138.4868, 2.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 10, -756.8497,2314.7163,132.3745))
			{
				if(GetPVarInt(playerid, "FinalKey") > 0)
				{
					SendMessageTD(playerid,	"I have the key to the mine, I'll get down faster");
				} else {
					SendMessageTD(playerid, "Try Find mine key, it must be somewhere nearby");
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -736.9871,2368.6479,125.5068, 2.0);
				}
				CreateExplosion(-776.7102,2308.8135,136.8032, 2, 5.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 15, -719.5264,2441.8540,125.9361))
			{
				GameTextForPlayer(playerid, "~r~WRONG WAY", 5000, 4);
			}
			if(IsPlayerInRangeOfPoint(playerid, 2, -717.7759,2341.0076,126.5653))
			{
				GetPlayerPos(playerid, x,y,z);
				CreateExplosionForPlayer(playerid, x,y,z, 11, 5.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 3, -655.2765,2325.0969,138.4015)) //end
			{
				if(GetPVarInt(playerid, "FinalKey") > 0)
				{
					SetPVarInt(playerid, "EventPart", 7);
					GameTextForPlayer(playerid, "~w~Chapter 7~n~Leave the village", 5000, 4);
					TextDrawSetString(TDCustomHud[playerid], "~w~Find a way to leave the village"); 
					StopAudioStreamForPlayer(playerid);
					PlayAudioStreamForPlayer(playerid,"https://minty.club/artist/jason-graves/credits/jason-graves-credits.mp3");
					SetPlayerPos(playerid, -408.1884,2315.4243,50.9399);
					SetPlayerFacingAngle(playerid, 200.1921);
					SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld(playerid, QWorld+1);
					SetPlayerCheckpoint(playerid, -480.3841,2190.2603,41.8672, 2.0);
					SetVehicleVirtualWorld(QuestVehicles[22], QWorld+1);
				} else {
					SendMessageTD(playerid, "Find the key, it must be somewhere nearby");
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 7, -668.2529,2325.6401,136.8388))
			{
				SendMessageTD(playerid, "Need shelter, try to hide here");
			}
			if(IsPlayerInRangeOfPoint(playerid, 6, -721.4399,2364.4954,126.9980))
			{
				SendMessageTD(playerid, "What's going on, i'm in hell?");
			}
			if((QuestTick % 30) == 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				GetPlayerPos(playerid, x,y,z);
				CreateExplosionForPlayer(playerid, x,y,z, 2, 20.0);
				EndQuest(playerid, 1);
			}
		}
		// Chapter 7
		if(GetPVarInt(playerid, "EventPart") == 7)
		{
			if(IsPlayerInRangeOfPoint(playerid, 3, 479.7727,2194.4080,41.8599)) 
			{
				SendMessageTD(playerid, "Where all boats?");
			}
			if(IsPlayerInRangeOfPoint(playerid, 3, -433.9363,2184.2710,42.3573))
			{
				PlayerPlaySound(playerid, 6200, 0.0, 0.0, 0.0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.5, -341.3934,2230.6277,42.4919)) 
			{
				SendMessageTD(playerid, "In the grave... my corpse");
				EndQuest(playerid, 5);
			}
			if(IsPlayerInRangeOfPoint(playerid, 6, -345.7212,2221.5273,42.4863))
			{
				SendMessageTD(playerid, "Wait, I see people! They look strange");
			}
			if(IsPlayerInRangeOfPoint(playerid, 6, -344.3505,2242.2844,42.4844)) 
			{
				SendMessageTD(playerid, "Wait, I see people! They look strange");
			}
			if(IsPlayerInRangeOfPoint(playerid, 6, -386.2534,2246.2778,42.0938))
			{
				SendMessageTD(playerid,	"Whole main street is on fire");
			}
			if(IsPlayerInRangeOfPoint(playerid, 6, -472.7353,2194.7078,46.0527))
			{
				SendMessageTD(playerid,	"Time to get out of here");
			}
			if(IsPlayerInRangeOfPoint(playerid, 6, -382.5864,2233.3040,42.0938))
			{
				SendMessageTD(playerid,	"The area looks definitely different than last time");
			}
			if(IsPlayerInRangeOfPoint(playerid, 6, -517.6089,2183.2913,40.1549))
			{
				SendMessageTD(playerid, "Water is cold, if the boat breaks I won't survive");
			}
			if(IsPlayerInRangeOfPoint(playerid, 10, -404.0629,2293.9229,39.8215))
			{
				SendMessageTD(playerid, "Damn fog, can't see anything");
			}

			if((QuestTick % 30) == 0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				GetPlayerPos(playerid, x,y,z);
				CreateExplosionForPlayer(playerid, x,y,z, 2, 20.0);
				EndQuest(playerid, 4);
			}
		}
	}
	return true;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT) 
    {
		CallRemoteFunction("FirstPersonMode", "ib", playerid, true);
    }
	if(oldstate == PLAYER_STATE_SPAWNED && newstate == PLAYER_STATE_ONFOOT)
	{
		if(GetPVarInt(playerid, "EventPart") > -1)
		{
			SetPlayerSkin(playerid, 295);
			SetPlayerWeather(playerid, 8);
			SetPlayerTime(playerid, 23, 0);
			if(GetPVarInt(playerid, "EventPart") < 6) ResetPlayerWeapons(playerid);
			if(GetPVarInt(playerid, "EventPart") == 5) SetPlayerInterior(playerid, 4);
			SendMessageTD(playerid, "I had a terrible dream before ..bad feeling");
			if(GetPlayerInterior(playerid) != 1) SetPlayerVirtualWorld(playerid, QWorld);
			CallRemoteFunction("FirstPersonMode", "ib", playerid, true);
		}
	}
	return true;
}

public OnPlayerShootDynamicObject(playerid, weaponid, objectid, Float:x, Float:y, Float:z)
{
	if(objectid == dyndoor[0])
	{
		if(GetPVarInt(playerid, "DoorDamage") < 300)
		{
			switch(weaponid)
			{
				case 24: SetPVarInt(playerid, "DoorDamage", GetPVarInt(playerid, "DoorDamage") + 75);
				case 25: SetPVarInt(playerid, "DoorDamage", GetPVarInt(playerid, "DoorDamage") + 100);
				case 26: SetPVarInt(playerid, "DoorDamage", GetPVarInt(playerid, "DoorDamage") + 100);
				case 33: SetPVarInt(playerid, "DoorDamage", GetPVarInt(playerid, "DoorDamage") + 65);
				default: SetPVarInt(playerid, "DoorDamage", GetPVarInt(playerid, "DoorDamage") + 50);
			}
				
			switch(random(3))
			{
				case 0: GameTextForPlayer(playerid, "~w~Arghh..", 2000, 4);
				case 1: GameTextForPlayer(playerid, "~w~Fucking door", 2000, 4);
				case 2: GameTextForPlayer(playerid, "~w~Move", 2000, 4);
				default: GameTextForPlayer(playerid, "~w~Some more", 2000, 4);
			}
		} else {
			DeletePVar(playerid, "DoorDamage");
			SetDynamicObjectRot(dyndoor[0], 0.000000, 0.000000, 90.0);
		}
	}
	return true;
}

public OnPlayerEnterCheckpoint(playerid)
{
	DisablePlayerCheckpoint(playerid);
	return true;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	new Float:health;
	if(GetPVarInt(playerid, "EventPart") < 2) 
	{
		SendMessageTD(playerid, "I should definitely explore the village first");
		return false;
	}
	
	if(pickupid == QuestPickups[0])
	{
		SendMessageTD(playerid,"~w~Key.. maybe it will open the door to the mine"); 
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
		SetPVarInt(playerid, "FinalKey", 1);
	}
	if(pickupid == QuestPickups[1])
	{
		SendMessageTD(playerid,"~w~Check the items in the bag later"); 
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[2])
	{
		SendMessageTD(playerid,"~w~Apparently I can't find any other weapon here"); 
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[3])
	{
		SendMessageTD(playerid,"~w~Tools might come in handy"); 
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[4])
	{
		SendMessageTD(playerid,"~w~Life jacket, will have to put in the boat later");
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[5])
	{
		SendMessageTD(playerid,"~w~Things of the victim, there is blood on them");
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[6])
	{
		SendMessageTD(playerid,"~w~No doubt - this is the murder weapon");
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[7])
	{
		SendMessageTD(playerid,"~w~Camera is broken, i'm fucking lucky");
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[8])
	{
		SendMessageTD(playerid,"~w~Police radio, let's try to get in touch. And it doesn't work either.");
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[9])
	{
		SendMessageTD(playerid,"~w~Hmm, empty clip");
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[10])
	{
		SendMessageTD(playerid,"~w~Sheriff's badge, things are definitely bad");
		//SendMessageTD(playerid,"~w~Someone wanted to hide the camera in the doghouse");
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[11])
	{
		SendMessageTD(playerid,"~w~Crowbar with traces of blood");
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[12])
	{
		SendMessageTD(playerid,"~w~Oh a flashlight! that would come in handy. Damn, no batteries");
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[13])
	{
		SendMessageTD(playerid,"~w~Scoot Wilson driver's license");
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[14])
	{
		SendMessageTD(playerid,"~w~I feel like I could use a weapon, but it's rusty and unusable");
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[15])
	{
		SendMessageTD(playerid,"~w~The last entry in the journal was made yesterday");
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[16])
	{
		SendMessageTD(playerid,"~w~FBI Card.. even the federals were here");
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
	}
	if(pickupid == QuestPickups[17])
	{
		SendMessageTD(playerid,"~w~police holster, a useful find");
		SetPVarInt(playerid, "EventKeys", GetPVarInt(playerid, "EventKeys") + 1);
		SetPlayerAttachedObject(playerid, 1, 19773, 8, 0.102999, -0.030000, 0.064999, 0.000000, -83.600044, -179.399993,  1.000000, 1.000000, 1.000000); // 19773
		SetPVarInt(playerid, "FinalWeapon", 24);
	}
	if(pickupid == QuestPickups[18])
	{
		if(GetPVarInt(playerid, "EventPart") == 6) SetPlayerCheckpoint(playerid, -655.9762,2324.8398,138.4403, 2.0);
		SendMessageTD(playerid,"~w~Key.. maybe it will open the door to the mine");
		SetPVarInt(playerid, "FinalKey", 1);
	}
	if(pickupid == QuestPickups[19])
	{
		SendMessageTD(playerid,"~w~I can break down the door with this gun");
		GivePlayerWeapon(playerid, 33, 25);
	}
	if(pickupid == QuestPickups[20] || pickupid == QuestPickups[21])
	{
		SendMessageTD(playerid,"~w~I feel a little better");
		GetPlayerHealth(playerid, health);
		if(health <= 50) SetPlayerHealth(playerid, health+50.0);
		else SetPlayerHealth(playerid, 100.0);
	}
	if(pickupid == QuestPickups[22])
	{
		SendMessageTD(playerid,"~w~Clear the passage with dynamite");
		SetPVarInt(playerid, "EventDynamite", 1);
	}
	if(pickupid == QuestPickups[23] || pickupid == QuestPickups[24])
	{
		SendMessageTD(playerid,"~w~Blow up rocks with these grenades");
		GivePlayerWeapon(playerid, 16, 3);
	}
	return true;
}

public OnPlayerGiveDamageDynamicActor(playerid, actorid, Float:amount, weaponid, bodypart)
{
	if(actorid == QuestActors[5])
	{
		if(GetPVarInt(playerid, "QuestManiacHealth") > 1)
		{
			SetPVarInt(playerid, "QuestManiacHealth",
			GetPVarInt(playerid, "QuestManiacHealth") - floatround(amount));
			switch(random(3))
			{
				case 0: SendMessageTD(playerid,"~w~Good shoot");
				case 1: SendMessageTD(playerid,"~w~Take it");
				case 2: SendMessageTD(playerid,"~w~Die");
			}
		}
	}
	return true;
}

stock EndQuest(playerid, code = 0)
{
	// code -1 is default player exit via /exit cmd
	SetPVarInt(playerid, "EventPart", -1);
	SetPVarInt(playerid, "EventTime", 0);
	SetPVarInt(playerid, "EventKeys", 0);
	SetPVarInt(playerid, "FireDamage", 0);
	SetPVarInt(playerid, "FinalKey", 0);
	SetPVarInt(playerid, "FinalWeapon", 0);
	SetPVarInt(playerid, "DoorDamage", 0);
	SetPVarInt(playerid, "EventDynamite", 0);
	SetPVarInt(playerid, "Event", -1);
	SetPVarInt(playerid, "NewClient", -1);
	CallRemoteFunction("Hud", "ib", playerid, true);
	CallRemoteFunction("FirstPersonMode", "ib", playerid, false);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 999);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 999);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 999);
	DestroyVehicle(GetPVarInt(playerid, "Vehicle"));
	SetPlayerWeather(playerid, 1); 
	SetPlayerTime(playerid, 12, 0);
	SetPlayerPos(playerid,-1221.0070,-70.8040,28.3859);
	SetPlayerFacingAngle(playerid,133.3912);
	SetPlayerVirtualWorld(playerid, 0);
	StopAudioStreamForPlayer(playerid);
	TextDrawHideForPlayer(playerid, TDCustomHud[playerid]);
	TextDrawHideForPlayer(playerid, TDQuestInfo[playerid]);
	foreach(Player, i) SetPlayerMarkerForPlayer(playerid, 1, 0xFFFF0070);
	SetPlayerTeam(playerid, 2);
	ResetPlayerWeapons(playerid);
	switch(code)
	{
		case 0: SendClientMessage(playerid, 0xF5511CAA, "It's a pity. But you can try another time");
		case 1:
		{
			GameTextForPlayer(playerid,
			"~w~Congratulations~n~you completed the halloween quest", 5000, 4);
			SendClientMessage(playerid, 0xF5511CAA,
			"Your plane did not reach the destination, but what does it really matter");
			//PlayerPlaySound(playerid, 1183, 0,0,0);
		}
		case 2:
		{
			GameTextForPlayer(playerid,
			"~w~You completed the halloween quest", 5000, 4);
			SendClientMessage(playerid, 0xF5511CAA, "You burned alive");
		}
		case 3:
		{
			GameTextForPlayer(playerid,
			"~w~You completed the halloween quest", 5000, 4);
			SendClientMessage(playerid, 0xF5511CAA,
			"You got stabbed and then eaten by cannibals, not a bad ending for your story");
		}
		case 4:
		{
			GameTextForPlayer(playerid,
			"~w~Congratulations~n~you completed the halloween quest", 5000, 4);
			SendClientMessage(playerid, 0xF5511CAA, "Your boat sank and fed the hungry fish");
		}
		case 5:
		{
			GameTextForPlayer(playerid,
			"~w~Congratulations~n~you completed the halloween quest", 5000, 4);
			SendClientMessage(playerid, 0xF5511CAA, "You realized that you have been dead for a long time");
		}
	}
}

forward HideMessageTD(playerid);
public HideMessageTD(playerid)
{
	TextDrawHideForPlayer(playerid, TDQuestInfo[playerid]);
	return true;
}

stock SendMessageTD(playerid, gametext[], seconds = 5)
{
	TextDrawSetString(TDQuestInfo[playerid], gametext);   
	TextDrawShowForPlayer(playerid, TDQuestInfo[playerid]);
	SetTimerEx("HideMessageTD", seconds*1000, false, "i", playerid);
}