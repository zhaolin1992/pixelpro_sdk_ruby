require 'pixelpro_sdk/string_ext_function.rb'
require 'byebug'

module PixelproSdk
  #generate the ddl_temp file
  class DdlGen

    @ddl_str = String.new
    @frame_num = 1

    #init the ddl generate instance
    def initialize
      @ddl_str = "0160"
    end
    #set the frame number of the ddl
    def set_frame num
      @frame_num = num
    end

    def add_image str,x,y,mask

    end

    #add text to the ddl file
    #Usage:add_text text info, x location, y location, frame mask
    def add_text str,x,y,mask=1
      raise "param type error.Usage:add_text(String,Fixnum,Fixnum,Fixnum)" unless ((str.class == String)&&(x.class == Fixnum)&&(y.class == Fixnum)&&(mask.class == Fixnum))
      offset = x
      is_consisten = 0
      ddl_temp = ""
      start_ascii = [48,65,97]

      if str.is_all_num?
        return 0 if (x+str.length*4 > 25)
        is_consisten = 1
      elsif str.is_all_up?
        return 0 if (x+str.length*5 > 25)
        is_consisten = 2
      elsif str.is_all_low?
        return 0 if (x+str.length*6 > 25)
        is_consisten = 3
      end

      if (is_consisten > 0)
        ddl_temp += "14#{x.to_s(16).rjust(2, '0')}#{y.to_s(16).rjust(2, '0')}#{str.length}#{(is_consisten*2-2).to_s}"
        str.each_byte do |letter,index|
          ddl_temp += (letter-start_ascii[is_consisten-1]).to_s(16).rjust(2, '0')
        end
      else
        str.each_byte do |letter,index|
          if letter>=65
            if letter>=97
              ddl_temp += "14#{offset.to_s(16).rjust(2, '0')}#{y.to_s(16).rjust(2, '0')}14"+((letter-97).to_s(16)).rjust(2, '0')
              offset += 6
            else
              ddl_temp += "14#{offset.to_s(16).rjust(2, '0')}#{y.to_s(16).rjust(2, '0')}12"+((letter-65).to_s(16)).rjust(2, '0')
              offset += 5
            end
          else
            ddl_temp += "14#{offset.to_s(16).rjust(2, '0')}#{y.to_s(16).rjust(2, '0')}10"+((letter-48).to_s(16)).rjust(2, '0')
            offset += 4
          end
        end
      end
      if @ddl_str.nil?
        @ddl_str = ddl_temp
      else
        @ddl_str += ddl_temp
      end
      return 1
    end

    #return the ddl
    def show_ddl
      return (@ddl_str.length / 2).to_s(16).rjust(2, '0')+@ddl_str
    end

  end
end
