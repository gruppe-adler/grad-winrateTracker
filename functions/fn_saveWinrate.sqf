params [["_winningPlayerNames",[]],["_losingPlayerNames",[]],"_winningSidesNames","_losingSidesNames"];

if (!isServer) exitWith {};


//PLAYER STATS =================================================================
_playerStatsArrayName = format ["grad_winrateTracker_%1_playerStats", missionName];
_playerStatsArray = profileNamespace getVariable [_playerStatsArray,[]];
if (count _playerStatsArray == 0) then {_playerStatsArray pushBack ["PLAYER","WINS","LOSSES","GAMES","WINRATE"]};
{
    _isWinner = _forEachIndex == 1;
    if (_isWinner) then {_addWin = 1; _addLoss = 0} else {_addWin = 0; _addLoss = 1};
    {
        _playerName = _x;
        _stats = [_playerName,_playerStatsArray] call grad_winrateTracker_fnc_findPlayerStats;

        _stats params [["_statsName",""],["_wins",0],["_losses",0],["_games",0],["_winrate"]];
        _stats set [1,_wins + _addWin];
        _stats set [2,_losses + _addLoss];
        _stats set [3,_games + 1];
        _stats set [4,(_wins + _addWin)/(_games + 1)];
    } forEach _x;
} forEach [_losingPlayerNames,_winningPlayerNames];

profileNamespace setVariable [_playerStatsArrayName,_playerStatsArray];

//TEAM STATS ===================================================================
if (!isNil "_winningSides" && !isNil "_losingSides") then {
    _winningSidesNames = if (typeName _winningSidesNames == "ARRAY") then {_winningSidesNames} else {[_winningSidesNames]};
    _losingSidesNames = if (typeName _losingSidesNames == "ARRAY") then {_losingSidesNames} else {[_losingSidesNames]};

    _teamStatsArrayName = format ["grad_winrateTracker_%1_teamStats", missionName];
    _teamStatsArray = profileNamespace getVariable [_teamStatsArrayName,[]];
    _data = (_teamStatsArray select 1);

    if (count _teamStatsArray == 0) then {_teamStatsArray pushBack (["TOTAL GAMES"] + _winningSidesNames + _losingSidesNames)};

    //set total games
    _totalGames = (_data select 0) + 1;
    _data set [0,_totalGames];

    //set winrates
    {
        _isWinner = _forEachIndex == 1;
        {
            _teamName = _x;
            _teamID = [_teamName,_teamStatsArray] call grad_winrateTracker_fnc_findTeamName;
            _teamWinrate = [_teamID,_teamStatsArray] call grad_winrateTracker_fnc_findTeamWinrate;

            if (_teamID >= 0) then {
                _totalWins = _totalGames * _teamWinrate;
                if (_isWinner) then {_totalWins = _totalWins + 1};
                _data set [_teamID,_totalWins/_totalGames];
            };
        } forEach _x;
    } forEach [_losingSidesNames, _winningSidesNames];

    profileNamespace setVariable [_teamStatsArrayName,_teamStatsArray];
};

//SAVE, COMPILE ARRAY FOR GRAD SCOREBOARD AND RETURN ===========================
saveProfileNamespace;

if (isNil "_teamStatsArray") then {_teamStatsArray = []},
_scoreBoardArray = [_playerStatsArray,_teamStatsArray] call grad_winrateTracker_fnc_compileForScoreboard;

_scoreBoardArray
