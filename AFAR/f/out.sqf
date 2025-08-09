params["_u"];
private _n=getPlayerUID _u;
private _r_f2=r_f getVariable"r_f";
private _f=_r_f2 select{_n in _x};_f apply{deleteVehicle(_x#1)};
{if(_n in _x)then{(r_f getVariable"r_f")deleteAt _forEachIndex};
if(r_p call r_rC)then{if(isAbleToBreathe _u &&{alive _u&&{currentChannel!=5}&&{r_vol>0}})then{playSound"outB2"}}}forEach _r_f2