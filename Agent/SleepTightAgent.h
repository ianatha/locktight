//
//  SleepTightAgent.h
//
//	Helper app implementation
//
//	Copyright © 2003 Alex Harper
//
// 	This file is part of SleepTight.
// 
// 	SleepTight is free software; you can redistribute it and/or modify
// 	it under the terms of the GNU General Public License as published by
// 	the Free Software Foundation; either version 2 of the License, or
// 	(at your option) any later version.
// 
// 	SleepTight is distributed in the hope that it will be useful,
// 	but WITHOUT ANY WARRANTY; without even the implied warranty of
// 	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// 	GNU General Public License for more details.
// 
// 	You should have received a copy of the GNU General Public License
// 	along with SleepTight; if not, write to the Free Software
// 	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
// 

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>
#import <IOKit/pwr_mgt/IOPMLib.h>
#import <IOKit/IOMessage.h>
#import "ScreenSaverControl.h"
#import "SleepTight.h"
#import "SleepTightSaverPref.h"
#import "SleepTightDefaults.h"
#import "SleepLockBezel.h"

// Carbon hotkey callback
static pascal OSStatus LockHotKeyHandler(EventHandlerCallRef nextHandler, EventRef theEvent, void *userData);

@interface SleepTightAgent : NSObject {
	// Hotkey plumbing
	EventHotKeyRef				lockHotKeyRef;
	EventHotKeyID				lockHotKeyID;
	// Timer for sleep check
	NSTimer						*sleepTimer;
	// Counter for how long the timer has waited
	double						waitedForSaver;
	// Our prefs
	SleepTightDefaults			*ourPrefs;
	// The lock bezel window
	IBOutlet SleepLockBezel		*bezelWindow;
	// The screensaver control
	ScreenSaverController 		*ssControl;
}

- (void)lockFromHotKey;
- (void)startSaver;
- (BOOL)saverIsFront;
- (void)configFromPrefs:(NSNotification *)notification;
- (void)registerHotKey;
- (void)unregisterHotKey:(NSNotification *)notification;
- (void)killAgent:(NSNotification *)notification;

@end
