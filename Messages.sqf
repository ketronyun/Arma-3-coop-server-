if (!isServer) exitWith {};


_messages =
[
	"This mission can be downloaded on the Steam Workshop! Search for 'Arma 3 Sandbox [Altis]'",
	"Remember to rate and favorite this mission on the Steam Workshop!"
];

_msgIndex = 0;

while {true} do {
	sleep 240;

	_msg = _messages select _msgIndex;
	{SystemChat _msg} remoteExecCall ["BIS_fnc_spawn",0];

	_msgIndex = _msgIndex + 1;
	if (_msgIndex == (count _messages)) then {
		_msgIndex = 0;
	};
};