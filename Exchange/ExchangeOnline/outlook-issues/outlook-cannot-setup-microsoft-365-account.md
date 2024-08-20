---
title: Outlook can't set up a Microsoft 365 account
description: Resolves an issue in which Outlook can't set up a Microsoft 365 account or create a new Outlook profile.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Client Connectivity
  - Exchange Online
  - CSSTroubleshoot
  - CI 171593
  - CI 173647
ms.reviewer: mohammed.hussian, vijayde, aruiz, meerak, v-trisshores
appliesto: 
  - Exchange Online
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/24/2024
---

# Outlook can't set up a Microsoft 365 account

## Symptoms

Consider the following scenario:

- You migrate a user's mailbox from on-premises Microsoft Exchange Server to Exchange Online.

- You disable all local Autodiscover options in the **Disable AutoDiscover** Group Policy policy settings.

- You disable the **Allow the use of connected experiences in Office** policy setting.

In this scenario, when users try to set up a Microsoft 365 email account on a Microsoft Outlook client, or create a new Outlook profile, they receive one of the following error messages:

> Something went wrong and Outlook couldn't set up your account. Please try again. If the problem continues, contact your email administrator.

> We're sorry, we couldn't set up your account automatically.

If the users view their Outlook account information in **File** \> **Office Account** \> **Connected Services**, they might receive the following error message:

> Office is currently offline.

## Cause

Autodiscover must use either local or cloud options to set up the user accounts on an Outlook client or create user profiles.

The following table lists the local and cloud Autodiscover options.

| Local Autodiscover options | Cloud Autodiscover options |
|-|-|
| Last known good URL | Office 365 Autodiscover URL |
| SCP object lookup | Autodiscover V2 service |
| Root domain query | |
| Autodiscover domain query | |
| HTTP redirect method | |
| SRV record query in DNS | |

In your scenario, after you disable the local Autodiscover options in the **Disable AutoDiscover** Group Policy policy settings, you expect that the cloud Autodiscover options will be available. However, because you also disable the **Allow the use of connected experiences in Office** policy setting, access is blocked to the web-based cloud Autodiscover options. This combination of settings effectively disables all Autodiscover options and prevents Outlook from retrieving the email account settings. It also generates the error messages that are described in the [Symptoms](#symptoms) section.

## Resolution

To resolve this issue, use either of the following methods. If you want to keep connected experiences in Office set as disabled, use the second method.

### Method 1

In the Group Policy Management Editor, enable the following policy to enable the cloud Autodiscover option:

**Administrative Templates** \> **Microsoft Office 2016** \> **Privacy** \> **Trust Center** \> **Allow the use of connected experiences in Office**

### Method 2

In the Group Policy Management Editor, make sure that the following policy doesn't disable local Autodiscover:

**Administrative Templates** \> **Microsoft Outlook 2016** \> **Account Settings** \> **Exchange** \> **Disable AutoDiscover**
