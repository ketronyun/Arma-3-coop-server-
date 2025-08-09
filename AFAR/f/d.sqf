if(((_this#0)==0)&&(_this#1)isEqualTo[])exitWith{};
private _d=[];
{_d pushBack[_x distance r_p,_x]}forEach(_this#1);

switch(_this#0)do{
case 0:{{[r_p,1]remoteExecCall["setPlayerVONVolume",(_x#1)];(_x#1)setPlayerVONVolume 1}forEach _d};

case 1:{
if((!isNull objectParent r_p)&&{((getNumber(configFile>>"CfgVehicles">>(typeOf objectParent r_p)>>"Side")==3)&&(getVehicleCargo(objectParent r_p)==0)) || (((assignedVehicleRole r_p#0) in["driver","Driver","turret","Turret"])&&((_d findIf{(_x#0)<=9600})>-1))})exitWith{
{private _p=(_x#1);if((_x#0)>9600||{(r_radios findIf{_x in(assignedItems r_p)}<0)&&(r_RTOBP findIf{unitBackpack _p isKindOf _x}<0)})then{
[r_p,0]remoteExecCall["setPlayerVONVolume",_p];_p setPlayerVONVolume 0}else{
[0,r_p]remoteExec["r_fuzz",_p];[2,r_p,(_x#0)]remoteExecCall["rVol",_p];_p setPlayerVONVolume r_vol}}forEach _d;if(r_vol>0)then{playSound("in"+str([]call rVolu))}};
if(({(_x#0)<=3200}count _d)isEqualTo[])exitWith{playSound"inB2"};
{private _p=(_x#1);if((_x#0)>3200||{(r_radios findIf{_x in(assignedItems r_p)}<0)&&(r_RTOBP findIf{unitBackpack _p isKindOf _x}<0)})then{
[r_p,0]remoteExecCall["setPlayerVONVolume",_p];_p setPlayerVONVolume 0}else{
[0,r_p]remoteExec["r_fuzz",_p];[1,r_p,(_x#0)]remoteExecCall["rVol",_p];_p setPlayerVONVolume r_vol}}forEach _d;if(r_vol>0)then{playSound("in"+str([]call rVolu))}};

case 2:{
if(({(_x#0)<=9600}count _d)isEqualTo[])exitWith{playSound"inB2"};
{private _p=(_x#1);if((_x#0)>9600||{(r_radios findIf{_x in(assignedItems r_p)}<0)&&(r_RTOBP findIf{unitBackpack _p isKindOf _x}<0)})then{
[r_p,0]remoteExecCall["setPlayerVONVolume",_p];_p setPlayerVONVolume 0}else{
[1,r_p]remoteExec["r_fuzz",_p];[2,r_p,(_x#0)]remoteExecCall["rVol",_p];_p setPlayerVONVolume r_vol}}forEach _d;if(r_vol>0)then{playSound("inA"+str([]call rVolu))}}}