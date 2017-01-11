params ["_playerStatsArray","_teamStatsArray"];

//PLAYER STATS =================================================================
_playerStats = +_playerStatsArray;

_minGames = [missionConfigFile >> "CfgWinrateTracker" >> "minGamesForSort", "number", 5] call CBA_fnc_getConfigEntry;
_sortBy = [missionConfigFile >> "CfgWinrateTracker" >> "sortBy", "text", "WINRATES"] call CBA_fnc_getConfigEntry;
_sortID = (["WINS","LOSSES","GAMES","WINRATES"] find _sortBy) + 1;

if (_sortID > 0) then {[_playerStats,_sortID] call grad_winrateTracker_fnc_sortStats};

//TEAM STATS ===================================================================
_teamStats = +_teamStatsArray;


//SET OTHER SETTINGS ===========================================================
_duration = [missionConfigFile >> "CfgWinrateTracker" >> "scoreBoardDuration", "number", -1] call CBA_fnc_getConfigEntry;
_mainHeadline = [missionConfigFile >> "CfgWinrateTracker" >> "playerStatsHeadline", "text", "PLAYER WINRATES"] call CBA_fnc_getConfigEntry;
_rankNumbers = true;
_sort = false;
_teamHeadline = [missionConfigFile >> "CfgWinrateTracker" >> "teamStatsHeadline", "text", "TEAM WINRATES"] call CBA_fnc_getConfigEntry;
_teamRankNumbers = false;
_teamSort = false;


//RETURN =======================================================================
[_duration,_playerStats,_mainHeadline,_rankNumbers,_sort,_teamStats,_teamHeadline,_teamRankNumbers,_teamSort]
