---
title: SharePoint 2013 - Disable WebDAV use on SharePoint
description: Describes that how to disable WebDAV use in SharePoint  .
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# How to disable WebDAV use in SharePoint  

## Summary  

In the event there is a cross site scripting attack using WebDAV by contributors to a site, a SharePoint administrator can protect their site by disabling all client integration.   

This is an extreme measure, since it will effectively block SharePoint from being a useful collaboration tool, and block all Office client interaction with SharePoint. As such it's meant only as a data protection mechanism until a more targeted remedy is available.    

## More Information  

To resolve this problem, disable the client integration. To do this, follow any of the following methods:

### Method 1  

1. Start SharePoint 2010 Central Administration | click Application Management | Manage Web applications.   
2. Select the web application for which you want to disable "Client Integration" and click on "Authentication providers" from the ribbon.   
3. Under Zone, Click Default to open the **Edit Authentication** page.   
4. Under Enable Client Integration, click No, and then click Save.     

### Method 2

Create a permission policy for the web application to set **UseRemoteAPIs** permission to **false**.

A permission policy level for a Web application contains permissions that enable a subset of users or groups to work with site collections in a specific way. For example, you might want to create a permission policy level for users of a site collection who will be allowed to add, edit, or delete items from a list, open a list, and view items, lists, and pages. However, you might want to prevent the same users from creating or deleting lists, which would require the Manage Lists permission.   

The permissions list contains a Grant All column and a Deny All column. You can either grant or deny all permissions as part of a permission policy level. You can also grant or deny individual permissions. No permissions are enabled by default.  

1. Start SharePoint 2010 Central Administration | click Application Management | Manage Web applications.   
2. Select the web application for which you want to create the permission policy click on "Permission Policy" from the ribbon.   
3. Click on **Add permission policy level**.   
4. To disable client integration, ensure that **Use Remote Interfaces - Use SOAP, Web DAV, or SharePoint Designer 2010 interfaces to access the Web site.** is set to **DENY**. Other permissions can be set at the discretion of the site collection administrator or site administrator.     

For more information, please the following articles:  

- [Manage permission policies for a Web application (SharePoint Foundation 2010)](/previous-versions/office/sharepoint-foundation-2010/ff607712(v=office.14))    
- [Manage permission policies for a Web application (SharePoint Server 2010)](/SharePoint/administration/manage-permission-policies-for-a-web-application)   
- [User permissions and permission levels (SharePoint Server 2010)](/SharePoint/sites/user-permissions-and-permission-levels)   
- [SPBasePermissions Enumeration](/previous-versions/office/sharepoint-server/ms412690(v=office.15))     

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
