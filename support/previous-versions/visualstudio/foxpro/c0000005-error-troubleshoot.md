---
title: C0000005 error and troubleshoot
description: This article defines a C0000005 error and offers troubleshooting suggestions.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.prod: visual-studio-family
---
# C0000005 error and how to troubleshoot them

This article introduces a C0000005 error and offers troubleshooting suggestions.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 2722492

## Symptoms

You are running Visual FoxPro interactive development environment or a custom VFP executable. The application closes and reports this error:

C0000005 Fatal exception

## Cause

A C0000005 error is memory error. Specifically, a C0000005 error is an access violation error caused by a buffer overrun.

## Resolution

Many scenarios may cause Visual FoxPro to report a C0000005 error. The most efficient method of determining the root cause is to get a memory dump on the Visual FoxPro process when the error occurs and then examine the stack for the faulting module. For example, if a printer driver module is on the top of the stack, one should try updating the printer driver or trying a different driver. If a third party OCX appears as the faulting module, then you should check with the developer of that control for an update on compatibility with your version of Visual FoxPro.

Since Visual FoxPro is a 32-bit application, you must use a 32-bit debugger to obtain a memory dump.

To obtain the latest version of debug diag, see [Debug Diagnostics Tool v1.2 is now available](https://support.microsoft.com/help/2580960)

These are some generic instructions for obtaining a memory dump for a Visual FoxPro process.

Install it on the machine(s) experiencing the crashes. Double-click DebugDiag.msi and follow the setup wizard. Install DebugDiag to a hard drive with at least 200 megs free.

To configure DebugDiag:

1. Open DebugDiag. The 'Select Rule Type' dialog should open. Select CRASH and then click next.
2. On the 'Select Target Type' dialog, select 'A specific process' and then click 'Next'.
3. Type the name of your .EXE into the 'Selected Process' textbox or select it from the list. If typing it in, be careful to spell the .EXE name correctly. Do NOT check the 'This process instance only' box - we want the rule in effect for all instances, until we capture a dump. Click 'Next' when done.
4. On the 'Advanced Configuration' dialog, set the 'Maximum Userdump Limit' to 25, then click the 'Exceptions' button.
5. Click 'Add Exception'
6. Select C0000005 in the list, then set the 'Action Type' to 'Full Userdump' and the 'Action Limit' to 25
7. Click 'OK', then 'Save and Close' and finally click 'Next'
8. On the next screen, please leave the rule name and path to store the dumps as-is, then click 'Next'.
9. On the 'Rule Complete' screen, select 'Activate the rule now' and click **FINISH**.
Now when a crash occurs in the application DebugDiag should automatically create dump files. The Userdump Count will also be incremented inside the DebugDiag IDE each time a dump for this rule is created. NOTE: It is not necessary to keep the DebugDiag window open; the dump monitor actually runs as a service and will capture the dump even if DebugDiag is closed.

Once the crash collection is complete, you can disable the rule we made earlier by doing this:

1. Open DebugDiag.
2. In the RULES tab, highlight our rule and then right-click and select 'DISABLE RULE'
