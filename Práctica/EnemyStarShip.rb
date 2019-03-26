#encoding: utf-8

module Deepspace
    class EnemyStarShip

        def initialize(ammoPower_,name_,shieldPower_,loot_,damage_)
            @ammoPower=ammoPower_
            @name=name_
            @shieldPower=shieldPower_
            @loot=loot_
            @damage=damage_
        end 

        attr_reader :ammoPower , :name  , :shieldPower , :loot , :damage

        def self.newCopy(e)
            @ammoPower=e.ammoPower
            @name=e.name
            @shieldPower=e.shieldPower
            @loot=e.loot
            @damage=e.damage
        end 

        def getUIversion
            new EnemyToUI(self)
        end 

        def protection 
            @shieldPower
        end 

        def power 
            @ammoPower
        end 

        def getDamage
            @damage
        end 

        def shieldPower
            @shieldPower
        end 

        def receiveShot(shot)
            if shot>@shieldPower
                ShotResult::DONOTRESIST
            else 
                ShotResult::RESIST
            end
        end 

        def getAmmoPower
            @ammoPower
        end 

        def getLoot 
            @loot
        end 

        def getName
            @name 
        end
    end
end 

