---
title: Windows OOBE fails when you start a new Windows-based computer for the first time
description: Describes issues in which Windows OOBE fails when you start a new Windows-based computer for the first time.
ms.date: 12/04/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Windows OOBE fails when you start a new Windows-based computer for the first time

_Original product version:_ &nbsp; Windows 10, version 1903, all editions, Windows 10, version 1809, all editions, Windows 10  
_Original KB number:_ &nbsp; 4020048

## Symptoms

When you start a new Windows-based computer for the first time, the Windows Out-Of-Box Experience (OOBE) process guides you through various setup operations. In rare cases, you may encounter one of the following issues during OOBE.  
 **Issue 1**  

Windows OOBE displays the following error message: Something went wrong - But you can try again.

**Issue 2**  

Windows OOBE does not transition to the next page, and you receive a "Just a moment..." prompt for an extended time. 

## Cause

This issue occurs because the specific timing of the OOBE process causes a deadlock situation. This issue does not involve hardware, and you can easily fix it. 

## Workaround

For Issue 1 ("Something went wrong - But you can try again"), click **Try again**  at the bottom of the screen. The OOBE process should continue as expected. For Issue 2 ("Just a moment..."), press and hold the power button until the system turns off, and then turn on the system again. The OOBE process should resume and complete as expected. 

## More information

Microsoft is continually improving the resiliency of the Windows Out-Of-Box-Experience through ongoing updates. The chances of these issues occurring should decrease over time as Microsoft identifies and resolves specific timing issues.
