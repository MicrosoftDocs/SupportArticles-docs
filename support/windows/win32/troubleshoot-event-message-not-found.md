---
title: Troubleshoot the error - Event Message Not Found
description: This article helps to troubleshoot the Event Message Not Found error.
ms.date: 03/20/2020
ms.prod-support-area-path: Developer Tools
ms.reviewer: garypelu 
---
# Troubleshoot the error: Event Message Not Found

This article helps you troubleshoot the error in Event Viewer: Event Message Not Found.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 166902

## Symptoms

The following error message may appear for events in Event Viewer:

> The description for Event ID ( <####> ) in Source (\<application name>) could not be found. It contains the following insertion string(s): \<the text of the message logged by ReportEvent>.

Listed below are the possible causes and more information on how to resolve the problem. The cause may be one or more of the following ones:

## Incorrect source name parameter is passed to RegisterEventSource

Make sure the source name in the registry matches what's passed to `RegisterEventSource`. This function will succeed even if the source isn't found in the registry. The source name in the registry should be in a sub key of `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog`.

Typically an application source is listed under the application sub key.

## Path to .dll or .exe file in the registry is incorrect

In the registry value named `EventMessageFile` found at `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Application\sourcename`, verify that the path to the .dll or .exe file is correct and the name of the .dll or .exe file is correct. In this case, the Event Viewer application fails to load the source of the message resources. Also, if you use `%SystemRoot%` or some other macro, you must use the REG_EXPAND_SZ registry value type. Otherwise, the macro doesn't get expanded.

## Registered message source is the wrong .dll or .exe file

In the registry value named `EventMessageFile` found at `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Application\sourcename`, verify that the path to the .dll or .exe file is the one that contains the expected message resources. Be careful of listing an `EventMessageFile` without a path and having multiple files with the same name. Event Viewer follows the rules to find the message source by using the search algorithm documented in the comments for the LoadLibrary API.

## Message resources aren't bound in the EventMessageFile source

A version of the Logging sample failed to include the .rc file as part of the build in the makefile. As a result, the DLL is built, but no message resources are included in the build. Some developers have tried to include the .bin file, which is output from the message compiler, as the resource. It doesn't properly bind the resource to the DLL. You must use the .rc file that's output from the message compiler, because it marks the resource with an ID of 1 and type 11 (`RT_MESSAGETABLE`). It's required for Event Viewer to find the message resources.

If you're using Visual C++ to build the `EventMessageFile` DLL, you must add the .rc file that is output from the message compiler as a source file of the Visual C++ project. It will tell Visual C++ to compile the .rc file and then link the resources to the DLL.

## Make sure the correct ID is passed to the ReportEvent function

Many think that the literal ID number found in the `.mc` file is the correct ID. It isn't so, because the message compiler bitwise ORs the ID number into the `LOWORD` and bitwise ORs the severity and facility bits into the `HIWORD`. An application should always use the symbolic name in the header file that is output from the message compiler.

Verify the `MessageIdTypedef=` statement in the `.mc` file. Some example `.mc` files show how to define the `MessageIDTypedef` to `WORD` for Category IDs. However, it causes Event IDs to loose the `HIWORD`. To correct this issue, define `MessageIdTypedef=` only once, and set it to `DWORD`.

Also be sure that the MC `-c` command line is consistently used for the message resources and header file. The `-c` switch turns on a bit in the `HIWORD` of the message ID.

## Event Viewer isn't restarted since you added the EventMessageFile entry

Event Viewer caches the DLLs it loads for event sources. If you have changed the registry to give a proper directory or source name after the event viewer has been started, you need to restart Event Viewer.
