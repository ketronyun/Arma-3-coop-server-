//
// Call repair.sqf with:	this addAction["Repair Vehicle","repair.sqf"];
//


_vehicle = (nearestObjects [player, ["LandVehicle","Air"], 5]); 
//Checks if Ifrit or Hunter are within 5m 

_veh = _vehicle select 0; 
// selects the nearest vehicle and puts it in '_veh'

_vehDamage = getDammage _veh;
//Puts the damage of '_vehicle' in the variable '_veh'

IF (count _vehicle == 1)
// If there is one vehicle within 5m

THEN {

	IF (vehicle player == player)
	//If player is not inside vehicle
	
	THEN {player playActionNow "medicStart";
	sleep 10;
	_vehDamage = _veh setDamage 0;
	_veh setFuel 1;
	player playActionNow "medicStop";}	
	// Start repair animation with a 10 second delay then set the damage to 0%

	ELSE {hint "You cannot repair from inside the vehicle";}}

ELSE {hint "You are too far away from the vehicle";};
// Else show "You are too far ...."

exit;