---
title: Can't share presentations from Lync in Skype for Business Online
description: Provides steps to troubleshoot issues that prevent you from sharing presentations from Lync 2010 or Lync 2013 in Skype for Business Online.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: dahans
appliesto:
- Skype for Business Online
---

# Users can't share PowerPoint presentations from Lync 2010 or Lync 2013 in Skype for Business Online

## Problem

When you try to share a PowerPoint presentation from Lync 2010 or Lync 2013 in Skype for Business Online (formerly Lync Online), you experience one of the following symptoms:

|Symptom|Cause|Resolution|
|----|----|---|
|When you try to share a PowerPoint presentation through Lync 2013, you receive the "Some sharing features are unavailable due to server connectivity issues" error message.|Lync 2013 can't contact the Office Online PowerPoint server. Skype for Business Online sends a valid connection URL, but Lync 2013 can't connect. This might be caused by Domain Name System (DNS) resolution or firewall restrictions.|See "Network troubleshooting" in the "Solution" section.|
|When you try to share a PowerPoint presentation through Lync 2013, you receive the "Sorry, but Presentation Template \<filename>.pptx can't be uploaded. We're having difficulties connecting to the service. If this keeps happening, you might want to contact your support team" error message.|Typically, this is a problem with the Skype for Business Online service. If the Skype for Business Online servers can't connect to the Office Online server, they won't send a connection URL to Lync 2013.|Check the Office 365 Service Health Dashboard for outages.|
|When you try to share a PowerPoint presentation in Lync 2010, you receive the "There was a problem converting the PowerPoint Presentation" error message.|The PowerPoint presentation is already open, is corrupted, is password protected, is of the wrong file type, or contains features that are unavailable in Lync.|[See "Check the integrity of the PowerPoint presentation" in the Solution section.|
|The organizer of the meeting uploads PowerPoint slide images. However, the PowerPoint slide images aren't displayed correctly.|Some kinds of media within PowerPoint presentations aren't supported.|[See "Check the integrity of the PowerPoint presentation" in the Solution section.|
|A meeting participant can't save shared content in any format, such as a native format or an XML Paper Specification (XPS) format.|Usually caused by permissions issues with the destination directory, certificate issues, or a problem with the Microsoft XPS Document Writer.|[See "Check local permissions and settings" in the Solution section.|

## Solution

### Network troubleshooting

Verify that the network meets the requirements for connecting to Skype for Business Online. For more information, go to the following Microsoft Knowledge Base article: 

[2409256 ](https://support.microsoft.com/help/2409256) You can't connect to Skype for Business Online, or certain features don't work, because an on-premises firewall blocks the connection

Additionally, make sure that the 65.54.54.0/24 IP range is open in your firewall. This range covers the Office Online server from which PowerPoint presentations are streamed.

### Check the integrity of the PowerPoint presentation

1. If a static image isn't displayed correctly, try to reproduce the issue by using the same .ppt file that contains the image. Then, try to reproduce the issue by using a different .ppt file that contains the same image.   
2. Be aware that some content (video, multimedia, and so on) will be removed from the deck during the upload process.   
3. Verify that the PowerPoint presentation that you want to upload isn't open anywhere else on the system.    
4. Verify that the PowerPoint presentation isn't protected by Information Rights Management (IRM).   
5. Verify that there are no open dialog boxes in PowerPoint. (For example, a dialog box appears when you click **File** and then click **Open**.)   

### Check local permissions and settings

1. Verify that you have the correct certificates in Certificate Manager. To do this, follow these steps:
      1. Open Certificate Manager. To do this, click **Start**, click **Run**, type certmgr.msc, and then click **OK**.   
      2. Expand **Personal**, and then expand **Certificates**.   
      3. Click the heading for the **Issued By** column to sort the column, and then look for a certificate that's issued by Communications Server.   
      4. Verify that the certificate is present and isn't expired.   
      5. If the certificate is expired, right-click the certificate, point to **All Tasks**, and then click **Delete**.   
      6. Try to sign in to Skype for Business Online. This action will download a new certificate if sign-in is successful.   
   
2. Verify that you have the appropriate permissions to save to your target destination.
      - Verify that the user has permissions to save content. Have a presenter open the content bin (or attachments, if the file is an attachment), click the right arrow (or right-click), and then click Make Available to. Make sure that **Make Available to** is set to the role of the person who is trying to save the file.   
   
3. If you save to a network location, verify that you have Read/Write permissions to the network share.   
4. If you can't save content in the XPS format only, check the XPS print queue. To do this, click **Start**, click **Devices and Printers,** open the Microsoft XPS Document Writer, and then delete all pending jobs that seem to be stuck.   

## More Information

In the Lync 2013 log files, you notice an entry that resembles the following if you can't connect to the Office Online server:
For the second error message, if Skype for Business Online can't send you a connection URL, you see the following entry in the Lync 2013 log files:

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).