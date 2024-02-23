---
title: Error after you accept an invite to a SharePoint
description: This article introduces that using relative URLs for content types across site collections is not supported.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "We're unable to complete your request" after you accept an invite to a SharePoint Online resource

## Problem

Consider the following scenario:

- You share a Microsoft SharePoint Online resource with an external user. During this process, you select the **Require sign-in** and **Send an email invitation** options.

- The external user receives the email invitation and then clicks the link to the shared resource.

- On the **Welcome to SharePoint Online** page, the external user clicks the **Create a Microsoft account, it's quick and easy!** link.

- The user finishes and submits the form to create a new Microsoft account.

In this scenario, the user receives the following error message:

```adoc
We're unable to complete your request.

Microsoft account is experiencing technical problems. Please try again later.
```

## Solution

To work around this issue, advise the user to use the new Microsoft account that's created to sign in to the site, as follows:

1. View the email invitation for the SharePoint Online resource, and then click the link to the shared content.

1. On the **Welcome to SharePoint Online** page, click the option to sign in with the Microsoft account.

1. Use the account that you created earlier (during the process that triggered the error message) to sign in to the site, and then access the shared resource.

> [!NOTE]
> Although the error occurs when you submit the form to create the new Microsoft account, the account is still created, and it can access the shared resource.

## More information

This is a known issue that occurs when an external user accepts an invitation to a SharePoint Online resource and then selects the option to create a new Microsoft account. 

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
