#encoding: utf-8

module Deepspace 

    class GameUniverse 

        @@WIN=10 

        def initialize(c,s,game,d)
            @currentStationIndex=c
            @turn=0
            @currentStation=s
            @spaceStations=Array.new
            @gameState=game
            @dice=Dice.new()
        end 

        def haveAWinner
            @spaceStations[@currentStationIndex].nMedals
        end 

        def mountShieldBooster(i)
            if @gameState=GameState::INIT or @gameState=GameState::AFTERCOMBAT
                @spaceStations.mountShieldBooster(i)
            end 
        end 

        def mountWeapon(i)
            if @gameState=GameState::INIT or @gameState=GameState::AFTERCOMBAT
            @spaceStations.mountWeapon(i)
            end 
        end 

        def discardWeapon(i)
            if @gameState=GameState::INIT or @gameState=GameState::AFTERCOMBAT
                @spaceStation.discardWeapon(i)
            end
        end 

        def discardShieldBooster(i)
            if @gameState=GameState::INIT or @gameState=GameState::AFTERCOMBAT
                @spaceStation.discardShieldBooster(i)
            end 
        end 

        def discardHangar 
            @spaceStation.discardHangar
        end 

        def discardShieldBoosterInHangar(i)
            @spaceStation.hangar.discardShieldBooster(i)
        end 

        def getState
            @gameState
        end 

        def getUIversion
            new GameUniverseToUI(self)
        end 
    end 

end 