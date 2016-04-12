#!/usr/bin/env ruby

require 'pp'
require 'nokogiri'
require 'fileutils'

dir = ARGV[0]
file_name = "#{dir}/composite.xml"


# Open XML File
doc = File.open(file_name) { |f| Nokogiri::XML(f) }

# Strip all results with "monitor" in them
doc.xpath("//Result").collect { |r|
  r.children.one? { |c|
    c.name == "Description" && c.children.find { |cc|
      cc.content.downcase.include?("monitor")
    }
  } && r.remove
}

# Write a new temp file
new_file = File.new("#{file_name}.tmp_#{$$}", "w")
new_file.puts doc.to_xml(save_with: Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS)
new_file.close
old_stat = File.stat(file_name)
File.chown(old_stat.uid, old_stat.gid, new_file.path)
File.chmod(old_stat.mode, new_file.path)

# Backup the XML file
file_bk = "#{file_name}.pre_strip"
FileUtils.cp(file_name,file_bk,:preserve => true) unless File.exist?(file_bk)

# Atomically update XML File
FileUtils.mv(new_file.path, file_name)
