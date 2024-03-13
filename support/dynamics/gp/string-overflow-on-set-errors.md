---
title: String overflow on set errors
description: Provides options to solve the string overflow on set errors that may occur in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "String overflow on set" error messages occur in Microsoft Dynamics GP

This article provides a resolution to solve the string overflow on set errors in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2451176

## Symptom 1

You receive the following error message in Microsoft Dynamics GP on Terminal Server machine when using Bank Reconciliation:

> Unhandled script exception:  
String overflow on set '[Not Found]'.  
EXCEPTION_CLASS_SCRIPT_STRING_OVERFLOW

## Symptom 2

A computer check batch in Payables Management keeps going to Batch Recovery and you get this message:

> String overflow on set 'Voucher Number - WORK'.

## Cause

String overflow messages are caused when a string value is being set into a field or variable that is shorter than the string value. They are not normally displayed on a live system and would only be showing up if the Debug menu was enabled and Show Debug Messages was enabled.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

Option 1: In the top menubar in Microsoft Dynamics GP, select **DEBUG** and then clear **Show Debug Messages**. Then test again and the issue should be resolved. However it is recommended that the Debug menu is not enabled in a live system as there can be other side effects. We recommend doing Option 2 as well.

Option 2: To resolve this problem, navigate to the code folder for Microsoft Dynamics GP. The default location is usually: *C:\Program Files\Microsoft Dynamics GP\GP\Data*. Right-click the Dexx.ini file and open it with Notepad. Review the file for the below lines and set them to **FALSE** or as shown below:

```console
ShowDebugMessage=FALSE
ScriptDebugger=FALSE
ScriptDebuggerProduct=0
```

This will disable the Dexterity Script debugger and the Debug menu and resolve the issue.

## More information

If you were using the Debug menu for the capturing of Dexterity Script Logs and Dexterity Script Profiles, this can be achieved easily with the Support Debugging Tool without needing the Debug menu enabled.
