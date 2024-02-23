---
title: Cannot disable Facebook contact sync for organization
description: Describes an issue in which your Facebook contact sync still appears to be enabled after you try to disable it through the Exchange admin center. Or, you receive an error message when you try to disable sync by using the Set-OwaMailboxPolicy cmdlet.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# You can't disable Facebook contact sync for your Microsoft 365 organization

_Original KB number:_ &nbsp; 2898124

## Symptoms

When you try to disable Facebook contact sync in your Microsoft 365 organization through a mailbox policy, you experience one or both of the following symptoms:

- After you try to disable it through the Exchange admin center, the feature still seems to be enabled.
- If you run the `Set-OwaMailboxPolicy` cmdlet together with the `DisableFacebook` switch, you receive the following error message:

> Error Message: A positional parameter cannot be found that accepts argument 'DisableFacebook'.  
\+ CategoryInfo : InvalidArgument: (:) [Set-OwaMailboxPolicy], ParameterBindingException  
\+ FullyQualifiedErrorId : PositionalParameterNotFound,Set-OwaMailboxPolicy  
\+ PSComputerName : pod\<x>`psh.outlook.com`

## Cause

This issue occurs if Facebook integration isn't available for your organization. Validation rules block access to features that don't apply to certain organizations. Even though you can't disable the feature, you don't have to be concerned about the feature being used by people in your organization. If the Facebook contact sync feature isn't available for your organization, this means that the feature is blocked at a deeper level.

## Resolution

Make sure that users don't have the option to connect to Facebook. If users don't have the option to add their Facebook friends as contacts, you can safely ignore the error message.

## More information

For more info about Facebook contact sync, see [Manage Facebook contact sync in your organization](/exchange/recipients-in-exchange-online/manage-facebook-contact-sync).

The features that are available to your Microsoft 365 organization are determined by the service plan for your account. Some features aren't available to mailboxes or organizations in specific regions.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-information-disclaimer.md)]
