#encoding: UTF-8

require_relative 'Damage'
require_relative 'Hangar'
require_relative 'Weapon'
require_relative 'ShieldBooster'
require_relative 'SuppliesPackage'
require_relative 'CardDealer'
require_relative 'SpaceStationToUI'

module Deepspace
    class SpaceStation
        @@MAXFUEL = 100.0 
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

            @name=n

            @gameState=nil
            @pendingDamage=nil
        end

        attr_reader :ammoPower , :fuelUnits , :hangar , :name , :nMedals , :pendingDamage , :shieldBoosters , :shieldPower , :weapons

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
                @hangar=h
            end 
        end 

        def discardHangar
            @hangar=nil
        end 

        def receiveSupplies(s)
            @ammoPower+=s.ammoPower
            @fuelUnits+=s.fuelUnits
            @shieldPower+=s.shieldPower
        end 

        def setPendingDamage(d)
            if d != nil 
                @pendingDamage=d.adjust(@weapons,@shieldBoosters)
            end 
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
                s=@hangar.removeShieldBooster(i)
                if(s!=nil)
                    @shieldBoosters.push(s)
                end 
            end 
        end 

        def fire
           
            size=@weapons.length
            
            factor=1.0
            for i in 0..size-1 do
                factor=factor*@weapons[i].useIt
            
            end 
            @ammoPower*factor
        end 

        def protection
            
            
            size=@shieldBoosters.length
            factor=1.0
            for i in 0..size-1 do  
                factor=factor*@shieldBoosters[i].useIt                
            end 
            @shieldPower*factor
        end 

        def receiveShot(shot)   
            myProtection=self.protection
           
            if myProtection >= shot 
                @shieldPower-=@@SHIELDLOSSPERUNITSHOT*shot
                @shieldPower=[0.0,@shieldPower].max
                ShotResult::RESIST
            else
                @shieldPower=0.0
                ShotResult::DONOTRESIST
            end 
        end
        
        def setLoot(loot)
            dealer=CardDealer.instance
            h=loot.nHangars
            if h>0
                hangar=dealer.nextHangar
            end 
            receivehangar(hangar)
            elements=loot.nSupplies
            
            for i in 0..elements-1 do 
                sup=dealer.nextSuppliesPackage
                receiveSupplies(sup)
            end 

            elements=loot.nWeapons
            
            for i in 0..elements-1 do  
                weap=dealer.nextWeapon
                receiveWeapon(weap)
            end

            elements=loot.nShields
            
            for i in 0..elements-1 do
                sh=dealer.nextShieldBooster
                
                receiveShieldBooster(sh)
            end 

            medals=loot.nMedals
            @nMedals+=medals
        end 

        def discardWeapon(i)
            size=@weapons.length
            if i>=0 and i<size 
                w=@weapons.delete_at(i)

                if @pendingDamage!=nil
                    @pendingDamage.discardWeapon(w)
                    cleanPendingDamage
                end     
            end 
        end 

        def discardShieldBooster(i)
            size=@shieldBoosters.length
            if i>=0 and i<size 
                @shieldBoosters.delete_at(i)
                if @pendingDamage!=nil
                    @pendingDamage.discardShieldBooster()
                    cleanPendingDamage
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
            if @fuelUnits < 0
                @fuelUnits = 0
            end  
        end 

        def validState
            if(@pendingDamage==nil or @pendingDamage.hasNoEffect)
                true 
            else 
                false 
            end 
        end 

        def cleanUpMountedItems
            @weapons.delete_if{ |w| w.uses == 0}
            @shieldBoosters.delete_if{ |s| s.uses == 0}
        end  

        def cleanPendingDamage
            if @pendingDamage.hasNoEffect
                @pendingDamage=nil
            end 
        end 
        
        def getUIversion
            SpaceStationToUI.new(self)
        end 

        def to_s 
            getUIversion.to_s
        end 

        private :assignFuelValue , :cleanPendingDamage
    end 

end 



if $0 == __FILE__
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

for i in 0..armillas.length do 
    h.addWeapon(armillas[i])
end 

for i in 0..s.length do 
    h.addShieldBooster(s[i])
end 


sup=Deepspace::SuppliesPackage.new(3,3,3)
space=Deepspace::SpaceStation.new("estacion",sup)
space.receivehangar(h)

space.mountWeapon(1)

puts space.inspect
end 