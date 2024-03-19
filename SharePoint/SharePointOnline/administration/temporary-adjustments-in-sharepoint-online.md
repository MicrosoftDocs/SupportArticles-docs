---
title: SharePoint Online service process schedule temporary change
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Reliability, Perf, and Throttling\Network Performance
  - CI 115969
  - CSSTroubleshoot
ms.reviewer: MS aliases for tech reviewers and CI requestor, without @microsoft.com.
description: Microsoft is temporarily restricting some SharePoint Online processes to operate only during off-peak hours.
---

# Temporary changes in process schedule for SharePoint Online services

## Summary

On March 24, 2020, Microsoft posted an announcement in the M365 message center ([MC207439](https://admin.microsoft.com/Adminportal/Home?source=applauncher#/MessageCenter?id=MC207439)) about temporary, time-based adjustments that are being made to some online services in SharePoint Online and OneDrive.

## More information

During these unprecedented times, we are taking steps to make sure that critical SharePoint Online and OneDrive services remain available and reliable for users who depend on these services in remote work scenarios. To do this, we will temporarily process some services during evening and weekend hours. 

> [!NOTE]
> These temporary feature adjustments may be in place during business hours in your region.  

### Content migration, Data Loss Prevention (DLP), and Backup solutions 
Many SharePoint Online and OneDrive customers run business-critical applications against services that run in the background, such as:

- Content migration
- Data Loss Prevention (DLP)
- Apps that scan the service
- Backup solutions

To help meet our objective to remain highly available, we are moving some operations to regional evening and weekend hours.

Migration, DLP, and Backup solutions might achieve limited throughput during regional weekday daytime hours. During evening and weekend hours for the region, the service will process a higher volume of requests from background apps. 

The following documents provide best practice guidance for getting maximize throughput:

- [General migration performance guidance](/sharepointmigration/sharepoint-online-and-onedrive-migration-speed). (This includes an [FAQ & Troubleshooting section](/sharepointmigration/sharepoint-online-and-onedrive-migration-speed#faq-and-troubleshooting).
- For DLP, apps that scan the service and Backup apps: [Best practices for discovering files and detecting changes at scale](/onedrive/developer/rest-api/concepts/scan-guidance).

### File management 

Some background processes that manage new media (such as images and videos) may now be processed during evening and weekend hours. 
Modified processes include: 
- **Video resolution.** Users may experience reduced video resolution for playback videos. 
- **Displaying large thumbnails.** Choosing to "display items by using large thumbnails" for OneDrive Files On-Demand will display generic icons instead.
  > [!NOTE]
  > Photo file thumbnails (jpeg, jpg, png, and so on) are not affected by this change. The following thumbnail types are affected by this limitation:
  
  - Video and PDF files: pdf, avi, mp4, mov, mpg, and so on
  - Document files that have generators: docx, txt, html, and so on
  - New extensions that might be permanently blocked because no thumbnail generator is likely to ever exist: reg|bak|iso|nupkg, and so on
  - Files types that are already currently blocked because no generator exists: lnk|xlsx|xls|url|exe|zip|rar|rdp|apprefms|msi|website

There is no workaround at this time. We will continue to listen to your feedback regarding this approach.

## References

- [Our commitment to customers and Microsoft cloud services continuity](https://www.microsoft.com/microsoft-365/blog/2020/03/21/commitment-customers-microsoft-cloud-services-continuity/) 
- [Awareness of temporary adjustments in Microsoft OneNote](https://techcommunity.microsoft.com/t5/onenote-service-updates/awareness-of-temporary-adjustments-in-microsoft-onenote/m-p/1248100)
- [Awareness of temporary adjustments in SharePoint Online](https://techcommunity.microsoft.com/t5/sharepoint-support-blog/awareness-of-temporary-adjustments-in-sharepoint-online/ba-p/1250603)

We will provide further updates to this post as the situation develops.


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
