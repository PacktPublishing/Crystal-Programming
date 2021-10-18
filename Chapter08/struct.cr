@[Link(ldflags: "#{__DIR__}/struct.o")]
lib LibStruct
  struct TimeZone
    minutes_west : Int32
    dst_time : Int32
  end

  fun print_tz(tz : TimeZone*) : Void
end

tz = LibStruct::TimeZone.new
tz.minutes_west = 1
tz.dst_time = 14

LibStruct.print_tz pointerof(tz)
