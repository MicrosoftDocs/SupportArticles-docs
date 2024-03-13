---
title: Privilege Error 
description: Provides a solution to an error that occurs when you select Yes to include new code in Microsoft Dynamics GP.
ms.reviewer: v-jomcc
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Privilege Error" Error message displays when you select Yes to include new code in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you select **Yes** to include new code in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 869266

## Symptom

You apply a service pack or a hotfix to the computer. When you start Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains, you're prompted to include new code. When you select **Yes**, you receive the following error message:
> Privilege Error

## Cause

This issue occurs if one or more of the following conditions are true:

- The Dynamics.cnk file is read-only.
- The Dynamics.dic file is read-only.

- Other users are using Microsoft Dynamics GP.

## Resolution

To resolve this issue, determine whether the Dynamics.cnk and Dynamics.dic files are read-only. To do it, follow these steps:

1. Open Windows Explorer.
2. Locate the Microsoft Dynamics GP folder. By default, this folder is in the following location:  
    `C:\Program Files\Microsoft Dynamics\GP`

3. Right-click the Dynamics.cnk file, and then select **Properties**.
4. Verify that the file isn't marked as **read-only**.
5. Repeat steps 3 and 4 for the Dynamics.dic file.

If this procedure doesn't resolve the issue, make sure that all users have exited Microsoft Dynamics GP.
