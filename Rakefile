require 'pathname'

SYMLINK_FILES = %w{.vim .vimperator .ackrc .dir_colors .screen.development .screenrc .vimperatorrc .vimrc .zshrc .oh-my-zsh}
SYMLINK_DIRS = %w{bin src .ssh}

$cwd = File.dirname(__FILE__)
$home = ENV['HOME'];

task :install do

	def symlink(f)
		src = "#{$cwd}/#{f}"
		dst = "#{$home}/#{f}"

		puts "symlink(\"#{src}\", \"#{dst}\")"

		if File.exists?(dst) && Pathname.new(dst).realpath.to_s != src
			puts "Error symlinking. #{dst} already exists and isn't linked to #{src}. (A)bort, (C)ontinue?"
			response = STDIN.gets
			if response =~ /^c.*/i
				puts "Continuing..."
				return
			else
				puts "Exiting"
				exit
			end
		elsif !File.exists?(dst)
			File.symlink(src, dst)
		end
	end

	SYMLINK_DIRS.each do |d|
		dir = "#{d}/*"
		Dir.glob(dir).each do |f|
			symlink(f)
		end
	end

	SYMLINK_FILES.each do |f|
		symlink(f)
	end

end
