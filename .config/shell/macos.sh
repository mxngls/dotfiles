#!/bin/sh

if [ "$(uname)" = "Darwin" ]; then
	# increase key repeat and initial key repeat rate
	defaults write NSGlobalDomain InitialKeyRepeat -int 10 # Normal minimum is 15 (225 ms)
	defaults write NSGlobalDomain KeyRepeat -int 1         # Normal minimum is 2 (30 ms)

	# only show currently open applications in dock
	defaults write com.apple.dock static-only -bool true
	killall Dock

	if [ -z "$HIDUTIL_REMAPPING_APPLIED" ]; then

		# Remapping Keys in macOS:
		# 	- https://developer.apple.com/library/archive/technotes/tn2450/_index.html
		# 	- https://github.com/apple-oss-distributions/IOHIDFamily/blob/main/IOHIDFamily/IOHIDUsageTables.h
		# 	- https://opensource.apple.com/source/IOHIDFamily/IOHIDFamily-870.60.4/IOHIDFamily/AppleHIDUsageTables.h
		#
		# Standard Apple Magic Keyboard Function Key Mappings:
		# F1  (0x3A) -> Brightness Down    (0xFF0100000021)
		# F2  (0x3B) -> Brightness Up      (0xFF0100000020)
		# F3  (0x3C) -> Mission Control    (0xFF0100000010)
		# F4  (0x3D) -> Spotlight/Launchpad (varies by Mac model)
		# F5  (0x3E) -> Dictation          (0xC000000CF)
		# F6  (0x3F) -> Do Not Disturb     (0x10000009B)
		# F7  (0x40) -> Previous Track     (0xC000000B6)
		# F8  (0x41) -> Play/Pause         (0xC000000CD)
		# F9  (0x42) -> Next Track         (0xC000000B5)
		# F10 (0x43) -> Mute               (0xC000000E2)
		# F11 (0x44) -> Volume Down        (0xC000000EA)
		# F12 (0x45) -> Volume Up          (0xC000000E9)

		FROM="\"HIDKeyboardModifierMappingSrc\""
		TO="\"HIDKeyboardModifierMappingDst\""

		hidutil property --set "{\"UserKeyMapping\":[
		{$FROM: 0x70000003A, $TO: 0xFF0100000021},
		{$FROM: 0x70000003B, $TO: 0xFF0100000020},
		{$FROM: 0x70000003C, $TO: 0xFF0100000010},
		{$FROM: 0x70000003D, $TO: 0xFF0100000004},
		{$FROM: 0x70000003E, $TO: 0xC000000CF},
		{$FROM: 0x70000003F, $TO: 0x10000009B},
		{$FROM: 0x700000040, $TO: 0xC000000B6},
		{$FROM: 0x700000041, $TO: 0xC000000CD},
		{$FROM: 0x700000042, $TO: 0xC000000B5},
		{$FROM: 0x700000043, $TO: 0xC000000E2},
		{$FROM: 0x700000044, $TO: 0xC000000EA},
		{$FROM: 0x700000045, $TO: 0xC000000E9}
	]}" >/dev/null

		# Prevent re-execution in this session
		export HIDUTIL_REMAPPING_APPLIED=1

	fi
fi
