#encoding: UTF-8 

module Deepspace 
    module WeaponType
        class Type 
            def initialize(p)
                @power=p
            end 
         
            def power
                @power
            end 

            def to_s 
                if @power==2
                    tipo="LASER"
                elsif @power==3
                    tipo="MISSILE"
                else 
                    tipo="PLASMA"
                end 
                tipo 
            end 
        end 

        LASER=Type.new(2.0)
        MISSILE=Type.new(3.0)
        PLASMA=Type.new(4.0)
    end 
end 