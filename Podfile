platform :ios, '9.0'

def lib_pods

  pod 'Pageboy', :git => 'https://github.com/uias/Pageboy', :branch => 'pageboy3'
  pod 'AutoInsetter', '~> 1.2.0'

end

target 'Tabman-Example' do
  workspace 'Tabman'
  project './Example/Tabman-Example.xcodeproj'

  use_frameworks!
  lib_pods

  pod 'BulletinBoard', '~> 2.0'
  pod 'SnapKit', '~> 4.0'

end

target 'Tabman' do
  workspace 'Tabman'
  project './Sources/Tabman.xcodeproj'

  use_frameworks!
  lib_pods

  target 'TabmanTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  
  # convert incompatible pods back to Swift 4.1
  myTargets = ['BulletinBoard', 'SnapKit']  
  installer.pods_project.targets.each do |target|
    if myTargets.include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.1'
      end
    end
  end
end