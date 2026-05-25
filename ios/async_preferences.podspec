#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint async_preferences.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'async_preferences'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin for asynchronous management of local preferences on iOS.'
  s.description      = <<-DESC
async_preferences is a Flutter plugin that provides asynchronous read and write access
to local preferences on iOS using UserDefaults, with a consistent API shared with Android.
                       DESC
  s.homepage         = 'https://davidserrano.io/'
  s.license          = { :type => 'Apache-2.0', :file => '../LICENSE' }
  s.author           = { 'David Serrano Canales' => 'contact@davidserrano.io' }
  s.source           = { :git => 'https://github.com/svprdga/async_preferences.git', :tag => s.version.to_s }
  s.source_files = 'async_preferences/Sources/async_preferences/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
