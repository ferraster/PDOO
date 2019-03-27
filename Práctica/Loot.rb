#encoding: UTF-8


module Deepspace
    class Loot
        attr_reader :nSupplies, :nWeapons, :nShields, :nHangars, :nMedals
    
        def initialize(supplies_num,weapons_num,shields_num,hangars_num,medals_num)
          @nSupplies = supplies_num
          @nWeapons = weapons_num
          @nShields = shields_num
          @nHangars = hangars_num
          @nMedals = medals_num
        end

        def to_s 
          "nSupplies=#{@nSupplies} nWeapons=#{@nWeapons} nShields=#{@nShields} nHangars=#{@nHangars} nMedals=#{@nMedals}"     
        end
        
        def getUIversion
          LootToUI.new(self)
        end 
      end
end 