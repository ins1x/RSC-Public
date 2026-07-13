# TechnicalDocumentation
Gamemode: CW/TG Sandbox gamemode by Russian Sawn-off Community 2023

## Features
- Fixed known [issues causing problems](https://team.sa-mp.com/wiki/Bugs.html) on the SA:MP server 
- [SAMPCAC](https://github.com/ins1x/sampcac-docs/) and [Nex-AC](https://github.com/NexiusTailer/Nex-AC) Anticheat integration  
- Pull out maximum possibilities from the server mainly with memory editing and hooking by [YSF](https://github.com/IllidanS4/YSF) plugin  
- Improved built-in server-side anticheat detecting many popular damage and weapon hacks  
- Works correctly in all [lag compensation](https://open.mp/docs/server/LagCompensation) modes (lagshot-skinshot)  
- Simple and fast player data storage system [Sqlite](https://sampwiki.blast.hk/wiki/Category:SQLite)  
- Improved Skinshot Synchronization (need [SKY](https://github.com/oscar-broman/SKY) plugin and [weapon-config.inc](https://github.com/oscar-broman/samp-weapon-config/blob/master/weapon-config.inc)).
- CW/TG system integrate to access basic game functions with simple menu  
- Administrators system (Logs, Ban, Monitoring, Specbar, DBmanagment etc)  
- Raid's protection system, detect (VPN, Mobile, Bots, Recon, Spam)  
- A unique system of virtual worlds with a wide range of features  
- NPCs system for training players [FCNPC](https://github.com/ziggi/FCNPC)   

## Build recomendations
Use the [Zeex's improved compiler](https://github.com/pawn-lang/compiler) to build this gamemode!   
Editor options: TABSIZE 4, encoding windows-1251, Lang EN-RU.  
Example [server.cfg](https://open.mp/docs/server/server.cfg) configfile:

```
gamemode0 cwPublic
filterscripts sampcac_base sampcac_gameresource
plugins crashdetect sscanf sampcac_server YSF streamer FCNPC
maxnpc 50
```

To enable improved sync #define _IMPROVED_SYNC_ and recompile gamemode 
> Need plugin dependent [SKY](https://github.com/oscar-broman/SKY) and [weapon-config.inc](https://github.com/oscar-broman/samp-weapon-config/blob/master/weapon-config.inc)  

It is not recommended to use [fixes.inc](https://github.com/pawn-lang/sa-mp-fixes) due to compatibility issues.  
All the necessary features from this include have already been included

## Requirements
* [SA:MP 0.3.7 R2 server](https://samp.romzes.com/files/samp037_svr_R2-2-1_win32.zip) or highter
* [Incognito Streamer 2.9 plugin](https://github.com/samp-incognito/samp-streamer-plugin/releases)
* [Crashdetect 4.19 plugin](https://github.com/Zeex/samp-plugin-crashdetect/releases)
* [Sscanf 2.8 plugin](https://github.com/Y-Less/sscanf/releases)
* [YSF 2.1 plugin](https://github.com/IllidanS4/YSF) 
* [SAMPCAC 0.10.0 plugin](https://github.com/ins1x/RSC/blob/main/include/sampcac.inc) 
* [FCNPC 2.0.8 plugin](https://github.com/ziggi/FCNPC)

## Anticheat
Sampcac anti-cheat is outdated and no longer supported.  
But its functionality is quite enough for our needs.  
Add only sampcac_base filterscript at config!!  
Documentation: https://github.com/ins1x/sampcac-docs  
> Players with SAMPCAC must connect from the [SA-MP 0.3.7 R1 Client](https://github.com/ins1x/sampcac-docs/raw/main/client/sa-mp-0.3.7-install.exe)

We use a modified version of this nexac include for our needs.  
look (#if defined RSC) in nex-ac.inc  
(Such as anti-cheat statistics, reset parameters, etc.)  
https://github.com/NexiusTailer/Nex-AC  

## Gamemode Logic

#### Connect sequence
- Check Valid Name (bad symbols, avertising) 
- Start sampcac memory check (if CAC on)
- Get player GeoIP data (ip-api.com service)
- Fake client check (Rakbot, RakDroid, old S0beits)
- Hardware ban check (hwis, gpci) - > DB core request
- Mute bypass checker (by ip) - > DB accounts request
- Check is server locked
- Preset enviroments
- CAC check
- VPN/Proxy check
- Load textdraws 
- RemoveServerBuildings
- Login dialog 

#### Login sequence
- Check players gcpi and ip for this nickname
  if they match -> Autologin
  else -> Login Dialog
- After login show class select dialog
  Check speconly mode if not active players on speconly start flymode
  Check locked teams

## Known Bugs
The mod needs to be reloaded once a day, otherwise on the third day false anti-cheat tests begin. On the 7th day, the timers are loaded. On the 10th day, the flight mode of the camera is switched off.  

## Monitorings
Check the availability of the host from other countries: https://check-host.net/check-http?host=82.208.17.10
#### SA:MP Monitoring
- https://samp-rating.ru/server/15929/  
- https://www.gs4u.net/ru/s/233929.html  
- https://www.open.mp/ru/servers/82.208.17.10:27981  