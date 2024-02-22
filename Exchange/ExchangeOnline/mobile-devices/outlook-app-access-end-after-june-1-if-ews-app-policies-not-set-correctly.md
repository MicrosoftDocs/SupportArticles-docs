---
title: Outlook app access end after June 1
description: Discusses that your Exchange Web Services access may end after June 1, 2017, if application policies are not set up correctly.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: jmartin, v-six
appliesto: 
  - Outlook for iOS
  - Outlook for Android
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Outlook app access may end after June 1 if EWS application policies are not set up correctly

> [!IMPORTANT]
> This article applies to Microsoft 365 customers who have explicitly set up Exchange Web Services (EWS) application policies.

_Original KB number:_ &nbsp; 4018623

## Summary

We are making a change to Microsoft Outlook for iOS and Android. If you use Exchange Web Services (EWS) application policies, you must take action to retain Outlook mobile app email access after June 1, 2017.

This article describes how to set up EWS application policies correctly.

## More information

All Microsoft 365 connections for Outlook for iOS and Android are being moved from the legacy, AWS architecture to the new Microsoft 365 architecture. AWS architecture uses Exchange ActiveSync (EAS) to sync mailbox data. Microsoft 365 uses REST to sync data

This move means that all mailbox data is now fully delivered through Microsoft services that provide a strong commitment to security, privacy, and compliance. REST also provides advanced features and capabilities to the Outlook app. The older, AWS-based architecture is scheduled to be replaced on June 1, 2017.

In order for Outlook for iOS and Android to be able to use REST to connect to the Microsoft 365-based architecture after June 1, you must make sure that your EWS application policies (that control which applications can use REST) are configured correctly. If EWS applications policies are configured to restrict the list of applications that can access messaging data, users may lose email access when the AWS-based architecture is disabled.

If access is enabled correctly by June 1, users who are currently connected to EAS-based Outlook for iOS and Android will be migrated smoothly to REST. In some cases, users may see their Inbox be updated, and have to reauthenticate their identity. Migrated users will have access to several new features that are enabled by REST.

The EAS protocol is not affected by these changes. EAS is still used by Outlook for Windows 10 Mobile and third-party mobile email apps to sync mailbox information by using Microsoft 365.

### How to set up EWS application policies

EWS application policies control whether applications can use the REST API. By default, an EWS application policy is not configured in an Exchange Online tenant. If you configure an EWS application policy that allows only specific applications access to your messaging environment, you must add the user-agent string for Outlook for iOS and Android to the EWS **allow** list.

There are three options to set up EWS application policies to correctly enable Outlook for iOS and Android access to Microsoft 365 mailboxes.

Option 1

If you have configured the EWS application policy to allow a list of client applications, add Outlook's user-agent strings to the EWS allow list, as in the following example:

```powershell
Set-OrganizationConfig -EwsAllowList @{Add="Outlook-iOS/*","Outlook-Android/*"}
```

Option 2

If you have configured the EWS application policy to allow all client applications except those that are specifically blocked, remove Outlook's user-agent strings from the EWS block list, as in the following example:

```powershell
Set-OrganizationConfig -EWSBlockList @{Remove="Outlook-iOS/*", "Outlook-Android/*"}
```

Option 3

If you are not using an EWS application policy, but you are controlling access to EWS, make sure that EWS is not disabled for your organization or the individual users who you want to use Outlook. For example, use the following commands:

- Set-OrganizationConfig -EwsEnabled:$true
- Set-CASMailbox -EWSEnabled:$true

For more information, see [How to: Control access to EWS in Exchange](/exchange/client-developer/exchange-web-services/how-to-control-access-to-ews-in-exchange).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
