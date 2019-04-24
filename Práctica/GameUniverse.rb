#encoding: utf-8

require_relative 'GameStateController'
require_relative 'SpaceStation'
require_relative 'Dice'
require_relative 'ShotResult'
require_relative 'EnemyStarShip'
require_relative 'GameUniverseToUI'
require_relative 'CombatResult'


module Deepspace 

    class GameUniverse 

        @@WIN=10 

        def initialize()
 
            @gameState=GameStateController.new
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
            if @gameState.state==GameState::INIT or @gameState.state==GameState::AFTERCOMBAT
                @currentStation.mountShieldBooster(i)
            end 
        end 

        def mountWeapon(i)
            if @gameState.state==GameState::INIT or @gameState.state==GameState::AFTERCOMBAT
                @currentStation.mountWeapon(i)
            end 
        end 

        def discardWeapon(i)
            if @gameState.state==GameState::INIT or @gameState.state==GameState::AFTERCOMBAT
                @currentStation.discardWeapon(i)
            end
        end 

        def discardShieldBooster(i)
            if @gameState.state==GameState::INIT or @gameState.state==GameState::AFTERCOMBAT
                @currentStation.discardShieldBooster(i)
            end 
        end 

        def discardHangar 
            @currentStation.discardHangar
        end 

        def discardShieldBoosterInHangar(i)
            @currentStation.hangar.removeShieldBooster(i)
        end 

        def discardWeaponInHangar(i)
            if @currentStation.hangar != nil
                @currentStation.hangar.removeWeapon(i)
            end
        end 

        def getState
            @gameState.state
        end 

        def getUIversion
            
            GameUniverseToUI.new(@currentStation,@currentEnemy)
        end 

        def init(names)
            
            state=self.getState
            if state==GameState::CANNOTPLAY
                @spaceStations=Array.new 
                dealer=CardDealer.instance 
                
                for i in 0..names.length-1 do
                    
                    supplies=dealer.nextSuppliesPackage
                    spacestation=SpaceStation.new(names[i],supplies)
                    
                    
                    nh=@dice.initWithNhangars
                    nw=@dice.initWithNWeapons
                    ns=@dice.initWithNShields
                    lo=Loot.new(0,nw,ns,nh,0)
                    spacestation.setLoot(lo)

                    @spaceStations.push(spacestation)
                    
                end 
                
                @currentStationIndex=@dice.whoStarts(names.length)
                @currentStation=@spaceStations[@currentStationIndex]
                @currentEnemy=dealer.nextEnemy
                @gameState.next(@turn,@spaceStations.length)
            end 

        end 

        def nextTurn
            state=self.getState
            if state.equal?(GameState::AFTERCOMBAT)
                stationState=@currentStation.validState
                if stationState
                    @currentStationIndex=(@currentStationIndex+1)% @spaceStations.length
                    @turn=@turn+1
                    @currentStation=@spaceStations[@currentStationIndex]
                    @currentStation.cleanUpMountedItems
                    dealer=CardDealer.instance
                    @currentEnemy=dealer.nextEnemy
                    @gameState.next(@turn,@spaceStations.length)
                    true
                else
                    false
                end 
            else 
                false
            end 
        end

        def combat
            state=self.getState
            if state.equal?(GameState::BEFORECOMBAT)||(state.equal?(GameState::INIT))
                self.combatGo(@currentStation,@currentEnemy)
            else 
                ret=CombatResult::NOCOMBAT
            end 
        end
        
        def combatGo(station,enemy)
            ch=@dice.firstShot
                if ch==GameCharacter::ENEMYSTARSHIP
                    fire=enemy.fire
                    result=station.receiveShot(fire)

                    if result==ShotResult::RESIST
                        enemyWins=(result==ShotResult::RESIST)
                    else 
                        enemyWins=true
                    end 
                else 
                    fire=station.fire
                    result=enemy.receiveShot(fire)
                    enemyWins=(result==ShotResult::RESIST)
                end 

                if enemyWins
                    s=station.getSpeed
                    moves=@dice.spaceStationMoves(s)

                    if !moves 
                        damage=enemy.damage
                        station.setPendingDamage(damage)
                        combatResult=CombatResult::ENEMYWINS
                    else
                        station.move
                        combatResult=CombatResult::STATIONSCAPES
                    end
                else 
                    aLoot=enemy.loot
                    station.setLoot(aLoot)
                    combatResult=CombatResult::STATIONWINS    
                end 
                
                @gameState.next(@turn,@spaceStations.length)
                combatResult
        end 
    end 
end 
