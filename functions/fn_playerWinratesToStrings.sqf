params ["_playerStats"];

{
    _winrate = (_x select 4);
    _winrate = (round (_winrate * 1000)) / 10;
    _winrate = format ["%1%",_winrate];
    _x set [4,_winrate];
} forEach _playerStats;

_playerStats
