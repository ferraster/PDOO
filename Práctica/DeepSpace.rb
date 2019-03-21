#encoding: UTF-8

require 'pp' 
require_relative './CombatResult.rb'
require_relative './Dice.rb'
require_relative './GameCharacter.rb'
require_relative './Loot.rb'
require_relative './ShieldBooster.rb'
require_relative './ShotResult.rb'
require_relative './SuppliesPackage.rb'
require_relative './Weapon.rb'
require_relative './WeaponType.rb'

module DeepSpace
    
class Test_P1

    def self.Main 

        puts "Clase Loot"
        loot_=Loot.new(1,2,3,4,5)
        puts "#{loot_.nSupplies} #{loot_.nWeapons} #{loot_.nShields} #{loot_.nHangars} #{loot_.nMedals}"
        puts "Clase SuppliesPackage"
        suppliesPackage__=SuppliesPackage.new(1,2,3)
        puts "#{suppliesPackage__.ammoPower} #{suppliesPackage__.fuelUnits} #{suppliesPackage__.shieldPower}"
        suppliesPackage_=SuppliesPackage.newCopy(suppliesPackage__)
            puts "#{suppliesPackage_.ammoPower} #{suppliesPackage_.fuelUnits} #{suppliesPackage_.shieldPower}"
            
            puts "Clase ShieldBooster"
            shieldBooster__=ShieldBooster.new(1,2,3)
            puts "#{shieldBooster__.boost} #{shieldBooster__.uses}"
            puts shieldBooster__.useIt
            shieldBooster_=ShieldBooster.newCopy(shieldBooster__)
            puts "#{shieldBooster_.boost} #{shieldBooster_.uses}"

           


        end 
    end 
end 

DeepSpace::Test_P1.Main

 