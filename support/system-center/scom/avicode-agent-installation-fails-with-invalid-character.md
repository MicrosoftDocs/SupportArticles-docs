---
title: The Path My Documents contains an invalid character
description: Fixes an issue in which you can't install the AVIcode agent because of an invalid character in the user profile.
ms.date: 08/13/2020
ms.reviewer: jfanjoy
---
# AVIcode agent installation fails with error: 1324 Error The Path contains an invalid character

This article helps you fix an issue in which you can't install the AVIcode agent because of an invalid character in the user profile.

_Original product version:_ &nbsp; AVIcode, Inc.  
_Original KB number:_ &nbsp; 2625330

## Symptoms

The installation (setup) of the AVIcode agent on a computer fails with the following error:

> "1324 Error." The Path "My Documents" contains an invalid character.

## Cause

It's caused by an invalid character in the user profile. For example, this error could occur if the Windows Registry entry for **My Documents** is pointing to an invalid location (for example drive D and there's no drive D).

## Resolution

To resolve this issue, verify the **My Document** location for the user profile isn't redirected to a location that's not available. Group Policy can cause **My Document** redirections if configured by network administrator. If the **My Document** folder is pointing to a location that isn't accessible, reconfigure the system so that the **My Document** location information in the registry points to a local folder, then sign out from system, sign back in, and begin the install process again. Once the location is valid, it should continue as expected.
