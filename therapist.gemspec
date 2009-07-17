# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{therapist}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Josh Nichols"]
  s.date = %q{2009-07-17}
  s.default_executable = %q{therapist}
  s.description = %q{Therapist is a command line tool to help you interact with GitHub issues. Also supports offline viewing of said issues.}
  s.email = %q{josh@technicalpickles.com}
  s.executables = ["therapist"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/therapist",
     "lib/therapist.rb",
     "test/test_helper.rb",
     "test/therapist_test.rb",
     "therapist.gemspec"
  ]
  s.homepage = %q{http://github.com/technicalpickles/therapist}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Helps you deal with your (GitHub) issues}
  s.test_files = [
    "test/test_helper.rb",
     "test/therapist_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nakajima-nakajima>, [">= 0"])
      s.add_runtime_dependency(%q<nakajima-optimus-prime>, [">= 0"])
      s.add_runtime_dependency(%q<git>, [">= 0"])
    else
      s.add_dependency(%q<nakajima-nakajima>, [">= 0"])
      s.add_dependency(%q<nakajima-optimus-prime>, [">= 0"])
      s.add_dependency(%q<git>, [">= 0"])
    end
  else
    s.add_dependency(%q<nakajima-nakajima>, [">= 0"])
    s.add_dependency(%q<nakajima-optimus-prime>, [">= 0"])
    s.add_dependency(%q<git>, [">= 0"])
  end
end
