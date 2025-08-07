if (isServer) then {[] execVM "Messages.sqf"};

[] execVM "bon_recruit_units\init.sqf";
[] execVM "cleanup.sqf";
call compileFinal preprocessFileLineNumbers "FAR_revive\FAR_revive_init.sqf";



//player addAction["<t color='#ff9900'>Asker Çağır</t>", "bon_recruit_units\open_dialog.sqf"] call BIS_fnc_MP;