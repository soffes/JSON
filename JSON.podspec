Pod::Spec.new do |s|
  s.name         = "JSON"
  s.version      = "0.1.3"
  s.summary      = "Micro framework for easily parsing JSON."
  s.description  = <<-DESC
    Micro framework for easily parsing JSON in Swift with rich error messages in less than 100 lines of code.
  DESC
  s.homepage     = "https://github.com/soffes/JSON"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Sam Soffes" => "sam@soff.es" }
  s.ios.deployment_target = "10.0"
  s.source       = { :git => ".git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
  s.swift_version = "4.1"
end
