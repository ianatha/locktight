//
//  SleepTightSaverPref.m
//
//	Read/Write screen saver preferences
//
// 	Done with CFPreferences becuase NSUserDefaults can't seem to find
//	ByHost preferences.
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


#include "SleepTightSaverPref.h"

BOOL ScreenSaverPasswordActive(void) {
	Boolean			isGood;
	CFIndex			isOn = 0;	
	
	isOn = CFPreferencesGetAppIntegerValue(CFSTR(SAVERPASSWORDPREFKEY), CFSTR(SAVERDEFAULTSDOMAIN), &isGood);
	if (isGood && isOn) {
		return YES;
	}
	else {
		return NO;
	}
	
} // ScreenSaverPasswordActive

void SetScreenSaverPasswordPref(BOOL state) {
	int		val = state ? 1 : 0;

	CFPreferencesSetValue(CFSTR(SAVERPASSWORDPREFKEY), CFNumberCreate(NULL, kCFNumberIntType, &val),
			CFSTR(SAVERDEFAULTSDOMAIN), kCFPreferencesCurrentUser, kCFPreferencesCurrentHost);
	CFPreferencesAppSynchronize(CFSTR(SAVERDEFAULTSDOMAIN));

} // SetScreenSaverPasswordPref

BOOL ScreenSaverIsAppleSupplied(void) {
	CFPropertyListRef	thePath = nil;
	
	thePath = CFPreferencesCopyAppValue(CFSTR(SAVERPATHPREFKEY), CFSTR(SAVERDEFAULTSDOMAIN));
	
	if (!thePath) {
		return NO;
	}
	else if ([(NSString *)thePath hasPrefix:@"/System/Library"]) {
		return YES;
	}
		
	return NO;
	
} // ScreenSaverIsAppleSupplied