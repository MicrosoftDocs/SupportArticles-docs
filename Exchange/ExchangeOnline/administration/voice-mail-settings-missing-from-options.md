---
title: Voice mail settings missing from Options
description: Describes an issue that makes voice mail settings go missing from the Options pane in Outlook on the web. Occurs for a user who's assigned an Office 365 plan that includes Unified Messaging (UM). Provides a resolution.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: alinastr
appliesto:
- Exchange Online
search.appverid: MET150
---
# Voice mail settings are missing from the Options pane in Outlook on the web in Office 365

_Original KB number:_ &nbsp; 3216404

> [!NOTE]
> Cloud Voicemail takes the place of Exchange Unified Messaging (UM) in providing voice messaging functionality for Skype for Business 2019 voice users who have mailboxes on Exchange Server 2019 or Exchange Online, and for Skype for Business Online voice users. For more information please check [Plan Cloud Voicemail service](/skypeforbusiness/hybrid/plan-cloud-voicemail) and [Retiring Unified Messaging in Exchange Online](https://techcommunity.microsoft.com/t5/Exchange-Team-Blog/Retiring-Unified-Messaging-in-Exchange-Online/ba-p/608991).

## Symptoms

Assume that you assigned an Office 365 plan that includes Unified Messaging (UM) to a user. However, when the user opens the **Options** pane in Outlook on the web, the **Voice mail** settings are missing.

## Cause

This issue may occur if UM isn't enabled in the mailbox policy that's assigned to the mailbox or the **MyTextMessaging** and **MyVoiceMail** settings aren't enabled for the user role that's assigned to the mailbox.

## Resolution

To resolve this issue, follow these steps:

1. Make sure that UM is enabled in the mailbox policy that's assigned to the mailbox. To do this, follow these steps:

   1. Connect to Exchange Online by using the remote PowerShell. For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
   2. Run the following command to identify the mailbox policy that's assigned to the mailbox:

        ```powershell
        Get-CASmailbox <mailboxUPN> | FL *OWAMailboxPolicy
        ```

   3. Open the Exchange admin center, select **permissions**, and then select **Outlook Web App policies**.
   4. Select the mailbox policy that you determined in step 1B, and then select **Edit**.
   5. Select **features**, select the **Unified Messaging** check box, and then select **Save**.

2. Make sure that the **MyTextMessaging** and **MyVoiceMail** settings are enabled for the user role that's assigned to the mailbox. To do this, follow these steps:

   1. Connect to Exchange Online by using the remote PowerShell. For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
   2. Run the following command to identify the role assignment policy that's assigned to the mailbox:

        ```powershell
        Get-mailbox <mailboxUPN> | FL *RoleAssignmentPolicy
        ```

   3. Open the Exchange admin center, select **permissions**, and then select **user roles**.
   4. Select the role assignment policy that you determined in step 2B, and then select **Edit**.
   5. Select the **MyTextMessaging** and **MyVoiceMail** check boxes, and then select **Save**.

## More information

If you're using the Skype for Business voice mail service with cloud PSTN, the voice mail options are not available. For more information, see [Set up your voice mail](https://support.microsoft.com/office/set-up-your-voice-mail-b0d849d3-dd36-46b2-b845-ab1f1a72c647).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
