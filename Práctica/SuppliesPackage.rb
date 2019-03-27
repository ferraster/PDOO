#encoding: UTF-8

module Deepspace 
    class SuppliesPackage 
        def initialize(ammoPower_,fuelUnits_,shieldPower_)
            @ammoPower=ammoPower_
            @fuelUnits=fuelUnits_
            @shieldPower=shieldPower_
        end 

        attr_reader :ammoPower, :fuelUnits, :shieldPower

        def self.newCopy(suppliesPackage_)
            new(suppliesPackage_.ammoPower,suppliesPackage_.fuelUnits,suppliesPackage_.shieldPower)
        end     

        def to_s 
            "ammoPower=#{@ammoPower} fuelUnits=#{@fuelUnits} shieldPower=#{@shieldPower}"
        end 

        def getUIversion
            SuppliesPackageToUI.new(self)
        end 
    end 
end 


puts Deepspace::SuppliesPackage.new(1,2,3).to_s