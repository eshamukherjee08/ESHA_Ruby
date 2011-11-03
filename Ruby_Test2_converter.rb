require 'xmlsimple'
require 'json'

module UseConverter
  
  # method that creates path when direct conversion doesnot exists.
   def pathCalc(item_unit, unitTo)
        while(true)
            @conv_list_hash.each do |r|
                if(item_unit == r[0].split("-")[0])
                    @path_conversion << r[0]
                    item_unit = r[0].split("-")[1]
                    break
                elsif(item_unit == r[0].split("-")[1])
                    @path_conversion << r[0]
                    item_unit = r[0].split("-")[0]
                    break
                end
            end
            if(item_unit == unitTo)
              break
            end 
        end
    end
    
    
    def final_Calculation(unit_from, unitTo, item_price, ratio)
        final_calc = (unit_from == unitTo) ? (item_price/ratio) : (item_price*ratio)
    end
end

class Converter
  
  include UseConverter
  
    def initialize
        @item_list_hash = XmlSimple.xml_in('xml_data.xml')
        @conv_list_hash = JSON.parse(File.read('json_data.json'))
    end
   
    def convert(id, unitTo)
        @path_conversion, item_unit, item_price = [], "", 0.0

        # Choose unit and preice for selected id
        # @item_list_hash["item"]

        @item_list_hash["item"].each do |item|
            if(id.to_s == item["id"])
                item_unit, item_price = item["unit"][0], item["price"][0].to_f
            end    
        end
        
        unit_from, unit_to, ratio, final_calc = "", "", 0.0, 0.0
        @conv_list_hash.each do |r|
            if(item_unit+"-"+unitTo == r[0] || unitTo+"-"+item_unit == r[0])
                unit_from, ratio = r[1]["unit_from"], r[1]["ratio"].to_f
            end    
        end
        
        
        #### unit_from.empty? 
        
        if !(unit_from.empty?)                       # when direct conversion exists.
            final_calc = final_Calculation(unit_from, unitTo, item_price, ratio)
        else
            pathCalc(item_unit, unitTo)           #enters when direct conversion doesnot exists.
            final_calc = item_price
            @path_conversion.each do |index|
                @conv_list_hash.each do |r|
                    if(index == r[0])
                        unit_from, unit_to, ratio = r[1]["unit_from"], r[1]["unit_to"], r[1]["ratio"].to_f
                    end
                end                       
                if(unit_from == item_unit)
                    item_unit, final_calc = unit_to, final_calc*ratio
                else
                    item_unit, final_calc = unit_from, final_calc/ratio
                end
            end    
        end
        puts "Conversion of Item id. #{id} to #{unitTo} is #{final_calc}\n\n"    
    end
end

obj = Converter.new
#obj.convert(3, "CAD")
#obj.convert(4, "USD")
obj.convert(4, "CAD")


#p XmlSimple.xml_in('xml_data.xml')
