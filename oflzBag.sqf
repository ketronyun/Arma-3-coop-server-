// oflzBag.sqf
if (isDedicated) exitWith {};  // Serverda çalışmasın, sadece clientta

// Ayarlar
private _BAGCLASS    = "Land_Bodybag_01_black_F";
private _SMOKECLASS  = "SmokeShellWhite";
private _OFFSET      = -0.05;     // Bodybag hafif yere gömülü
private _SMOKE_DELAY = 55;        // Duman çıkış süresi
private _LIFETIME    = 60;        // Bodybag toplam yaşam süresi

// Konsola yükleme mesajı
systemChat "Oflaz Leş Sistemi yüklendi.";

// Cesedi paketleme fonksiyonu
private _fnc_packCorpse = {
    params ["_corpse"];

    if (isNull _corpse) exitWith {};

    private _pos = getPosATL _corpse;
    deleteVehicle _corpse;

private _bag = createVehicle [
    _BAGCLASS,
    [_pos select 0, _pos select 1, (_pos select 2) + _OFFSET],
    [], 0, "CAN_COLLIDE"
];
_bag setDir random 360;

// 3 dakika sonra bodybag'i otomatik sil
[_bag] spawn {
    params ["_bag"];
    sleep 180;
    if (!isNull _bag) then {
        deleteVehicle _bag;
    };
};

    _bag setDir random 360;

    // Duman efekti + 60 saniye sonra sil
    _bag spawn {
        sleep _SMOKE_DELAY;

        if (!isNull _this) then {
            private _posBag = getPosATL _this;
            private _smoke = createVehicle [_SMOKECLASS, _posBag, [], 0, "CAN_COLLIDE"];

            sleep (_LIFETIME - _SMOKE_DELAY);

            if (!isNull _this) then { deleteVehicle _this; };
            if (!isNull _smoke) then { deleteVehicle _smoke; };
        };
    };
};

// Cesede scroll menüde action ekleme fonksiyonu
private _fnc_addCorpseActions = {
    params ["_corpse"];

    if (isNull _corpse) exitWith {};
    if (!(_corpse isKindOf "Man")) exitWith {};

    // Aynı cesede birden fazla action eklenmesin
    if (_corpse getVariable ["oflz_actions_added", false]) exitWith {};
    _corpse setVariable ["oflz_actions_added", true];

    // Sürükle
    _corpse addAction [
        "<t color='#00FF00'>Cesedi Sürükle</t>",
        {
            params ["_target", "_caller", "_id"];
            _caller attachTo [_target, [0, 1.2, 0]]; // Önüne bağla
            _caller setVariable ["draggingCorpse", _target];
            hint "Cesedi sürüklemeye başladın.";
        },
        nil, 1.5, true, true, "", ""
    ];

    // Bırak
    _corpse addAction [
        "<t color='#FF6600'>Cesedi Bırak</t>",
        {
            params ["_target", "_caller", "_id"];
            detach _caller;
            _caller setVariable ["draggingCorpse", objNull];
            hint "Cesedi bıraktın.";
        },
        nil, 1.5, true, true,
        "",  // Koşul yok, aktifleştirilebilir her zaman
        ""
    ];

    // Paketle
    _corpse addAction [
        "<t color='#FFCC00'>Paketle</t>",
        {
            params ["_target", "_caller", "_id"];
            [_target] call _fnc_packCorpse;
            hint "Ceset paketlendi.";
        },
        nil, 1.5, true, true, "", ""
    ];
};

// Mevcut ölü tüm birimlere action ekle
{
    if (_x isKindOf "Man" && !alive _x) then {
        [_x] call _fnc_addCorpseActions;
    };
} forEach allDeadMen;

// Yeni oluşan birimlere event handler ile action ekle
addMissionEventHandler ["EntityCreated", {
    params ["_entity"];

    if (!isNull _entity && {_entity isKindOf "Man"}) then {
        _entity addEventHandler ["Killed", {
            params ["_dead"];
            [_dead] spawn {
                params ["_corpse"];
                sleep 0.5;
                [_corpse] call _fnc_addCorpseActions;
            };
        }];
    };
}];

// Player cesedi sürüklerken önde kalmasını sağlamak için detach olana kadar update
[] spawn {
    while {true} do {
        {
            private _dragger = _x getVariable ["draggingCorpse", objNull];
            if (!isNull _dragger) then {
                _dragger setVectorUp [0,0,1];
            };
        } forEach allPlayers;

        sleep 1;
    };
	
	
};
