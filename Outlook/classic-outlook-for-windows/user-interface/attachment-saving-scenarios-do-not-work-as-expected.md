---
title: Attachment saving not working as expected
description: Various attachment saving scenarios don't work as expected in Outlook 2016. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Data Protection and Security\Attachment administration and control
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: sbradley, gbratton
appliesto: 
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Various attachment saving scenarios do not work as expected in Outlook 2016

_Original KB number:_ &nbsp; 4090818

## Symptoms

Microsoft Outlook provides a feature set for saving attachments to an email message. In this process, you have the option to save each attachment one at a time or to save all the attachments at the same time.

Outlook allows saving files to local or network drives, and the functionality can be accessed from different places in the Outlook user interface. For example, you can right-click an attachment in the attachment well, and then select **Save All**. You can also select **Save Attachments** on the **File** menu. But there are several scenarios in which you can't save the attachment as expected.

### Scenario 1 - Can't Save All to a network file location

You select **Save All Attachments** for an email message that has multiple attachments, and you specify a network location as the destination. However, the files are not successfully saved to the network location. Instead, you are returned to the file list, and you receive no error message.

### Scenario 2 - Can't Save All to a SharePoint online site library location

You select **Save All Attachments** for an email message that has multiple attachments, and you specify a SharePoint online location as the destination. However, the files are not successfully saved, and you receive a **Cannot save the Attachment. File name or directory names is not valid** error message.

### Scenario 3-  Can't save Share Link style OneDrive attachment to a network file location

Someone sends you a modern attachment, which is a link to a file that is stored in a cloud location. You try to save the attachment to a network location, but the save is not successful. If you use the **Save All Attachments** option, you receive a **Cannot find this file. Verify the path and file name are correct** error message. If you use the **Save As** option to save the single attachment, the save is not successful. However, you do not receive an error message.

### Scenario 4 - Can't save an attachment to a network drive that has been mapped

You have mapped a network share to a drive letter. For example, the \\\server\share\ folder has been mapped to the H:\ folder. When you try to save all attachments from an email message to the H:\ folder, the save is not successful. However, you do not receive an error message.

### Scenario 5 - Path error when saving a single file from the Save All dialog

You select **Save All Attachments** for an email message that has multiple attachments. From the **Save All** dialog box, you select a single file to save. Even though the file is successfully saved, you receive a "Path does not exist. Verify the path is correct" error message. You can safely ignore this error.

## Cause

Because of the many variables that are involved in saving files to a file system (network versus local, security implications, permission requirements, and so on), the technology that is used by Microsoft Outlook in this feature set area does not guarantee successful saves in all scenarios in older builds. As fixes are made for the problem scenarios, the fixed build information will be listed in this article.

> [!NOTE]
>
> - Starting in Outlook 365, version **1806** (build **10228.20080**), scenarios 1, 2, and 3 should work successfully.
> - Starting in Outlook 365, version **1807** (build **10730.20088**), scenario 4 should work successfully.
> - Starting in Outlook 365, version **1809**  (build **10872.20138**), scenario 5 should work successfully.

To check the Outlook build, see [What version of Outlook do I have?](https://support.microsoft.com/office/what-version-of-outlook-do-i-have-b3a9568c-edb5-42b9-9825-d48d82b2257c).

## Workaround

To resolve each of the scenarios that are described in the Symptoms section, a new implementation of the attachment saving feature set is implemented in Microsoft Outlook.

If you are using an older Outlook build, you can work around many of the problem scenarios by saving the files to a temporary local location and then using the usual Windows methods to copy the files to the network location. In many scenarios, you can also drag the attachment to the destination successfully.

## References

For an update history for Microsoft 365 Apps for enterprise, see [Update history forMicrosoft 365 Apps for enterprise(listed by date)](/officeupdates/update-history-microsoft365-apps-by-date).
