---
title: User cannot tab between fields
description: Provides a solution to an issue where user can't tab between fields in a Microsoft Dynamics GP window.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# User can't tab between fields in a Microsoft Dynamics GP window

This article provides a solution to an issue where user can't tab between fields in a Microsoft Dynamics GP window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2011820

## Symptoms

The symptom of this bug is that as soon as the issue occurs, the user is no longer able to tab between fields in any Microsoft Dynamics GP window.

The nature of the bug is a combination of a .NET Framework application window (typically a Dynamics GP Add-in) displayed as a modal window and having VBA active in Dynamics. After the Add-in window is closed, the issue prevents the user from being able to tab between fields in any Microsoft Dynamics GP window until they exit Microsoft Dynamics GP.

The reason for the Microsoft.Dexterity.Support.FilterEvents.dll is to resolve MBS Great Plains bug 46619 in all versions of Microsoft Dynamics GP 10.0.

## Cause

The problem area is within the event processing loop that controls all aspects of Dynamics including the code and in the user interface. When an Add-in window is opened as a modal window and then closed, the Dynamics.exe runtime processes don't correctly handle the tab keystrokes. Th e keystrokes that move the focus instead move to the first field on the window and not from field to field in the typical tab sequence.  

## Resolution

To lessen risk to the Dynamics GP community, the solution is implemented as an Add-in assembly. This assembly is basically the same code that would typically go into the Dynamics.exe runtime engine, it's packaged as an external application.

To resolve this issue, download the [MBSGreatPlains_46619.zip](https://mbs2.microsoft.com/fileexchange/?fileID=43f4e20a-72d3-4198-a3be-6d51dab4e7c6) file and follow the installation instructions contained in the compressed (.zip) file.

## More information

This solution won't be required in the next version of Microsoft Dynamics GP. The fix included with this solution will be included in that release.  This Microsoft.Dexterity.Support.FilterEvents.dll is only required for Microsoft Dynamics GP 10.0.
