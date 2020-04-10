---
title: SharePoint Online service processes temporarily limited to off-peak hours
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 2/5/2019
audience: Admin
ms.topic: article
ms.prod: microsoft-teams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams
ms.custom: 
- CI 115969
- CSSTroubleshoot 
ms.reviewer: MS aliases for tech reviewers and CI requestor, without "@microsoft.com".  
description: Microsoft is temporarily restricting some SharePoint Online processes to operate only during off-peak hours. 
---

# Temporary off-peak processing of SharePoint Online services 

## Summary

On March 24, 2020, Microsoft announced in the M365 message center ([MC207439](https://admin.microsoft.com/Adminportal/Home?source=applauncher#/MessageCenter?id=MC207439)) details around temporary time-based adjustments made to some online services in SharePoint Online and OneDrive.

## More information

During these unprecedented times, Microsoft is taking steps to make sure that critical SharePoint Online and OneDrive services remain available and reliable for users who depend on these services in remote work scenarios by temporarily processing some services during evening and weekend hours. 

> [!NOTE]
> These temporary feature adjustments may be in place during business hours in your region.  

### Content migration, Data Loss Prevention (DLP), and backup solutions 
Many SharePoint Online and OneDrive customers run business-critical applications against the service that run in the background. These include:

- Content migration
- Data Loss Prevention (DLP)
- Apps that scan the service
- Backup solutions

In support of the objective to remain highly available, we are moving some operations to regional evening and weekend hours.

Migration, DLP, and backup solutions might achieve limited throughput during regional weekday daytime hours. During evening and weekend hours for the region, the service will process a significantly higher volume of requests from background apps. 

The following documents provide best practice guidance, which describes how to get maximize throughput. 

- [Migration performance guidance](https://docs.microsoft.com/sharepointmigration/sharepoint-online-and-onedrive-migration-speed), which includes an [FAQ & Troubleshooting section](https://docs.microsoft.com/sharepointmigration/sharepoint-online-and-onedrive-migration-speed).
- For DLP, apps that scan the service and backup apps: [Best practices for discovering files and detecting changes at scale](https://docs.microsoft.com/onedrive/developer/rest-api/concepts/scan-guidance?view=odsp-graph-online).

### File Management 

Some background processes to manage new media (such as images and videos) may now be processed during evening and weekend hours. 
Modified processes include: 

- 360-file views. New file uploads will not be available until the process has run after hours. 
- Automatic metadata tagging of images and files with metadata. For example, if you upload an image or file and tag it with the word "tree," the item will not be tagged with metadata until the process has run after hours.  
- New documents in Office Online. Recently edited Office documents may require additional loading time when viewing the document in Office Online.
- Video resolution. Users may experience reduced video resolution for playback videos. 
- Displaying large thumbnails. Choosing to "display items by using large thumbnails" for OneDrive Files On-Demand will display generic icons instead.
  > [!NOTE]
  > Photo file thumbnails (jpeg, jpg, png, etc) are not affected by this change.
  <div>&nbsp;</div>The following thumbnail types are affected by this limitation
  
  - Video and PDF files: pdf, avi, mp4, mov, mpg, etc.
  - Document files with generators: docx, txt, html, etc.
  - New extensions likely to be permanently blocked because no thumbnail generator is ever likely to exist:  reg|bak|iso|nupkg, etc.
  - Files types already blocked today because no generator exists: lnk|xlsx|xls|url|exe|zip|rar|rdp|apprefms|msi|website.

There is no workaround at this time. Microsoft will continue listening to feedback and iterate on this approach.

## More information  
- [Our commitment to customers and Microsoft cloud services continuity](https://www.microsoft.com/microsoft-365/blog/2020/03/21/commitment-customers-microsoft-cloud-services-continuity/) 
- [Awareness of temporary adjustments in Microsoft OneNote](https://techcommunity.microsoft.com/t5/onenote-service-updates/awareness-of-temporary-adjustments-in-microsoft-onenote/m-p/1248100)
- [Awareness of temporary adjustments in SharePoint Online](https://techcommunity.microsoft.com/t5/sharepoint-support-blog/awareness-of-temporary-adjustments-in-sharepoint-online/ba-p/1250603)

Microsoft will provide further updates to this post as the situation changes.


Still need help? Go to [Microsoft Community](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fanswers.microsoft.com%2F&data=02%7C01%7Cv-todmc%40microsoft.com%7C98910814456c474880f108d7cf62d97d%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637205895885805857&sdata=9%2FYStDGvrU5ZIYXB7guowmaPlKazab0U%2BTpiBIItDaQ%3D&reserved=0).