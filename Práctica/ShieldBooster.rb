#encoding: UTF-8 

module DeepSpace 
    class ShieldBooster
        def initialize(name_,boost_,uses_)
            @name=name_
            @boost=boost_
            @uses=uses_
        end 

        def self.newCopy(shieldBooster_)
            new(shieldBooster_.name,shieldBooster_.boost,shieldBooster_.uses)
        end 

        def name 
            @name 
        end 
         
        def boost 
            @boost
        end 

        def uses
            @uses
        end 

        def useIt
            if(self.uses>0)
                retval=self.boost
                @uses=self.uses-1
            else 
                retval=1.0
            end 
        end 

        def to_s 
            "name=#{@name} boost=#{@boost} uses=#{@uses}"
        end 

        def ShieldBoosterToUI
            new ShieldBoosterToUI(self)
        end 
    end 
end 