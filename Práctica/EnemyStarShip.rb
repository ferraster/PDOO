#encoding: utf-8

require_relative 'Damage'
require_relative 'Loot'
require_relative 'EnemyToUI'
require_relative 'ShotResult'

module Deepspace
    class EnemyStarShip

        def initialize(name_,ammoPower_,shieldPower_,loot_,damage_)
            @ammoPower=ammoPower_
            @name=name_
            @shieldPower=shieldPower_
            @loot=loot_
            @damage=damage_
        end 

        attr_reader :ammoPower , :name  , :shieldPower , :loot , :damage

        def self.newCopy(e)
            new(e.name,e.ammoPower,e.shieldPower,e.loot,e.damage)
        end 

        def getUIversion
            EnemyToUI.new(self)
        end 

        def to_s 
            getUIversion.to_s
        end 

        def protection 
            @shieldPower
        end 

        def fire 
            @ammoPower
        end 


        def receiveShot(shot)
            if shot>@shieldPower
                ShotResult::DONOTRESIST
            else 
                ShotResult::RESIST
            end
        end 
    end
end 

if $0 == __FILE__

a=Deepspace::Loot.new(1,2,3,4,5)
b=Deepspace::Damage.newNumericWeapons(10,10)
ene=Deepspace::EnemyStarShip.new(1,"uwu",2,a,b)

ene.to_s

end 