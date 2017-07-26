require 'fileutils'
begin
  gem "git"
rescue LoadError
  system("gem install git")
  Gem.clear_paths
end
require 'git'
require 'etc'
require 'open3'

chart_repo = "https://owain-je.github.io/charts/"


task :default => [:clean,:helm_init,:build_charts, :move_charts_to_docs ,:index_charts]


module Utils
  class Subprocess
    def initialize(cmd, &block)
      Open3.popen3(cmd) do |stdin, stdout, stderr, thread|
        { :out => stdout, :err => stderr }.each do |key, stream|
          Thread.new do
            until (line = stream.gets).nil? do
              if key == :out
                yield line, nil, thread if block_given?
              else
                yield nil, line, thread if block_given?
              end
            end
          end
        end
        thread.join # don't exit until the external process is done
        exit_code = thread.value
		if(exit_code != 0)
			puts("Failed to execute_cmd #{cmd} exit code: #{exit_code}")
			Kernel.exit(false)
		end
      end
    end
  end
end

def execute_cmd(cmd,chdir=File.dirname(__FILE__))
	puts("execute_cmd: #{cmd}")	
	Utils::Subprocess.new cmd do |stdout, stderr, thread|
  		puts "\t#{stdout}"
  		if(stderr.nil? == false)
  			puts "\t#{stderr}"	
  		end
	end
end


task :clean do 
	FileUtils.rm_f("*.tgz")
end

task :helm_init do 
	path = File.join(Etc.getpwuid.dir,'.helm')
	execute_cmd("helm init --client-only") unless File.exists?(path)
end


task :build_charts do 	
	folders = Dir.glob('*').select {|f| File.directory? f}
	folders.each do |f|
      if(f != 'docs')
      	puts("packaging #{f}")
      	execute_cmd("helm package #{f}")
      end
	end
end 

task :move_charts_to_docs do 
   FileUtils.mv(Dir.glob("*.tgz"),"docs")
end

task :index_charts do 
  Dir.chdir "docs"
  execute_cmd("helm repo index . --url #{chart_repo}")
  Dir.chdir ".."
  git = Git.open(Dir.pwd)  
  git.config('user.name', 'automation')
  git.config('user.email', 'automation@owain-je.com')
  git.add('docs')
  git.commit('Automated index build.')
  git.pull()
  git.push(git.remote('origin'))
end

