Pod::Spec.new do |spec|
  spec.name = "GenericPasswordRow"
  spec.version = "3.1.0"
  spec.summary = "Eureka row to validate passwords"
  spec.homepage = "https://github.com/EurekaCommunity/GenericPasswordRow"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Diego Ernst" => 'dernst@xmartlabs.com' }

  spec.platform = :ios, "9.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/EurekaCommunity/GenericPasswordRow.git", tag: "#{spec.version}", submodules: true }
  spec.ios.source_files = 'Sources/**/*.swift'
  spec.resource_bundles = {
    'GenericPasswordRow' => ['Resources/*']
  }
  spec.swift_version = '5.0'
  spec.ios.frameworks = 'UIKit', 'Foundation'
  spec.dependency "Eureka", "~> 5.2"
end
