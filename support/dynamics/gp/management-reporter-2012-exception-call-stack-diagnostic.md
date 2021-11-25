---
title: Management Reporter 2012 Exception Call Stack Diagnostic
description: This diagnostic connects to a selected local process and outputs the call stack from the specified exception type.
ms.reviewer: kellybj
ms.date: 03/31/2021
---
# [SDP 3][527f0061-fb98-48b3-af4c-230914a1fbad] Management Reporter 2012 Exception Call Stack Diagnostic

This diagnostic connects to a selected local process and outputs the call stack from the specified exception type.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics AX 2012 R3, Microsoft Dynamics AX 2012 R3 CU8, Microsoft Dynamics SL 2011, Microsoft Dynamics SL 2011 Service Pack 1, Microsoft Dynamics SL 2011 Service Pack 2, Microsoft Dynamics SL 2011 Service Pack 3, Microsoft Dynamics SL 2015, Microsoft Management Reporter 2012  
_Original KB number:_ &nbsp; 3146041

You will be prompted to:

1. Select the process you wish to connect to.

2. Decide if you want to log exceptions first on process and choose one of these exceptions to log call stacks for

    Or

    Type in the exception type manually (ex: **System.InvalidCastException**)

If an exception call stack is logged that matches the selected exception type, then notepad.exe will open with that output.
