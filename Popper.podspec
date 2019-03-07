#
# Be sure to run `pod lib lint Popper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Popper'
  s.version          = '0.3.0'
  s.summary          = 'A Pull Up Controller for presenting Draggable View Controller'
  s.description      = "This Presentation Controller gives you the ability to vertically drag the modally presented View Controller"
  s.homepage         = 'https://github.com/mitulmanish/Popper'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mitulmanish' => 'mitul.manish@gmail.com' }
  s.source           = { :git => 'https://github.com/mitulmanish/Popper.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'Popper/Classes/**/*'
  s.swift_version = '4.2'
end
