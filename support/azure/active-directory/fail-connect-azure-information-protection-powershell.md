---
title: Fail to connect to the Microsoft Azure Information Protection by using Windows PowerShell with error (The attempt to connect to the Windows Azure AD Rights Management
description: Describes an issue in which you can't connect to the Azure Information Protection by using Windows PowerShell in Office 365. Provides a resolution.
ms.date: 10/06/2020
ms.reviewer: willfid
ms.service: active-directory
ms.subservice: enterprise-users
---
# Unable to connect to Azure Information Protection using Windows PowerShell

> [!NOTE]
> Microsoft Azure Information Protection was previously known as Microsoft Azure Rights Management.

This article resolves an issue where you can't connect to the Azure Information Protection Service using Windows PowerShell in Office 365.

_Original product version:_ &nbsp; Azure Active Directory, Azure Information Protection  
_Original KB number:_ &nbsp; 2797755

## Symptoms

When you try to connect to Microsoft Azure Information Protection using Windows PowerShell in Microsoft Office 365, you get an error message that resembles the following:

> `PS C:\> Connect-AipService`
>
> `Connect-AipService : The attempt to connect to the Azure Information Protection service failed. Verify that the user name and password you are using are correct and try again. If you have continued problems, see http://go.microsoft.com/fwlink/?LinkId=251909.`
>
> `The correlation ID is 1df4c755-f859-4284-907b-be5d2a551260. Please note and provide this value if asked by support for it.`
>
> `At line:1 char:1`
>
> `+ Connect-AipService`
>
> `+ ~~~~~~~~~~~~~~~~~~`
>
> `+ CategoryInfo          : NotSpecified: (:) [Connect-AipService], ApplicationFailedException`
>
> `+ FullyQualifiedErrorId : NotSpecified,Microsoft.RightsManagementServices.Online.Admin.PowerShell.ConnectAipServiceCommand`

## Cause

This issue occurs if one or more of the following conditions are true:

- You entered the wrong user name or password.
- You aren't a company administrator.
- You don't have a subscription that includes Azure Information Protection.
- The network is preventing you from connecting to Azure Information Protection.

## Resolution

> [!NOTE]
> If Azure Information Protection isn't enabled for your company, you use the Microsoft 365 admin center to enable it. For more info about how to do this, read [Azure Information Protection deployment road map](/azure/information-protection/deployment-roadmap).

To resolve this issue, make sure that the following are true:

- Make sure that you enter the correct user name and password. To check that you entered them correctly, sign in to the [Office 365 portal](https://portal.office.com).
- You must be a global administrator to connect to Azure Information Protection.
- To use Azure Information Protection, you must have a subscription that includes Azure Information Protection.
- Work with the network administrator to make sure that the network meets [the requirements for connecting to Azure Information Protection](/azure/information-protection/requirements#firewalls-and-network-infrastructure). The requirements are as follows:
  - Incoming and outgoing connections to `*.aadrm.com` are enabled.
  - Incoming and outgoing connections to `*.cloudapp.net` (`rmsoprod*-b-rms*.cloudapp.net`) are enabled.
  - Port 443 is open.

## More information

For more information on Azure Information Protection, visit [AIPService](/powershell/module/aipservice/).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
