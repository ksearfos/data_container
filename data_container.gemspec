Gem::Specification.new do |spec|
  spec.name        = 'data_container'
  spec.version     = '0.0.3'
  spec.summary     = 'DataContainer class'
  spec.date        = '2014-08-20'
  spec.description = 'DataContainers store global/configuration values used throughout a project, but not belonging to any individual object'
  spec.author      = 'Kelli Searfos'
  spec.email       = ['ksearfos@gmail.com']
  spec.homepage    = 'https://github.com/ksearfos/data_container'
  spec.files       = ['lib/data_container.rb']
  spec.add_development_dependency 'rspec', '~> 3.0'
end
