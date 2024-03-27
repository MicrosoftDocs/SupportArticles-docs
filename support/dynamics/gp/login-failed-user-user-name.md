---
title: Login failed for user User Name 
description: Provides a solution to an error that occurs when you run the UserInfoGet.CreateADOConnection VBA function in Microsoft Dynamics GP 10.0.
ms.reviewer: theley, grwill, KVogel
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# "Login failed for user '[User Name]'" Error message when you run the UserInfoGet.CreateADOConnection VBA function in Microsoft Dynamics GP 10.0

This article provides a solution to an error that occurs when you run the UserInfoGet.CreateADOConnection VBA function in Microsoft Dynamics GP 10.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 941457

## Symptoms

When you run the UserInfoGet.CreateADOConnection Visual Basic for Applications (VBA) function in Microsoft Dynamics GP 10.0, you receive the following error message:
> Login failed for user '\<User Name>'.

> [!NOTE]
> In this error message, **User Name** represents the actual user name.

## Cause

This problem occurs if the user name differs from the user identifier (user ID).

For example, the user name is **John Doe**, but the user ID is **JDoe**. In this case, the UserInfoGet.CreateADOConnection function tries to authenticate with an instance of Microsoft SQL Server by using the user name of **John Doe**. However, the user ID that is created in Microsoft SQL Server is **JDoe**.

## Resolution

To resolve this problem, obtain the latest service pack for Microsoft Dynamics GP 10.0.

## Workaround

To work around this problem, update the user name to be the same as the user ID. To do it, update the value in the **User Name** field in the User Setup window to match the value that is in the **User ID** field.

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section. This problem was first corrected in Microsoft Dynamics GP 10.0 Service Pack 1.
