if (isDedicated) exitWith {}; // Serverda çalışmasın, sadece clientta çalışsın

// Sadece oyuncu için
if (alive player) then {
    player addAction [
        "Cesedi Torbala",
        {
            hint "Test action tıklandı!";
        },
        nil,
        5,
        false,
        true,
        "", // hiçbir koşul yok
        ""
    ];
};
