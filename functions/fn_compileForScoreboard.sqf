params ["_playerStatsArray","_teamStatsArray"];

//PLAYER STATS =================================================================
_playerStats = +_playerStatsArray;

_minGames = [missionConfigFile >> "CfgWinrateTracker" >> "minGamesForSort", "number", 5] call CBA_fnc_getConfigEntry;
_sortBy = [missionConfigFile >> "CfgWinrateTracker" >> "sortBy", "text", "WINRATES"] call CBA_fnc_getConfigEntry;
_sortID = (["WINS","LOSSES","GAMES","WINRATES"] find _sortBy) + 1;

if (_sortID > 0) then {[_playerStats,_sortID,_minGames] call grad_winrateTracker_fnc_sortStats};
[_playerStats] call grad_winrateTracker_fnc_playerWinratesToStrings;

//TEAM STATS ===================================================================
_teamStats = +_teamStatsArray;
{
    if (_forEachIndex > 0) then {
        _winrate = _x;
        _winrate = (round (_winrate * 1000)) / 10;
        _winrate = format ["%1%",_winrate];
        _x set [_forEachIndex,_winrate];
    };
} forEach (_teamStats select 1);

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
