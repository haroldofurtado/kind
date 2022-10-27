source 'https://rubygems.org'

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

activemodel_version = ENV['ACTIVEMODEL_VERSION']

activemodel = case activemodel_version
              when '3.2' then '~> 3.2.0'
              when '4.0' then '~> 4.0.0'
              when '4.1' then '~> 4.1.0'
              when '4.2' then '~> 4.2.0'
              when '5.0' then '~> 5.0.0'
              when '5.1' then '~> 5.1.0'
              when '5.2' then '~> 5.2.0'
              when '6.0' then '~> 6.0.0'
              when '6.1' then '~> 6.1.0'
              when '7.0' then '~> 7.0.0'
              end

simplecov_version =
  case RUBY_VERSION
  when /\A2.[123]/ then '0.17.1'
  when /\A2.4/ then '~> 0.18.5'
  else '~> 0.21.2'
  end

is_ruby_2_1 = RUBY_VERSION <= '2.2.0'

minitest_version =
  if activemodel_version
    activemodel_version < '4.1' ? '~> 4.2' : '~> 5.0'
  else
    is_ruby_2_1 ? '~> 4.2' : '~> 5.0'
  end

group :test do
  if activemodel_version
    gem 'activesupport', activemodel, require: false
    gem 'activemodel'  , activemodel, require: false
  end

  gem 'minitest' , minitest_version
  gem 'simplecov', simplecov_version, require: false
end

gem 'rake', is_ruby_2_1 ? '~> 12.3' : '~> 13.0'

# Specify your gem's dependencies in type_validator.gemspec
gemspec
