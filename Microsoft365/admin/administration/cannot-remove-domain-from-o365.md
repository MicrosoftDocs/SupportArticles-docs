---
title: Cannot remove domain from Office 365
description: Fixes an issue in which you receive a <DomainName> can't be removed because you're using it for your SharePoint Online website error message when you try to remove a domain from Office 365.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
---

# "Cannot Remove Domain" error when you try to remove a domain from Office 365

## Problem

When you try to remove a domain from Office 365 in the Office 365 portal, you receive the following error message:

```adoc
Cannot Remove Domain

<DomainName> can't be removed because you're using it for your SharePoint Online website. If you want to remove the domain, first change the address that you're using for SharePoint Online to a different domain.
```

## Solution

To resolve this issue, change the domain that's used for your SharePoint Online website address, and then wait up to 24 hours. To do this, follow these steps:

1. Sign in to the Office 365 portal ([https://portal.office.com](https://portal.office.com)) as a global administrator.   
2. Click **Admin**, and then click **SharePoint**.    
3. On the Site Collections page, click to select the check box next to your public website link, and then click Rename Website.    
4. In the list, select **<your_domain>.sharepoint.com**, and then click **OK**.   
5. Wait 1 hour, and then try to remove the domain. Check back periodically. The process could take as long as 24 hours.   

## More information

For more information, see [You get an error message when you try to remove a domain from Office 365](https://docs.microsoft.com/office365/troubleshoot/administration/error-remove-domain-from-office-365).  

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
