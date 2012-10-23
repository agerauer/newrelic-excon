task :gem do
  `gem build *.gemspec`
end

task :install do
  Rake::Task[:gem].invoke
  `sudo gem install *.gem`
  Rake::Task[:cleanup].invoke
end

task :cleanup do
  `rm *.gem`
end


# ---------------------- Documentation

Rake::RDocTask.new { |rdoc|
  rdoc.rdoc_dir = 'doc/rdoc'
  rdoc.title    = "MCC"
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.template = "#{ENV['template']}.rb" if ENV['template']
  if ENV['DOC_FILES'] 
    rdoc.rdoc_files.include(ENV['DOC_FILES'].split(/,\s*/))
  else
    rdoc.rdoc_files.include('README')
    rdoc.rdoc_files.include('lib/**/*.rb')
  end
}
