---
title: Management Reporter 2012 TDBX Update Diagnostic
description: Describes the steps that the tdbx diagnostic for Management Reporter will perform.
ms.reviewer: kellybj, kevogt
ms.date: 03/31/2021
---
# [SDP 3.0][783d5dcd-1017-4b80-9429-fbb89a92174e] Management Reporter 2012 TDBX Update Diagnostic

This article introduces the steps that the TDBX Update Diagnostic for Management Reporter will take.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP, Microsoft Dynamics AX 2009, Microsoft Dynamics SL 2011  
_Original KB number:_ &nbsp; 2720120

## Summary

This diagnostic will enable you to change the dimension names in a `.tdbx` file. There are a few scenarios where you may have to change this:

- You have multiple companies with different charts of accounts or differently named chart of accounts.
- You are importing a `.tdbx` of reports.
- You are upgrading from Microsoft Dynamics AX 2009 to Microsoft Dynamics AX 2012.
- You are upgrading from the Microsoft Dynamics SL Legacy Provider to the Microsoft Dynamics SL DDM Provider.

## More information

This diagnostic goes through the following steps:

1. After the initial information screens, you are asked to browse to the `.tdbx` file you want to change.
2. You are shown a list of dimension names found in the `.tdbx` file. Select the dimension names that you want to change.
3. You will be shown a screen, for each dimension name that you have selected, where you can enter in the new dimension name.

    - If the update is successful, you will be shown the file name and path of the updated `.tdbx` file as well as a list of the dimension name changes. When you select **Next**, the folder where this file is located will open.
    - If the update failed, you will be shown the name of the step that failed. Contact Support for more help.
