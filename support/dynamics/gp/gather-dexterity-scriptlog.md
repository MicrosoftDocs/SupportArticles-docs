---
title: Gather a Dexterity Scriptlog in Microsoft Dynamics GP
description: Describes how to gather a Dexterity Script Debugger log in Microsoft Dynamics GP.
ms.topic: how-to
ms.reviewer: theley, cwaswick
ms.date: 03/13/2024
---
# How to gather a Dexterity Scriptlog in Microsoft Dynamics GP

This article contains steps on how to gather a Dexterity Script Debugger log in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3077859

## Summary

Dexterity Scriptlogs are often helpful to give insight into what dexterity code is being called, and helpful to verify if any third-party products are being called during the process that's captured in the log. The default dictionary ID for Microsoft Dynamics GP is (0), so you can review if any other dictionary ID's are listed.

## Steps to gather the scriptlog

1. Exit out of Microsoft Dynamics GP.

2. Navigate to the GP code folder (default location is C:\\Program Files (x86)\\Microsoft Dynamics\\GP\\Data) and right-click on the Dex.ini file and open it with Notepad.

3. Review if the `ScriptDebugger=TRUE` trigger exists, and then set it to TRUE, or if it doesn't exist, add the below trigger to the end of the file.

4. Close the file and save your changes.

5. Relaunch Microsoft Dynamics GP.

6. Now you will see a **DEBUG** item listed in the top menubar of all windows. Open the window you need to recreate the issue in. (Or get to the point you need to be at, right before the issue happens and you want to start the scriptlog at this point.)

7. Click on **DEBUG** in the top menubar and click on **LOG SCRIPTS** to start the script log. Enter a filename and path of where you want to save the scriptlog to and click **Save**. (This puts a checkmark next to **LOG SCRIPTS** under the **DEBUG** menu and *the scriptlog is now running*.)

8. Perform the action you want captured in the log. Cancel out of any posting reports (if prompted) and then STOP!

9. Now click on **DEBUG** again and click on **LOG SCRIPTS** again to stop the log. (This removes the checkmark next to **LOG SCRIPTS** under the **DEBUG** menu item).

    > [!NOTE]
    > You can stop and start the script log by clicking on **DEBUG** > **LOG SCRIPTS** to have the checkmark next to **LOG SCRIPTS** or not. The checkmark means it is running, and no checkmark means it is not. Clicking on **LOG SCRIPTS** will add/remove the checkmark to start/stop the scriptlog from running. Each time you start it, it should prompt you for a new filename and path to save the new log to.

10. Locate the Script.log file in the path you generated it to, and open it with Notepad to ensure it captured the process.
    1. Send this script.log file (or whatever you named it) to the Support Engineer for further analysis.

    2. Also send the Dynamics.set file (from the GP code folder) to the Engineer, so they can cross-reference any dictionary ID's to the products you've installed.
