---
title: FileNotFoundException occurs
description: Provides a solution to a FileNotFoundException that occurs when creating a Microsoft Dynamics CRM organization.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# FileNotFoundException occurs when creating a Microsoft Dynamics CRM organization

This article provides a solution to a FileNotFoundException that occurs when creating a Microsoft Dynamics CRM organization.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015  
_Original KB number:_ &nbsp; 3080984

## Symptoms

When attempting to create a new organization via the Microsoft Dynamics CRM 2015 Deployment Manager, you may receive the following error message:

> Exception occurred during Microsoft.Crm.Tools.Admin.OrganizationCreator: Error.ActionFailed Microsoft.Crm.Tools.Admin.ImportActivityFeedsAction  
InnerException:  
System.ServiceModel.FaultException`1[Microsoft.Xrm.Sdk.OrganizationServiceFault]: System.IO.FileNotFoundException: Microsoft Dynamics CRM has experienced an error. Reference number for administrators or support: #F80E2561 (Fault Detail is equal to Microsoft.Xrm.Sdk.OrganizationServiceFault).

It causes the creation of the Microsoft Dynamics CRM organization to fail.

## Cause

Windows Identity Foundation 3.5 may not be installed on the Windows Server hosting Microsoft Dynamics CRM.

## Resolution

Go through the following steps to add the Windows Identify Foundation 3.5 feature to the Microsoft Dynamics CRM Server:

> [!NOTE]
> These steps will require a reboot of the Windows Server once completed.

1. Open Windows Server Manager.
2. Select **Manage**.
3. Select **Add Roles and Features**.
4. Select **Next** on the **Before You Begin** window.
5. Choose the **Role-based or feature-based installation** option and select **Next**.
6. Select the wanted CRM server from the **Server Pool** window and select **Next**.
7. On the **Server Roles** window, select **Next**.
8. Under **Features** find and select the **Windows Identity Foundation 3.5 feature**.
9. Select **Next**.
10. Continue with the installation the Windows Identity Foundation 3.5 feature.
11. Restart the Windows Server.

## More information

After the installation fails, the following exception may be displayed in the Windows Event Viewer Application log. This exception indicates that a DLL (Dynamic-link library) related to the Windows Identify Foundation 3.5 feature can't be found.

> Exception type: ConfigurationErrorsException
>
> Exception message: Could not load file or assembly 'Microsoft.IdentityModel, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. The system cannot find the file specified. (\<installation drive>:\Program Files\Microsoft Dynamics CRM\CRMWeb\web.config line 29)
>
> at System.Web.Configuration.CompilationSection.LoadAssemblyHelper(String assemblyName, Boolean starDirective)
