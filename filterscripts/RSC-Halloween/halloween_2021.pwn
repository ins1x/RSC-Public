/*
	Filterscript: Halloween Quests
	Created specifically for RSC server 
	CW/TG gamemode powered by Russian Sawn-off Community 2021
	find us: https://vk.com/sawncommunity
	Author: 1NS 
	Description: Creates 3 unique locations available for solo and joint passage.
	Locations were created by the author from 0 and inspired by various games.
*/
	
#include <a_samp>
#include <foreach>

new BossHealth = 3500; // Final boss health
new QuestTimer; // Update timer
new PumpkinPickups[20]; // Chapter 1 pumpkin pickups
new RefillPickup; // Boss level upgrade
new HalloweenActors[4]; // All fs actors
new BossEye1, BossEye2; //Boss eyes
new BossRedObjects[5]; // Red lights
new DynamitePickup, DynamitePickup2; //chapter 3 pickups
new explodetick = 0; //explode var
new Text: TDTimer[MAX_PLAYERS]; // Time and game info textdraw
new Float: syncX, Float: syncY, Float: syncZ, Float: syncA; // resync data

public OnFilterScriptInit()
{ 
	SetWeather(20);
	SetWorldTime(6);
	QuestTimer = SetTimer("QuestUpdate", 1000, true);
	// TDTimer
	for(new i = 0; i < MAX_PLAYERS; i++) // default look bottom bar panel
	{
		TDTimer[i] = TextDrawCreate(520.0, 380.0, " ");
		TextDrawUseBox(TDTimer[i], 0);
		TextDrawBoxColor(TDTimer[i], 0x00000066);
		TextDrawLetterSize(TDTimer[i], 0.215, 1.0);
	    TextDrawFont(TDTimer[i], 1);
	    TextDrawSetOutline(TDTimer[i], 1);
		TextDrawAlignment(TDTimer[i], 2);
    }
	
	// actors
	HalloweenActors[0] = CreateActor(93, -1227.9746,-60.9235,26.2922,57.6229);
	SetActorInvulnerable(HalloweenActors[0], true);
	HalloweenActors[1] = CreateActor(214, 2917.4829, 2108.4695, 17.8955, 0.0);
	SetActorInvulnerable(HalloweenActors[1], true);
	HalloweenActors[2] = CreateActor(93, 3099.1458, 1956.3824, 7.5337, 0.0);
	SetActorInvulnerable(HalloweenActors[2], true);
	HalloweenActors[3] = CreateActor(285, -1204.3008,-49.1836,28.5887,138.05);
	SetActorInvulnerable(HalloweenActors[3], true);
	
	// pickups
	PumpkinPickups[0] = CreatePickup(19320, 3, 2972.459716, 2101.036376, 7.153663);
	PumpkinPickups[1] = CreatePickup(19320, 3, 3016.061035, 2266.974853, 7.423666);
	PumpkinPickups[2] = CreatePickup(19320, 3, 3159.627441, 1981.081054, 7.143664);
	PumpkinPickups[3] = CreatePickup(19320, 3, 3054.963623, 1963.637695, 6.853662);
	PumpkinPickups[4] = CreatePickup(19320, 3, 2996.937744, 1946.497192, 9.424843);
	PumpkinPickups[5] = CreatePickup(19320, 3, 3071.692138, 2133.753173, 6.798164);
	PumpkinPickups[6] = CreatePickup(19320, 3, 3170.367675, 2173.437988, 25.480369);
	PumpkinPickups[7] = CreatePickup(19320, 3, 3068.865234, 2174.327880, 32.886238);
	PumpkinPickups[8] = CreatePickup(19320, 3, 3082.210693, 2197.114013, 9.856938);
	PumpkinPickups[9] = CreatePickup(19320, 3, 3160.267822, 2122.571777, 8.151776);
	PumpkinPickups[10] = CreatePickup(19320, 3, 3110.385986, 2098.660644, 6.823661);
	PumpkinPickups[11] = CreatePickup(19320, 3, 3087.028564, 2204.573974, 25.541530);
	PumpkinPickups[12] = CreatePickup(19320, 3, 3078.764892, 2068.936523, 6.863664);
	PumpkinPickups[13] = CreatePickup(19320, 3, 3103.996582, 1984.063842, 6.803662);
	PumpkinPickups[14] = CreatePickup(19320, 3, 2994.682861, 2068.266601, 6.963664);
	PumpkinPickups[15] = CreatePickup(19320, 3, 3037.682617, 2020.576171, 6.813663);
	PumpkinPickups[16] = CreatePickup(19320, 3, 3065.642333, 2271.404541, 9.444640);
	PumpkinPickups[17] = CreatePickup(19320, 3, 3135.088623, 2232.869140, 6.863664);
	PumpkinPickups[18] = CreatePickup(19320, 3, 2997.7598, 2101.3542, 10.22);
	PumpkinPickups[19] = CreatePickup(19320, 3, 3007.199, 2197.135, 8.62);
	
	// Final round pickups
	RefillPickup = CreatePickup(1242, 3, 2010.218994, 2932.506835, 50.976230);
	DynamitePickup = CreatePickup(1654, 2, 2016.006713, 2939.709960, 51.236213);
	DynamitePickup2 = CreatePickup(1654, 2, 2005.074218, 2939.709960, 51.236213);
	
	// mapping section
	new tmpobjid; 
	// LoadSpawn
	tmpobjid = CreateObject(8131, -1203.189208, -58.746143, 21.355493, 0.000000, 0.000000, -45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	SetObjectMaterial(tmpobjid, 1, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(3814, -1217.142456, -67.128684, 19.776548, 0.000000, 0.000000, -45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 10023, "bigwhitesfe", "forestfloor3", 0x00000000);
	SetObjectMaterial(tmpobjid, 1, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(18766, -1199.231079, -49.163867, 32.763046, -90.000000, 0.000000, -45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(18763, -1208.834594, -53.218898, 26.082027, 0.000000, 0.000000, -45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(18765, -1202.896240, -52.921112, 22.618675, -90.000000, 0.000000, 45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(18763, -1203.213500, -58.840423, 26.082027, 0.000000, 0.000000, -45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(18762, -1198.171508, -51.297054, 29.968713, 0.000000, 0.000000, 45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(18762, -1201.315917, -48.157436, 29.988740, 0.000000, 0.000000, 45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(18763, -1203.239135, -47.625652, 27.502058, 0.000000, 0.000000, -45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(18763, -1197.602050, -53.261333, 27.502058, 0.000000, 0.000000, -45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(18763, -1205.968872, -55.994125, 25.685911, 0.000000, 90.000000, -45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(18763, -1206.584838, -56.609317, 25.235900, 0.000000, 90.000000, -45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(18765, -1202.896240, -52.921112, 22.618675, -90.000000, 0.000000, 45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(19604, -1199.776000, -49.711009, 27.298667, 90.000000, 0.000000, -45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 18901, "matclothes", "bandanaredish", 0x00000000);
	tmpobjid = CreateObject(18762, -1212.885375, -45.160743, 24.080499, 167.500122, 0.000000, 45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(18765, -1203.212280, -53.252925, 22.588674, -90.000000, 0.000000, -45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(18762, -1196.256713, -59.338764, 24.437448, -174.599777, 0.000000, 45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	tmpobjid = CreateObject(8131, -1208.783569, -53.152893, 21.355493, 0.000000, 0.000000, -45.000000, 300.0); 
	SetObjectMaterial(tmpobjid, 0, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	SetObjectMaterial(tmpobjid, 1, 13691, "bevcunto2_lahills", "ws_patio1", 0x00000000);
	
	//CreateObject(2869, -1210.659790, -54.643566, 26.221759, 0.000000, 0.000000, -65.899780, 300.0); 
	CreateObject(16052, -1197.869995, -53.544586, 29.318674, 0.000000, 0.000000, 135.000000, 300.0); 
	CreateObject(16410, -1214.973022, -47.499721, 26.753421, 0.000000, -13.800004, -40.699981, 300.0); 
	CreateObject(16410, -1230.659912, -62.745304, 25.506395, -7.799998, -13.800004, -40.699981, 300.0); 
	CreateObject(16410, -1197.799560, -62.271602, 26.944553, 0.000000, 6.799995, -40.699981, 300.0); 
	CreateObject(16410, -1210.319580, -76.614334, 25.790956, -6.799996, 6.799995, -40.699981, 300.0); 
	//CreateObject(2869, -1204.668212, -60.534030, 26.221759, 0.000000, 0.000000, -105.699783, 300.0); 
	CreateObject(16052, -1203.500732, -47.915981, 29.318674, 0.000000, 0.000000, 135.000000, 300.0); 
	CreateObject(16630, -1199.480224, -56.411128, 28.098543, 0.000000, 0.000000, 45.000000, 300.0); 
	CreateObject(16630, -1206.387817, -49.495555, 28.098543, 0.000000, 0.000000, 45.000000, 300.0); 
	CreateObject(734, -1212.403808, -40.587703, 20.421321, 0.000000, 0.000000, 0.000000, 300.0); 
	CreateObject(734, -1233.924316, -62.177654, 22.231328, 0.000000, 0.000000, 30.399999, 300.0); 
	CreateObject(734, -1194.603393, -61.317707, 21.311323, 0.000000, 0.000000, 0.000000, 300.0); 
	CreateObject(734, -1213.355224, -82.147926, 23.961326, 0.000000, 0.000000, 8.399992, 300.0);
	// Chapter 1. The Village
	CreateObject(19551, 2995.454345, 2119.744384, 6.533660, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(735, 2935.714355, 2137.546142, 11.243638, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(735, 3059.804443, 2071.557861, 3.773636, 0.000000, 0.000000, 63.999958, 300.00); 
	CreateObject(16280, 2993.044921, 2043.437744, 10.203651, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(17005, 2987.519287, 2149.173339, 14.193608, 0.000000, 0.000000, 90.000000, 300.00); 
	CreateObject(735, 2935.714355, 2085.995849, 11.243638, 0.000000, 0.000000, 38.299999, 300.00); 
	CreateObject(19551, 3120.393798, 2119.744384, 6.533660, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19551, 2995.454345, 1994.815673, 6.533660, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19551, 3120.393798, 1994.758544, 6.533660, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19551, 2995.454345, 2244.740966, 6.533660, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19551, 3120.393798, 2244.677978, 6.533660, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(735, 2997.963623, 1948.686889, 1.043635, 0.000000, 0.000000, -36.600036, 300.00); 
	CreateObject(16169, 3056.715332, 2287.994140, 21.338939, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(16252, 3117.156250, 2268.291259, 30.185894, 0.000000, 0.000000, 43.199985, 300.00); 
	CreateObject(16169, 3072.032714, 1951.646606, 4.788921, 0.000000, 0.000000, 176.999954, 300.00); 
	CreateObject(16252, 3183.229248, 1997.333007, 30.185894, 0.000000, 0.000000, -38.600013, 300.00); 
	CreateObject(16258, 3190.968017, 2107.580566, 46.480411, 0.000000, 0.000000, 94.299926, 300.00); 
	CreateObject(18267, 3154.027832, 2126.344238, 7.783650, 0.000000, 0.000000, 3.699999, 300.00); 
	CreateObject(3355, 2972.279785, 2094.579833, 6.463661, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(3414, 3065.532958, 2131.853027, 8.680974, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(13002, 3091.222412, 2135.196777, 10.182842, 0.000000, 0.000000, -88.500045, 300.00); 
	CreateObject(16051, 3038.897216, 2059.141357, 9.620680, 0.000000, 0.000000, 90.000000, 300.00); 
	CreateObject(12937, 3069.341552, 2178.107910, 34.403991, -5.299997, 0.000000, 0.000000, 300.00); 
	CreateObject(16169, 3182.301757, 2091.591064, 14.188921, 0.000000, 0.000000, -95.299980, 300.00); 
	CreateObject(5715, 3049.080810, 1993.480957, 15.931450, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(5713, 3016.060546, 1995.579956, 12.282073, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(5714, 3008.272460, 1967.888305, 8.221117, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(5714, 3083.811035, 1967.888305, 8.221117, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(5713, 3093.218017, 1995.579956, 12.282073, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(5715, 3131.448974, 2005.932373, 15.931450, 0.000000, 0.000000, 90.000000, 300.00); 
	CreateObject(16690, 3147.012207, 2040.661865, 10.767938, 0.000000, 0.000000, 83.099929, 300.00); 
	CreateObject(16689, 3125.139160, 2058.123291, 9.369618, 0.000000, 0.000000, 48.899990, 300.00); 
	CreateObject(16053, 3025.116455, 2028.478515, 10.046812, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(16280, 3133.076660, 2214.929687, 10.193627, 0.000000, 0.000000, -180.000000, 300.00); 
	CreateObject(16444, 3142.830810, 1971.592041, 8.455007, 0.000000, 0.000000, 20.500000, 300.00); 
	CreateObject(12961, 3159.335449, 1972.225952, 7.062378, 0.000000, 0.000000, -180.000000, 300.00); 
	CreateObject(5710, 3138.305175, 1979.437988, 11.745512, 0.000000, 0.000000, -180.000000, 300.00); 
	CreateObject(13438, 3159.292724, 1971.222167, 7.517994, 0.000000, 0.000000, -180.000000, 300.00); 
	CreateObject(16054, 3088.519531, 2077.128417, 9.426513, 0.000000, 0.000000, -90.000000, 300.00); 
	CreateObject(18255, 2996.258544, 2174.718261, 9.672622, 0.000000, 0.000000, -90.000000, 300.00); 
	CreateObject(8187, 3086.812744, 2014.114501, 7.283661, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(16444, 3139.390625, 1974.403564, 8.455007, 0.000000, 0.000000, -40.600009, 300.00); 
	CreateObject(16689, 3069.473632, 2039.736938, 9.369617, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(735, 3030.658935, 2015.482666, 4.993638, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(735, 3150.941894, 2041.445434, 4.993638, 0.000000, 0.000000, 54.599994, 300.00); 
	CreateObject(735, 3126.301269, 1958.333251, 5.113637, 0.000000, 0.000000, -36.600036, 300.00); 
	CreateObject(16195, 3043.300292, 2222.595458, -2.242170, -1.799998, 0.000000, -69.899887, 300.00); 
	CreateObject(18246, 3012.369873, 2274.836669, 8.979533, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18247, 3122.309570, 2259.986083, 11.207683, 0.000000, 0.000000, 53.500041, 300.00); 
	CreateObject(18245, 3080.051269, 2203.875976, 18.123750, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18254, 3007.728759, 2207.483398, 15.457670, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18252, 3049.652343, 2270.583007, 9.981683, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(18255, 3102.681152, 2191.672851, 9.672622, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(16689, 3024.909179, 2089.965820, 9.369617, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(16116, 3174.785156, 2213.232666, 5.820645, 0.000000, 0.000000, 127.899848, 300.00); 
	CreateObject(16690, 3037.536376, 2138.642333, 10.767938, 0.000000, 0.000000, 48.599960, 300.00); 
	CreateObject(16051, 2995.527832, 2099.224609, 9.620680, 0.000000, 0.000000, -90.000000, 300.00); 
	CreateObject(11243, 3110.451416, 2117.213134, 4.847849, 1.899999, 0.000000, 94.899925, 300.00); 
	CreateObject(8187, 3039.807128, 2097.113037, 7.214199, 0.000000, 0.000000, 90.000000, 300.00); 
	CreateObject(13004, 3139.414306, 2128.448974, 7.497303, 0.000000, 0.000000, -87.600006, 300.00); 
	CreateObject(13749, 3162.208740, 2183.440185, 19.299243, 0.000000, 0.000000, 163.599822, 300.00); 
	CreateObject(18846, 3172.236083, 2173.806152, 26.325880, -2.200000, 90.000000, 21.800001, 300.00); 
	CreateObject(735, 2953.263916, 2210.587646, 19.003656, 0.000000, 0.000000, -117.500000, 300.00); 
	CreateObject(735, 2968.318115, 2000.225463, 25.643636, 0.000000, 0.000000, 71.899993, 300.00); 
	CreateObject(16280, 3066.180908, 2168.221191, 34.313785, 0.000000, 0.000000, 92.100051, 300.00); 
	CreateObject(773, 3081.886962, 1997.649169, 5.519412, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(735, 3011.286132, 2276.598876, 4.993630, 0.000000, 0.000000, 59.199905, 300.00); 
	CreateObject(773, 2965.075927, 2137.780273, 3.779411, 0.000000, 0.000000, -12.799996, 300.00); 
	CreateObject(773, 3009.542236, 2163.181152, 3.779411, 0.000000, 0.000000, 174.300125, 300.00); 
	CreateObject(773, 3014.876708, 2068.772949, 2.979408, 0.000000, 0.000000, 43.300144, 300.00); 
	CreateObject(735, 3015.783935, 2132.527099, 2.773638, 0.000000, 0.000000, 41.799995, 300.00); 
	CreateObject(773, 3044.385986, 1983.289428, 5.519412, 0.000000, 0.000000, -16.399997, 300.00); 
	CreateObject(773, 2997.984863, 2012.216674, 3.239413, 0.000000, 0.000000, 68.200012, 300.00); 
	CreateObject(773, 3073.282714, 2031.429931, 4.709415, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(773, 3165.239501, 2021.597167, -1.810582, 0.000000, 0.000000, 152.600067, 300.00); 
	CreateObject(773, 3130.664306, 2091.290039, 3.669410, 0.000000, 0.000000, 179.199966, 300.00); 
	CreateObject(773, 3055.296386, 2122.573730, 2.829405, 0.000000, 0.000000, 150.300094, 300.00); 
	//CreateObject(2803, 3147.658691, 1979.596313, 8.596043, 0.000000, 0.000000, 44.100002, 300.00); 
	CreateObject(5712, 3144.222412, 1977.185058, 9.883822, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(3009, 3054.719970, 1963.552856, 6.615725, -5.800000, -86.399955, -168.300033, 300.00); 
	CreateObject(16116, 3192.175048, 2129.615234, 5.100644, 0.000000, 0.000000, 127.899848, 300.00);  
	CreateObject(12918, 3004.325439, 2197.492187, 7.431731, 0.000000, 0.000000, 0.000000, 300.00);
	// Chapter 2. Hit and Run
	CreateObject(18765, 2810.215332, 3015.441162, 43.557701, 90.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18769, 2815.768554, 2940.641845, 38.683673, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2826.048583, 2931.480468, 51.137794, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2815.330078, 2920.130126, 51.127712, 0.000000, 0.000000, 90.000000, 300.00); 
	CreateObject(18981, 2805.496826, 2931.480468, 51.097709, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2826.048583, 2956.459716, 51.137794, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2805.496826, 2956.470458, 51.097709, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(2927, 2823.536865, 2950.620361, 41.085842, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19538, 2810.925292, 2981.980468, 48.141193, 0.000000, 0.000000, -90.000000, 300.00); 
	CreateObject(18981, 2822.948974, 2951.055419, 51.127712, 0.000000, 0.000000, 90.000000, 300.00); 
	CreateObject(19545, 2813.394775, 2981.753906, 39.319290, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(16532, 2814.922119, 2958.851318, 46.242076, 0.000000, 180.000000, 90.000000, 300.00); 
	CreateObject(1482, 2808.784179, 2984.391601, 40.473762, 0.000000, -90.000000, 90.000000, 300.00); 
	CreateObject(18765, 2820.079589, 2965.375488, 43.557701, 90.000000, 90.000000, 0.000000, 300.00); 
	CreateObject(18765, 2808.768066, 2973.811767, 43.557701, 90.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18766, 2803.852050, 2970.615478, 42.929298, 0.000000, 90.000000, 90.000000, 300.00); 
	CreateObject(18766, 2809.926757, 2963.472412, 42.929298, 0.000000, 90.000000, 90.000000, 300.00); 
	CreateObject(2567, 2803.522705, 3123.425292, 41.109283, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(18766, 2816.532958, 2956.023925, 42.929298, 0.000000, 90.000000, 0.000000, 300.00); 
	CreateObject(2927, 2813.016601, 2920.619628, 41.085842, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(2927, 2817.663818, 2958.492187, 41.085842, 0.000000, 0.000000, 90.000000, 300.00); 
	CreateObject(942, 2816.331787, 2972.495605, 41.499263, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(2567, 2821.477050, 2954.121582, 41.169281, 0.000000, 0.000000, 89.899955, 300.00); 
	CreateObject(18981, 2821.354003, 2988.690429, 51.137794, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2805.423339, 2988.690429, 51.137794, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18765, 2822.304931, 2974.222656, 43.557701, 90.000000, 90.000000, 0.000000, 300.00); 
	CreateObject(18765, 2817.191406, 2984.242431, 43.557701, 90.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18765, 2817.191406, 3003.514160, 43.557701, 90.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18765, 2812.270263, 2993.302246, 43.557701, 90.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(3799, 2807.394287, 2989.325683, 39.119297, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(16532, 2757.293212, 3335.177978, 66.422950, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18260, 2817.480468, 2999.847656, 40.659271, 0.000000, 0.000000, 89.999977, 300.00); 
	CreateObject(19545, 2802.971923, 3031.932617, 39.339290, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2804.972900, 3027.772705, 51.137794, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2795.459960, 3023.609619, 51.137794, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18260, 2809.953857, 3037.802001, 40.659271, 0.000000, 0.000000, 1.799980, 300.00); 
	CreateObject(3257, 2800.172119, 3019.377685, 39.339290, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18765, 2807.940673, 3005.709960, 43.557701, 90.000000, 90.000000, 0.000000, 300.00); 
	CreateObject(5261, 2800.714111, 3009.563720, 41.189208, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(3257, 2800.192138, 3040.129150, 39.339290, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(5261, 2819.029541, 3010.734863, 41.189208, 0.000000, 0.000000, -90.000000, 300.00); 
	CreateObject(3799, 2816.360351, 3014.435302, 39.119297, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2795.459960, 3048.597167, 51.137794, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2810.027343, 3048.546630, 51.137794, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19545, 2807.525634, 3094.294921, 39.329292, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(3257, 2799.824218, 3069.119628, 35.249305, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(3257, 2814.235839, 3069.149902, 35.249305, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(18981, 2810.027343, 3089.824218, 51.137794, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2804.074951, 3089.770996, 51.137794, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(3257, 2800.234375, 3110.610107, 35.249305, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(3257, 2814.235839, 3110.626708, 35.249305, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(3675, 2806.431152, 3081.843750, 39.615352, -74.399902, 0.000000, 89.000007, 300.00); 
	CreateObject(3675, 2809.068115, 3084.281982, 40.527523, -89.799819, 0.000000, 89.000007, 300.00); 
	CreateObject(3675, 2807.353027, 3086.714355, 43.793811, 0.000000, -90.000000, 0.000000, 300.00); 
	CreateObject(18765, 2807.412597, 3090.602294, 41.327720, 90.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19545, 2802.981933, 3155.844238, 39.339290, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2810.889404, 3131.389648, 51.137794, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2799.502929, 3131.239257, 51.137794, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(3257, 2806.114990, 3132.810546, 30.159290, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(3257, 2800.729736, 3174.328857, 28.439243, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(18981, 2796.910888, 3154.834472, 51.137794, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2810.979492, 3156.303710, 51.137794, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(3575, 2802.784423, 3154.715576, 41.969295, 0.000000, 0.000000, 179.700012, 300.00); 
	CreateObject(3257, 2803.502197, 3182.361328, 28.449243, 0.000000, 0.000000, -90.000000, 300.00); 
	CreateObject(16532, 2802.032226, 3145.918701, 48.673877, 90.000000, 0.000000, 90.000000, 300.00); 
	CreateObject(16087, 2802.978027, 3264.526123, 43.300437, 0.000000, 0.000000, 90.000000, 300.00); 
	CreateObject(3257, 2803.502197, 3312.822021, 28.449243, 0.000000, 0.000000, -90.000000, 300.00); 
	CreateObject(3257, 2803.532226, 3321.218261, 37.949413, 0.000000, 0.000000, -90.000000, 300.00); 
	CreateObject(3257, 2803.502197, 3329.195556, 49.599563, 0.000000, 0.000000, -90.000000, 300.00); 
	CreateObject(3470, 2804.224853, 3325.260742, 60.279560, 0.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(3257, 2773.560302, 3345.272460, 49.599563, 0.000000, 0.000000, -90.000000, 300.00); 
	CreateObject(3257, 2762.870849, 3337.874511, 60.299564, 0.000000, 0.000000, 0.300022, 300.00); 
	CreateObject(3799, 2768.618408, 3346.738769, 67.882972, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(16532, 2782.130859, 3346.937744, 77.442901, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(3257, 2806.371093, 3357.968017, 62.079601, 0.000000, 0.000000, -90.000000, 300.00); 
	CreateObject(3257, 2818.953125, 3347.185302, 62.079601, 0.000000, 0.000000, 90.000000, 300.00); 
	CreateObject(3257, 2806.371093, 3496.500976, 62.079601, 0.000000, 0.000000, -90.000000, 300.00); 
	CreateObject(16087, 2802.978027, 3442.930175, 76.800376, 0.000000, 0.000000, 90.000000, 300.00); 
	CreateObject(16663, 2806.375244, 3508.846435, 81.449653, 0.000000, 0.000000, -135.000000, 300.00); 
	CreateObject(3257, 2796.113281, 3508.342285, 68.519622, 0.000000, 0.000000, -180.000000, 300.00); 
	CreateObject(3257, 2816.663574, 3507.714355, 68.519622, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(3257, 2806.371093, 3520.076660, 72.069610, 0.000000, 0.000000, -90.000000, 300.00); 
	CreateObject(18769, 2806.409179, 3510.408203, 76.345893, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19297, 2805.983398, 3512.384765, 78.800003, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18691, 2801.178466, 3028.497558, 37.679340, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18691, 2805.578369, 3086.774414, 37.679340, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18691, 2811.246337, 3003.245605, 38.159336, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1482, 2807.993408, 2952.601074, 40.473762, 0.000000, -90.000000, 90.000000, 300.00); 
	CreateObject(1482, 2808.784179, 3007.004394, 40.473762, 0.000000, -90.000000, 90.000000, 300.00); 
	CreateObject(1482, 2796.897705, 3033.257080, 40.473762, 0.000000, -90.000000, 90.000000, 300.00); 
	CreateObject(1479, 2807.011962, 3089.880859, 47.331867, 90.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(1479, 2807.011962, 3113.235839, 40.301910, 90.000000, 0.000000, 180.000000, 300.00); 
	CreateObject(1462, 2802.267333, 3142.559082, 45.919887, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1462, 2802.349365, 3154.999023, 46.039875, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1462, 2799.525878, 3227.338378, 45.865577, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1462, 2805.016601, 3271.373779, 46.104339, 0.000000, 0.000000, 0.000000, 300.00);
	// Chapter 3. Boss Fight
	tmpobjid = CreateObject(19842, 2017.534179, 2953.678955, 43.776264, 0.000000, 0.000000, 0.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 18996, "mattextures", "lava1", 0x00000000);
	tmpobjid = CreateObject(19842, 2005.964477, 2953.678955, 43.776264, 0.000000, 0.000000, 0.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 18996, "mattextures", "lava1", 0x00000000);
	tmpobjid = CreateObject(19479, 2011.086791, 2937.339843, 50.706230, 0.000000, 90.000000, 90.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateObject(9833, 2003.451782, 2959.114990, 53.535976, -67.599990, 0.000000, 0.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "hangingwires1", 0x00000000);
	tmpobjid = CreateObject(9833, 2017.109008, 2959.623046, 53.492656, -65.799995, -2.899998, 4.899999, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "hangingwires1", 0x00000000);
	tmpobjid = CreateObject(18846, 2004.194335, 2959.946777, 53.756378, -90.000000, 0.000000, 0.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 19319, "warlock01", "warlock01", 0x00000000);
	tmpobjid = CreateObject(18846, 2017.556274, 2959.946777, 53.806377, -90.000000, 0.000000, 0.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 19319, "warlock01", "warlock01", 0x00000000);
	tmpobjid = CreateObject(19697, 2008.454711, 2960.755126, 52.317260, 142.999771, -90.000000, -93.999954, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "hangingwires1", 0x00000000);
	tmpobjid = CreateObject(19697, 2013.429443, 2960.697265, 52.083496, 155.800262, -85.400070, -99.499992, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 16322, "a51_stores", "hangingwires1", 0x00000000);
	tmpobjid = CreateObject(19650, 2011.134399, 2960.263183, 42.839435, 90.000000, 0.000000, 0.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 16646, "a51_alpha", "ws_stationgirder1", 0x00000000);
	tmpobjid = CreateObject(19479, 2011.086791, 2917.408935, 50.676231, 0.000000, 90.000000, 90.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateObject(19604, 2010.442260, 2916.879150, 53.235843, 90.000000, 0.000000, 0.000000, 300.00); 
	SetObjectMaterial(tmpobjid, 0, 18901, "matclothes", "bandanaredish", 0x00000000);
	
	CreateObject(18981, 2000.076049, 2923.021484, 50.662155, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18769, 2010.604370, 2931.104492, 50.012172, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2021.055664, 2923.021484, 50.662155, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2010.226074, 2916.321289, 50.662155, 0.000000, 0.000000, 90.000000, 300.00); 
	CreateObject(18981, 2010.226074, 2956.488769, 38.232154, 0.000000, 0.000000, 90.000000, 300.00); 
	CreateObject(18981, 1999.965942, 2947.998291, 43.782073, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2021.057250, 2947.998291, 43.822086, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(6865, 2011.231689, 2960.149658, 54.307338, 4.999998, -6.399997, 40.899986, 300.00); 
	CreateObject(18981, 2010.226074, 2941.528320, 38.932159, 0.000000, 0.000000, 90.000000, 300.00); 
	CreateObject(18762, 2005.018554, 2941.619873, 53.816223, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18981, 2010.226074, 2929.153808, 55.772197, 0.000000, 90.000000, 90.000000, 300.00); 
	CreateObject(18762, 2016.107055, 2941.619873, 53.816223, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(7950, 2023.474487, 2913.686035, 39.734935, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(3524, 2001.020874, 2956.413085, 48.926258, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18759, 2010.670043, 2960.405517, 36.289905, -90.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(3524, 2020.060546, 2956.413085, 48.926258, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(18766, 2010.418945, 2933.464843, 47.626262, 0.000000, 90.000000, 0.000000, 300.00); 
	
	CreateObject(2907, 2020.435668, 2929.487548, 51.050392, -87.200027, 0.000000, 104.800003, 300.00); 
	CreateObject(2905, 2019.997314, 2929.580322, 50.809425, 0.000000, 86.699935, 97.299942, 300.00); 
	CreateObject(2905, 2020.059570, 2929.298095, 50.820140, 1.300001, 73.699913, 103.899978, 300.00); 
	CreateObject(2906, 2020.483886, 2929.333251, 50.989475, -94.799888, 0.000000, -89.199935, 300.00); 
	CreateObject(2908, 2020.397460, 2929.518066, 51.584026, -83.899993, 0.000000, 0.000000, 300.00); 
	CreateObject(2906, 2014.774169, 2934.842041, 50.702804, -2.199917, 0.000000, -124.499954, 300.00); 
	CreateObject(2908, 2011.708740, 2936.672363, 50.746883, -171.599990, 0.000000, 43.099994, 300.00); 
	CreateObject(2905, 2015.316894, 2937.790039, 50.748378, 0.000000, 168.599990, 149.999862, 300.00); 
	CreateObject(2906, 2006.270874, 2935.615722, 50.718997, -2.199917, 0.000000, -51.699947, 300.00); 
	CreateObject(2907, 2009.654174, 2935.480957, 50.747379, 2.699956, 0.000000, 15.800002, 300.00); 
	CreateObject(2905, 2007.069091, 2940.527832, 51.133083, -89.700019, -87.000000, 178.500000, 300.00); 
	CreateObject(2359, 2011.457641, 2932.815185, 50.891025, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(3016, 2009.178100, 2932.813964, 50.806846, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(342, 2011.228393, 2932.833740, 50.853187, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(342, 2011.078247, 2932.693603, 50.853187, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(342, 2011.358520, 2932.693603, 50.853187, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(2906, 2018.822265, 2935.188964, 50.428779, 89.500114, -15.200008, 27.300050, 300.00); 
	CreateObject(2908, 2004.360595, 2938.384277, 50.783584, -171.599990, 0.000000, 43.099994, 300.00); 
	CreateObject(3524, 2005.140380, 2916.572265, 51.137092, 2.499999, 0.000000, -180.000000, 300.00); 
	CreateObject(3524, 2015.611328, 2916.572265, 51.137092, 2.499999, 0.000000, -180.000000, 300.00); 
	CreateObject(3524, 2017.541503, 2960.525878, 53.526275, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(3524, 2004.181518, 2960.535888, 53.496276, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(2907, 2008.855957, 2938.302978, 50.748912, 2.699956, 176.599975, 150.099990, 300.00); 
	CreateObject(2906, 2012.080322, 2939.243164, 50.740299, -2.199917, 0.000000, -56.699974, 300.00);
	CreateObject(2888, 2005.065795, 2940.374023, 51.574951, -90.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(2888, 2016.098388, 2940.374023, 51.574951, -90.000000, 0.000000, 0.000000, 300.00);	
	
	// dynamic eyes
	BossEye1 = CreateObject(19296, 2010.370483, 2959.508056, 0.0, 0.0, 0.0, 0.0, 300.00); 
	BossEye2 = CreateObject(19296, 2011.932006, 2959.508056, 0.0, 0.0, 0.0, 0.0, 300.00); 
	
	BossRedObjects[0] = CreateObject(19296, 2004.244995, 2960.198730, 53.519500,
	0.000000, 0.000000, 0.000000, 300.00);
	BossRedObjects[1] = CreateObject(19296, 2011.016479, 2959.297851, 50.509544,
	0.000000, 0.000000, 0.000000, 300.00); 
	BossRedObjects[2] = CreateObject(19282, 2011.919433, 2959.582275, 55.147930,
	0.000000, 0.000000, 0.000000, 300.00); 
	BossRedObjects[3] = CreateObject(19282, 2010.297851, 2959.582275, 55.117931,
	0.000000, 0.000000, 0.000000, 300.00); 
	BossRedObjects[4] = CreateObject(19296, 2017.726318, 2960.198730, 53.759490,
	0.000000, 0.000000, 0.000000, 300.00); 
	// end mapping
    return 1; 
} 

public OnFilterScriptExit()
{ 
	// Destroy textdraws, actors, pickups
	KillTimer(QuestTimer);
	DestroyPickup(RefillPickup);
	DestroyPickup(DynamitePickup);
	DestroyPickup(DynamitePickup2);
	for(new p = 0; p < sizeof(PumpkinPickups); p++) DestroyPickup(p);
	for(new o = 0; o < MAX_OBJECTS; o++) DestroyObject(o);
	for(new a = 0; a < sizeof(HalloweenActors); a++) DestroyActor(HalloweenActors[a]);
	for(new i = 0; i < MAX_PLAYERS; i++) TextDrawDestroy(TDTimer[i]);
	return 1;
} 

public OnPlayerConnect(playerid)
{ 
	// Pvar pre-set
	SetPVarInt(playerid, "EventPart", -1);
	SetPVarInt(playerid, "EventPumpkins", 0);
	SetPVarInt(playerid, "EventTime", 0);
	SetPVarInt(playerid, "Event2Distance", 0);
	SetPVarInt(playerid, "EventDynamite", 0);
	
	// None Quest time 
	SetPlayerWeather(playerid, 20); 
	SetPlayerTime(playerid, 6, 0);
	
	ApplyActorAnimation(HalloweenActors[0], "GRAVEYARD", "MRNF_LOOP", 4.1, 1, 0, 0, 0, 0);
	ApplyActorAnimation(HalloweenActors[3], "CRACK", "CRCKIDLE1", 4.1, 1, 0, 0, 0, 0);
	
	SendClientMessage(playerid, 0xF5511CAA,
	"The Halloween event is running on the server. Take part and get unique Halloween costumes (/info)");
	return 1;
} 

public OnPlayerDeath(playerid, killerid, reason)
{
	if(GetPVarInt(playerid, "EventPart") == 1)
	{
		SetPVarInt(playerid, "EventPumpkins", 0);
		PlayerPlaySound(playerid, 31202, 0.0, 0.0, 0.0); // LOSE
		GameTextForPlayer(playerid, "~r~ You Lost all pumpkins!", 5000, 5);
	}
	if(GetPVarInt(playerid, "EventPart") == 2)
	{
		GameTextForPlayer(playerid, "~r~ Try again!", 5000, 5);
	}
	if(GetPVarInt(playerid, "EventPart") == 3)
	{
		PlayerPlaySound(playerid, 31202, 0.0, 0.0, 0.0); // LOSE
		GameTextForPlayer(playerid, "~r~ YOU DIE!", 5000, 5);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(GetPVarInt(playerid, "EventPart") > 0)
	{
		if(GetPVarInt(playerid, "Resync") > 0)
		{
			SetPlayerPos(playerid, syncX, syncY, syncZ);
			SetPlayerFacingAngle(playerid, syncA);
			SetPVarInt(playerid, "Resync",0);
			SetCameraBehindPlayer(playerid);
			return 1;
		}
		SetPlayerHealth(playerid, 100.0);
		SetPlayerArmour(playerid, 0.0);
		ResetPlayerWeapons(playerid);
		SendClientMessage(playerid, -1, "Type /exit to leave the quest. (All progress will be lost)");
	}
	
	if(GetPVarInt(playerid, "EventPart") < 0)
	{
		SetPlayerWeather(playerid, 20); 
		SetPlayerTime(playerid, 6, 0);
	}
	
	if(GetPVarInt(playerid, "EventPart") == 1)
	{
		SetPVarInt(playerid, "EventTime", gettime() + 60*7);
		SetPVarInt(playerid, "EventPumpkins",0);
		ApplyActorAnimation(HalloweenActors[2], "GRAVEYARD", "MRNF_LOOP", 4.1, 1, 0, 0, 0, 0);
		SetPlayerPos(playerid, 2933.3010, 2119.4119, 18.49);
		GameTextForPlayer(playerid, "~w~Chapter 1: The Village.~n~Collect all pumpkins", 5000, 5);
		SendClientMessage(playerid, -1, "Collect all pumpkins before time runs out");
	}
	if(GetPVarInt(playerid, "EventPart") == 2)
	{
		SetPVarInt(playerid, "EventTime", gettime() + 60*3+30); //3:30
		SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 1);
		GivePlayerWeapon(playerid, 26, 668);
		SetPlayerPos(playerid, 2814.4172, 2926.3601, 41.15);
		GameTextForPlayer(playerid, "~w~Chapter 2: Hit and run.~n~Run to the finish line", 5000, 5);
		SendClientMessage(playerid, -1, "Run to the finish line before time runs out");
	}
	if(GetPVarInt(playerid, "EventPart") == 3)
	{
		SetPVarInt(playerid, "EventTime", gettime() + 60*6);
		//SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 1);
		GivePlayerWeapon(playerid, 27, 668);
		SetPlayerPos(playerid, 2009.5916,2918.5032, 51.67);
		BossHealth = 3500;
		GameTextForPlayer(playerid,"~w~Chapter 3: Boss fight.~n~Collect dynamite to kill the Boss", 5000, 5);
		SendClientMessage(playerid, -1, "Load dynamite to kill the Boss. Dynamite respawns after 30 seconds.");
	}
	
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	// pumpkin pickups chapter 1
	new str[24];
    if(pickupid == PumpkinPickups[0] || pickupid == PumpkinPickups[1]
	|| pickupid == PumpkinPickups[2] || pickupid == PumpkinPickups[3]
	|| pickupid == PumpkinPickups[4] || pickupid == PumpkinPickups[5]
	|| pickupid == PumpkinPickups[6] || pickupid == PumpkinPickups[7]
	|| pickupid == PumpkinPickups[8] || pickupid == PumpkinPickups[9]
	|| pickupid == PumpkinPickups[10] || pickupid == PumpkinPickups[11]
	|| pickupid == PumpkinPickups[12] || pickupid == PumpkinPickups[13]
	|| pickupid == PumpkinPickups[14] || pickupid == PumpkinPickups[15]
	|| pickupid == PumpkinPickups[16] || pickupid == PumpkinPickups[17]
	|| pickupid == PumpkinPickups[18] || pickupid == PumpkinPickups[19])
    {
		SetPVarInt(playerid, "EventPumpkins", GetPVarInt(playerid, "EventPumpkins") + 1);
		format(str, 24, "~w~Collected: %d/15", GetPVarInt(playerid, "EventPumpkins"));
		GameTextForPlayer(playerid, str, 3000, 5);
        PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);		
    }
	if(pickupid == RefillPickup)
	{
		SetPlayerArmour(playerid, 66.6);
		SetPlayerHealth(playerid, 100.0);		
		GameTextForPlayer(playerid, "~w~Now you ready to fight!", 3000, 5);
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0); // AMMUNATION_BUY_WEAP
	}
    if(pickupid == DynamitePickup || pickupid == DynamitePickup2)
	{
		SetPVarInt(playerid, "EventDynamite", GetPVarInt(playerid, "EventDynamite") + 1);
		format(str, 24, "~w~Loaded: %d/15", GetPVarInt(playerid, "EventDynamite"));
		GameTextForPlayer(playerid, str, 3000, 5);
        PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);	
		BossHealth = BossHealth - 100;
		CreateExplosionForPlayer(playerid, 2011.016479, 2959.297851, 50.509544, 2, 5.0);
	}
    return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	new str[24],
	Float:fOriginX, Float:fOriginY, Float:fOriginZ,
	Float:fHitPosX, Float:fHitPosY, Float:fHitPosZ;
	GetPlayerLastShotVectors(playerid, fOriginX, fOriginY, fOriginZ, fHitPosX, fHitPosY, fHitPosZ);
	
	if(GetPVarInt(playerid, "EventPart") > 0)	
	{
		if(hittype == BULLET_HIT_TYPE_PLAYER) return 0;
		
		new Float:bossdistance = GetPlayerDistanceFromPoint(playerid, 2010.0, 2956, 50.0);
		if(bossdistance < 24.0) //25 safezone
		{
			if(fHitPosX > 2010.0 && fHitPosX < 2011.0
			|| fHitPosY > 2956.0 && fHitPosY < 2957.0)
			{
				BossHealth = BossHealth - 36;
				format(str, 24, "~r~boss health: %d", BossHealth);
				if(BossHealth > 0) GameTextForPlayer(playerid, str, 3000, 5);
			}
		}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[255], idx;
    cmd = strtok(cmdtext, idx);
	if(!strcmp(cmd, "/info", true))
	{
		SendClientMessage(playerid, 0xF5511CAA, "Complete all 3 stages to get unique costumes, and have a lot of fun");
		SendClientMessage(playerid, 0xF5511CAA, "Chapter 1: The Village.(Collect all pumpkins)");
		SendClientMessage(playerid, 0xF5511CAA, "Chapter 2: Hit and run.(Run to the finish line before time runs out)");
		SendClientMessage(playerid, 0xF5511CAA, "Chapter 3: Boss fight.(Load dynamite to kill the Boss)");
		SendClientMessage(playerid, 0xF5511CAA, "Bonus costumes can be found at: N - Attachments - Select slot - Bonus.");
		SendClientMessage(playerid, 0xF5511CAA, "Type /quest if you are ready");
		GameTextForPlayer(playerid, "~w~Type ~g~/quest~w~ if you are ready", 5000, 5);
		return 1;
	}
	if(!strcmp(cmd, "/quest", true))
	{
		SetPlayerWeather(playerid, 42); 
		SetPlayerTime(playerid, 23, 0);
		SetPVarInt(playerid, "EventPart", 1);
		SetPVarInt(playerid, "EventPumpkins", 0);
		ApplyActorAnimation(HalloweenActors[0], "GRAVEYARD", "MRNF_LOOP", 4.1, 1, 0, 0, 0, 0);
		ApplyActorAnimation(HalloweenActors[3], "CRACK", "CRCKIDLE1", 4.1, 1, 0, 0, 0, 0);
		SendClientMessage(playerid, 0xF5511CAA, "Type /info to view information about all stages");
		SpawnPlayer(playerid);
		return 1;
	}
	if(!strcmp(cmd, "/exit", true))
	{
		SetPVarInt(playerid, "EventPart", 0);
		SetPVarInt(playerid, "EventPumpkins", 0);
		SetPVarInt(playerid, "EventTime", 0);
		SetPVarInt(playerid, "Event2Distance", 0);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 999);
		SetPlayerWeather(playerid, 20); 
		SetPlayerTime(playerid, 6, 0);
		SetPlayerPos(playerid, -1200.0552, -49.9265, 28.6187);
		return 1;
	}
	if(GetPVarInt(playerid, "Admin") >= 3 || IsPlayerAdmin(playerid))
	{
		if(!strcmp(cmd, "/quest1", true))
		{
			SetPlayerWeather(playerid, 42); 
			SetPlayerTime(playerid, 23, 0);
			SetPVarInt(playerid, "EventPart", 1);
			SpawnPlayer(playerid);
			return 1;
		}
		if(!strcmp(cmd, "/quest2", true))
		{
			SetPlayerWeather(playerid, 42); 
			SetPlayerTime(playerid, 23, 0);
			SetPVarInt(playerid, "EventPart", 2);
			SpawnPlayer(playerid);
			return 1;
		}
		if(!strcmp(cmd, "/quest3", true))
		{
			SetPlayerWeather(playerid, 42); 
			SetPlayerTime(playerid, 23, 0);
			SetPVarInt(playerid, "EventPart", 3);
			SpawnPlayer(playerid);
			return 1;
		}
	}
	return false;
}

public OnPlayerUpdate(playerid)
{
	// Moved to global timer QuestUpdate()
	return 1;
}

forward QuestUpdate();
public QuestUpdate()
{	
	new hour, minute, second;
	gettime(hour, minute, second);
	new gametext[100];
	
	if((second % 2) == 0) // every 2 sec
	{
		switch(random(5))
		{
			case 0: SetActorPos(HalloweenActors[1],3073.3723,2069.9331,7.5337);
			case 1: SetActorPos(HalloweenActors[1],3052.0325,2153.6348,33.476);
			case 2: SetActorPos(HalloweenActors[1],3000.4419,2141.9580,7.5337);
			case 3: SetActorPos(HalloweenActors[1],3013.0239,2052.3828,7.5337);
			case 4: SetActorPos(HalloweenActors[1],3007.7139,1978.3890,7.5337);
			default: SetActorPos(HalloweenActors[1],2917.4829,2108.4695,17.8955);
		}
		ApplyActorAnimation(HalloweenActors[1], "PED", "WOMAN_WALKSEXY", 4.1, 1, 1, 1, 1, 0);
	}
	
	foreach(Player, i)
	{
		new Float:x,Float:y,Float:z,Float:health,Float:armour;
		GetPlayerPos(i, x,y,z);
		GetPlayerHealth(i, health);
		GetPlayerArmour(i, armour);
		if(GetPVarInt(i, "EventPart") > 0)
		{
			SetPlayerWeather(i, 42); 
			SetPlayerTime(i, 23, 0);
			if(GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK)
			{
				GameTextForPlayer(i, "~r~It was a bad idea!", 5000, 5);
				SpawnPlayer(i);
			}
		}
		
		// Timer
		if(GetPVarInt(i, "EventTime") != 0 && GetPVarInt(i, "EventTime") > gettime())
		{
			new ctime = GetPVarInt(i, "EventTime") - gettime();
			
			if(GetPVarInt(i, "EventPart") == 1)
			{		
				format(gametext, sizeof(gametext), 
				"~w~Game objective: Collect all pumpkins~n~Pumpkins ~g~%d/15~w~ Time ~g~%d:%d",
				GetPVarInt(i, "EventPumpkins"), ctime/60, ctime%60);
			}
			if(GetPVarInt(i, "EventPart") == 2)
			{		
				format(gametext, sizeof(gametext), 
				"~w~Game objective: Run to the finish line~n~Distance: ~g~%.0f~w~ Time ~g~%d:%d",
				GetPVarFloat(i, "Event2Distance"), ctime/60, ctime%60);
			}
			if(GetPVarInt(i, "EventPart") == 3)
			{		
				format(gametext, sizeof(gametext), 
				"~w~Game objective: Collect dynamite to kill the Boss~n~Dynamite: ~g~%d/15~w~ Time ~g~%d:%d",
				GetPVarInt(i, "EventDynamite"), ctime/60, ctime%60);
			}
			TextDrawSetString(TDTimer[i], gametext);   
			TextDrawShowForPlayer(i, TDTimer[i]);
		} else {
			TextDrawHideForPlayer(i, TDTimer[i]);
		}
		
		//Spawn to quests teleport
		if(IsPlayerInRangeOfPoint(i, 5, -1200.0552, -49.9265, 28.6187))
		{
			GameTextForPlayer(i, "~w~Type ~g~/quest~w~ if you are ready", 5000, 5);
		}
		
		if(GetPVarInt(i, "EventPart") == 1)
		{
			if((second % 30) == 0) // every 30 sec
			{
				SetActorPos(HalloweenActors[1], x+3, y+3, z);
				ApplyActorAnimation(HalloweenActors[1], "PED", "WOMAN_WALKSEXY", 4.1, 1, 1, 1, 1, 0);
			}
			if(GetPVarInt(i, "EventTime") > gettime())
			{
				if(GetPVarInt(i, "EventPumpkins") == 15)
				{
					SendClientMessage(i, 0xF5511CAA,
					"The Halloween costumes are unlocked. Type the secret code in the attachments menu: Bloodrayne, Schoolgirl, Slipknot, Zombieman, Jason");
					GameTextForPlayer(i, "~w~Level ~g~completed!", 5000, 5);
					SetPVarInt(i, "EventPart",2);
				}
			} else {
				GameTextForPlayer(i, "~w~Time is ~r~over!", 5000, 5);
				SetPVarInt(i, "EventPart",0);
				SpawnPlayer(i);
			}
		}
		
		if(GetPVarInt(i, "EventPart") == 2)
		{
			if(GetPVarInt(i, "EventTime") > gettime())
			{
				if(GetPlayerState(i) == PLAYER_STATE_ONFOOT)
				{
					new Float:findistance = GetPlayerDistanceFromPoint(i, 2806.27, 3512.31, 78.80);
					{
						SetPVarFloat(i, "Event2Distance", findistance); // distance to finish
					}
					if(41 - floatround(z) > 5)
					{
						//GameTextForPlayer(i, "~r~ Try again!", 5000, 5);
						SpawnPlayer(i);
					}
				}
				if(IsPlayerInRangeOfPoint(i, 5, 2806.27, 3512.31, 78.80))
				{
					GameTextForPlayer(i, "~w~Level ~g~completed!", 5000, 5);
					SendClientMessage(i, 0xF5511CAA,
					"The Halloween costumes are unlocked. Type the secret code in the attachments menu: Mr.Halloween, Pumpkin, Madclown, BDSM, Maninass, Witch");
					SetPVarInt(i, "EventPart",3);
					SpawnPlayer(i);
				}
			} else {
				GameTextForPlayer(i, "~w~Time is ~r~over. Try again!", 5000, 5);
				SpawnPlayer(i);
			}
		}
		
		if(GetPVarInt(i, "EventPart") == 3)
		{
			if(GetPVarInt(i, "EventTime") > gettime())
			{	
				new Float:bossdistance = GetPlayerDistanceFromPoint(i, 2010.0, 2956, 50.0);
	
				// Dynamic Eyes
				if(!IsPlayerInRangeOfPoint(i, 2, 2010.2813,2931.1782,51.6762) && bossdistance < 30.5)
				{
					SetObjectPos(BossEye1, 2010.370483, 2959.508056, 55.189449);
					SetObjectPos(BossEye2, 2011.932006, 2959.508056, 55.189449);
					if(explodetick < 3) explodetick++;
				} else {
					SetObjectPos(BossEye1, 2010.370483, 2959.508056, 0.0);
					SetObjectPos(BossEye2, 2011.932006, 2959.508056, 0.0);
					if(explodetick > 0) explodetick--;
				}
				// adds warning sound before boss attack
				if(explodetick > 1) {
					PlayerPlaySound(i, 25801, 0.0, 0.0, 0.0); // MECHANIC SLIDE_OUT
				}
				// Boss attack logic
				if(explodetick >= 3)
				{
					if(GetPlayerState(i) == PLAYER_STATE_ONFOOT)
					{
						// Respawn the player if he went outside the arena
						if(52 - floatround(z) > 3) SpawnPlayer(i);
						// checks player near wall or not
						if(!IsPlayerInRangeOfPoint(i, 2, 2010.2813,2931.1782,51.6762))
						{
							if(bossdistance < 30.5) //25 safezone
							{
								//printf("dist %.3f x %.3f y %.3f z %.3f", bossdistance, x, y, z);
								CreateExplosion(x+1.4 + random(1), y+1.4+random(1), z+0.5, 12, 1);
								PlayerPlaySound(i, 6600, 0.0, 0.0, 0.0); // ROOF_COLLAPSE
								explodetick = 0;
							}
						}
					}
				}
				
				if((second % 10) == 0) // health regeneration
				{
					if(health < 40.0) 
					{
						GameTextForPlayer(i, "~r~Refill your health or die", 5000, 5);
					}
					if(health < 100.0) SetPlayerHealth(i, health + 5.0);	
				}

				// Finale 
				if(GetPVarInt(i, "EventDynamite") == 15 || BossHealth <= 0)
				{
					CreateExplosionForPlayer(i, 2004.244995, 2960.198730, 53.519500, 2, 5.0);
					CreateExplosionForPlayer(i, 2011.016479, 2959.297851, 50.509544, 2, 5.0);
					CreateExplosionForPlayer(i, 2017.726318, 2960.198730, 53.759490, 2, 5.0);
					SetObjectPos(BossRedObjects[0], 2004.244995, 2960.198730, 0.0);
					SetObjectPos(BossRedObjects[1], 2011.016479, 2959.297851, 0.0);
					SetObjectPos(BossRedObjects[2], 2011.919433, 2959.582275, 0.0);
					SetObjectPos(BossRedObjects[3], 2010.297851, 2959.582275, 0.0);
					SetObjectPos(BossRedObjects[4], 2017.726318, 2960.198730, 0.0);
					SetTimerEx("EndQuest", 5000, false, "i", i);
					SetPVarInt(i, "EventPart", 0);
				}
			} else {
				GameTextForPlayer(i, "~w~Time is ~r~over. Try again!", 5000, 5);
				SpawnPlayer(i);
			}
		}
	}
	return true;
}

forward EndQuest(playerid);
public EndQuest(playerid)
{
	new gametext[100];
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	GameTextForPlayer(playerid, "~r~Halloween ~w~quest ~g~completed!", 5000, 5);
	SetPVarInt(playerid, "EventPart", 0);
	SetPVarInt(playerid, "EventDynamite", 0);
	SetPlayerWeather(playerid, 20); 
	SetPlayerTime(playerid, 6, 0);
	PlayerPlaySound(playerid, 43001, 0.0, 0.0, 0.0);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 999);
	SpawnPlayer(playerid);
	
	// Restore default boss state
	BossHealth = 3500;
	SetObjectPos(BossRedObjects[0], 2004.244995, 2960.198730, 53.519500);
	SetObjectPos(BossRedObjects[1], 2011.016479, 2959.297851, 50.509544);
	SetObjectPos(BossRedObjects[2], 2011.919433, 2959.582275, 55.147930);
	SetObjectPos(BossRedObjects[3], 2010.297851, 2959.582275, 55.117931);
	SetObjectPos(BossRedObjects[4], 2017.726318, 2960.198730, 53.759490);
	
	format(gametext, sizeof(gametext),
	"Congratulations %s(%d) completed the Halloween quest!", name, playerid);
	SendClientMessageToAll(0xF5511CAA, gametext);
	
	SendClientMessage(playerid, 0xF5511CAA,
	"All the Halloween costumes are unlocked. Type the secret codes in the attachments menu");
	SendClientMessage(playerid, 0xF5511CAA,
	"Secret costumes level 1: Bloodrayne, Schoolgirl, Slipknot, Zombieman, Jason");
	SendClientMessage(playerid, 0xF5511CAA,
	"Secret costumes level 2: Mr.Halloween, Pumpkin, Madclown, BDSM, Maninass, Witch");
	SendClientMessage(playerid, 0xF5511CAA,
	"Secret costumes level 3: Mr.Pumpkin, Revenant, Fireman, MIB, Meatman, RipCJ");
	SendClientMessage(playerid, 0xF5511CAA,
	"Bonus costumes can find at: N - Attachments - Select slot - Bonus.");
	SendClientMessage(playerid, 0xF5511CAA,"Take a screenshot <F8> to save secret codes");
	return true;
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