/*
	Filterscript: Halloween Quest
	Created specifically for RSC server 
	CW/TG gamemode powered by Russian Sawn-off Community 2023
	find us: https://dsc.gg/sawncommunity
	Author: 1NS 
	Description: Halloween 2023
*/

#include <a_samp>
#include <streamer>

// ignore literal array/string passed to a non-const parameter
#pragma warning disable 239

new HalloweenActors[1];

public OnFilterScriptInit()
{ 
	// actors
	HalloweenActors[0] = CreateDynamicActor(91, -1242.7585,-73.5721,25.9477,40.5444, 1, 100.0, 0);
	ApplyDynamicActorAnimation(HalloweenActors[0], "GRAVEYARD", "MRNF_LOOP", 4.1, 1, 0, 0, 0, 0);
	SetDynamicActorVirtualWorld(HalloweenActors[0], 0);
	
	SendRconCommand("hostname Russian Sawn-off Community | Halloween");
	
	// mapping section
	new tmpobjid, object_world = -1, object_int = -1;
	
	// LoadSpawn
	tmpobjid = CreateDynamicObject(19481, -1235.479614, -87.738426, 13.181521, 0.000000, 90.000000, 45.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(11385, -1273.026489, -114.045562, 13.208758, 0.000000, 0.000000, -45.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(4206, -1235.604736, -19.071733, 13.271051, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -1193.291137, -133.035751, 13.181521, 0.000000, 90.000000, 45.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -1214.991699, -65.514114, 26.411518, 0.000000, 90.000000, -45.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -1204.995117, -87.544692, 13.216059, 0.000000, 90.000000, -45.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -1199.673706, -100.293418, 13.216059, 0.000000, 90.000000, -24.900001, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(11385, -1255.831420, -145.420654, 13.208758, 0.000000, 0.000000, 157.499801, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(19334, -1234.756591, -18.468473, -1.414978, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 14803, "bdupsnew", "Bdup2_wallpaperC", 0x00000000);
	tmpobjid = CreateDynamicObject(19278, -1205.259155, -55.443405, -22.867740, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 2, 13691, "bevcunto2_lahills", "crazypave", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 13691, "bevcunto2_lahills", "crazypave", 0x00000000);
	tmpobjid = CreateDynamicObject(18846, -1244.573974, -22.859003, 23.238050, 5.699997, 115.599983, 28.800006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(18846, -1238.546386, -29.020608, 23.168018, -5.099997, 111.799980, 73.899978, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(11385, -1301.991943, -98.063415, 13.208758, 0.000000, 0.000000, 153.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(18846, -1243.462890, -25.758543, 14.607975, 5.699995, 115.599983, 28.800006, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(18846, -1240.890991, -28.840545, 13.644770, 5.699995, 115.599983, 60.599964, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	tmpobjid = CreateDynamicObject(2810, -1227.194335, -61.202602, 24.828987, 15.999998, -21.399999, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2589, "ab_ab", "ab_carcass", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 2589, "ab_ab", "ab_carcass", 0x00000000);
	tmpobjid = CreateDynamicObject(11385, -1220.869750, -166.858230, 13.208758, 0.000000, 0.000000, 8.099796, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(11385, -1180.847045, -168.496810, 13.198759, 0.000000, 0.000000, 11.999795, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -1138.458374, -115.364112, 19.471202, -173.499908, 15.299987, -104.100028, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "!", 120, "Webdings", 120, 0, 0xFF000000, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(11385, -1339.565063, -165.254302, 13.208758, 0.000000, 0.000000, -45.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -1295.208496, 37.129554, 13.181521, 0.000000, 90.000000, 45.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -1249.647583, 8.217704, 13.181521, 0.000000, 90.000000, 129.899993, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(11385, -1309.956542, -51.866592, 13.208758, 0.000000, 0.000000, 153.999938, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(11385, -1325.838989, -13.940241, 13.208758, 0.000000, 0.000000, -1.100013, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -1256.545166, -75.435432, 13.493754, 7.299997, 0.000000, 135.500015, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "Make us whole", 130, "Courier New", 20, 1, 0xFF880000, 0x00000000, 0);
	tmpobjid = CreateDynamicObject(19477, -1241.607910, -60.390422, 17.157613, -89.600021, 45.000000, 0.399998, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(2810, -1129.069335, -202.844955, 11.872974, 0.000000, -7.499991, 141.599914, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18773, "tunnelsections", "stonewall4", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18773, "tunnelsections", "stonewall4", 0x00000000);
	tmpobjid = CreateDynamicObject(2743, -1128.177734, -202.287780, 13.234040, 0.000000, 0.000000, -87.800003, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2905, "dead_mantxd", "billyblood", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 2905, "dead_mantxd", "billyblood", 0x00000000);
	tmpobjid = CreateDynamicObject(2810, -1127.965820, -199.371932, 12.070611, 16.400003, -27.699995, 34.699989, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18773, "tunnelsections", "stonewall4", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18773, "tunnelsections", "stonewall4", 0x00000000);
	tmpobjid = CreateDynamicObject(2810, -1126.776855, -201.808868, 12.130900, 0.000000, -27.699995, -37.099979, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18773, "tunnelsections", "stonewall4", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18773, "tunnelsections", "stonewall4", 0x00000000);
	tmpobjid = CreateDynamicObject(2810, -1128.325439, -203.701751, 12.190241, 0.000000, -27.699995, -176.700057, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18773, "tunnelsections", "stonewall4", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18773, "tunnelsections", "stonewall4", 0x00000000);
	tmpobjid = CreateDynamicObject(3092, -1212.142211, -32.497234, 36.036853, 0.000000, 0.000000, 166.900039, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 1, 2905, "dead_mantxd", "billyblood", 0x00000000);
	tmpobjid = CreateDynamicObject(19480, -1128.425781, -201.208114, 13.205819, 0.000000, 90.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 5069, "ctscene_las", "ruffroadlas", 0x00000000);
	tmpobjid = CreateDynamicObject(2809, -1128.193481, -202.272430, 13.189805, 0.000000, 0.000000, -101.700012, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 16407, "des_airfieldhus", "quar_cranerail", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 2905, "dead_mantxd", "billyblood", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -1142.014282, -114.409347, 18.118606, 54.899997, -19.999998, -86.799987, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "\"", 130, "Webdings", 190, 0, 0xFFFFFFFF, 0x00000000, 1);
	tmpobjid = CreateDynamicObject(835, -1236.760742, -18.622358, 27.601156, 0.000000, -77.300003, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "silk8-128x128", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 19480, "signsurf", "sign", 0x00000000);
	tmpobjid = CreateDynamicObject(19481, -1149.081054, -115.929550, 13.216058, 0.000000, 90.000000, 67.999984, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(19944, -1140.777709, -122.409454, 23.313316, 80.699996, -72.500007, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "silk5-128x128", 0x00000000);
	tmpobjid = CreateDynamicObject(19944, -1144.804077, -116.819900, 25.377214, 80.699996, -19.500026, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19058, "xmasboxes", "silk5-128x128", 0x00000000);
	tmpobjid = CreateDynamicObject(11385, -1289.091064, -215.727569, 13.208758, 0.000000, 0.000000, -45.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(8493, -1111.918334, -24.221458, 16.204032, 0.000000, 0.000000, 68.799995, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18027, "cj_barb2", "BLOCK2low", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 18027, "cj_barb2", "BLOCK2low", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 2, 18027, "cj_barb2", "BLOCK2low", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 3, 18027, "cj_barb2", "BLOCK2low", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 4, 18027, "cj_barb2", "BLOCK2low", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 5, 18027, "cj_barb2", "BLOCK2low", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 6, 18027, "cj_barb2", "BLOCK2low", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 7, 18027, "cj_barb2", "BLOCK2low", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 8, 18027, "cj_barb2", "BLOCK2low", 0x00000000);
	tmpobjid = CreateDynamicObject(3462, -1170.689208, -107.471122, 27.097122, 0.000000, 0.000000, 40.999992, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2589, "ab_ab", "ab_carcass", 0x00000000);
	tmpobjid = CreateDynamicObject(2745, -1174.651855, -108.872222, 26.734085, 0.000000, 0.000000, 87.099998, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 3, 2905, "dead_mantxd", "billyblood", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 5, 2905, "dead_mantxd", "billyblood", 0x00000000);
	tmpobjid = CreateDynamicObject(14467, -1176.508911, -113.150535, 28.287494, 0.000000, 0.000000, 137.799972, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 19480, "signsurf", "sign", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 1, 2589, "ab_ab", "ab_carcass", 0x00000000);
	tmpobjid = CreateDynamicObject(2745, -1172.535278, -111.866157, 26.734085, 0.000000, 0.000000, 159.700027, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 3, 2905, "dead_mantxd", "billyblood", 0x00000000);
	SetDynamicObjectMaterial(tmpobjid, 5, 2905, "dead_mantxd", "billyblood", 0x00000000);
	tmpobjid = CreateDynamicObject(2906, -1170.888793, -107.247726, 27.721406, -85.499984, 0.000000, 116.899971, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2589, "ab_ab", "ab_carcass", 0x00000000);
	tmpobjid = CreateDynamicObject(2906, -1170.634521, -107.735466, 27.721406, -85.499984, 0.000000, -67.900123, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 2589, "ab_ab", "ab_carcass", 0x00000000);
	tmpobjid = CreateDynamicObject(19480, -1175.447021, -112.487030, 26.388128, 0.000000, 90.000000, -45.000000, object_world, object_int, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	
	tmpobjid = CreateDynamicObject(2906, -1289.442993, -111.972213, 13.241559, 173.100051, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2803, -1212.722534, -94.675819, 13.591567, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(16410, -1202.522460, -68.598129, 26.162237, -2.299998, 9.700001, -35.099998, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(6865, -1234.895019, -85.083702, 20.077640, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(735, -1215.638793, -32.019496, 11.154808, 0.000000, 0.000000, 71.399993, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(735, -1182.071655, -66.053924, 11.154808, 0.000000, 0.000000, 122.000122, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(6865, -1195.744750, -132.563613, 20.077640, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(735, -1139.449340, -113.637969, 11.154808, 0.000000, 0.000000, 122.000122, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(16410, -1216.101806, -48.784931, 25.827766, -6.899998, -12.999991, -35.099998, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(3524, -1210.967529, -54.357158, 24.299364, 0.000000, 0.000000, -45.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(3524, -1204.165893, -61.201950, 24.319356, 0.000000, 0.000000, -45.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19320, -1180.623291, -148.332672, 13.407270, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19320, -1250.636962, -69.389007, 13.387804, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2907, -1269.973388, -161.455474, 13.256519, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(12961, -1218.165893, -85.485076, 25.487079, 0.199999, -12.199999, 131.900024, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(12961, -1234.636596, -67.128631, 25.578798, -0.099999, 11.199995, 131.900024, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(9931, -1270.943237, 22.831539, 29.760797, 0.000000, 0.000000, -45.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(9931, -1277.576049, 60.407691, 29.760797, 0.000000, 0.000000, -135.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(735, -1228.864013, 7.566202, 11.154808, 0.000000, 0.000000, 71.399993, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2905, -1295.321777, 40.089633, 13.220623, 178.700057, -3.600001, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2905, -1241.576171, -60.194629, 16.548656, -68.399993, 20.300006, -20.400007, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2907, -1241.681518, -60.495681, 17.427900, -89.300018, -47.599994, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2906, -1241.344970, -60.112586, 17.906417, 30.800006, 0.000000, -41.900009, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2905, -1241.836059, -60.528778, 16.484811, -92.300025, 20.300006, -20.400007, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2906, -1242.027709, -60.828292, 17.901189, 144.500106, 0.000000, -41.900009, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19944, -1128.606811, -198.878173, 13.047286, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19559, -1128.088989, -202.204040, 14.067728, 0.000000, 0.000000, 80.000045, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(3013, -1127.870971, -202.234756, 14.100086, 0.000000, 87.899925, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2907, -1202.809326, -108.235176, 13.564417, -89.300018, -47.599994, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2905, -1202.942626, -107.788032, 13.314570, 178.599884, -87.499992, -144.999984, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2906, -1202.959350, -108.421890, 13.536258, -110.299713, 126.100059, -47.099990, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(16444, -1219.346069, -35.189994, 13.352990, 0.000000, 0.000000, 71.699989, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19527, -1219.315185, -32.025241, 13.080106, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19296, -1244.085449, -22.670860, 23.159355, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19296, -1238.644409, -28.870861, 23.159355, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19296, -1236.050048, -84.896743, 21.009672, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19296, -1234.819702, -85.976722, 21.009672, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(16052, -1192.663818, -129.434600, 27.755874, 0.000000, -0.499998, 133.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19282, -1138.571655, -115.758285, 18.096794, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(19282, -1138.231323, -115.758285, 18.206796, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2905, -1143.648437, -121.342941, 13.263850, 178.599884, -87.499992, -144.999984, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(8483, -1382.194458, -265.119781, 17.958530, 0.000000, 0.000000, 40.500015, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(18749, -1178.664428, -116.305267, 26.402969, -87.999984, 11.099994, -58.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(841, -1170.802001, -107.547157, 26.455884, -0.899996, -4.699989, 38.400016, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(18691, -1170.996582, -107.708694, 24.708913, 0.000000, 0.000000, 0.000000, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2805, -1170.697998, -107.529106, 28.400695, 0.000000, 179.599960, 53.700023, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(841, -1170.577758, -107.549392, 26.477550, 2.900002, -2.099982, -90.200057, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(2908, -1176.394653, -112.049263, 29.229673, -91.700012, 0.000000, -128.200012, object_world, object_int, -1, 300.00, 300.00); 
	tmpobjid = CreateDynamicObject(12961, -1185.350952, -122.205032, 26.656026, 0.199999, 0.600001, 135.000000, object_world, object_int, -1, 300.00, 300.00); 

	// Village 2022
	tmpobjid = CreateDynamicObject(19078, -387.779785, 2218.948242, 46.029232,
	4.600030, -90.499977, -71.800010); 
	SetDynamicObjectMaterial(tmpobjid, 0, 18996, "mattextures", "sampblack", 0x00000000);
	tmpobjid = CreateDynamicObject(19477, -393.151428, 2228.148925, 41.463741, 0.000000, -89.500000, 0.000000, -1); 
	SetDynamicObjectMaterial(tmpobjid, 0, 14612, "ab_abattoir_box", "ab_bloodfloor", 0x00000000);
	tmpobjid = CreateDynamicObject(19477, -397.627777, 2225.707519, 43.319625, 11.700001, 0.000000, 14.299999, -1); 
	SetDynamicObjectMaterialText(tmpobjid, 0, "Arco del oeste", 40, "Comic Sans MS", 25, 1, 0xF4400000, 0x00000000, 0);
	CreateDynamicObject(12957, -396.845092, 2184.647949, 41.671051, -3.199999, 0.000000, -179.699966, -1); 
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
	CreateDynamicObject(3872, -376.225006, 2240.291503, 39.865821, 1.099999, 0.000000, 0.000000, -1); 
	CreateDynamicObject(3872, -377.884857, 2245.916992, 39.973712, 3.699999, 0.000000, 0.000000, -1); 
	CreateDynamicObject(1739, -393.469451, 2227.987060, 42.179672, 0.000000, 0.000000, 169.199996, -1);
	CreateDynamicObject(2680, -361.319793, 2221.890380, 42.785900, 14.700004, -11.500000, -61.400016, -1);
	// Village fire
	CreateDynamicObject(18691, -359.720214, 2224.478515, 41.491203, 0.0, 0.0, 0.0, -1); 
	CreateDynamicObject(18691, -359.720214, 2221.669189, 44.561218, 0.0, 0.0, 0.0, -1); 
	CreateDynamicObject(18691, -352.650177, 2221.669189, 47.091262, 0.0, 0.0, 0.0, -1); 
	CreateDynamicObject(18691, -351.960052, 2225.052490, 44.731277, 0.0, 0.0, 0.0, -1);
	CreateDynamicObject(18691, -391.759857, 2227.551513, 45.491180, 0.0, 0.0, 0.0, -1);  
	CreateDynamicObject(18691, -399.469726, 2248.592773, 42.731189, 0.0, 0.0, 0.0, -1);  
	CreateDynamicObject(18691, -393.539916, 2248.592773, 39.241176, 0.0, 0.0, 0.0, -1);  
	CreateDynamicObject(18691, -399.899902, 2241.453613, 43.451179, 0.0, 0.0, 0.0, -1);  
	CreateDynamicObject(18691, -398.249908, 2227.842285, 43.451179, 0.0, 0.0, 0.0, -1);  
	CreateDynamicObject(18691, -376.949707, 2239.482421, 43.861171, 0.0, 0.0, 0.0, -1);  
	CreateDynamicObject(18691, -376.859863, 2242.225097, 40.441169, 0.0, 0.0, 0.0, -1);  
	CreateDynamicObject(18691, -378.109832, 2248.085937, 41.371139, 0.0, 0.0, 0.0, -1);  
	CreateDynamicObject(18691, -387.169769, 2217.047119, 40.381145, 0.0, 0.0, 0.0, -1);  
	CreateDynamicObject(18691, -385.349792, 2207.416259, 43.871147, 0.0, 0.0, 0.0, -1);  
	CreateDynamicObject(18691, -392.069732, 2207.416259, 45.931156, 0.0, 0.0, 0.0, -1);  
	// end mapping
    return true; 
} 

public OnFilterScriptExit()
{ 
	// Unused
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
	
	SendClientMessage(playerid, 0xF5511CAA,	"Halloween Is Coming!");
	
	PlayAudioStreamForPlayer(playerid,"https://www.myinstants.com/media/sounds/sounds_5861469915393822539981.mp3");
	
	return true;
} 

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/quest", true) || !strcmp(cmdtext, "/ghosttown", true))
	{
		SetPlayerWeather(playerid, 9); 
		SetPlayerTime(playerid, 23, 0);
		SetPlayerPos(playerid, -374.0404,2198.2251,42.0865);
		SetPlayerFacingAngle(playerid, 11.5158);
		return true;
	}
	return false;
}