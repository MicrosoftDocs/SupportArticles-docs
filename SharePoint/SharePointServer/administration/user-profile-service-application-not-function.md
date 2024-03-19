---
title: User Profile service application doesn't work
description: Provides a workaround for an issue in which the User Profile service application doesn't work. This issue occurs after a SharePoint farm is restored to a server by using the Central Administration website in SharePoint Server 2013.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Administration\Service Applications (except Search)
  - CSSTroubleshoot
ms.reviewer: vikkarti
appliesto: 
  - SharePoint Server 2013
search.appverid: MET150
ms.date: 12/17/2023
---
# User Profile service application doesn't function correctly after you restore a SharePoint farm

_Original KB number:_ &nbsp; 2752610

## Symptoms

Assume that you back up a Microsoft SharePoint farm and restore it to a different SharePoint server by using the Central Administration website in SharePoint Server 2013. When the restore process is complete, the User Profile service application doesn't function correctly.

Additionally, you receive the following error message in the properties of the User Profile service application:

> An unexpected error has occurred

## Cause

This is a known issue that occurs when you restore a SharePoint farm by using the Central Administration website.

## Workaround

To work around this issue, delete the current User Profile service application proxy, and then create a new proxy. To do this, run the following PowerShell commands:

- ```powershell
  $proxy = Get-SPServiceApplicationProxy | where {$_.typename -eq "User profile service application Proxy"}

  Remove-SPServiceApplicationProxy -Identity $proxy -confirmfalse
  ```

  This command deletes the current user profile service application proxy.

- ```powershell
  $upa = Get-SPServiceApplication | where {$_.name -eq "<name here>"}  

  New-SPProfileServiceApplicationProxy -Name<ProxyName> -Uri $upa.uri.absoluteURI
  ```

  This command creates a new user profile service application proxy.

> [!NOTE]
> After you create the new User Profile service application proxy, the My Site URL that's associated with the restored User Profile application may still point to the original server. This may cause issues when you try to browse to the My Site page. To resolve this issue, change the value in the My Site Host location field to reflect the new server name. To do this, follow these steps:
>
> 1. Verify that you are a member of the Farm Administrators group or a service application administrator for the User Profile service application.
> 2. On the Central Administration website, select **Manage service applications** under **Application Management**.
> 3. On the Manage Service applications page, select **User Profile Service Application** from the list of service applications.
> 4. On the ribbon, select **Manage**.
> 5. On the Manage Profile Service page, select **Setup My Sites** under **My Site Settings**.
> 6. On the My Site Settings page, change the value in the **My Site Host location** field to reflect the new server location.

## More information

For more information about how to restore a User Profile service application in SharePoint Server 2013 Preview, see [Restore User Profile Service applications in SharePoint Server](/SharePoint/administration/restore-a-user-profile-service-application).
