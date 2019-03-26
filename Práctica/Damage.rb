#encoding: UTF-8 

require_relative 'WeaponType'
require_relative 'Weapon'
require_relative 'ShieldBooster'

module Deepspace
    class Damage

        private_class_method :new 
        def initialize(w,s,wl)   
            @nWeapons=w
            @nShields=s
            @weapons=wl
        end 
        
        attr_reader :weapons, :nShields, :nWeapons

        def self.newNumericWeapons(w,s)
            new(w,s,nil)
        end

        def self.newSpecificWeapons(wl,s)
            new(-1,s,wl)
            
        end 

        def self.newCopy(d)
            new(d.nWeapons,d.nShields,d.weapons)
        end

        def getUIversion()
            DamageToUI.new(self)
        end 

        def arrayContainsType(w,t)
            indice = 0
            ret = -1
            while indice < w.length and ret == -1
                if(w[indice].type==t)
                    ret = indice
                end
                indice+=1
            end 
            ret
        end 

        def adjust(w,s)
            if nWeapons==-1 and weapons != nil
                puts self.nShields
                self.class.newSpecificWeapons(@weapons.select{|weapon| w.map{ |wp| wp.type}.any?weapon}, [s.length,@nShields].min)
            elsif nWeapons!=-1 and weapons == nil
                self.class.newNumericWeapons([w.length,@nWeapons],[s.length,@nShields].min)
            end 
        end

        def hasNoEffect
            if(nWeapons==-1)
                weapons.empty?
            else 
                nWeapons==0
            end 
        end

        def discardWeapon(w)
            if(nWeapons==-1)
                @weapons.delete(w.type)
            else
                if @nWeapons>0 
                    @nWeapons=@nWeapons-1
                end 
            end
            
        end 

        def discardShieldBooster()
            if(@nShields>0)
                @nShields=@nShields-1
            end
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
puts d.inspect
d=d.adjust(armillas,s)
puts d.inspect
puts nuevo.hasNoEffect

