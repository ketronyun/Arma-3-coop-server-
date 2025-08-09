private _seat=[["Driver"],["driver"],["Turret",[0]],["Turret",[0,0]]];private _p=[];
if((r_RTOBP findIf{unitBackpack r_p isKindOf _x}>=0)||{(assignedVehicleRole r_p in _seat && objectParent r_p isKindOf"Air" && !(objectParent r_p isKindOf"ParachuteBase"))})then{
{private _y=_x;if((r_RTOBP findIf{unitBackpack _y isKindOf _x}>=0)||{(assignedVehicleRole _x in _seat && objectParent _x isKindOf"Air" && !(objectParent _x isKindOf"ParachuteBase"))})then{_p pushBack _x}}forEach(allPlayers-[r_p]select{playerSide==side _x});
if(r_alertOn)then{r_p call r_alert};
if(count _p>0)then{
if((r_incap)&&(lifeState r_p=="INCAPACITATED"))then{
{(_x#0)enableChannel[false,false];(_x#1)radioChannelRemove[r_p]}forEach[[(ch6+5),ch6],[(ch7+5),ch7],[(ch8+5),ch8]];setCurrentChannel 5;playSound"inB2";
switch(playerSide)do{
case WEST:{[(r_ptt#0),(ch6+5),_p]call r_out2};
case EAST:{[(r_ptt#0),(ch7+5),_p]call r_out2};
case INDEPENDENT:{[(r_ptt#0),(ch8+5),_p]call r_out2};
}
}else{
switch(playerSide)do{
case WEST:{(ch6+5)enableChannel r_mCH};
case EAST:{(ch7+5)enableChannel r_mCH};
case INDEPENDENT:{(ch8+5)enableChannel r_mCH}};[2,_p]call r_d;if(r_vol>0)then{playSound("inA"+str([]call rVolu))}};
}else{playSound"inB2"};[]call r_anm}else{
{(_x#0)enableChannel[false,false];(_x#1)radioChannelRemove[r_p]}forEach[[(ch6+5),ch6],[(ch7+5),ch7],[(ch8+5),ch8]];setCurrentChannel 5};