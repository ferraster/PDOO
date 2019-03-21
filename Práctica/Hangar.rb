#encoding: UTF-8

module Deepspace 
    class Hangar 
        @maxElements
    
        def initialize(capacity)
            @maxElements=capacity 
            @ShieldBoosterList=Array.new
            @WeaponList=Array.new
        end 

        def self.newCopy(h)
            n=new(h.getMaxElements)
            n.WeaponList=h.getWeapons
            n.ShieldBoosterList=h.getShieldBoosters
            n
        end 

        def getUIversion
            HangarToUI.new(self)
        end 

        private 
        def spaceAvailable
            (@WeaponList.size+@ShieldBoosterList.size)<@maxElements 
        end 

        def addWeapon(w)
            if(self.spaceAvailable)
                @WeaponList.push(w)
                true 
            else
                false
            end 
        end 

        def addShieldBooster(s)
            if(self.spaceAvailable)
                @ShieldBoosterList.push(s)
                true 
            else
                false
            end  
        end 

        def removeWeapon(w)
            if(@WeaponList.size>w)
                @WeaponList.delete(w)
            else
                nil
            end  
        end

        def removeShieldBooster(s)
            if(@ShieldBoosterList.size>w)
                @ShieldBoosterList.delete(w)
            else
                nil
            end  
        end

        def getWeapons
            @WeaponList
        end 

        def getShieldBoosters
            @ShieldBoosterList
        end 

        def getMaxElements
            @maxElements
        end ,
    end 
end 