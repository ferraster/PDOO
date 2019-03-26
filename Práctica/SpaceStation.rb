#encoding: UTF-8

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

            @shieldBoosters=nil 
            @weapons=nil
            @pendingDamage=nil
        end

        attr_reader :nMedals

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
            @hangar.addWeapon(w)
        end 

        def receiveShieldBooster(s)
            @hangar.addShieldBooster(s)
        end 

        def receiveHangar(h)
            if(@Hangar==nil)
                @Hangar=h
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
            @damage=d.adjust(@weapons,@shieldBoosters)
        end 

        def mountWeapon(i)
            w=nil
            w=@hangar.removeWeapon(i)
            if(@hangar!=nil and w!=nil)
                @weapons.push(w)
            end 
        end 

        def mountShieldBooster(i)
            s=nil
            s=@hangar.removeShieldBooster
            if(@hangar!=nil and s!=nil)
                @shieldBoosters.push(w)
            end 
        end 

        def discardWeaponInHangar(i)
            if(@Hangar!=nil)
                @Hangar.removeWeapon(i)
            end 
        end 

        def discardShieldBoosterInHangar(i)
            if(@Hangar!=nil)
                @Hangar.removeShieldBooster(i)
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
    end 

end 