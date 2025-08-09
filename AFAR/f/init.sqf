waitUntil{!isNull(findDisplay 46)};private _d=findDisplay 46;
r_f="Logic" createVehicleLocal [0,0,0];r_f enableSimulation false;
r_f setVariable["r_f",[]];
r_myCH=5;
missionNamespace setVariable["r_p",player];setCurrentChannel 5;
[]spawn{waitUntil{r_p==player};[]call r_allOn};

//Toggle radio channels when radio dropped/picked up
r_p addEventHandler["Put",{if(_this#2 in r_radios||(r_RTOBP findIf{unitBackpack r_p isKindOf _x}>=0))then{if(r_p call r_RC)exitWith{};[]call r_allOff;{deleteVehicle(_x#1)}forEach(r_f getVariable"r_f");r_f setVariable["r_f",[]];{r_p remoteExecCall["r_out",_x]}forEach(allPlayers-[r_p]select{side _x==playerSide});
{uiNamespace setVariable[_x,nil]}forEach["AFAR_Pos","AFAR_txtPos","AFAR_txt2Pos","AFAR_batPos","AFAR_halpPos","AFAR_but2Pos","AFAR_but3Pos","AFAR_but4Pos"];r_UI=0}}];
r_p addEventHandler["Take",{if(_this#2 in r_radios||(r_RTOBP findIf{unitBackpack r_p isKindOf _x}>=0))then{if(alive r_p)then{[]call r_allOn}}}];

//EHs to call In & Out functions on KeyPress/Release
_d displayAddEventHandler["KeyDown",{_block=false;if((_this#1)in(actionKeys"VoiceOverNet"))then{_block=true;titleText["Replace your 'VoiceOverNet' key with 'PushToTalk' instead!","PLAIN"];setCurrentChannel 5};_block}];
if(!r_chOn)then{(findDisplay 46)displayAddEventHandler["KeyDown",{[]call r_noCHS}]};


//onEachFrame StackedEventHandler for PushToTak detection
r_dn_=false;r_up_=false;
afarDn=["afarKey","onEachFrame",
{
private _ptt=[
"PushToTalkAll",
"PushToTalkSide",
"PushToTalkCommand",
"PushToTalkGroup",
"PushToTalkVehicle",
"PushToTalkDirect",
"pushToTalk",
"voiceOverNet"
]findIf{inputAction _x>0};

if(!r_dn_&&_ptt>-1)then{
r_dn_=true;r_up_=false;_ptt call r_dn}else{
if(r_dn_&&_ptt==-1)then{
r_dn_=false;r_up_=true;0 call r_up}};
},
nil
]call BIS_fnc_addStackedEventHandler;


//Talking + reloading bug workaround
_d displayAddEventHandler["KeyDown","if(_this#1 in(actionKeys'reloadMagazine'))then{if(!r_Anim)exitWith{};if(isNull objectParent r_p && alive r_p && currentWeapon r_p!='')then{r_Anim=false;[]spawn{sleep 5;r_Anim=true}}}"];

//Cycling channels via keybinds
_d displayAddEventHandler["KeyDown",{_block=false;if((_this#1)in(actionKeys'nextChannel'))then{_block=true;if(r_chOn)then{[]call NextCH}else{[]call r_useRadio}};_block}];
_d displayAddEventHandler["KeyDown",{_block=false;if((_this#1)in(actionKeys'prevChannel'))then{_block=true;if(r_chOn)then{[]call PrevCH}else{[]call r_useRadio}};_block}];

//Vehicle channel detection
r_p addEventHandler["GetInMan",{4 enableChannel r_vCH;(_this#0)call r_RTO;r_myCH=currentChannel;}];
r_p addEventHandler["GetOutMan",{4 enableChannel[false,false];(_this#0)call r_RTO;if(currentChannel==4)then{if(true in channelEnabled r_myCH)then{setCurrentChannel r_myCH}else{setCurrentChannel 5}}}];


r_p addEventHandler["Killed",{r_myCH=currentChannel;[(r_ptt#0)]call r_out2;[]call r_allOff;{deleteVehicle(_x#1)}forEach(r_f getVariable"r_f");r_f setVariable["r_f",[]];
{r_p remoteExecCall["r_out",_x]}forEach(allPlayers-[r_p]select{side _x==playerSide});
if("Spectator"in getMissionConfigValue"respawnTemplates")then{_ch9=(ch9+5);ch9 radioChannelAdd[player];_ch9 enableChannel[true,true];setCurrentChannel _ch9}}];

r_p addEventHandler["Respawn",{if(alive player&& !isNull player)then{if("Spectator"in getMissionConfigValue"respawnTemplates")then{ch9 radioChannelRemove[player]};missionNamespace setVariable["r_p",player];
[]call r_allOn;
if(true in channelEnabled r_myCH)then{setCurrentChannel r_myCH}else{setCurrentChannel 5};r_dn_=false;}}];

//Block channel switching in Esc menu
r_escD=0;
[missionNamespace,"OnGameInterrupt",{
[(_this#0)]spawn{params["_d"];waitUntil{!isNull _d};
r_escD=_d displayAddEventHandler["KeyDown",{_block=false;if((_this#1)in(actionKeys"nextChannel"+actionKeys"prevChannel"))then{_block=true};_block}];
r_myCH=currentChannel;
(_this#0)spawn{waitUntil{isNull(_this)};_this displayRemoveEventHandler["KeyDown",r_escD];
if(currentChannel==r_myCH)exitWith{};
if((!alive r_p)||{(isObjectHidden r_p)||(isNull player)})then{if("Spectator"in getMissionConfigValue"respawnTemplates")then{ch9 radioChannelRemove[player]}else{[]call r_allOff}};
setCurrentChannel r_myCH}}}]call BIS_fnc_addScriptedEventHandler;

//Radio UI DblClick ctrlEventHandler
player addEventHandler["InventoryOpened",{
[]spawn{waitUntil{!isNull(findDisplay 602)};
(findDisplay 602)displayCtrl 6214 ctrlAddEventHandler["MouseButtonDblClick",{
params["_ctrl", "_btn"];
if(r_radios findIf{_x in(assignedItems r_p)}==-1)exitWith{};
closeDialog 602;
playSound"click";
0 call r_useRadio;
}]}}];

systemChat"[AFAR: View radio by double-clicking your equipped radio]";
if(actionKeys"PushToTalk"isEqualTo[])then{systemChat"[!]: Please set a PushToTalk keybind, via the Multiplayer controls!"};
if(!(actionKeys"VoiceOverNet"isEqualTo[]))then{systemChat"[!]: Please unbind your VoiceOverNet keybind via Multiplayer controls! (Use PushToTalk instead)"};
if((getAudioOptionVolumes#3)<0.1)then{systemChat"[!]: Please raise your VON volume in audio settings!"};


[0,(allPlayers-[r_p])]call r_d;
systemChat"[AFAR: Initialized]";setCurrentChannel 5;	