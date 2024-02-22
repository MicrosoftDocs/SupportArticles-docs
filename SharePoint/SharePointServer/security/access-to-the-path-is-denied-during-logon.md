---
title: Server Error in '/' Application. Access to the path is denied when you log on to Windows SharePoint Services 2.0
description: Describes how you receive an error message and you cannot log on to SharePoint Services installed on a domain controller by using a correct user name and password. To resolve this issue, you must configure the appropriate permissions ASP.NET.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto: 
  - Windows SharePoint Services 2.0
ms.date: 12/17/2023
---

# "Server Error in '/' Application. Access to the path  is denied" when you log on to Windows SharePoint Services 2.0  

## Symptoms  

Consider the following scenario:  

- You install IIS 6.0 and ASP.NET on a member server.   
- You use the Active Directory Installation Wizard (Dcpromo.exe) tool to install Active Directory.  
- You install Windows SharePoint Services 2.0 on the domain controller.  
- You try to log on to a Windows SharePoint Services 2.0 website.   
- You correctly type your user name and password three times.     

In this scenario, you may receive an error message that resembles the following:  

```
Error: Server Error in '/' Application.   

Access to the path "C:\WINDOWS\Microsoft.NET\Framework\v1.1.4322\Temporary ASP.NET Files\root\8c91a6b5\649b28ba" is denied.  
```

**Note** You may encounter similar symptoms when you access the following sites in Microsoft Windows Small Business Server 2003:Accessing Backup (http://servername/backup): Error: Server Error in '/Backup' Application Accessing Companyweb (http://companyweb):Error: Server Error in '/'ApplicationAccessing Monitoring and Reporting (http://servername/monitoring): Error: Server Error in '/Monitoring' ApplicationAccessing Remote Web Workplace (http://servername/remote):Error: Server Error in '/Remote' ApplicationDuring Installation (configadminvs.aspx):Access to the path C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\60\template\admin\1033\app_data is denied.  

## Cause  

This issue occurs  because the Network Service group does not have sufficient permissions to the Temporary ASP.NET Files folder when you install IIS 6.0 and ASP.NET before you install Active Directory.   

## Resolution  

To resolve this issue, follow the steps for the version of ASP.NET that you are running.
   
### ASP.NET 1.1  

1. Click Start, click Run, type cmd in the Open  box, and then click OK.   
2. Switch to the *Drive*:\Windows\Microsoft.Net\Framework\v1.1.4322 folder. In this folder, *Drive* is the drive where Windows is installed. To do this, type the following line at the command prompt, and then press Enter:
   ```
   cd **Drive**:\windows\microsoft.net\framework\v1.1.4322
   ```    
3. Add the appropriate permissions to the Network Service group for the Temporary ASP.NET Files folder. To do this, type the following line, and then press Enter:
   ```
   aspnet_regiis -ir
   ```
   **Note** For more information about the difference between the -ir  command-line option and the -i  command-line option, see [ASP.NET IIS Registration Tool](/previous-versions/dotnet/netframework-1.1/k6h9cz8h(v=vs.71)) on the Microsoft Developer Network (MSDN) website.    

4. Type exit, and then press Enter to close the command prompt.     

### ASP.NET 2.0  

1. Click Start, click Run, type cmd  in the Open  box, and then click OK.   
2. Switch to the *Drive*:\WINDOWS\Microsoft.NET\Framework\v2.0.50727 folder. In this folder, *Drive* is the drive where Windows is installed. To do this, type the following line at the command prompt, and then press Enter:
   ```
   cd **Drive**:\WINDOWS\Microsoft.NET\Framework\v2.0.50727
   ```    
3. Add the appropriate permissions to the Network Service group for the Temporary ASP.NET Files folder. To do this, type the following line, and then press Enter:
   ```
   aspnet_regiis -ir
   ```

   **Note** For more information about the difference between the -ir command-line option and the -i command-line, see [ASP.NET IIS Registration Tool](/previous-versions/dotnet/netframework-1.1/k6h9cz8h(v=vs.71)) on the Microsoft Developer Network (MSDN) website.      

## Workaround  

To prevent this issue from occurring, install Active Directory before you install IIS 6.0 and ASP.NET.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).