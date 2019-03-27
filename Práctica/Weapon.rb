#encoding: UTF-8  

require_relative 'WeaponType'

module Deepspace 
    class Weapon 
        def initialize(name_,weaponType_,uses_)
            @name=name_
            @type=weaponType_
            @uses=uses_
        end 

        attr_reader :name, :type , :uses 

        def self.newCopy(w)
            new(w.name,w.type,w.uses)
        end

        def power 
            @type.power
        end 
        
        def useIt
            if(self.uses>0)
                @uses=self.uses-1
                @type.power
            else
                1.0
            end 
        end
        
        def to_s 
            "name=#{@name} type=#{@type} uses=#{@uses}"
        end 

        def getUIversion
            WeaponToUI.new(self)
        end 
    end 
end 