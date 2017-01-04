#
# Be sure to run `pod lib lint SuperSimpleMapper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SuperSimpleMapper'
  s.version          = '0.1.0'
  s.summary          = 'Very simple object mapper'
  s.description      = <<-DESC
This is just a simple utility to map object of one type to object of another type. Useful if you are using an ORM and feel the need to map to plain objects your ORM objects to prevent complex objects polluting all layers of your app. It also works as json mapper but there's lot's of better solutions for that purpose.
                       DESC

  s.homepage         = 'https://github.com/frograin/SuperSimpleMapper'
  s.license          = 'MIT'
  s.author           = { "FrogRain" => "info@frograin.com" }
  s.source           = { :git => "https://github.com/frograin/FluidValidator.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'SuperSimpleMapper/Classes/**/*'
end
