---
title: Rebuild a Microsoft Office Web Apps server farm easily
description: Describes how to rebuild Microsoft Office Web Apps server farm.
author: helenclu
ms.author: luche
ms.reviwer: brbering
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Office Web Apps
ms.date: 03/31/2022
---

# Rebuild a Microsoft Office Web Apps server farm easily

This article was written by [Tom Schauer](https://social.technet.microsoft.com/profile/Tom+Schauer+-+MSFT), Technical Specialist.

You can rebuild Microsoft Office Web Apps server farm with a few easy steps. To do this, follow these steps:

> [!NOTE]
>- Because there is a minimal configuration from an Office Web Apps perspective and zero data loss, there is little risk to rebuild an Office Web Apps farm.
>- These steps can be used for fixing technical issues with Office Web Apps.

1. Take the Microsoft Office Web Apps server farm offline if there is a load balancer.
1. Collect the current farm information through PowerShell by using the following command on a Microsoft Office Web Apps (WAC) Server(s):

   ```powershell
   Get-OfficeWebAppsFarm > c:\MyWACfarm.txt
   ```

   > [!NOTE]
   > Save this output because you will need it for later steps.

1. For a multi-server farm, remove each child machine from the farm, and then remove the parent machine by using PowerShell on WAC Servers.

   ```powershell
   Remove-OfficeWebAppsMachine
   ```

   To find which server is the Parent and which servers are the Child, review the farm output from step 2 and look toward at the bottom for "Machines" listed. The first server is your Parent server and the rest are Child servers. Run the following command on the Child servers first, and as soon as it is completed, run the command on the Parent server. This will delete the farm.

1. Reboot the Office Web Apps Servers.
1. Re-create the farm through PowerShell on WAC servers by using the parameter values from the command that we ran in step 2.

   ```powershell
   New-OfficeWebAppsFarm -InternalURL "http://WACServer.corp.contoso.com" -AllowHttp -EditingEnabled -OpenFromURLEnabled
   ```

1. Reunite the Child servers with the Parent server through PowerShell on the WAC server. To do this, run the following command on each Child server:

   ```powershell
   New-OfficeWebAppsMachine -MachineToJoin *ParentServer*
   ```

1. Put the farm back online if there is a load balancer.

   If you want to rebuild the bindings, run the following commands on SharePoint Servers through SharePoint PowerShell:

   ```powershell
   Remove-SPWOPIBinding –All:$true

   New-SPWOPIBinding –ServerName "WACServer.corp.contoso.com" -AllowHttp
   ```

To verify that your Microsoft Office Web Apps server farm was configured correctly, go to **https://servername/hosting/discovery** in a web browser.

If Office Web Apps server is working as expected, you should see a **Web Application Open Platform Interface Protocol (WOPI)-discovery** XML file in your web browser.

For example:

```xml
<?xml version="1.0" encoding="utf-8" ?>
- <wopi-discovery>
- <net-zone name="internal-http">
- <app name="Excel" favIconUrl="http://servername/x/_layouts/images/FavIcon_Excel.ico" checkLicense="true">
```

> [!NOTE]
> You need to replace **WACServer.corp.contoso.com** in previous steps with the correct information from your farm.

For more information about how to configure Microsoft Office Web Apps, see [Configure Office Online Server for SharePoint Server](https://technet.microsoft.com/library/ff431687).
