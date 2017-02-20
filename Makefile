test:
	xcodebuild test -project JSON.xcodeproj -scheme JSON-macOS | xcpretty --color; exit ${PIPESTATUS[0]}
