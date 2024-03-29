Pod::Spec.new do |spec|
  spec.name         = "ForcibleValue"
  spec.version      = "0.3.1"
  spec.summary      = "Better Codable through Property Wrappers."

  spec.description  = <<-DESC
    Decode value that is sometimes an Int and other times a String your Codable structs through property wrappers.
  DESC

  spec.homepage     = "https://github.com/to4iki/ForcibleValue"
  spec.license      = "MIT"
  spec.author       = { "Toshiki Takezawa" => "tsk.take815@gmail.com" }

  spec.ios.deployment_target = "11.0"
  spec.osx.deployment_target = "10.13"
  spec.swift_version = "4.2"

  spec.source        = { :git => "https://github.com/to4iki/ForcibleValue.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/ForcibleValue"
  spec.framework     = "XCTest"

  spec.requires_arc = true
end
