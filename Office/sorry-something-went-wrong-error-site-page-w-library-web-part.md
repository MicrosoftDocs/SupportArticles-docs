---
title: "User receives "Virus Found" error when antivirus scanner in SharePoint Server 2013 is unavailable"
ms.author: v-todmc
author: v-todmc
manager: joselr
ms.date: 2/20/2019
ms.audience: Admin
ms.topic: article
ms.service: office
localization_priority: Normal
search.appverid:
- SPO160
- MET150
ms.assetid: 
description: "How to resolve the error "Virus Found" in SharePoint Server 2013 when the antivirus scanner is unavailable ."
---
# “Sorry, something went wrong” error on a Site Page with a Pages library web part added

## Symptoms
You receive the following error when selecting **Show Related Resources** within the Site Content and Structure page (sitemanager.aspx):



> [!ERROR]
> Sorry, something went wrong  
An unexpected error has occurred.

## Cause
This can happen if you have a list view web part that is consuming a publishing library that has the option ”Require Content Approval” selected.

SharePoint ULS reports:

```
w3wp.exe (0x192C) 0x14AC SharePoint Foundation General 8nca Medium Application error when access /_layouts/15/sitemanager.aspx, Error=Object reference not set to an instance of an object…(truncated)…
```

Steps to reproduce the error:
1.	Navigate to the **Site Pages Library**.
2.	Create a new **Site Page**.
3.	Insert the **Pages library web part** on the page.
4.	**Save and Check-in** the page.
5.	Navigate to **Site Settings** > **Content and structure**, then select **Site Pages** in the left panel.
6.	Select the checkbox next to the Site Page created in step 2, then click **Show Related Resources**.
> ![NOTE]
> The system will display the related resources for the selected page.
7.	Navigate back to the Site Page created in step 2.
8.	Place the page in **Edit** mode, then place the **Pages Library web part** in edit mode.
9.	Select **OK** in the **web part properties** box without making any changes, then **Save and check-in** the page. 

Results:

## Workaround
Per Office support article [Features enabled in a SharePoint Online publishing site] (https://support.office.com/en-us/article/Features-enabled-in-a-SharePoint-Online-publishing-site-3AB3810C-3C2C-4361-9D0E-0CBE666EA0B0), beginning in October 2018 the Site Content and Structure was deprecated in SharePoint Online. The UI entry point to SiteManager.aspx has been removed from SharePoint Online and direct access will be restricted to Site Collection Admins until March 2019.

Because Site Manager has been deprecated, it will no longer receive investment beyond security fixes in SharePoint Online or On Premise.

Options for resolving the issue:
1.	Create a page in the pages library and add the web part there rather than create the page in the site pages library.
2.	Turn off **Require content approval for submitted items** on Pages library.

## More information