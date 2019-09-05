---
title: Troubleshooting issues in SharePoint
description: Describes how to troubleshoot "Sorry there's a problem with the page you tried to view" issue in SharePoint.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
- SharePoint Server 2016
- SharePoint Server 2016 Central Administration
- SharePoint Foundation 2013
- SharePoint Server 2013 Enterprise
- SharePoint Server 2013 Central Admin
- SharePoint Foundation 2010
- SharePoint Server 2010
- SharePoint Online admin center
- SharePoint Online Small Business
---

# Troubleshooting issues in SharePoint

Sorry there's a problem with the page you tried to view.

## How to get help

If you know the person who manages the SharePoint site, contact them to make sure you have the correct permission. If you don't know who manages the site, check with your manager or supervisor, or contact your IT department.

Describe the problem you're experiencing, such as:

- **Problems uploading files.** The most common issues are inadequate permission and file size over the limit.
- **Problems when signing in** to your organization's network or getting access to certain data.
- **Errors with format or permission when entering data** into a line of business application such as a ledger or order form. Errors like this are problems with the page or application that is specifically written for your organization, so they can be fixed only by your organization's SharePoint administrator.

You may be asked to provide the following information to help administrators fix the problem:

- The date and time the error occurred.
- The page or site you were on when you got the error.
- The action you tried when you got the error.
- The correlation ID. This is a long hyphenated string on the error message, and is a key in helping administrators fix the problem.

## If you're a SharePoint administrator or developer ...

As a SharePoint administrator, or app developer for a SharePoint site, here are some suggestions for how to find a solution.

### If you host SharePoint on your own server (on-premises):

The Correlation ID or GUID that you get on an error or receive from an end user, is used with the Universal Logging System (ULS) logs to troubleshoot issues.

- [View diagnostic logs for SharePoint Server](https://docs.microsoft.com/SharePoint/administration/view-diagnostic-logs)

### If you're using SharePoint Online or Office 365:

For Office 365 and SharePoint Online you won't have access to the ULS logs. In this case you'll need to contact Microsoft for support. Support options are available here: [Contact support for business products - Admin Help](https://docs.microsoft.com/office365/admin/contact-support-for-business-products?redirectSourcePath=%252fen-us%252farticle%252fcontact-support-for-business-products-admin-help-32a17ca7-6fa0-4870-8a8d-e25ba4ccfd4b&view=o365-worldwide&tabs=phone)

Here are a few other resources to help you find solutions:

- If you're using Office 365, try the [Office 365 Troubleshooter](https://diagnostics.outlook.com/). This page helps you narrow down your search, and finds topics on Microsoft support and community websites.
- For SharePoint Online, you can search for your issue [Support Community](https://go.microsoft.com/fwlink/p/?LinkID=617897).
- The Microsoft Knowledge Base has a many articles on specific errors. Search the Microsoft Knowledge Base at [support.microsoft.com](https://support.microsoft.com).
- To identify and fix lags, hangs, and slow performance, see [Performance troubleshooting plan for Office 365](https://docs.microsoft.com/office365/enterprise/performance-troubleshooting-plan).
- If you are using Office 365 operated by 21Vianet in China, see [Contact support for business products - Admin Help](https://docs.microsoft.com/Office365/Admin/contact-support-for-business-products?view=o365-21vianet&tabs=phone).