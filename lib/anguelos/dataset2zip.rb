#!/usr/bin/env ruby
require 'zip/zip'
require 'zip/zipfilesystem'

class DatasetContainer
	def self.greet()
		puts "\n\n\n\n\n\n\n\n\nDatasetContainer HELLOOO!!!!!!!!!!!!!!!!\n\n\n\n\n\n\n"
	end
end


if __FILE__ == $0
	ARGV.each do|a|
		print DatasetContainer.parseZipFile(a).keys()
	end
end

