require 'fileutils'
(11..60).each do |i|
	FileUtils.cp_r "0#{i < 10 ? "0#{i.to_s}" : i}", "#{i + 90}"
end