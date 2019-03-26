#encoding: UTF-8

require_relative './ShieldBooster.rb'

module Deepspace 
    class Hangar 
        @maxElements
    
        def initialize(capacity)
            @maxElements=capacity 
            @shieldBoosters=Array.new
            @weapons=Array.new
        end 

        attr_reader :shieldBoosters , :weapons , :maxElements
        attr_writer :weapons , :shieldBoosters

        def self.newCopy(h)
            n=new(h.getMaxElements)
            n.weapons=h.getWeapons
            n.shieldBoosters=h.getshieldBoosters
            n
        end 

        def getUIversion
            HangarToUI.new(self)
        end 

        
        def spaceAvailable
            (@weapons.length+@shieldBoosters.length)<@maxElements 
        end 

        def addWeapon(w)
            if(spaceAvailable)
                @weapons.push(w)
                true 
            else
                false
            end 
        end 

        def addShieldBooster(s)
            if(spaceAvailable)
                @shieldBoosters.push(s)
                true 
            else
                false
            end  
        end   

        def removeWeapon(w)
            if(@weapons.size>w)
                @weapons.delete_at(w)
            else
                nil
            end  
        end

        def removeShieldBooster(s)
            if(@shieldBoosters.length>s)
                @shieldBoosters.delete_at(s) #--------------
            else
                nil
            end  
        end

        def getWeapons
            @weapons
        end 

        def getshieldBoosters
            @shieldBoosters
        end 

        def getMaxElements
            @maxElements
        end 
         
        private :spaceAvailable
    end 
end 