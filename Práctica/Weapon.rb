#encoding: UTF-8  

module DeepSpace 
    class Weapon 
        def initialize(name_,weaponType_,uses_)
            @name=name_
            @type=weaponType_
            @uses=uses_
        end 

        def self.newCopy(w)
            new(w.name,w.type,w.uses)
        end
        
        def name
            @name
        end

        def uses
            @uses
        end 

        def type 
            @type
        end 

        def power
            @type.power
        end 

        def useIt()
            if(self.uses>0)
                @uses=self.uses-1
                ret=@type.power
            else
                ret=1.0
            end 
        end
        
        def to_s 
            "name=#{@name} type=#{@type} uses=#{@uses}"
        end 

        def WeaponToUI
            WeaponToUI(self)
        end 
    end 
end 