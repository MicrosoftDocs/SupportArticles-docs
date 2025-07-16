---
title: PowerPivot for SharePoint 2016 Gallery Snapshots Fail for SSL Host Header Sites
description: Describes an issue in which PowerPivot Gallery Snapshots Fail for SSL Host Header Sites.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
ms.reviewer: randring
appliesto: 
  - SharePoint Server 2016
ms.date: 12/17/2023
---

# PowerPivot Gallery Snapshots Fail for SSL Host Header Sites

This article was written by [Rick Andring](https://social.technet.microsoft.com/profile/Rick+A.+-+MSFT), Support Escalation Engineer.

If you have been following the multiple threads on issues and changes to the PowerPivot for SharePoint 2016 Gallery Snapshots, you may be aware of an issue where gallery snapshots do not function properly (infinite "hourglass") for SSL sites when there are multiple sites bound to the same port. While not limited to port 443 we will use a generic port 443 site as an example here as it is the most common usage.

This issue was discovered back in December 2016 during testing and again in a well-researched blog post by [Brian Laws](https://social.technet.microsoft.com/profile/Brian+H+Laws)
(<https://info.summit7systems.com/blog/bug-report-powerpivot-for-sharepoint-2016-thumbnails-not-generating>) in February of 2017.

:::image type="content" source="media/troubleshooting-powerpivot-gallery-snapshot/hourglass-issue.png" alt-text="Screenshot shows the issue in the PowerPivot Gallery.":::

Extensive detail on the snapshot process or the log entries is not covered in this post (you can see Brian's blog above for most of it or follow along in the ULS logs). Here is the 10,000 foot view:

1.  A user uploads a new PowerPivot workbook to the Gallery.
2.  Event receiver detects the file, and whether or not it is a file valid for a snapshot.
3.  SharePoint calls the ExcelRest.aspx for each relevant item in the workbook via a URL similar to the following sample:
    
    https://**localhost**/\_vti\_bin/ExcelRest.aspx/PowerPivot%20Gallery/GenericWorkbook.xlsx/Model/Sheets('Sheet1')

4.  As part of the above call, the full URL of the document is sent with the request to OOS on behalf of the user that uploaded the document. (Obviously "localhost" is not a valid URL for OOS, so we also send the full URL as part of the request and OOS knows where to go to retrieve the snapshots.)
5.  Office Online Server loads the workbook, retrieves the snapshots, and returns them to the SharePoint WFE server. 
6.  The snapshots are applied to the document.

## The Issue

The new snapshot process causes an issue for SSL sites that share a port **and** use unique certificates. When you combine multiple unique URLs, each with their own unique SSL certificates and localhost calls, you wind up with IIS getting confused on what certificate to pin to the request (since it is localhost, it takes the first one in line generally). In an effort to avoid an authentication double hop in a scenario where more than one SharePoint web front end (WFE) is involved, the product team opted to utilize localhost. If this was not in place, Kerberos Constrained Delegation (KCD) would need to be configured between the SharePoint WFE servers to avoid an overcomplicated configuration, just for gallery snapshots to function properly.

In the SharePoint ULS logs, you will see a set of entries similar to the following detailing the failure:

```
00/00/2017 00:00:00:00 w3wp.exe (0xXXXX) 0x18A8 PowerPivot
Service Unknown 46 Medium Capturing Report Gallery snapshot information
from the following URL:
https://localhost/_vti_bin/ExcelRest.aspx/PowerPivot
Gallery/GenericWorkbook.xlsx/model/Sheets 37abef9d-92a8-20b9-17bb-d369b513965b

00/00/2017 00:00:00:00 w3wp.exe (0xXXXX) 0x18A8 PowerPivot
Service Unknown 46 High Snapshot <strong>Exception: Unable to take snapshots or
get details of the file: https://ssl.contoso.com/PowerPivot
Gallery/GenericWorkbook.xlsx from the uri:
https://localhost/_vti_bin/ExcelRest.aspx/PowerPivot
Gallery/GenericWorkbook.xlsx/model/Sheets. 37abef9d-92a8-20b9-17bb-d369b513965b

00/00/2017 00:00:00:00 w3wp.exe (0xXXXX) 0x18A8 PowerPivot
Service Unknown 46 <strong>High Snapshot Exception: Ensure localhost uris are
allowed</strong>. 37abef9d-92a8-20b9-17bb-d369b513965b

00/00/2017 00:00:00:00 w3wp.exe (0xXXXX) 0x18A8 PowerPivot
Service Report Gallery 99 High <strong>EXCEPTION: System.Net.WebException: The
underlying connection was closed: An unexpected error occurred on a
send</strong>. <<Truncated stack>> 37abef9d-92a8-20b9-17bb-d369b513965b
```

During our multiple attempts to narrow this down, we could see the snapshot process attempting to load the first site bound certificate in our list (for my "secondary" SSL site) instead of the certificate for ssl.contoso.com. Because of the localhost call, IIS is confused (obviously) about what certificate to hand out for the request. This issue is specific to farms where everything else is configured properly and functional, but it is not limited to just this scenario. This just happens to be the most common (and basic) configuration.

**The product team has determined this is by design and will not be changed due to product limitations with SharePoint and Office Online Server.**

## The Workaround

  - You can use a wildcard certificate. This is the only possible workaround we have found so far. With a wildcard certificate for your sites, you can utilize multiple SSL host header sites and your gallery snapshots will function (this has been tested and confirmed working). Again, this is assuming that everything else is configured properly for snapshots to function. We realize that it is not viable for everyone, but it is only option to keep sites SSL and have functional snapshots at this point.
    
  > [!NOTE]
  > 
  > Be sure that you research all aspects of using Wildcard certificates before implementing this solution so you are fully informed of the risks and rewards of using them.

## Other Options

  - You can restrict your usage to one SSL site  with host header and certificate and no IP-specific bindings (site-specific SSL certs and IP-specific bindings usually go hand-in-hand).
  - Stop using the PowerPivot Gallery all together. You can schedule data refreshes for PowerPivot workbooks in any document library as
    long as the PowerPivot solution is deployed to the web app and the features are activated on the site.
  - Convert your SSL sites to HTTP. (Maybe even just the sites that host
    workbooks?)

  - Set "All Documents" to the default view in the PowerPivot Gallery:

    1.  Navigate to the list a site owner.    
    2.  Click "Library" \> "Library Settings" from the ribbon menu.  
        :::image type="content" source="media/troubleshooting-powerpivot-gallery-snapshot/library-settings.png" alt-text="Screenshot to select the Library Settings item under the Library tab." lightbox="media/troubleshooting-powerpivot-gallery-snapshot/library-settings.png":::
    3.  Scroll down to the **Views** section and click **All Documents**.  
        :::image type="content" source="media/troubleshooting-powerpivot-gallery-snapshot/views-all-documents.png" alt-text="Screenshot of the Views section with the All Documents item selected.":::
    4.  Check the **Make the default view** box and click "OK"  
        :::image type="content" source="media/troubleshooting-powerpivot-gallery-snapshot/make-the-default-view.png" alt-text="Screenshot to check the Make the default view box.":::

  - You can take the above a step further by deleting the Silverlight views in the PowerPivot Gallery:
    
      - (Do the "Set "All Documents" to the default view" section above first)
        
        1.  Navigate to the list a site owner.        
        2.  Click "Library" \> "Library Settings" from the ribbon menu.  
            :::image type="content" source="media/troubleshooting-powerpivot-gallery-snapshot/library-settings.png" alt-text="Screenshot to select the Library Settings item under the Library tab." lightbox="media/troubleshooting-powerpivot-gallery-snapshot/library-settings.png":::
        3.  Scroll down to the "Views" section and click on any of the 3 PowerPivot Silverlight views "Gallery", "Theatre" and "Carousel".  
            :::image type="content" source="media/troubleshooting-powerpivot-gallery-snapshot/views-gallery-theatre-carousel.png" alt-text="Screenshot of the Views section, with the Gallery, Theatre, and Carousel items selected.":::
        4.  Click "Delete".  
            :::image type="content" source="media/troubleshooting-powerpivot-gallery-snapshot/delete-button.png" alt-text="Screenshot to select the Delete button in the PowerPivot Gallery.":::

  - You can also Delete/Hide the extra views with PowerShell (sample scripts attached below):
    
      - [Delete and hide sample scripts](https://download.microsoft.com/download/7/0/D/70DEB092-347A-4AD3-B7BA-2947025889D4/HideAndDeletePowerPivotViews.zip)
  
        > [!NOTE]
        >
        > For your current PowerPivot Galleries, they will continue to attempt to take snapshots even if you disable/delete the views. The only way to stop them from attempting to create snapshots is to replace the gallery with a normal document library. As long as you keep the PowerPivot features deployed to the site, you will still be able to schedule data refreshes as usual. We STRONGLY recommend that you test these scripts extensively in a development environment before using them on a farm that matters.
        >

This article covers an issue specific to PowerPivot Gallery Snapshots in SharePoint 2016, and it does not refer to or reference any other products. If you see similar errors in other versions of SharePoint, the solutions/recommendations list here will not help you and are not relevant to your issue. The PowerShell scripts provided in this article are provided as samples for testing with no guarantee or warrantee by Microsoft.
