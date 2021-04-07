---
title: Error when you configure Microsoft Dynamics CRM for Office Outlook
description: This article provides a resolution for the problem that occurs when you attempt to configure Microsoft Dynamics CRM for Microsoft Office Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# "Error.AspNetInstallPath.Exception0" error when configuring Microsoft Dynamics CRM for Microsoft Office Outlook

This article helps you resolve the problem that occurs when you attempt to configure Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2016, Dynamics CRM 2015, Dynamics CRM 2013, Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 3183901

## Symptoms

When attempting to configure Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the following error:

> There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem persists, contact your system administrator.
>
> Error.AspNetInstallPath.Exception at Microsoft.Crm.Application.Outlook.Config.ConfigInfo.GetAspDotNetPath()
 at Microsoft.Crm.Application.Outlook.Config.GlobalRepositoryConfigurator.SetLaptopClientRegistryValues()
 at Microsoft.Crm.Application.Outlook.Config.GlobalRepositoryConfigurator.SetConfigurationRegistryValuesAction()
 at Microsoft.Crm.Application.Outlook.Config.GlobalRepositoryConfigurator.Configure(IProgressEventHandler progressEventHandler)
 at Microsoft.Crm.Application.Outlook.Config.ConfigEngine.Configure(Object stateInfo)

## Cause

This error can occur if there is a problem with your installation of the Microsoft .NET Framework.

## Resolution

- Option 1

  Download and run the [Microsoft .NET Framework Repair Tool](https://www.microsoft.com/download/details.aspx?id=30135).

- Option 2 (Windows 8 or later)

  Uninstall and reinstall the .NET Framework.

  > [!NOTE]
  > CRM 2013 for Outlook uses .NET Framework 4 or later. CRM 2015 for Outlook uses .NET Framework 4.5 or later. CRM 2016 for Outlook uses .NET Framework 4.5.2 or later.

  1. Access the **Control Panel** and then open **Uninstall a Program (Programs and Features)**.
  2. Click **Turn Windows features on or off**.
  3. Remove the selection of the .NET Framework and then click **OK**.
  4. Click **Close**.
  5. Click **Turn Windows features on or off**.
  6. Enable the .NET Framework and also the ASP.NET option below it.
  7. Click **OK**.

- Option 3 (Windows 7)

  Repair the .NET Framework within **Add/Remove Programs**.

  1. Access the **Control Panel** and then open **Uninstall a Program (Programs and Features)**.
  2. Select the Microsoft .NET Framework and then click **Uninstall/Change**.
  3. Select the **Repair** option and then click **Next**.
