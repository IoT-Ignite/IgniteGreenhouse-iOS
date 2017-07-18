# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
workspace 'IgniteGreenhouse'

def shared_pods
  pod 'Alamofire'
  pod 'SwiftyJSON'
  #pod 'RealmSwift'
end

target 'IgniteGreenhouse' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for IgniteGreenhouse
  shared_pods
  pod 'ViewDeck'
  pod 'Charts'
  #pod 'ChartsRealm'
end

target 'IgniteGreenhouseTests' do
  use_frameworks!
  pod 'SwiftyJSON'
end

target 'IgniteAPI' do
  project 'IgniteAPI/IgniteAPI.xcodeproj'
  use_frameworks!
  shared_pods
end

target 'IgniteAPITests' do
  project 'IgniteAPI/IgniteAPI.xcodeproj'
  use_frameworks!
  shared_pods
end
