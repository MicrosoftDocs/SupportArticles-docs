---
title: Attachment is missing from an e-mail message that is sent to a Microsoft Windows SharePoint Services 3.0 document library
description: Describes a problem in Microsoft Windows SharePoint Services 3.0. When e-mail messages that contain attachments are sent to a document library, the attachments are removed. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Windows SharePoint Services 3.0
ms.date: 12/17/2023
---

# Attachment is missing from an e-mail message that is sent to a document library  

## Symptoms  

Consider the following scenario.

- You use a Microsoft Exchange Server e-mail client, such as Microsoft Office Outlook, to send an e-mail message to a Microsoft Windows SharePoint Services 3.0 document library.
- The e-mail message contains an attachment.

In this scenario, the e-mail message arrives in the document library. However, the attachment is missing.  

## Cause  

This issue occurs when you associate the document library with an e-mail address. When you do this, the SharePoint Directory Management Service may not add the following attributes:  

- internet Encoding = 1310720   
- mAPIRecipient = false     

These two attributes must be added to the contact so that the attachment is sent correctly.  

## Resolution  

To resolve this issue, you must use Active Directory Service Interfaces (ADSI) to manually add the two missing attributes. To do this, follow these steps:  

**Note** On the Microsoft Windows Server 2003 CD, ADSI Edit is included in Windows Support Tools. To install Support Tools for Windows Server 2003, use the SUPTOOLS.MSI program that is located in the Support\Tools folder. To install Support Tools for Windows 2000, use the Setup.exe program that is located in the Support\Tools folder.   

1. Click **Start**, click **Run**, type Adsiedit.msc , and then click **OK**.   
2. Expand **ADSI Edit**, expand **Domain DomainName]**, expand **DC=DomainName**, **DC=com**, and then expand **CN=Users**.   
3. Right-click the user name to which you want to add the missing attributes, and then click **Properties**.   
4. In the properties dialog box, double-click **internet Encoding** on the **Attribute Editor** tab.   
5. In the **Integer Attribute Editor** dialog box, type 1310720 in the Value box, and then click **OK**.   
6. Double-click **mAPIRecipient**.
7. In the **Boolean Attribute Editor** dialog box, click **False**, and then click **OK** two times.     

## Workaround  

In the Exchange Management Console, you can add a new Message Format under the Global Settings, set the domain to the Fully Qualified Domain Name of the SharePoint server, and set it to never use Exchange Rich-Text Format.   

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
