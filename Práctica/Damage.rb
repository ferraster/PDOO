#encoding: UTF-8 

require_relative 'Weapon'
require_relative 'ShieldBooster'
require_relative 'DamageToUI'


module Deepspace
    class Damage

        
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
            if @nWeapons==-1 and @weapons != nil
                weapons=Array.new(@weapons)
                weap=w.map{|w| w.type}
                final=Array.new
                weapons.each{ |weapon|
                    if weap.include?weapon
                        weap.delete_at(weap.find_index(weapon))
                        final.push(weapon)
                    end 
                }
               
                self.class.newSpecificWeapons(final,[s.length,@nShields].min)

            elsif @nWeapons!=-1 
                self.class.newNumericWeapons([w.length,@nWeapons].min,[s.length,@nShields].min)
            end 
        end

        def hasNoEffect
            if(@nWeapons==-1)
                (@weapons.empty? and @nShields==0)
            else
                (@nWeapons==0 and @nShields==0)
            end 
        end

        def discardWeapon(w)
            if(@nWeapons==-1)
                for i in 0..@weapons.length-1 do
                    if @weapons[i]==w.type
                        @weapons.delete_at(i)
                    end 
                end 
            elsif @nWeapons>0 
                    @nWeapons=@nWeapons-1
            end
        end 

        def discardShieldBooster()
            if(@nShields>0)
                @nShields=@nShields-1
            end
        end 

        def to_s 
            getUIversion.to_s
        end 

        private :arrayContainsType 
        private_class_method :new 

    end 
end



if $0 == __FILE__
vector=Array.new(3){Deepspace::WeaponType::PLASMA}

vector.push(Deepspace::WeaponType::LASER)


armillas=Array.new 

w1=Deepspace::Weapon.new("arma1",Deepspace::WeaponType::LASER,1)
armillas.push(w1)
w2=Deepspace::Weapon.new("arma2",Deepspace::WeaponType::MISSILE,1)
armillas.push(w2)
w3=Deepspace::Weapon.new("arma3",Deepspace::WeaponType::MISSILE,1)
armillas.push(w3)



nuevo=Deepspace::Damage.newNumericWeapons(0,0)
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
puts "------------------------------------------------------------------"
puts d.inspect

end 
