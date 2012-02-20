require 'pathname'

SYMLINK_FILES = %w{.vim .ackrc .dir_colors .screen.development .screenrc .vimrc .zshrc .oh-my-zsh .colordiffrc .gitglobalignore .zshplugins}
SYMLINK_DIRS = %w{bin src .ssh}
MERGE_FILES = {
  ['.gitconfig','.gitconfig.private'] => '.gitconfig',
  ['.ssh_config','.ssh_config.private'] => '.ssh/config'
}

$cwd = File.dirname(__FILE__)
$home = ENV['HOME'];

task :install do

  def symlink_wrapper(f)
    src = "#{$cwd}/#{f}"
    dst = "#{$home}/#{f}"

    puts "symlink(\"#{src}\", \"#{dst}\")"

    if File.exists?(dst) && Pathname.new(dst).realpath.to_s != src
      print "Error symlinking. #{dst} already exists and isn't linked to #{src}. (A)bort, (C)ontinue?"
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
      symlink_wrapper(f)
    end
  end

  SYMLINK_FILES.each do |f|
    symlink_wrapper(f)
  end

  MERGE_FILES.each do |sources,dest|
    final_s = ''
    sources.each do |source|
      s_file = "#{$cwd}/#{source}"
      if not File.exists?(s_file) or not File.readable?(s_file) then
	puts "Could not find source file #{s_file} or file not readable"
	next
      end
      final_s << File.open(s_file).read()
    end

    d_file = "#{$home}/#{dest}"

    if final_s.empty? then
      raise Exception.new("Empty sources for #{d_file}, bailing")
    end

    if File.exists?(d_file) and not File.file?(d_file) then
      raise Exception.new("Destination file #{d_file} not a file")
    end
    if File.exists?(d_file) and not File.writable?(d_file) then
      raise Exception.new("Destination file #{d_file} not writable")
    end

    preview = true
    while File.exists?(d_file) and preview
      preview = false
      print "Destination file #{d_file} already exists. (P)review, (S)kip, (U)nlink? "
      response = STDIN.gets
      case response
      when /^u.*/i then
	puts "Unlinking #{d_file}"
	File.unlink(d_file)
      when /^p.*/i then
	preview = true
	puts File.open(d_file).read() + "\n\n"
      else
	puts "Skipping #{d_file}"
	next
      end
    end
    puts "Writing to #{d_file}"
    File.open(d_file, 'w') { |f| f.write(final_s) }
  end # End MERGE_FILES

  `./updateSubmodules.sh`
  ctags_dst = "#{$home}/.ctags"
  if !File.exists?(ctags_dst) then
    File.symlink("#{$cwd}/.vim/bundle/vim-scala/ctags", "#{$home}/.ctags")
  end

end
