#encoding: utf-8

require_relative 'GameStateControler'
require_relative 'SpaceStation'
require_relative 'Dice'
require_relative 'ShotResult'
require_relative 'EnemyStarShip'


module Deepspace 

    class GameUniverse 

        @@WIN=10 

        def initialize()
            @gameState=GameStateControler.new
            @dice=Dice.new()

            @turn=0
            @currentStationIndex=-1
    
            @currentStation=nil
            @spaceStations=Array.new
            @currentEnemy=nil
            
        end 

        def haveAWinner
            @spaceStations[@currentStationIndex].nMedals==@@WIN
        end 

        def mountShieldBooster(i)
            if @gameState=GameState::INIT or @gameState=GameState::AFTERCOMBAT
                @currentStation.mountShieldBooster(i)
            end 
        end 

        def mountWeapon(i)
            if @gameState=GameState::INIT or @gameState=GameState::AFTERCOMBAT
                @currentStation.mountWeapon(i)
            end 
        end @spaceStation

        def discardWeapon(i)
            if @gameState=GameState::INIT or @gameState=GameState::AFTERCOMBAT
                @currentStation.discardWeapon(i)
            end
        end 

        def discardShieldBooster(i)
            if @gameState=GameState::INIT or @gameState=GameState::AFTERCOMBAT
                @currentStation.discardShieldBooster(i)
            end 
        end 

        def discardHangar 
            @currentStation.discardHangar
        end 

        def discardShieldBoosterInHangar(i)
            @currentStation.hangar.discardShieldBooster(i)
        end 

        def discardWeaponInHangar(i)
            @currentStation.hangar.discardWeaponInHangar(i)
        end 

        def getState
            @gameState
        end 

        def getUIversion
            GameUniverseToUI.new(self)
        end 
    end 

end 