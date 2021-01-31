# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MarvelHeroes' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  def testing_pods
    pod 'Quick'
    pod 'Nimble'
    pod 'SnapshotTesting'
  end
  # Pods for MarvelHeroes

  target 'MarvelHeroesTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

  target 'MarvelHeroesUITests' do
    # Pods for testing
    testing_pods
  end

end
