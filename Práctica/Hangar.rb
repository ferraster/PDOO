#encoding: UTF-8

require_relative 'ShieldBooster'
require_relative 'Weapon'
require_relative 'WeaponType'
require_relative 'HangarToUI'

module Deepspace 
    class Hangar 
    
        def initialize(capacity)
            @maxElements=capacity 
            @shieldBoosters=Array.new
            @weapons=Array.new
        end 

        attr_reader :shieldBoosters , :weapons , :maxElements

        def self.newCopy(h)
            n=new(h.maxElements)
            h.weapons.map{ |x| h.addWeapon(x)}
            h.shieldBoosters.map{ |x| h.addShieldBooster(x)}
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
            if(@weapons.length>w)
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

        def to_s
            getUIversion.to_s
        end 
         
        private :spaceAvailable
    end 
end 

u=Deepspace::Hangar.new(1)
w1=Deepspace::Weapon.new("arma1",Deepspace::WeaponType::LASER,5)
w2=Deepspace::Weapon.new("arma2",Deepspace::WeaponType::LASER,5)

puts u.addWeapon(w1)
puts u.addWeapon(w2)

u.to_s
