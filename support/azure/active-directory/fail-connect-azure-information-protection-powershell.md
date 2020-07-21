---
title: Fail to connect to the Microsoft Azure Information Protection by using Windows PowerShell with error (The attempt to connect to the Windows Azure AD Rights Management
description: Describes an issue in which you can't connect to the Azure Information Protection by using Windows PowerShell in Office 365. Provides a resolution.
ms.date: 05/22/2020
ms.prod-support-area-path: 
ms.reviewer: willfid
---
# Unable to connect to Azure Information Protection using Windows PowerShell

> [!NOTE]
> Microsoft Azure Information Protection was previously known as Microsoft Azure Rights Management.

This article describes an issue in which you can't connect to the Azure Information Protection by using Windows PowerShell in Office 365. It provides a resolution.

_Original product version:_ &nbsp; Azure Active Directory, Azure Information Protection  
_Original KB number:_ &nbsp; 2797755

## Symptoms

When you try to connect to Microsoft Azure Information Protection by using Windows PowerShell in Microsoft Office 365, you get an error message that resembles the following:

> The attempt to connect to the Windows Azure AD Rights Management (Azure RMS) service for \<Organizational Account> failed. Verify that the user name and password you are using are correct and try again. If you have continued problems see `https://go.microsoft.com/fwlink/?linkid=251909`.  
The correlation ID is a3740c18-7bb2-4bb6-9025-8b5fc9468b09. Please note and provide this value if asked by support for it.  
Connect-AadrmService : The remote server returned an error: (401) Unauthorized.  
At line:1 char:1  
\+ Connect-AadrmService  
\+ ~~~~~~~~~~~~~~~~~~~~  
\+ CategoryInfo : InvalidOperation: (:) [Connect-AadrmService], WebException  
\+ FullyQualifiedErrorId : InvalidOperation,Microsoft.RightsManagementServices.Online.Admin.  PowerShell.ConnectAadrm  
ServiceCommand  

## Cause

This issue occurs if one or more of the following conditions are true:

- You entered the wrong user name or password.
- You aren't a company admin.
- You don't have a subscription that includes Azure Information Protection.
- The network is preventing you from connecting to Azure Information Protection.

## Resolution

> [!NOTE]
> If Azure Information Protection isn't enabled for your company, you use the Microsoft 365 admin center to enable it. For more info about how to do this, read [Azure Information Protection deployment roadmap](/azure/information-protection/deployment-roadmap).

To resolve this issue, make sure that the following are true:

- Make sure that you enter the correct user name and password. To check that, sign in to the [Office 365 portal](https://portal.office.com).
- You must be a global admin to connect to Azure Information Protection.
- To use Azure Information Protection, you must have a subscription that includes Azure Information Protection.
- Work with the network admin to make sure that the network meets the requirements for connecting to Azure Information Protection. The requirements are as follows:
  - Incoming and outgoing connections to `*.aadrm.com` are enabled.
  - Incoming and outgoing connections to `*.cloudapp.net` (`rmsoprod*-b-rms*.cloudapp.net`) are enabled.
  - Port 443 is open.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
