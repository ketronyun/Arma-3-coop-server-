params["_ch","_cc","_p"];
if(isServer)then{hintSilent format["_ch = %1 _cc = %2",_ch,_cc]};
_p=if!(isNil"_p")then{_p}else{
switch(_ch)do{
case 1:{(allPlayers select{playerSide==side _x})-[player]};
case 2:{allPlayers-[r_p]select{leader group _x==_x}};
case 3:{(units group r_p)select{isPlayer _x}};
case 4:{(crew r_p)select{isPlayer _x}};
case 5:{((allPlayers)-[r_p]select{_x distance r_p<=99})};
default{allPlayers-[r_p]select{side _x==playerSide}}}
};

switch(_ch)do{
case 1:{{r_p remoteExecCall["r_out",_x]}forEach _p};
case 2:{{r_p remoteExecCall["r_out",_x]}forEach _p};
case 3:{{r_p remoteExecCall["r_out",_x]}forEach _p};
case 4:{{"outB2"remoteExecCall["playSound",_x]}forEach _p};
case 5:{r_p remoteExecCall["r_out",_x]};
case(ch6+5):{{r_p remoteExecCall["r_out",_x]}forEach _p};
case(ch7+5):{{r_p remoteExecCall["r_out",_x]}forEach _p};
case(ch8+5):{{r_p remoteExecCall["r_out",_x]}forEach _p}}