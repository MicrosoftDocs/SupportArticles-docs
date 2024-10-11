---
title: Mac client enrollment fails
description: This article provides a workaround to solve the issue that Configuration Manager CMEnroll tool fails on a Mac client computer.
ms.date: 12/05/2023
ms.reviewer: kaushika, erinwi
---
# Mac client enrollment fails if passwords contain special characters

This article provides a workaround to solve the issue that Mac client enrollment fails in Microsoft System Center 2012 Configuration Manager if the password has special characters.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2839072

## Symptoms

The Configuration Manager CMEnroll tool fails on a Mac client computer with the following error:

> Error received:Server Connection failed. HTTP Response code is 400 and reason is Bad request.

## Cause

This issue can occur if the user has the special characters **&** and **<** in their domain password. CMEnroll.exe doesn't encode the **&** and **<** special characters correctly for Mac-based clients.

## Resolution

To work around this issue, have the user change the password so that it doesn't contain these special characters.

## More information

For more information on Mac clients and Configuration Manager, see [How to Install Clients on Mac Computers in Configuration Manager](/previous-versions/system-center/system-center-2012-R2/jj591553(v=technet.10)).
