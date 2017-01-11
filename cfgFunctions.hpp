#ifndef MODULES_DIRECTORY
    #define MODULES_DIRECTORY modules
#endif

class GRAD_winrateTracker {
    class common {
        file = MODULES_DIRECTORY\grad-winrateTracker\functions;

        class compileForScoreboard {};
        class findMax {};
        class findPlayerStats {};
        class findTeamName {};
        class findTeamWinrate {};
        class playerWinratesToStrings {};
        class saveWinrate {};
        class sortStats {};
    };
};
