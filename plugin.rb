#!/usr/bin/env ruby

# Support functions for Ruby munin plugins


# Clean up field name so it complies with munin requirements.
# Even though most versions of munin sanitises field names
# this at least avoids getting .s in field names which will
# very much still break munin.
#
# usage: name="clean_fieldname(fieldname)"
# 
def clean_fieldname(fieldname = '')
  fieldname.gsub(/^[^A-Za-z_]/, '_').gsub(/[^A-Za-z0-9_]/, '_')
end