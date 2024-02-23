---
title: Test-OwaConnectivity and Test-ECPConnectivity cmdlets fail
description: Describes an issue in which the Test-OwaConnectivity and Test-ECPConnectivity cmdlets fail randomly.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jcoiffin, v-six
appliesto: 
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# Test cmdlets fail with error: The task couldn't sign in with user extest_\<id>

_Original KB number:_ &nbsp;2914460

## Symptoms

### Symptom 1

The `Test-OwaConnectivity` and `Test-ECPConnectivity` cmdlets fail randomly in Microsoft Exchange Server 2010, and you receive the following error message:

> The task couldn't sign in with user \<domainename>\extest_\<id>. Run Scripts\new-TestCasConnectivityUser.ps1 to verify that the user exists on the Mailbox server \<servername>

> [!NOTE]
> The Microsoft Exchange management pack runs these test cmdlets regularly. Therefore, you will also experience this issue when you monitor your Exchange servers through System Center Operations Manager (SCOM).

### Symptom 2

After many incorrect passwords are entered, the extest account becomes locked, and all test cmdlets fail.

## Cause

This issue occurs because the date format that's set in the regional settings isn't the same for all Exchange Server 2010-based servers that use the extest account.

## Resolution

To resolve this issue, make sure that all Exchange servers on an Active Directory site that are using the extest account use the same regional settings.

You can check the format for the current user, welcome screen, and new user account. To do this, click **Region** in Control Panel, click the **Administrative**  tab, and then click **Copy settings**.

You should set the same format for the welcome screen and the new user account for all Exchange servers that are using the extest account on the Active Directory site.

To change this information for a server, configure the date format. To do this, follow these steps:

1. In Control Panel, click **Region**, and then click **Format** for the user.
1. In Control Panel, click **Region**, click the **Administrative** tab, and then click **Copy settings**.
1. Use the two check boxes to copy the current user settings to the system settings for the welcome screen and the new user account.
