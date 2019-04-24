#encoding: UTF-8

require_relative 'GameCharacter'

module Deepspace
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

        def firstShot 
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

        def getUIversion
            DiceToUI.new(self)
        end
    end
end 


if $0 == __FILE__

    dice=Deepspace::Dice.new
    contador0=0
    contador1=0
    for i in 0..100 do
        ret=dice.initWithNShields
    
    end
    puts "contador 1: #{contador1} ------ contador 0: #{contador0}"

end 