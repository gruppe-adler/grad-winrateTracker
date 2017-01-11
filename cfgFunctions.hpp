#ifndef MODULES_DIRECTORY
    #define MODULES_DIRECTORY modules
#endif

class GRAD_winrateTracker {
    class common {
        file = MODULES_DIRECTORY\grad-winrateTracker\functions;

        class compileForScoreboard {};
        class findPlayerStats {};
        class findTeamName {};
        class findTeamWinrate {};
        class saveWinrate {};
        class sortStats {};
    };
};
