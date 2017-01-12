#define PREFIX grad
#define COMPONENT winrateTracker
#include "\x\cba\addons\main\script_macros_mission.hpp"

params ["_playerStatsArray","_teamStatsArray"];

INFO("STATS UPDATED: ===========================================================");

{
    INFO_1("%1",_x);
} forEach _playerStatsArray;

{
    INFO_1("%1",_x);
} forEach _teamStatsArray;

INFO("END OF STATS =============================================================")
