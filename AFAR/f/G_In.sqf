if(r_p call r_RC)then{
private _p=(units group r_p-[r_p]select{isPlayer _x});
if(r_alertOn)then{r_p call r_alert};
if(count _p>0)then{
if((r_incap)&&(lifeState r_p=="INCAPACITATED"))then{playSound"inB2";[(r_ptt#0),3,_p]call r_out2;3 enableChannel[false,false];setCurrentChannel 5}else{
{(_x#0)enableChannel(_x#1)}forEach[[3,r_grCH],[5,r_dCH]];
[(if(r_RTOBP findIf{unitBackpack r_p isKindOf _x}>=0)then{2}else{1}),_p]call r_d}}else{playSound"inB2"};[]call r_anm}