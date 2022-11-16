project:
	tuist clean
	tuist fetch
	tuist generate --no-open && pod install && open Rimer.xcworkspace
	
open:
	tuist generate --no-open && pod install && open Rimer.xcworkspace
	
asset:
	tuist generate
	pod install
