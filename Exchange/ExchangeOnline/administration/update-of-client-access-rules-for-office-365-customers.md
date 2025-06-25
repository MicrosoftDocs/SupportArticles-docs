---
title: Updates to Client Access Rules in Microsoft 365
description: Describes a procedural update to Client Access Rules in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: jmartin, meerak, v-six
appliesto: 
  - Exchange Online
  - Microsoft Exchange Online Dedicated
search.appverid: MET150
ms.date: 01/24/2024
---
# Updates to Client Access Rules in Microsoft 365

> [!IMPORTANT]
> This article applies to Office 365 Dedicated, Office 365 D/ITAR, and selected Office 365 Enterprise customers.

_Original KB number:_ &nbsp; 4013974

## Summary

Microsoft is making a change that affects how [Client Access Rules](https://download.microsoft.com/download/4/8/7/487093CB-2471-48CE-9B72-6695DDAED6ED/vNext/EXO-D%20Managing%20Client%20Access%20Rules%20%28Legacy%202013_vNext%29.pdf) (CARs) work in Microsoft 365. We will be adding support for managing the REST API through Client Access Rules. Previously, the predicate for ExchangeWebServices (EWS) applied to both the EWS protocol and REST API. The upcoming updates to Exchange CARs will let you independently manage these connection types.

This update will be especially important if you want to deploy Outlook for iOS and Android because those apps use REST APIs to sync mail, calendar, and contact information with Microsoft 365.

## Phases

This update will be made in the following phases:

- Phase 1: Updates to existing Client Access Rules to add REST predicate

  Timeline: Feb 10-March 31

  Over the next several weeks, you will start seeing the REST predicate added to their existing CARs that include EWS predicates. This change will be visible on your existing CARs in Windows PowerShell. There is no action for you to take, and the changes will not affect the behavior of your existing CARs.

  This change ensures the following behavior:

  - If a user is blocking EWS access today, both EWS and REST access will be blocked after the update.
  - If a user is allowing EWS access today, both EWS and REST access will be allowed after the update.

  After the updates to existing CARs are visible in PowerShell, you will be able to enable REST access while you continue to block EWS access. Although EWS predicates will still apply to both EWS and REST, you have the following options:

  - Option 1: Create a rule that has a higher precedence action that explicitly allows REST.

    ```powershell
    New-ClientAccessRule -Action AllowAccess -Name AllowREST -AnyOfProtocols REST -Priority [something_smaller_or_equal_than_your_other_rule]
    ```

  - Option 2: Update your existing EWS blocking rule to allow REST.

    ```powershell
    Set-ClientAccessRule blockEWS -AnyOfProtocols ExchangeWebServices -ExceptAnyOfProtocols REST
    ```

- Phase 2: Update CARs to make EWS and REST independently managed controls

  Timeline: Q2-Q3 calendar year 2017

  After Phase 1 is complete, we will begin rolling out a second change that will remove the EWS control's ability to manage REST through CARs. When this second rollout is complete, EWS and REST will be two separate controls. Therefore, they can be managed independently. Rules that have EWS predicates will no longer manage or apply to REST in any way.

  If you have set up a rule to allow REST by using one of the two options during Phase 1, you may want to update your rules accordingly.

## Effect of changes on Outlook for iOS and Android

Timeline: June 1, 2017. 60 days after delivery of Phase 1.

We are currently moving all Microsoft 365 connections for Outlook for iOS and Android from our legacy AWS-based architecture (which uses EAS) to our new Microsoft 365-based architecture. The new architecture uses REST. REST provides advanced features and capabilities to the Outlook app. Today, some Office 365 Dedicated, Office 365 D/ITAR, and select Office 365 Enterprise tenants still use EAS to connect to Outlook for iOS and Android.

On June 1, 2017, 60 days after REST is available and independently manageable, Microsoft will disable EAS for Outlook for iOS and Android. Customers have to make sure that REST access is allowed by this date so that they do not lose email access in those apps.

Users who are currently connected to Outlook for iOS and Android by using EAS will be migrated to REST. Because REST access is likely to be allowed, users will probably not be affected. You may be prompted occasionally to reauthenticate your Inbox when it is updated.

If REST access is not allowed when Microsoft disables EAS access for Outlook for iOS and Android, you will lose email access on your mobile device.

The EAS protocol is not affected by these changes. EAS is still used by Outlook for Windows 10 Mobile and third-party mobile email apps to sync mailbox information with Microsoft 365. EAS will continue to be available as a protocol to manage through CARs.

> [!IMPORTANT]
> You cannot use the `AnyOfClientIPAddressesOrRanges` parameter to manage Outlook for iOS and Android by using Client Access Rules. This is because of the Microsoft 365-based architecture that is used by Outlook for iOS and Android.

## Which Microsoft 365 users are affected by this update

Office 365 Dedicated, Office 365 D/ITAR, and selected Office 365 Enterprise customers.
