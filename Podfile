# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

workspace 'ChuckNorris'

# Define main pods.
def common_pods

end

# Define main test pods.
def common_test_pods
  pod 'Quick'
  pod 'Nimble'
end

target 'Application' do
  project 'Application/Application.xcodeproj'

  common_pods
  # Pods for Application

  pod 'RxSwift'
  pod 'RxCocoa'

  target 'ApplicationTests' do
    project 'Application/Application.xcodeproj'

    common_test_pods
    # Pods for ApplicationTests

    pod 'iOSSnapshotTestCase'
    pod 'KIF'

  end
end

target 'Domain' do
  project 'Domain/Domain.xcodeproj'

  common_pods
  # Pods for Domain

  target 'DomainTests' do
    project 'Domain/Domain.xcodeproj'

    common_test_pods
    # Pods for DomainTests

  end
end

target 'Services' do
  project 'Services/Services.xcodeproj'

    common_pods
    # Pods for Services

    target 'ServicesTests' do
      project 'Services/Services.xcodeproj'

      common_test_pods
      # Pods for ServicesTests

    end
  end