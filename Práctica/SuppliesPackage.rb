#encoding: UTF-8

module DeepSpace 
    class SuppliesPackage 
        def initialize(ammoPower_,fuelUnits_,shieldPower_)
            @ammoPower=ammoPower_
            @fuelUnits=fuelUnits_
            @shieldPower=shieldPower_
        end 

        attr_reader :ammorPower, :fuelUnits, :shieldPower

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