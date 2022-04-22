---
title: Azure Active Directory Connect services don't start
description: Describes an issue that prevents Azure Active Directory Connect services from starting. Provides a resolution.
ms.date: 12/22/2021
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: "riantu,nualex,reviei"
ms.service: active-directory
ms.subservice: enterprise-users
---
# One or more Azure Active Directory Connect services don't start

This article describes an issue that prevents Microsoft Azure Active Directory (Azure AD) Connect services from starting.

_Original product version:_ &nbsp; Azure Active Directory, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2995030

## Symptoms

You discover that one or more Azure AD Connect services don't start. For example, the Microsoft Azure AD Sync service (formerly known as ADSync) or the Windows Azure Active Directory Synchronization Service (formerly known as DirSync) doesn't start.

## Solution 1: Set the directory synchronization account to log on as a service in Group Policy

1. Select **Start**, enter _gpedit.msc_ in the search box, and then press Enter to open the Local Group Policy Editor snap-in.

2. Expand **Computer Configuration** > **Window Settings** > **Security Settings** > **Local policies**, and then select **User rights assignment**.

3. Verify that the directory synchronization service account is added to the following policies:

   - Log on as a service
   - Log on as batch job
   - Log on locally

4. If you made changes to the local policy, restart the computer to apply the changes.

## Solution 2: Troubleshoot error messages in directory synchronization logging

You can also try to find and fix the problem by scanning the application and system events in the directory synchronization logs. For more information, see [Troubleshoot other error messages](installation-configuration-wizard-errors.md#troubleshoot-other-error-messages).

## Solution 3: Reinstall directory synchronization

If solutions 1 and 2 don't resolve the issue, remove and then reinstall directory synchronization.

For example, if you use the Azure Active Directory Sync tool, remove and then reinstall it. Or, if you use Azure AD Sync, remove and then reinstall it.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
