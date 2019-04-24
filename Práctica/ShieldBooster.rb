#encoding: UTF-8 

require_relative 'ShieldToUI'

module Deepspace 
    class ShieldBooster
        def initialize(name_,boost_,uses_)
            @name=name_
            @boost=boost_
            @uses=uses_
        end 

        attr_reader :name , :boost , :uses 

        def self.newCopy(shieldBooster_)
            new(shieldBooster_.name,shieldBooster_.boost,shieldBooster_.uses)
        end 

        def useIt
            if(self.uses>0)
                retval=self.boost
                @uses=self.uses-1
            else 
                retval=1.0
            end 
            retval
        end 

        def to_s 
            "name=#{@name} boost=#{@boost} uses=#{@uses}"
        end 

        def getUIversion
            ShieldToUI.new(self)
        end 
    end 
end 