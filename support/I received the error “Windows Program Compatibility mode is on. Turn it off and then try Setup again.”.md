---
title: I received the error “Windows Program Compatibility mode is on. Turn it off and then try Setup again.”
description: Provides a resolution to the error.
ms.date: 04/07/2022
author: jasonchlus
ms.author: jasonchlus
ms.reviewer: terry.g.lee
---

# I received the error “Windows Program Compatibility mode is on. Turn it off and then try Setup again.”

_Applies to:_&nbsp;Visual Studio 2015

## Symptom
While attempting to install Visual Studio the error  “Windows Program Compatibility mode is on. Turn it off and then try Setup again.” appears.

## Resolution
1. Navigate to your Downloads folder or the location where you saved the installer.
1. Right click on the Visual Studio Installer icon
1. Select Properties
1. Go to the Compatibility tab
1. Look for the Compatibility Mode section. Uncheck “Run this program in compatibility mode for:”
1. Restart the installation.

If the option to change the Compatibility Mode is greyed out

1. Select Change settings for all users
1. Look for the Compatibility Mode section. Uncheck “Run this program in compatibility mode for:”
