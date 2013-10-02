namespace :gem do

  desc "build"
  task :build do
    puts %x[rm -rf *.gem]
    puts %x[gem build *.gemspec]
  end

  desc "install"
  task :install do
    puts %x[gem install *.gem]
    puts %x[rm -rf *.gem]
  end

  desc "release"
  task :release do
    gems = Dir.glob("*.gem").length
    puts gems
    raise "0 or > 1 gem in directory; aborting!" if gems != 1
    puts %x[gem push *.gem]
    puts %x[rm -rf *.gem]
  end

  desc "build & install"
  task :build_and_install do
    Rake::Task["gem:build"].invoke
    Rake::Task["gem:install"].invoke
  end

  desc "build & release"
  task :build_and_release do
    Rake::Task["gem:build"].invoke
    Rake::Task["gem:release"].invoke
  end

end