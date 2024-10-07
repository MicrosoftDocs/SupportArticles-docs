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

In the middle of your desktop flow run, you receive the error message SessionHasLoggedOff

## Troubleshooting

The SessionHasLoggedOff error code means that the Windows session that was running your dekstop flow was logged off by the system. This can come from either a manual user action or another piece of software running on your machine.

Steps to investigate:

1. Note the time of when the desktop flow run completed

1. Go to the machine that ran the flow and open the Windows Event Viewer. Look in the local session manager logs by going to Application and Serices Logs > Microosft > Windows > TerminalServices-LocalSessionManager. Attempt to find the log corresponding to the time when the logoff occurred by using the time when the run completed and looking at logs at that time up to many minutes before. 

1. Look for indications of what may have caused the disconnection of the session, including whether it may have come from a process running in session 0, or come from a user.

1. If you see that the disconnect came from a third party piece of software, you can also look at the Event Viewer logs Windows > Application logs at the timestamp around when the disconnect occurred to see if the application may have logged anything.
