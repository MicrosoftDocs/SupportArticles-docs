---
title: Outlook performance is slow in Microsoft 365
description: Describes performance issues that occur when you use Outlook in a Microsoft 365 environment. Specifically, Outlook performs slowly when you open email messages, and mail sits for a long time in the Outbox after you send it. A resolution is provided.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Exchange Mailbox Accounts\Slow to connect or access mailbox
  - CSSTroubleshoot
appliesto:
- Exchange Online
- Outlook 2016
- Outlook 2013
- Microsoft Outlook 2010
- Microsoft Office Outlook 2007
search.appverid: MET150
ms.reviewer: willfid, gregmans, v-six
author: cloud-writer
ms.author: meerak
ms.date: 02/27/2025
---
# Outlook performance is slow in the Microsoft 365 environment

## Symptoms

When you use Microsoft Outlook together with Microsoft 365, you experience one or more of the following symptoms:

- Outlook responds slowly when you try to open email messages.
- When you send an email message, the message sits in the Outbox folder for a long time.
- Outlook responds slowly when you try to insert an attachment. Frequently, you receive the following warning message:
  > Outlook is retrieving information from the server

## Cause

This issue may occur for many reasons.

This issue may be caused by an Exchange Online server issue. In this case, sign in to the Microsoft 365 portal by using your administrator credentials, and then select **service health** to determine whether other customers are experiencing the same issue. If other customers are experiencing the issue, the issue should end when the service-interrupting event is resolved.

Also, determine whether any local network issues might be causing the problem. This includes issues that affect your local proxy server, firewall, or Internet service provider.

## Resolution

To fix this issue, follow these steps:

1. Make sure that the latest updates for Outlook are installed. For more information, see [How to install the latest applicable updates for Microsoft Outlook (US English only)](/outlook/troubleshoot/installation/install-outlook-latest-updates).

   Test to learn whether the issue is resolved. If the issue persists, go to step 2.

2. Try the methods from the following articles, as appropriate for the version of Outlook that you're running:

   - For Outlook 2010 and later versions, see [Outlook not responding error or Outlook freezes when you open a file or send mail](/outlook/troubleshoot/performance/outlook-not-responding-error-or-outlook-freezes).
   - For Outlook 2010, see [How to troubleshoot performance issues in Outlook](https://support.microsoft.com/topic/how-to-troubleshoot-performance-issues-in-outlook-7ac5402d-c4eb-ed6b-9545-b26dde618755).

    If the issue persists, go to step 3.

3. Try the following methods:

   - Run the [Classic Outlook Advanced Diagnostics troubleshooter](https://aka.ms/SaRA-OutlookAdvDiagExpExp-sarahome) to create a detailed configuration report.

     > [!NOTE]
     >
     > - The troubleshooter doesn't work in new Outlook for Windows.
     > - To run the troubleshooter, make sure that you're using the same Windows device that classic Outlook is installed on. Additionally, make sure that your device is running Windows 10 or a later version.

     To run the troubleshooter, follow these steps:

       1. Select the following button to start the troubleshooter.

           > [!div class="nextstepaction"]
           > [Classic Outlook Advanced Diagnostics troubleshooter](https://aka.ms/SaRA-OutlookAdvDiagExpExp-sarahome)

           If you receive a pop-up window that displays "This site is trying to open Get Help.", select **Open**.
       1. Follow the instructions in the Get Help app to run the troubleshooter.

     After the troubleshooter finishes, it displays the results and provides additional information about how to resolve the issue.

   - Disable Skype for Business Online (formerly Lync Online) integration. If Outlook is integrated with Skype for Business Online in your Microsoft 365 environment, the integration may affect Outlook's performance. To disable Skype for Business Online integration with Outlook, follow these steps:

     1. Open Lync, select the gear icon in the upper-right corner, point to **Tools**, and then select **Options**.
     2. Select **Personal**, and then clear the check boxes in the **Personal information manager** area.
     3. Select **OK**, and then restart Outlook and Lync.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
