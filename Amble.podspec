#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "Amble"
  s.version          = "0.1.0"
  s.summary          = "A short description of Amble."
  s.description      = <<-DESC
                       An optional longer description of Amble

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/lilhinx/amble"
  s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Chris Hinkle" => "lilhinx@gmail.com" }
  s.source           = { :git => "https://github.com/lilhinx/amble.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/lilhinx'

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Classes'
  s.resources = 'Assets'
  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.dependency 'ReactiveCocoa', '~> 2.2.4'
end
