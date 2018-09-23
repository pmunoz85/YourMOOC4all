#Date::DATE_FORMATS.merge!({:db => '%m/%d/%Y', :uk_format => '%m/%d/%Y', :es_format => '%m/%d/%Y'})
#Date::DATE_FORMATS[:default]='%d %m %Y'

Time::DATE_FORMATS[:default] = lambda { |time| I18n.l(time) }
Date::DATE_FORMATS[:default] = lambda { |date| I18n.l(date) }



#DATE_AT_FORMAT = "%d/%m/%Y %H:%M"
#DATE_ON_FORMAT = "%d/%m/%Y"
#
#Time::DATE_FORMATS.merge!(
#:standard => DATE_AT_FORMAT,
#:default => DATE_AT_FORMAT,
#:standard_time => DATE_AT_FORMAT
#)
#
#Date::DATE_FORMATS.merge!(
#:standard => DATE_ON_FORMAT,
#:default => DATE_ON_FORMAT,
#:standard_time => DATE_ON_FORMAT
#)




#DATE_AT_FORMAT = "%d/%m/%Y %H:%M"
#DATE_ON_FORMAT = "%d/%m/%Y"
#
#Time::DATE_FORMATS[:default] = DATE_AT_FORMAT
#Date::DATE_FORMATS[:default] = DATE_ON_FORMAT

