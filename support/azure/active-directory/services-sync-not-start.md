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

You discover that one or more Azure AD Connect services don't start. For example, the Microsoft Azure AD Sync service (ADSync) doesn't start.

## Solution 1: Set the directory synchronization account to log on as a service in Group Policy

1. Select **Start**, enter _gpedit.msc_ in the search box, and then press Enter to open the Local Group Policy Editor snap-in.

2. Expand **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local policies**, and then select **User rights assignment**.

3. Verify that the Azure AD Connect service account is added to the following policy settings:

   - Log on as a service
   - Log on as batch job
   - Log on locally

4. A domain group policy will take precedence over a local policy. You can check that by generating a group policy report with "```gpresult /H gpresult.htm```" from a command prompt with administrator privileges.

5. Open the resulting group policy report and check if **User rights assignment** settings are applied through any domain group policy object. If yes, use **Domain Policy Management** console from a Domain Controller, to remove the following policy settings from the **Winning GPO** or update that domain group policy to include Azure AD Connect service account:

   - Log on as a service
   - Log on as batch job
   - Log on locally

6. If you made any changes to the local policy or domain group policy, restart the computer to apply the changes.

## Solution 2: Troubleshoot error messages in directory synchronization logging

You can also try to find and fix the problem by scanning the application and system events in the directory synchronization logs. For more information, see [Troubleshoot other error messages](installation-configuration-wizard-errors.md#troubleshoot-other-error-messages).

## Solution 3: Reinstall directory synchronization

If solutions 1 and 2 don't resolve the issue, remove and then reinstall directory synchronization.

For example, if you use the Azure Active Directory Sync tool, remove and then reinstall it. Or, if you use Azure AD Sync, remove and then reinstall it.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
