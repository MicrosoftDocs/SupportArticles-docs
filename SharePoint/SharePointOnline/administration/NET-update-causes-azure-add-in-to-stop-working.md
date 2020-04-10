---
title: .NET update causes SharePoint provider-hosted add-in running on Azure to stop working
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 2/18/2020
audience: Admin
ms.topic: article
ms.service: sharepoint-online
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Online 
ms.custom: 
- CI 113694
- CSSTroubleshoot 
ms.reviewer: lucaband 
description: How to resolve an issue where a .NET update in SharePoint causes an add-in running on Azure to stop working. 
---

# A SharePoint provider-hosted add-in running on Azure stops working after a .NET update

*This article is based on a contribution from Westley Hall, an engineer on the SharePoint Developer Support team.*

## Symptoms

You find that an add-in stops working under the following conditions:
- You have a SharePoint provider-hosted add-in that's running on Azure web services.
- The add-in is hosted on a SharePoint page that's inside an app part (or a client web part or add-in) or an iframe.

## Cause

The problem is likely caused by a change in the default **SameSite** cookie property.

A recent .NET Framework update rollout reset the default **SameSite** property value on the ASP.NET_SessionId cookie to **Lax**. This change prevents the cookie from being sent to an iframe if the domain of the iframe is different than the domain of the host page. In a SharePoint provider-hosted web part add-in, the iframe will always be in a different domain.

For example, the session cookie resembles the following:

```
Set-Cookie: ASP.NET_SessionId=<xxxxxxxx>; path=/; HttpOnly; SameSite=Lax
```

> [!NOTE]
> In this example, \<xxxxxxx> is a random identifier of the session.

This session is typically used in the ASP.NET application to maintain the authentication. The page tries to redirect back to authenticate on the second attempt instead of using the session if there is a post or any AJAX call to the same app.

Sometimes, the Directory Service will generate a "405 Method Not Allowed" error.  This is because AJAX calls might trigger a **CORS OPTIONS** request, and SharePoint will reject such a request.

## Resolution

To resolve this issue, set the defaults in the web.config as follows in the system.web section:

```
<system.web>
    <httpCookies sameSite="None" requireSSL="true"/>
    <sessionState cookieSameSite="None" />
```

> [!NOTE]
> If **SameSite** is set to **None**, SharePoint does not force the requirement for the iframe and host to be in the same domain.

To update the **Web.config** file on the live instance of your Azure web app, follow these steps:
 
1.    Navigate to your web application settings in the Azure portal.
2.    Select **Advanced Tools**, and then select **Go**.<br/>
![Advanced Tools screen in the Azure portal.](media/NET-update-causes-azure-add-in-to-stop-working/NET-update-causes-azure-add-in-to-stop-working-1.png)
3.    In the Kudu screen, select **Debug console**, and then select **CMD**.<br/>
![Select CMD in the Debug console.](media/NET-update-causes-azure-add-in-to-stop-working/NET-update-causes-azure-add-in-to-stop-working-2.png)<br/>
![Search results. ](media/NET-update-causes-azure-add-in-to-stop-working/NET-update-causes-azure-add-in-to-stop-working-3.png)
4.    In the **File View** screen, enter the **CD site\wwwroot** command (shown in the lower red box in the next screenshot) to get the root directory of the web application. Then, press **Enter**.
    > [!NOTE]
    > The file list on the upper part of the page refreshes to show the **Web.config** file (you may have to scroll to see it). To edit the file, select the edit icon (the pencil, as shown in the red box in the  image below).
![To edit the file, select the pencil icon.](media/NET-update-causes-azure-add-in-to-stop-working/NET-update-causes-azure-add-in-to-stop-working-4.png)
5.    Add the **httpCookies** and **sessionState** cookie settings that are highlighted  in the next screenshot. If the **system.web** section is missing, add it so that it resembles the sample that's shown in the next screenshot.
![How the system.web section should look. ](media/NET-update-causes-azure-add-in-to-stop-working/NET-update-causes-azure-add-in-to-stop-working-5.png)
6.    Select **Save**.
7.    Verify that your add-in web parts are working as expected.
 
For future deployments, we recommend that you add this change to any source code projects that the web application was deployed from.

## More information
For more information about the .NET Framework update, see [Azure App Service—SameSite cookie handling and .NET Framework 4.7.2 patch](https://azure.microsoft.com/updates/app-service-samesite-cookie-update/). 

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
