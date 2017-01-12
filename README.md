# GRAD WinrateTracker (WIP)
Tracks winrate for players and sides and saves them on the server.
Can be used supplementary to [GRAD Scoreboard](https://github.com/gruppe-adler/grad-scoreboard) or standalone.


## Dependencies
* [CBA_A3](https://github.com/CBATeam/CBA_A3)

## Installation

### Manually
1. Create a folder in your mission root folder and name it `modules`. Then create one inside there and call it `grad-winrateTracker`.
2. Download the contents of this repository ( there's a download link at the side ) and put it into the directory you just created.
3. Append the following lines of code to the `description.ext`:

```sqf
class CfgFunctions {
    #include "modules\grad-winrateTracker\cfgFunctions.hpp"
};
```

### Via `npm`
_for details about what npm is and how to use it, look it up on [npmjs.com](https://www.npmjs.com/)_

1. Install package `grad-winrateTracker` : `npm install --save grad-winrateTracker`
2. Append the following lines of code to the `description.ext`:

```sqf
#define MODULES_DIRECTORY node_modules
class CfgFunctions {
    #include "node_modules\grad-winrateTracker\cfgFunctions.hpp"
};
```

## Usage

## Saving Stats
The mission ended, you now want to save the statistics. Use `[winning player names,losing player names,winning team names,losing team names] call grad_winrateTracker_fnc_saveWinrate`. An array is returned that can then be fed into [GRAD Scoreboard](https://github.com/gruppe-adler/grad-scoreboard) (not part of this module).

| Parameter            | Type         | Explanation                                                                  |
|----------------------|--------------|------------------------------------------------------------------------------|
| winning player names | Array        | An array of names of all players who won this mission.                       |
| losing player names  | Array        | An array of names of all players who lost this mission.                      |
| winning team names   | Array/String | Optional. A single name or an array of names of teams who won this mission.  |
| losing team names    | Array/String | Optional. A single name or an array of names of teams who lost this mission. |

Example:  
```sqf
_stats = [["Frank","Heiner","Joachim"],["Thorsten","Jonas","Wolfgang"],"BLUFOR",["OPFOR","INDEPENDENT"]] call grad_winrateTracker_fnc_saveWinrate;
_stats call grad_scoreboard_fnc_loadScoreboard;
```

### Resetting Stats
To reset stats you can use `[_consent,_missionName] call grad_winrateTracker_fnc_resetStats`. This will delete all stats of the provided missionName.

| Parameter   | Type   | Explanation                                                                                                 |
|-------------|--------|-------------------------------------------------------------------------------------------------------------|
| consent     | String | Function will only work if this is "I KNOW THIS WILL DELETE ALL STATS".                                     |
| missionName | String | Optional. Mission name of stats to be reset. If not provided, mission name of current mission will be used. |


## Configuration
You can configure this module in your `description.ext`. This is entirely optional however, since every setting has a default value.  
All of these values only affect the returned array, that you can use with [GRAD Scoreboard](https://github.com/gruppe-adler/grad-scoreboard).

Add the class `CfgWinrateTracker` to your `description.ext`, then add any of these attributes to configure the module:

| Attribute       | Default Value         | Explanation                                                  |
|-----------------|-----------------------|--------------------------------------------------------------|
| scoreBoardDuration      | 20                      | duration that the scoreboard will stay open  |
| sortBy       | "WINRATE"                          | what to sort by, can be "GAMES","WINS","LOSSES","WINRATES"               |
| minGamesForSort     | 5                           | minimum number of games a player needs to have to be in the upper ranks  |
| playerStatsHeadline   | "PLAYER WINRATES"         | headline for scoreboard                                  |
| teamStatsHeadline   | "TEAM WINRATES"             | headline for team stats                            |
| missionName | missionName of current mission      | name that these stats will be saved under |


Example:  

```sqf
class CfgWinrateTracker {
    scoreBoardDuration = 20;                            
    sortBy = "WINRATE";                                
    minGamesForSort = 5;                                
    playerStatsHeadline = "PLAYER WINRATES";           
    teamStatsHeadline = "TEAM WINRATES";                
};
```
