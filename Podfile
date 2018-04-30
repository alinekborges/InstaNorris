# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

def common_pods
  pod 'Swinject', '~> 2.0.0'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Moya/RxSwift'
  pod 'Reusable'
  pod 'SwiftLint'
  pod 'R.swift'
  pod 'ReachabilitySwift'
end

target 'InstaNorris' do
	inhibit_all_warnings!
  	common_pods

target 'InstaNorrisTests' do
    inherit! :search_paths
    
	pod 'Quick'
   	pod 'Nimble'
   	pod 'RxBlocking',

   post_install do |installer|
     installer.pods_project.targets.each do |target|
       target.build_configurations.each do |config|
         config.build_settings['ENABLE_BITCODE'] = 'NO'
       end
     end
   end
 end
end

