// Sunucuysa mesaj sistemini başlat
if (isServer) then {
    [] execVM "Messages.sqf";
[] execVM "scripts\intro.sqf";
	
};

// AFAR sistemi başlatılıyor
[] spawn compileFinal preprocessFileLineNumbers "AFAR\init.sqf";

// BON asker çağırma sistemi
[] execVM "bon_recruit_units\init.sqf";

// Cleanup sistemi
[] execVM "cleanup.sqf";

[terminal] execVM "HackEX\hackex.sqf";

// Revive sistemi başlatılıyor
call compileFinal preprocessFileLineNumbers "FAR_revive\FAR_revive_init.sqf";

[] execVM "scripts\NRE_earplugs.sqf";



[] execVM "oflzBag.sqf";


// Tüm oyuncular kazabilir, sınıf kontrolü yok
_TFB_dig_time = 10;

// Fonksiyon: Siper kaz
TFB_fnc_digTrench = {
    private _unit = _this select 0;
    private _target = _this select 1;
    private _actionID = _this select 2;

    private _pos = getPosATL _target;
    private _trench = createVehicle ["Land_BagFence_Short_F", [_pos select 0, _pos select 1, (_pos select 2) - 0.35], [], 0, "CAN_COLLIDE"];
    _trench setDir (getDir _target - 90);

    _target removeAction _actionID;

    _trench addAction [
        "Fill Trench",
        {
            deleteVehicle (_this select 0);
            (_this select 1) addAction [
                "Dig Trench",
                {
                    [_this select 0, _this select 1, _this select 2] call TFB_fnc_digTrench;
                }
            ];
        }
    ];
};

// Oyuncuya kazma eylemi ver
[player] spawn {
    waitUntil { !isNull player };
    player addAction [
        "Dig Trench",
        {
            [_this select 0, _this select 1, _this select 2] call TFB_fnc_digTrench;
        }
    ];
    hint "Tüm oyuncular için TRENCH aktif!";
};
