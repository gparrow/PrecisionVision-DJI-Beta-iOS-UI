Pod::Spec.new do |s|
  s.name = 'DJI-UXSDK-iOS-Beta'
  s.version = '0.1.0'
  s.license = 'MIT'
  s.summary = 'DJI iOS UX SDK'
  s.homepage = 'https://github.com/gparrow/PrecisionVision-DJI-Beta-iOS-UI'
  s.authors = { 'DJI' => 'dev@dji.com' }
  s.documentation_url = 'https://github.com/dji-sdk/Mobile-UXSDK-Beta-iOS/wiki'
  s.ios.deployment_target = '11.0'
  s.requires_arc = true
  s.module_name = 'DJIUXSDKBeta'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC -all_load' } 
  s.source = { :git => 'https://github.com/gparrow/PrecisionVision-DJI-Beta-iOS-UI.git', :tag => s.version.to_s }
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO', 'DEFINES_MODULE' => 'YES', 'SWIFT_OBJC_BRIDGING_HEADER' => '$(PODS_TARGET_SRCROOT)/'}
  s.cocoapods_version = '>= 1.7.1'
  s.source_files = 'DJIUXSDKBeta/**/*.{h,m}'
  s.dependency 'DJI-UXSDK-iOS-Beta-Core', '0.1.0'
  s.dependency 'DJI-UXSDK-iOS-Beta-Communication', '0.1.0'
  s.dependency 'DJI-UXSDK-iOS-Beta-Widgets', '0.1.0'
end
