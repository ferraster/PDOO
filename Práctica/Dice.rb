#encoding: UTF-8

module DeepSpace
    class Dice 
        def initialize()
            @NHANGARSPROB=0.25
            @NSHIELDSPROB=0.25
            @NWEAPONSPROB=0.33
            @FIRSTSHOTPROB=0.5
            @RANDOM=Random.new 
        end 

        def initWithNhangars
            prob=@RANDOM.rand(1.0)
            if(prob<@NHANGARSPROB)
                ret=0
            else 
                ret=1
            end 
        end 

        def initWithNWeapons
            prob=@RANDOM.rand(1.0)
            if(prob<@NWEAPONSPROB)
                ret=1 
            elsif(@NWEAPONSPROB <= prob and prob< 2*@NWEAPONSPROB)
                ret=2
            else 
                ret=3
            end 
        end 

        def initWithNShields 
            prob=@RANDOM.rand(1.0)
            if(prob<@NSHIELDSPROB)
                ret=0        
            else 
                ret=1
            end 
        end 

        def whoStarts(nPlayers)
            ret=@RANDOM.rand(nPlayers-1)
        end 

        def FirstShot 
            prob=@RANDOM.rand(1.0)
            if(prob<@FIRSTSHOTPROB)
                ret=GameCharacter::SPACESTATION
            else 
                ret=GameCharacter::ENEMYSTARSHIP
            end 
        end 

        def spaceStationMoves(speed)
            prob=@RANDOM.rand(1.0)
            if(prob<speed)
                ret=true
            else 
                ret=false 
            end 
        end
        
        def to_s
            "NHANGARSPROB=#{@NHANGARSPROB} NSHIELDSPROB=#{@NSHIELDSPROB} NWEAPONSPROB=#{@NWEAPONSPROB} FIRSTSHOTPROB=#{@FIRSTSHOTPROB}"
        end 

        def DiceToUI
            DiceToUI(self)
        end
    end
end 