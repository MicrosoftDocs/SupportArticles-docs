---
title: How to use Group Policy Objects to set advanced settings
description: This article provides the steps to set advanced settings by using Group Policy objects (GPOs) in Microsoft Internet Explorer.
ms.date: 02/28/2020
ms.reviewer: cgilbert
---
# How to set advanced settings in Internet Explorer by using Group Policy objects

[!INCLUDE [](../../../includes/browsers-important.md)]

This article describes how to implement advanced settings by using Group Policy objects (GPOs) in Microsoft Internet Explorer on a computer that is running Microsoft Windows Server. This article does assume that you have successfully implemented Group Policies in your environment. When you configure Internet Explorer on client computers by using Group Policies, you can customize the Advanced settings and some of the Temporary Internet Files settings that are not available by default.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 274846

## Use Group Policy objects to set advanced settings

You must have the Group Policy set to Preference mode to customize Internet Explorer. To do this:

1. Open the Group Policy Editor by using Microsoft Management Console (MMC).
2. Locate and click **Internet Explorer Maintenance** under **Windows Settings** in **User Configuration**.
3. Right-click **Internet Explorer Maintenance**, and then click **Preference Mode**.

If a policy is already defined, you must click **Reset Browser Settings** before you can place this policy in Preference mode. When you reset the browser settings, any policy settings that are specified to that Group Policy are reset.

> [!NOTE]
> Preference mode settings are set by an administrator; however, you can change the settings after the policy is applied (for example, your home page or settings on the **Advanced** tab). After the policy is applied to a client computer, you can change your home page and advanced settings because Preference mode is only applied once per user.

If the administrator does not want users to change the settings, the administrator can apply a restriction by using the Administrative templates in the GPO.

An administrator must also combine GPOs, an organizational unit, a user, or a computer by implementing both a Preference mode and a MAINTENANCE MODE GPO.
