---
title: Users are redirected when browsing to a SharePoint or OneDrive site
description: Users are redirected in SharePoint with a warning message saying Access to Microsoft SharePoint Online is monitored.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sites\Other
  - CSSTroubleshoot
ms.collection: SPO_Content
ms.author: meerak
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "Access to Microsoft SharePoint Online is monitored" when browsing to a SharePoint site

## Symptoms

When users browse to a Microsoft SharePoint site or OneDrive site, they're redirected to the https://*tenant*-onmicrosoft.com.nas002.access-control.cas.ms/aad_login page. Additionally, they receive a warning message that resembles the following:

**Access to Microsoft SharePoint Online is monitored.**

**For improved security, your organization allows access to Microsoft SharePoint Online in monitor mode. Access is only available from a web browser. Continue to Microsoft SharePoint Online**

After they click the "Continue to Microsoft SharePoint Online" link, they're redirected again to a site that resembles the following:

https://*tenant*.sharepoint.com.us2.case.ms/sitepages/home.aspx

## Cause

This issue occurs if a Microsoft Defender for Cloud Apps policy applies to the user's session.

> [!NOTE]
> When you create a session policy, each user session that matches the policy is redirected to session control instead of to the app directly. For example, if the app returns a page that uses links whose domains end in *myapp.com*, Conditional Access Web App Control replaces the links with domains that end in something that resembles *myapp.com.us.cas.ms*. In this case, all the sessions are monitored by Microsoft Defender for Cloud Apps.

## Resolution

If you don't want to notify users that they're being monitored, you can disable the notification message. To do this, follow these steps:

1. Select the **Settings** icon (cog), and then select **General settings**.
1. Under **Conditional Access App Control**, select **User monitoring**, and then clear the **Notify users** check box.

To keep users within the session, Conditional Access Web App Control replaces all the relevant URLs, Java scripts, and cookies within the app session with Microsoft Defender for Cloud Apps URLs.

To disable monitoring, you have to browse to the Microsoft Defender for Cloud Apps page, select the activity log, and then search for the affected users. After you locate the policy, you can either disable the policy or remove the users from the group so that the policy no longer affects them.

## More information

For more information, see [Session policies](/cloud-app-security/session-policy-aad).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
