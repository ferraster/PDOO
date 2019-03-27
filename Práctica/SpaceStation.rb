#encoding: UTF-8

require_relative 'Damage'
require_relative 'Hangar'
require_relative 'Weapon'
require_relative 'ShieldBooster'
require_relative 'SuppliesPackage'

module Deepspace
    class SpaceStation
        @@MAXFUEL = 100 
        @@SHIELDLOSSPERUNITSHOT = 1.0

        def initialize(n,suppliesPackage_)
            @ammoPower=suppliesPackage_.ammoPower
            @fuelUnits=suppliesPackage_.fuelUnits
            @shieldPower=suppliesPackage_.shieldPower
            
            @nMedals=0
            @damage=nil 
            @hangar=nil
            @shieldBoosters=Array.new
            @weapons=Array.new

            @gameState=nil
            @pendingDamage=nil
        end

        attr_reader :nMedals , :fuelUnits , :shieldPower , :nMedals , :damage , :hangar , :shieldBoosters , :weapons , :pendingDamage 

        def assignFuelValue(f)
            if(f>@@MAXFUEL)
                @fuelUnits = @@MAXFUEL
            else
                @fuelUnits = f
            end 
        end 

        def cleanPendingDamage
            if(@damage.hasNoEffect)
                @damage=nil
            end 
        end 

        def receiveWeapon (w)
            if hangar!=nil
                @hangar.addWeapon(w)
            else 
                false 
            end 
        end 

        def receiveShieldBooster(s)
            if hangar!=nil 
                @hangar.addShieldBooster(s)
            else 
                false 
            end 
        end 

        def receivehangar(h)
            if(@hangar==nil)
                puts "LEL"
                @hangar=h
            end 
        end 

        def discardhangar
            @hangar=nil
        end 

        def receiveSupplies(s)
            @ammoPower+=s.ammoPower
            @fuelUnits+=s.fuelUnits
            @shieldPower+=s.shieldPower
        end 

        def setPendingDamage(d)
            @pendingDamage=d.adjust(@weapons,@shieldBoosters)
        end 

        def mountWeapon(i)
            w=nil
            if(@hangar!=nil)
                w=@hangar.removeWeapon(i)
                if(w!=nil)
                    @weapons.push(w)
                end 
            end 
        end 

        def mountShieldBooster(i)
            s=nil
            if(@hangar!=nil)
                s=@hangar.removeShieldBooster
                if(s!=nil)
                    @shieldBoosters.push(s)
                end 
            end 
        end 

        def discardWeaponInhangar(i)
            if(@hangar!=nil)
                @hangar.removeWeapon(i)
            end 
        end 

        def discardShieldBoosterInhangar(i)
            if(@hangar!=nil)
                @hangar.removeShieldBooster(i)
            end 
        end
        
        def getSpeed
            @fuelUnits/@@MAXFUEL
        end 

        def move 
            @fuelUnits-=self.getSpeed*@fuelUnits
        end 

        def validState
            if(@pendingDamage==nil or @pendingDamage.hasNoEffect)
                true 
            else 
                false 
            end 
        end 

        def cleanUpMountedItems
            @weapons.delete_if{ |weapon| weapon.uses == 0}
        end  
        
        def getUIversion
            SpaceStationToUI.new(self)
        end 
    end 

end 




vector=Array.new(1){Deepspace::WeaponType::MISSILE}
vector.push(Deepspace::WeaponType::LASER) 
vector.push(Deepspace::WeaponType::PLASMA)

armillas=Array.new 

w1=Deepspace::Weapon.new("arma1",Deepspace::WeaponType::LASER,1)
armillas.push(w1)
w2=Deepspace::Weapon.new("arma2",Deepspace::WeaponType::MISSILE,1)
armillas.push(w2)


nuevo=Deepspace::Damage.newNumericWeapons(0,10)
d=Deepspace::Damage.newSpecificWeapons(vector,10)

a=Deepspace::ShieldBooster.new("a",2,3)
b=Deepspace::ShieldBooster.new("b",2,3)
c=Deepspace::ShieldBooster.new("c",2,3)

s=Array.new
s.push(a)
s.push(b)
s.push(c)

h=Deepspace::Hangar.new(20)
h.weapons=armillas
h.shieldBoosters=s

sup=Deepspace::SuppliesPackage.new(3,3,3)
space=Deepspace::SpaceStation.new("estacion",sup)
space.receivehangar(h)

space.mountWeapon(1)

puts space.inspect