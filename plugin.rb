#!/usr/bin/env ruby

def clean_fieldname(fieldname = '')
  fieldname.gsub(/^[^A-Za-z_]/, '_').gsub(/[^A-Za-z0-9_]/, '_')
end