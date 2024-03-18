---
title: Error when you start SharePoint Workspace or Groove
description: Describe an issue that occurs because the SharePoint Worspace or Groove device URL must be unique for each computer. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: lgreer
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Workspace 2010
ms.date: 12/17/2023
---

# Error message when you start SharePoint Workspace or Groove: "SharePoint Workspace/Groove has detected another device with the same DeviceURL as yours"

## Symptoms

You install Microsoft SharePoint Workspace 2010 or Microsoft Office Groove 2007 or an earlier version of Groove on a computer and then start SharePoint Workspace or Groove. Then, you create an image from this computer and distribute this image to other computers. When the people who receive the image start SharePoint Workspace or Groove, they may receive one of the following error messages:

```adoc
SharePoint Workspace has detected another device with the same DeviceURL as yours. The other device is running on your LAN with an IP address of **IP address.** Please contact your administrator or SharePoint Workspace support immediately.

Groove has detected another device with the same DeviceURL as yours. The other device is running on your LAN with an IP address of IP address. Please contact your administrator or Groove support immediately.
```

When this occurs, SharePoint Workspace or Groove may start. However, Groove messages and workspace synchronization are unreliable.

## Cause

This issue occurs because the device URL must be unique for each computer. SharePoint Workspace or Groove creates the device URL to identify the computer the first time that SharePoint Workspace or Groove is started. 

When SharePoint Workspace or Groove is installed and then started on a computer, and then an image is created from that computer and distributed to other computers on the local area network (LAN), all the installations have the same device URL. Because these installations appear identical in Groove communications, SharePoint Workspace or Groove is unreliable on most of or all the computers that have that image.

Other, less common activities that duplicate configuration can also cause this issue.

## Workaround

You cannot change the device URL in an active SharePoint Workspace or Groove installation. To work around this issue, you must remove all SharePoint Workspace or Groove data on each affected computer. This data includes the account and all workspaces. Then, each user must create a new account. 

**Note** Do not save your account to a file and then restore it. The device URL is saved in the account file. 

You can remove the SharePoint Workspace or Groove data by uninstalling the program and selecting the option to remove all data, or by using the grooveclean.exe or groove.exe options to remove all data. 

The following procedures will help you recover from this issue with as little data loss as possible. 

### For SharePoint Workspace 2010

1. In SharePoint Workspace, view Workspaces in the Launchbar.    
2. For each Groove workspace that has other members, make sure that another member has all workspace data.   
3. For each Groove workspace that has no other members, save the workspace as an archive.   
4. For each SharePoint workspace, record the URL of the SharePoint site.   
5. Clear all SharePoint Workspace data. 
6. Restart SharePoint Workspace, and then create a new account or accept a new account that was created by your administrator.   
7. Restore the archives that you created in step 3.   
8. Fetch other workspaces from other members.   
9. Re-create SharePoint workspaces by using the URLs that you recorded in step 4.    

For more information about how to remove data without uninstalling SharePoint Workspace, click the following article number to view the article in the Microsoft Knowledge Base:

[982279](https://support.microsoft.com/help/982279) How to delete temporary and permanent data in SharePoint Workspace 2010

### For Groove 2007

1. In Groove 2007, view Workspaces in the Launchbar.    
2. For each Groove workspace that has other members, make sure that another member has all workspace data.   
3. For each Groove workspace that has no other members, save the workspace as an archive.   
4. Clear all SharePoint Workspace data. 
5. Restart Groove, and then create a new account or accept a new account that was created by your administrator.   
6. Restore the archives that you created in step 3.   
7. Fetch other workspaces from other members.   
 
For more information about how to uninstall Groove, click the following article number to view the article in the Microsoft Knowledge Base: 

[907504 ](https://support.microsoft.com/help/907504) How to uninstall Groove 

For more information about how to remove data without uninstalling Groove, click the following article number to view the article in the Microsoft Knowledge Base: 

### How to create images

To prevent this issue when you create images, do not start SharePoint Workspace or Groove between the time that you install SharePoint Workspace or Groove and the time that you create an image from the installation.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
