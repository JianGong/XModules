Pod::Spec.new do |s|

  s.name         = "XModules"
  s.version      = "0.6.2"
  s.summary      = "工厂化模组"
  s.description  = <<-DESC
                   *目常用组件
                   DESC

  s.homepage     = "http://ibcker.me"
  s.license      = 'Apache'
  s.author       = { "ibcker" => "happymiyu@gmail.com" }
  s.source       = { :git => "https://github.com/ibcker/XModules.git",:branch => "dev"}
  s.source_files  = 'XModules/**/*.{h,m}'
  s.resource     = 'XModules/**/*.bundle'
  s.exclude_files = 'XModules/debuger'
  s.frameworks   = 'UIKit', 'CoreText', 'CoreGraphics', 'QuartzCore'
  s.requires_arc = true
  s.platform = :ios, '7.0'

# s.default_subspec = 'utils'

  s.dependency 'AFNetworking', '~>2.5'
  s.dependency 'EGOCache', '~>2.1'
  s.dependency 'SVProgressHUD'
  s.dependency 'SDWebImage', '~>3.7'

end