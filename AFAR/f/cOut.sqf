if(r_p call r_RC)then{
if((r_incap)&&(lifeState r_p=="INCAPACITATED"))then{2 enableChannel[false,false];setCurrentChannel 5}else{{(_x#0)enableChannel(_x#1)}forEach[[2,r_cCH],[5,r_dCH]];{r_p remoteExecCall["r_out",_x]}forEach(allPlayers-[r_p]select{leader group _x==_x&&side _x==playerSide})};
if(r_vol>0)then{playSound("out"+str([]call rVolu))}
}