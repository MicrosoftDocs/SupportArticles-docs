---
title: How to determine the version of CRM portals installed
description: Introduces how to determine the version of a Microsoft Dynamics 365 portal.
ms.reviewer: jbirnbau
ms.topic: troubleshooting
ms.date: 
---
# How to determine the version of a Microsoft Dynamics 365 portal

This article introduces how to determine the version of Microsoft Dynamics CRM portals installed.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2016  
_Original KB number:_ &nbsp; 3166126

## Summary

On September 28, 2015, Microsoft announced [Microsoft acquires Adxstudio Inc., Web portal and application lifecycle management solutions provider](https://blogs.microsoft.com/blog/2015/09/28/microsoft-acquires-adxstudio-inc-web-portal-and-application-lifecycle-management-solutions-provider/). Following the acquisition, Microsoft has continued to develop the portal application, releasing version 8.x as an optional portal add-on for Microsoft Dynamics CRM Online 2016 Update 1.

For upgrading and troubleshooting purposes, it is often very helpful to identify the specific version and build number of the portal that is currently installed within a Microsoft Dynamics CRM or Microsoft Dynamics 365 organization. The methods to identify the version of the currently installed portal are outlined below.

## Adxstudio portals legacy releases (version 7.x and Below)

- Navigate to the portal's **about** page.  By appending **/_services/about** without the quotes to the end of a portal's URL (for example, `https://yourportal.com/_services/about`), an **about** page can be reached that displays the portal version along with the validity of the currently installed license. This about page was added in the version 7.0.0007 release of Adxstudio Portals, so portals below this version will require one of the other two methods below.

  > [!NOTE]
  > If the about page is unreachable, it is possible that it may have been rendered inaccessible by the portal administrator. Contact the portal administrator for further assistance.

- Capture a diagnostic report using the diagnostic handler. By appending **/diag.axd** without the quotes to the end of a portal's URL (for example, `https://yourportal.com/diag.axd`) on the local web server, a diagnostics report will be generated that includes the portal version at the very top along with the versions of all related assemblies, Microsoft Dynamics CRM solution information, and other data. The diagnostic page was added in the version 5.x release of Adxstudio portals, so portals below this version would require the use of the final method below.

  > [!NOTE]
  > The diagnostic handler can only be reached through a browser on the local web server. If the diagnostic handler is still unreachable on the local web server, then it may have been removed from the portal website's web.config file. Contact the portal administrator if further assistance with accessing the handler is required.

- Check the Adxstudio.Xrm.dll assembly version. On the web server hosting the Adxstudio Portals data files, navigate to the **bin** folder underneath the portal website's physical path (the physical path within the site's advanced settings in IIS), right-click the Adxstudio.Xrm.dll file, choose **Properties**, and then select the **Details** tab. The **Product version** value here will indicate the version of the portal (for example, 7.0.0022).

## Microsoft Dynamics 365 portals releases (version 8.x and above)

- Navigate to the portal's **about** page. By appending **/_services/about** without the quotes to the end of a portal's URL (for example, `https://yourportal.com/_services/about`), an **about** page can be reached that displays the portal version along with the portal ID. If the logged-in user has been assigned a Web Role that is associated with a Website Access Permission record with all four permissions checked, then this page will display additional diagnostic information and provide a button to automatically clear the cache.
- Reference the instance's solutions within the Dynamics 365 Administration Center in Office 365. Sign in to Office 365 with a Global Administrator account, navigate to the Dynamics 365 Administration Center, select the **Instances** tab, and select the Dynamics 365 instance that is hosting the portal data. With the instance highlighted, select the **pencil** icon next to the **Solutions** heading in the panel to the right. On the solutions view, the value listed in the **Version** column next to any of the listed portal types (for example, Community Portal) that have a status of **Installed** is representative of the version of the portal installed.
