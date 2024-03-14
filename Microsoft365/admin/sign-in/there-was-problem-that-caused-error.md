---
title: Parts of Online Services Sign-in Assistant to be disabled error when signing in cloud service
description: Discusses a scenario in which you experience authentication issues in Microsoft 365, Azure, or Microsoft Intune and you receive an error that states there was a problem that caused parts of the Microsoft Online Services Sign-in Assistant to be disabled. A resolution is provided.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: dahans
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# You receive a "There was a problem that caused parts of the Microsoft Online Services Sign-in Assistant to be disabled" error

## Problem

You experience sign-in issues in a Microsoft cloud service such as Microsoft 365, Microsoft Azure, or Microsoft Intune. Specifically, you see a pop-up dialog box that contains the following error message:

> There was a problem that caused parts of the Microsoft Online Services Sign-in Assistant to be disabled. The problem may have been caused by a program that was recently installed.

## Cause

This problem occurs when the Microsoft Online Services Sign-in Assistant detects that an issue occurred in the Microsoft Online Services Sign-in Assistant service. In this situation, the connection to the service is ended. 

## Solution 

To restart the Microsoft Online Services Sign-in Assistant service, follow these steps:

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type **services.msc**, and then press Enter.

   :::image type="content" source="media/there-was-problem-that-caused-error/run-page.png" alt-text="Screenshot of the Run window with services.msc typed." border="false":::
3. In the list of services, locate and then double-click the Microsoft Online Services Sign-in Assistant service.

   :::image type="content" source="media/there-was-problem-that-caused-error/online-services-sign-in-assistant.png" alt-text="Screenshot to select the Microsoft Online Services Sign-in Assistant in the Services window." border="false":::

4. Stop the service. To do this, click Stop, and then wait until the service stops. The Service status should be displayed as Stopped.

   :::image type="content" source="media/there-was-problem-that-caused-error/service-status-is-stopped.png" alt-text="Screenshot of the Online Services Sign-in Assistant properties window, showing the Service status is stopped." border="false":::
5. Start the service. To do this, click Start, and then wait until the service starts. The Service status should be displayed as Started.

   :::image type="content" source="media/there-was-problem-that-caused-error/service-status-is-started.png" alt-text="Screenshot of the Online Services Sign-in Assistant properties window, showing the Service status is started." border="false":::
6. Verify that the issue is resolved and the pop-up dialog box is no longer displayed.   
7. If you continue to see the pop-dialog box, restart the computer, and then verify that the issue is resolved.

Did this fix the problem?

- Check whether the problem is fixed.
  - If the problem is fixed, you are finished with these steps.    
  - If the problem is not fixed, go to the [Microsoft Community](https://answers.microsoft.com/), the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website, or [contact support](https://support.microsoft.com/contactus).   
   
- We would appreciate your feedback. To provide feedback or to report any issues with this solution, please send us an [email](mailto:fixit4me@microsoft.com?subject=kb) message.   


## More Information 

For more information about related technical issues, see the following Microsoft Knowledge Base article: 

[2637629](https://support.microsoft.com/help/2637629) How to troubleshoot non-browser apps that can't sign in to Microsoft 365, Azure, or Intune

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
