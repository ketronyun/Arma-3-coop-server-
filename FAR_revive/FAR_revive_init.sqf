//
// Farooq's Revive 1.5a + Oflaz Leş Sistemi v2 - Birleşik
//

// -------------- FAR Parameters -------------------
FAR_BleedOut = 600;	
FAR_EnableDeathMessages = true;
FAR_MuteRadio = false;
FAR_ReviveMode = 1;
#define SCRIPT_VERSION "1.5a"

FAR_isDragging = false;
FAR_isDragging_EH = [];
FAR_deathMessage = [];
FAR_Debugging = true;

if (isDedicated) exitWith {};

// --------- Oflaz Leş Sistemi Ayarları ---------------
private _BAGCLASS    = "Land_Bodybag_01_black_F";
private _SMOKECLASS  = "SmokeShellWhite";
private _OFFSET      = -0.05;
private _SMOKE_DELAY = 55;
private _LIFETIME    = 60;

// Bildirim clientta üst ortada
cutText ["Oflaz'ın Leş Sistemi + Revive Yüklendi", "PLAIN DOWN"];

// Farooq's Revive fonksiyonlarını çağır
call compile preprocessFile "FAR_revive\FAR_revive_funcs.sqf";

// ---------------- FAR Player Init ------------------
FAR_Player_Init =
{
	FAR_PlayerSide = side player;

	player removeAllEventHandlers "HandleDamage";

	player addEventHandler ["HandleDamage", FAR_HandleDamage_EH];

	
	player setVariable ["FAR_isUnconscious", 0, true];
	player setVariable ["FAR_isStabilized", 0, true];
	player setVariable ["FAR_isDragged", 0, true];
	player setVariable ["ace_sys_wounds_uncon", false];
	player setCaptive false;

	FAR_isDragging = false;
	
	[] spawn FAR_Player_Actions;
};


private _fnc_addCorpseActions = {
	params ["_corpse"];

	if (isNull _corpse) exitWith {};
	if (!(_corpse isKindOf "Man")) exitWith {};
	if (_corpse getVariable ["oflz_actions_added", false]) exitWith {};

	_corpse setVariable ["oflz_actions_added", true];

_corpse addAction [
    "<t color='#00FF00'>Cesedi Sürükle</t>",
    {
        params ["_target", "_caller", "_id"];
        _caller attachTo [_target, [0, 1.2, 0]];
        _caller setVariable ["draggingCorpse", _target];
    },
    nil, 1.5, true, true, "", ""  // Koşulu kaldırdım
];


	_corpse addAction [
		"<t color='#FF6600'>Cesedi Bırak</t>",
		{
			params ["_target", "_caller"];
			detach _caller;
			_caller setVariable ["draggingCorpse", nil];
		},
		nil, 1.5, true, true, "", "(_target isKindOf 'Man') && !alive _target && (_caller getVariable ['draggingCorpse', objNull]) isEqualTo _target"
	];

	_corpse addAction [
		"<t color='#FFCC00'>Paketle</t>",
		{
			params ["_target"];
			[_target] call _fnc_packCorpse;
		},
		nil, 1.5, true, true, "", "(_target isKindOf 'Man') && !alive _target"
	];
};

// ----------------- Başlangıç ----------------------------
// Oyuncu hazır olunca başlat
[] spawn
{
	waitUntil {!isNull player};
	
	// Public event handlerleri ayarla
	"FAR_isDragging_EH" addPublicVariableEventHandler FAR_public_EH;
	"FAR_deathMessage" addPublicVariableEventHandler FAR_public_EH;

	[] spawn FAR_Player_Init;

	if (FAR_MuteRadio) then
	{
		[] spawn FAR_Mute_Radio;
	};

	// Tüm mevcut birimlere event handler ekle (AI + Players)
	{
		if (_x isKindOf "Man") then {
			_x addEventHandler ["Killed", {
				params ["_dead"];
				[_dead] spawn {
					sleep 0.5;
					[_this] call _fnc_addCorpseActions;
				};
			}];
		};
	} forEach allUnits;

	// Yeni spawnlanan birimler için
	addMissionEventHandler ["EntityCreated", {
		params ["_entity"];
		if (!isNull _entity && {_entity isKindOf "Man"}) then {
			_entity addEventHandler ["Killed", {
				params ["_dead"];
				[_dead] spawn {
					sleep 0.5;
					[_this] call _fnc_addCorpseActions;
				};
			}];
		};
	}];
};
