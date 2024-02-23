---
title: Publish Calendar option is missing from Calendar
description: Describes an issue in which Microsoft 365 users can't publish their calendar in Outlook on the web because the Publish Calendar option is missing from Calendar settings.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: alinastr, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Publish Calendar option is missing from Calendar settings in Outlook on the web in Microsoft 365

_Original KB number:_ &nbsp; 3187580

## Symptoms

Microsoft 365 users can't publish their calendar in Outlook on the web because the **Publish calendar** option is missing from Calendar settings.

## Cause

This problem can occur if the *Anonymous* domain isn't set in the sharing policy that's assigned to the user.

## Resolution

To resolve this problem, follow these steps:

1. Determine the sharing policy that's assigned to the user.

   1. Connect to Exchange Online by using remote PowerShell. For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
   2. Run the following command, and note the policy that is returned:

      ```powershell
      Get-Mailbox User1 | fl *sharing*
      ```

2. Update the sharing policy for the user. To do this, follow these steps:

   1. Open the Exchange admin center.
   2. Select **Organization**.
   3. Under **Individual Sharing**, double-click the policy that's assigned to the user. This is the policy that was returned in step 1.
   4. On the Sharing Rule page, select **Sharing with a specific domain** under **Specify the domains that you want to share with**, and then type *Anonymous*.
   5. Under **Specify what information you want to share**, select the calendar sharing level that you want to allow, and then select **Save**.

## More information

For more information, see [Enable Internet calendar publishing](/exchange/enable-internet-calendar-publishing-exchange-2013-help).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
