---
title: Program is trying to send an e-mail message on your behalf
description: Discusses an issue in which you receive an error when you send an email message from another program, such as Microsoft Excel. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Data Protection and Security\Programmatic access warnings
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 160073
ms.reviewer: tasitae
appliesto: 
  - Outlook LTSC 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# "A program is trying to send an e-mail message on your behalf" warning in Outlook

_Original KB number:_ &nbsp; 3189806

## Symptoms

In Microsoft Outlook LTSC 2021, Outlook 2019, Outlook for Microsoft 365, Outlook 2016, and Outlook 2013, when you send an email message from another program, such as Microsoft Excel, you receive the following warning message:

> A program is trying to send an e-mail message on your behalf. If this is unexpected, click Deny and verify your antivirus software is up-to-date.

## Cause

This warning message is displayed when a program tries to access your Outlook client to send an email message on your behalf, and your antivirus software is detected to be inactive or out-of-date.

## Resolution Method 1 - Enable or update your antivirus application

To learn how Outlook detects your antivirus status, follow these steps:

1. In Outlook, select **File**, and then select **Options**.
2. Select **Trust Center**, and then select **Trust Center Settings**.
3. Select **Programmatic Access**.
4. View the **Antivirus status** information that's listed in this window. If the status is anything other than **Valid**, follow the appropriate steps to enable your antivirus program, or update your antivirus program as necessary.

   :::image type="content" source="media/a-program-is-trying-to-send-an-email-message-on-your-behalf/antivirus-status.png" alt-text="Screenshot of the Trust Center dialog box, where Antivirus status valid is highlighted in Programmatic Access entry.":::

## Resolution Method 2 - Change the Programmatic Access Security setting in the registry

1. Select **Start**, and then enter *regedit*. Right-click **Registry Editor** in the search results, and then select **Run as administrator**.
1. In Registry Editor, navigate to the appropriate registry subkey, as follows:

    - Different bitness (32-bit Office running on 64-bit Windows):
    HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\<x.0>\Outlook\Security
    - Same bitness (32-bit Office running on 32-bit Windows or 64-bit Office running on 64-bit Windows):
    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\<x.0>\Outlook\Security

    **Notes:**

    - In these subkeys, the <*x.0*> placeholder represents your version of Office (16.0 = Office 2016, Office 2019, Office LTSC 2021, or Outlook for Microsoft 365, and 15.0 = Office 2013).
    - If the indicated registry subkey isn’t present, right-click the last subkey in the path, select **New** > **Key**, and then create the necessary subkey.

1. Right-click the registry subkey, and then select **New** > **DWORD**.
1. Name the DWORD as `ObjectModelGuard`.
1. Set the value of the DWORD to the behavior that you want:

    - DWORD: ObjectModelGuard

    - Values:

        **0** = Warn me about suspicious activity when my antivirus software is inactive or out-of-date (recommended) 

        **1** = Always warn me about suspicious activity 

        **2** = Never warn me about suspicious activity (not recommended) 

1. Exit Registry Editor.

After you update the registry, check Outlook to make sure that the change is shown correctly in the **Programmatic Access** settings:

1. In Outlook, select **File**, and then select **Options**.
2. Select **Trust Center**, and then select **Trust Center Settings**.
3. Select **Programmatic Access**.

    :::image type="content" source="media/a-program-is-trying-to-send-an-email-message-on-your-behalf/never-warn-me-about-suspicious-activity-not-recommended-option.png" alt-text="Screenshot showing that the Never warn me about suspicious activity (not recommended) option is selected in the Programmatic Access Security area.":::
