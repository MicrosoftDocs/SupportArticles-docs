---
title: Upgrading to Office 2016 fails
description: Provides a solution to an issue where upgrading to Office 2016 fails.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: gbratton, tasitae
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2016
ms.date: 10/30/2023
---
# Errors when you upgrade to Office 2016

_Original KB number:_ &nbsp; 3098831

## Symptoms

When you upgrade to Office 2016, you receive the following error message during the installation process:

> Stop, you should wait to install Office 2016  
> You won't be able to receive mail from a current mailbox.  
> Outlook 2016 requires access to the Autodiscover service for your Exchange service. You may want to contact your mailbox provider or system administrator about this issue.

:::image type="content" source="./media/upgrade-errors-office-2016/error-message-dialog-box.png" alt-text="Screenshot of the error message when you upgrade to Office 2016." border="false":::

If you select **Install anyway** and upgrade to Outlook 2016, and then you start Outlook, you receive the following error message:

> Outlook cannot log on. Verify you are connected to the internet and are using the proper server and mailbox name.

After you click **OK**, you receive the following error message:

> Cannot start Microsoft Outlook. Cannot open Outlook window. The set of folders cannot be opened.

> [!NOTE]
> Outlook may freeze at the splash screen for several minutes before these errors messages are displayed.

## Cause

You receive the error messages that are mentioned in the [Symptoms](#symptoms) section if the Office 2016 update process determines that the Autodiscover service is inaccessible. The update process checks your current Outlook configuration to determine whether you are affected by some known issues.

If you select **Install anyway** to upgrade to Office 2016, and then you start Outlook, Outlook may be unable to connect to the Exchange Server Autodiscover service because Autodiscover is not configured or is not working correctly. This generates an error message.

After you upgrade Outlook or you create a new profile, Autodiscover is required to configure an Outlook profile the first time that Outlook is started.

This problem may occur for one of the following reasons:

- The previous version of Outlook was configured to connect to Exchange Server without Autodiscover. This was done by manually specifying the server settings. In Outlook 2016, the option to manually configure an Exchange account is no longer available.

- Autodiscover was previously available but is no longer available.

## Resolution

To resolve this problem, your Exchange Server administrator or service provider should make sure that Autodiscover is functional and can be accessed by Outlook 2016.

## More information

Autodiscover is required during the initial connection between Outlook 2016 and Exchange Server. This is because Outlook uses Autodiscover to automatically configure the connection settings. Earlier versions of Outlook also used Autodiscover to enable important functionality.

For more information about how to configure Autodiscover, see the following articles:

- [White Paper: Understanding the Exchange 2010 Autodiscover Service](/previous-versions/office/exchange-server-2010-technical-article/jj591328(v=exchg.141)).

- [Autodiscover service](/exchange/autodiscover-service-for-exchange-2013)
