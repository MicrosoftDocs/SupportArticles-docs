---
title: Power Automate SessionHasLoggedOff troubleshooting
description: Provides a set of troubleshooting steps for receiving the error SessionHasLoggedOff
ms.subservice: power-automate-desktop-flows
ms.date: 10/07/2024
ms.author: johndund 
author: johndund
---
# Desktop flow cloud flow run ends in error code SessionHasLoggedOff

This article provides troubleshooting steps for when you receive SessionHasLoggedOff during the middle of a desktop flow cloud run.

## Symptoms

In the middle of your desktop flow run, you receive the error message SessionHasLoggedOff with the message "The session logged off during run execution".

## Troubleshooting

The SessionHasLoggedOff error code means that the Windows session that was running your desktop flow was logged off by the system. This can come from either a manual user action or another piece of software running on your machine.

Steps to investigate:

1. Verify that there is no custom sript (such as a batch file or any powershell script execution) in your desktop flow which may cause the session to be logged off or for the machine to reboot.

1. Verify that no group policy setting may be logging off the remote desktop session due to time limits. You can verify settings opening the Local Group Policy Editor and navigating to Computer Configuration > Administrative Templates > Windows Components > Remote Desktop Services > Session Time Limits.

1. Note the time of when the desktop flow run completed.

1. Go to the machine that ran the flow and open the Windows Event Viewer. Look in the local session manager logs by going to Application and Service Logs > Microosft > Windows > TerminalServices-LocalSessionManager. Attempt to find the log corresponding to the time when the logoff occurred by using the time when the run completed and looking at logs at that time up to many minutes before. 

1. Look for indications of what may have caused the disconnection of the session, including whether it may have come from a process running in session 0, or come from a user. If you see an event with Event ID 40 which describes that the session has been disconnected with a reason code, you can find mapping of the reason codes in [this documentation](https://learn.microsoft.com/en-us/windows/win32/termserv/extendeddisconnectreasoncode?redirectedfrom=MSDN).

1. If you see that the disconnect came from a third party piece of software, you can also look at the Event Viewer logs Windows > Application logs at the timestamp around when the disconnect occurred to see if the application may have logged anything.
