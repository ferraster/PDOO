#encoding: UTF-8 

module Deepspace
    class Damage
        def initialize(w,s)
            @nShields=s 
            @nWeapons=w
            @WeaponList=nil
        end 
        
        attr_reader : WeaponList

        def self.newDamage(wl,s)
            n=new(-1,s)
            
        end 

        def 
    end 

end 