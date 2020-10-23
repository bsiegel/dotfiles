#!/usr/bin/env ruby
require 'tmpdir'

abort("Usage: build_slides.rb <markdown-file> [<destination-path>]") unless ARGV[0]
slides_path = File.expand_path(ARGV[0])
abort("#{ARGV[0]} does not exist") unless File.exists?(slides_path)

destination_path = ARGV[1] ? File.expand_path(ARGV[1])
                           : File.dirname(slides_path)

if File.directory?(destination_path)
  slides_basename = File.basename(slides_path, '.*')
  destination_path = File.join(destination_path, "#{slides_basename}.html")
end

puts "Writing static html to #{destination_path}"

Dir.mktmpdir { |dirname|
  Dir.chdir(dirname) {
    cmd = "reveal-md \"#{slides_path}\" --static out"
    exec_result = system(cmd)
    abort("Failed to exec '#{cmd}'") unless exec_result
    
    site_path = File.join(dirname, 'out')
    page_path = File.join(site_path, "#{slides_basename}.html")

    contents = IO.read(page_path)
    contents.gsub!(/\.\/(dist|plugin)/, 'https://cdn.jsdelivr.net/npm/reveal.js@4/\1')
    contents.gsub!(/^(\s*)<link rel="stylesheet" href="(\.\/css\/.+)" \/>$/) { |_|
      css_path = File.join(site_path, $2)
      css_contents = IO.read(css_path)
      "#{$1}<style>\n#{css_contents}\n#{$1}</style>"
    }
    IO.write(destination_path, contents)
  }
}

puts "Done."
