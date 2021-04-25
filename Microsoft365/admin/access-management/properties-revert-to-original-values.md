---
title: Properties changed revert to their original values
description: Describes an issue in which the properties of user accounts revert to the original values after Windows Server Essentials synchronization when Office 365 is integrated with Windows Server Essentials.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-administration
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-maqiu
appliesto:
- Azure Active Directory
- Office 365 Identity Management
- Windows Server 2012 Essentials
- Windows Server 2012 R2 Essentials
---

# Properties of Office 365 users revert to original values when running Windows Server Essentials

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## PROBLEM

Assume that you're running Windows Server 2012 Essentials or Windows Server 2012 R2 Essentials integrated with Microsoft Office 365. You change the properties of one or more Office 365 users by using the Office 365 portal. However, after the Windows Server Essentials directory integration process runs, the properties revert to their original values.

## CAUSE

After Windows Server Essentials is integrated with Office 365, Windows Server Essentials becomes the authoritative source for managing the cloud accounts. If you use the Office 365 portal to change the properties of an Office 365 user who is integrated with Windows Server Essentials, the changes revert to the original values after a Windows Server Essentials synchronization cycle.

## SOLUTION

Take one of the following actions:

- Use the Windows Server Essentials Dashboard or the Active Directory Users and Computers console to change the properties of users.

  To update the license, first name, or last name of a user who's integrated with Windows Server Essentials, you can use the Windows Server Essentials Dashboard. For any other user properties such as **Display Name**, use the Active Directory Users and Computers console. The changes that are made in the on-premises environment will be updated in the cloud after the next Windows Server Essentials synchronization cycle.

- Disable Office 365 integration in Windows Server Essentials.

  If you want to use the Office 365 portal to manage users, you should disable Office 365 integration in Windows Server Essentials. To do this, click **Disable the integration** under **Services** in the Windows Server Essentials Dashboard.

## MORE INFORMATION

For more information about Windows Server Essentials and Small Business Server, see the following resources:

[Windows Server Essentials and Small Business Server](https://techcommunity.microsoft.com/t5/Windows-Server-Essentials-and/bg-p/SBS/2014/01/01/how-to-create-a-service-integration-add-in-for-windows-server-essentials-experience)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.