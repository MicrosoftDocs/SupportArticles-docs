---
title: Sensitivity button in Outlook isn't enabled in a hybrid Exchange environment
description: Provides a resolution for an issue in which the Sensitivity button in Outlook isn't enabled for on-premises users in a hybrid Exchange environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sensitivity Labels
  - Exchange Online
  - CSSTroubleshoot
  - CI 189415
ms.reviewer: ziading, dcortan, toz, gbratton, meerak, v-trisshores
appliesto: 
  - Microsoft Purview
  - Outlook for Microsoft 365
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 04/17/2024
---

# Sensitivity button in Outlook isn't enabled in a hybrid Exchange environment

## Symptoms

Your organization uses sensitivity labels to classify and protect email messages in a hybrid Microsoft Exchange Server environment. However, Outlook for Microsoft 365 users who connect to on-premises mailboxes can't apply sensitivity labels because the **Sensitivity** button in new messages isn't enabled.

## Cause

Version 2308 and later versions of Outlook for Microsoft 365 include a new feature that filters sensitivity labels based on the identity of the Outlook user. However, if both the following conditions are true, the filtering feature doesn't work, and the **Sensitivity** button isn't enabled:

- The Outlook for Microsoft 365 client is connected to an on-premises mailbox in a hybrid Exchange environment.

- The Outlook for Microsoft 365 client connects to Exchange Server by using one of the [Security Support Provider Interface](/windows-server/security/windows-authentication/security-support-provider-interface-architecture) (SSPI) authentication methods: Negotiate, Kerberos, or NTLM.

## Workaround

> [!IMPORTANT]
> This workaround disables the new feature that filters sensitivity labels based on user identity. Use the workaround at your own discretion because it changes the intended operation of Outlook for Microsoft 365. The underlying functionality of the new feature might change unexpectedly. Therefore, the workaround might not always work.

For each affected user, use the following steps on the computer that has the user's Outlook for Microsoft 365 client installed.

[!INCLUDE [Important registry alert](../../../includes/registry-important-alert.md)]

1. Create a text file that's named *sensitivity-label-fix.reg*.

2. Copy and paste the following text into the file, and then save the file:

   ```notepad
   Windows Registry Editor Version 5.00
  
   [HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\ExperimentEcs\Overrides]
   "Microsoft.Office.Security.CLP.CG.EnableSensitivityFlyoutByDocumentContentType"="false"
   "Microsoft.Office.Security.CLP.CG.EnableSensitivityFlyoutByDocumentContentType2"="false"
   ```

3. Double-click *sensitivity-label-fix.reg* to run it.

4. When you're prompted for approval, select **Yes**.

5. Restart Outlook for Microsoft 365.

6. Open a new email message to verify that the **Sensitivity** button is enabled and that all sensitivity labels are visible and unfiltered.
