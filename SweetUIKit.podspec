Pod::Spec.new do |s|
  s.name             = "SweetUIKit"
  s.summary          = "Helpers and sugar for the UIKit framework."
  s.version          = "1.13.1"
  s.homepage         = "https://github.com/UseSweet/SweetUIKit"
  s.license          = 'MIT'
  s.author           = { "Use Sweet" => "usesweet.contact@gmail.com" }
  s.source           = { :git => "https://github.com/UseSweet/SweetUIKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/use_sweet'
  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'
  s.requires_arc = true
  s.source_files = 'Sources/**/*.swift'
  s.tvos.exclude_files   = 'Sources/**/iOS/*.swift'
  s.frameworks = 'UIKit'
  s.resources = 'Resources/**/*'
  s.resource_bundles = { 'SweetUIKitResources' => ['Resources/**/*'] }
end
