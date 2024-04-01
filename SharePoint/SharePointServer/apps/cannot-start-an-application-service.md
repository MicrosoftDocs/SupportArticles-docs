---
title: You can't start the SharePoint Foundation Web Application service
description: Describes an issue in which the SharePoint Foundation Web Application service gets stuck during startup in SharePoint Server 2013 and 2010.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2013
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# You can't start the SharePoint Foundation Web Application service  

## Symptoms  

You can't start the SharePoint Foundation Web Application service in Microsoft SharePoint Server 2013 or Microsoft SharePoint Server 2010. The service gets stuck during startup, and the following error entry is logged in  the ULS logs:

```       
Provision of service failed. The process cannot access the file 'C:\inetpub\wwwroot\wss\VirtualDirectories\<web_app_name>\_app_bin\STSSOAP.DLL' because it is being used by another process. If this is a Web service, IIS must be restarted for the change to take effect. To restart IIS, open a command prompt window and type "iisreset /noforce".       
```

## Cause  

The issue occurs because of an antivirus scan.   

## Resolution  

> [!NOTE]
> When the SharePoint Foundation Web Application service is stopped, you may lose web.config changes and other customizations. We recommend that you back up the C:\inetpub\wwwroot\wss\VirtualDirectories folder before you apply this fix.

To resolve the issue, follow these steps:   

1. Follow the guidance in [KB 952167](https://support.microsoft.com/help/952167) to exclude certain folders from antivirus scanning.    
2. Run the following PowerShell commands to stop the SharePoint Foundation Web Application service:  

   ```  
   $service = Get-SPServiceInstance -Server $server | where-object {$_.TypeName -eq "Microsoft SharePoint Foundation Web Application"}  
   Stop-SPServiceInstance $service
   ```  

3. After the SharePoint Foundation Web Application service is stopped, check whether there are any remnants of SharePoint sites in IIS Manager, and delete any existing sites from IIS Manager.    
4. Clear the SharePoint configuration cache. For the steps to do this, see [this Developer article](/archive/blogs/josrod/clear-the-sharepoint-configuration-cache).    
5. Run the following command to provision the service:  

   ```  
   stsadm -o provisionservice -action start -servicetype spwebservice  
   ```    

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
