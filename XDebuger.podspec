Pod::Spec.new do |s|

  s.name         = "XDebuger"
  s.version      = "0.0.1"
  s.summary      = "工厂化模组-debuger"
  s.description  = <<-DESC
                   *构建项目常用组件
                   *debuger
                   DESC

  s.homepage     = "http://ibcker.me"
  s.license      = 'Apache'
  s.author       = { "ibcker" => "happymiyu@gmail.com" }
  s.source       = { :git => "https://github.com/ibcker/XModules.git"}
  s.source_files  = 'XModules/debuger/**/*.{h,m}'
  s.frameworks   = 'UIKit','QuartzCore'
  s.requires_arc = true
  s.platform = :ios, '7.0'
  s.compiler_flags = '-w'
  
#  s.default_subspec = 'reveal' #有一个bug，设定debug模式下依赖不生效，release下也会加载reveal
#  s.subspec 'reveal' do |ss|
#    ss.dependency   'Reveal-iOS-SDK'
#  end

end
