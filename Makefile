CONFIG = debug
PLATFORM_IOS = iOS Simulator,name=iPhone 14 Pro

.PHONY: test
test:
	xcodebuild test \
		-configuration $(CONFIG) \
		-scheme ForcibleValue \
		-destination platform="$(PLATFORM_IOS)"

.PHONY: test-swift
test-swift:
	swift test --parallel

.PHONY: format
format:
	swift format \
		--ignore-unparsable-files \
		--in-place \
		--recursive \
		./Package.swift ./Sources ./Tests
