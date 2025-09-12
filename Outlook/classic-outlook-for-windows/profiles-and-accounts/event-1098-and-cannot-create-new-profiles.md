---
title: Event 1098 and can't create new profiles
description: You can't create an Outlook profile with an error message saying you can't start Outlook or something went wrong.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Exchange Mailbox Accounts\Problems after moving a mailbox
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: dalkim
appliesto: 
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
ms.date: 01/30/2024
---
# Unable to create an Outlook profile after a migration with Event 1098 in Microsoft Entra ID log

_Original KB number:_ &nbsp; 4499299

## Symptoms

When you try to create a Microsoft Outlook profile after a domain migration, you receive an error message that indicates you can't start Outlook or something went wrong. You also receive a sign-in prompt.

:::image type="content" source="media/event-1098-and-cannot-create-new-profiles/error.png" alt-text="Screenshot of the Outlook error messages." border="false":::

Additionally, you may see the Event 1098 in Microsoft Entra Operational log that resembles the following error:

> Error: 2147943712
>
> ErrorMessage: A specified logon session does not exist. It may already have been terminated. A specified logon session does not exist. It may already have been terminated.
>
> AdditionalInformation: Exception of type 'class WinRTException' at webaccountprocessor.cpp, line: 190, method:  
> Microsoft Entra ID::Core::WebAccountProcessor::ProcessBrokerRequest::<lambda_>::operator (). Log: 0xcaa5001c Token broker operation failed. Operation name: RequestToken Logged at webaccountprocessor.cpp, line: 520, method: Microsoft Entra ID::Core::WebAccountProcessor::ReportException.

To find the Microsoft Entra Operational log in Event Viewer, locate **Applications and Services Logs** > **Microsoft** > **Windows** > **Microsoft Entra ID** > **Operational**.

:::image type="content" source="media/event-1098-and-cannot-create-new-profiles/aad-operational-log.png" alt-text="Screenshot shows Microsoft Entra location in Event Viewer.":::

## Cause

There are multiple scenarios that can result in a change to a user security identifier (SID), for example, migrating the user to a new domain. However, the user profile isn't changed, and data files that have the old SID are now cached in an old profile. In this case, you may have an Office connection problem or authentication loops that results in this error.

## Resolution

To resolve this issue, follow these steps:

1. Delete all files from the Accounts folder at the following: location:

   %LOCALAPPDATA%\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\AC\TokenBroker\Accounts

   > [!NOTE]
   > Copy and paste the above location in the Windows Search box to find the folder.

2. Restart and re-create an Outlook profile.  
