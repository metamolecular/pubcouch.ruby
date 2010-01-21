Dir.glob(File.dirname(__FILE__) + '/pubcouch/*.rb').each do |lib_file|
  require lib_file
end
