desc 'installs the generator and templates in your current ruby directory'
task :install do
  rdoc_path = get_rdoc_path()  
  generator_path, template_path = get_local_paths()
  generator_install_path, template_install_path = get_install_paths(rdoc_path)
  
  say "Installing ajax generator"
  sudo "cp #{generator_path}/ajax_generator.rb #{generator_install_path}"
  
  say "Installing ajax templates"
  sudo "cp -R #{template_path}/ajax #{template_install_path}"
  
  say "Installed to #{rdoc_path}"
end

task :uninstall do
  rdoc_path = get_rdoc_path()
  generator_install_path, template_install_path = get_install_paths(rdoc_path)
  sudo "rm -rf #{generator_install_path}/ajax_generator.rb #{template_install_path}/ajax"
end

def sudo(cmd)
  # puts %Q{sudo -p "Password: " #{cmd}}
  %x[sudo -p "Password: " #{cmd}]
end

def say(msg)
  puts msg
end

def get_rdoc_path
  rdoc_path = ENV['RDOC']
  # if using macports ruby i know where stuff is
  rdoc_path ||= %x[which ruby] =~ /^\/opt/ ? '/opt/local/lib/ruby/1.8/rdoc' : nil
  raise ArgumentError, "Don't forget: RDOC_PATH=/path/to/lib/ruby/1.8/rdoc rake install" unless rdoc_path
  rdoc_path
end

def get_local_paths
  generator_path = File.join(File.dirname(__FILE__), '..', 'rdoc', 'generators')
  template_path  = File.join(generator_path, 'template')
  [generator_path, template_path]
end

def get_install_paths(rdoc_path)
  generator_install_path = File.join(rdoc_path, 'generators')
  template_install_path = File.join(rdoc_path, 'generators', 'template')
  [generator_install_path, template_install_path]
end