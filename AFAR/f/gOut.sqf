if(r_p call r_RC)then{
if((r_incap)&&(lifeState r_p=="INCAPACITATED"))then{3 enableChannel[false,false];setCurrentChannel 5}else{{(_x#0)enableChannel(_x#1)}forEach[[3,r_grCH],[5,r_dCH]];{r_p remoteExecCall["r_out",_x]}forEach(units group r_p-[r_p]select{isPlayer _x})};
if(r_vol>0)then{playSound("out"+str([]call rVolu))}
}