---
title: Fix pending state issue with Directory synchronization for Microsoft 365, Azure, or Intune
description: Provides resolution to the pending state issue with directory synchronization for Microsoft 365, Azure, or Intune
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
ms.author: luche
ms.reviewer: ericta, andypunt, v-lanac
appliesto: 
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365 Identity Management
ms.date: 03/31/2022
---
# Fix pending state issue with Directory synchronization for Microsoft 365, Azure, or Intune


## Symptoms

You experience one of the following symptoms in a Microsoft cloud service such as Microsoft 365, Microsoft Azure, or Microsoft Intune:

- When you activate directory synchronization in the [Microsoft 365 admin center](https://admin.microsoft.com/#/dirsyncmanagement), the page indicates that directory synchronization is enabled. However, when you install the Azure Active Directory Sync tool and run the Configuration Wizard, you receive the following message:

    `Error 15: DirSync not activated`

    You then revisit the [Directory sync status](https://admin.microsoft.com/#/dirsyncmanagement) page to view the directory synchronization status. When you look under **3: Active Directory Synchronization** in the center pane, you see the following message:

    `Active Directory synchronization is being activated`

- When you deactivate directory synchronization on the [Directory sync status](https://admin.microsoft.com/#/dirsyncmanagement) page of the Microsoft 365 portal, the page indicates that directory synchronization is enabled.

    You then revisit the [Directory sync status](https://admin.microsoft.com/#/dirsyncmanagement) page to view the directory synchronization status. When you look under **3: Active Directory Synchronization** in the center pane, you see the following message:

    `Active Directory synchronization is being deactivated`


## Cause

This issue may occur if directory synchronization isn't completely activated or deactivated. It may take up to 72 hours for activation or deactivation to finish.

[!INCLUDE [Azure AD PowerShell deprecation note](../../../includes/aad-powershell-deprecation-note.md)]

To determine whether directory synchronization is activated or deactivated, follow these steps by using the Azure Active Directory module for Windows PowerShell:

1. Select **Start**, type **Azure Active Directory module for Windows PowerShell** in the search box, and then select **Azure Active Directory module for Windows PowerShell**.
1. Type the following cmdlets in the order in which they are presented. Make sure that you press Enter after you type each cmdlet.

    - `$cred = get-credential`

        > [!NOTE]
        > When you're prompted, enter your cloud service admin credentials.

    - `Connect-MSOLService -credential $cred`
    - `(Get-MSOLCompanyInformation).DirectorySynchronizationEnabled`

        > [!NOTE]
        > This cmdlet returns a value of  **True** or **False**. If it returns **True**, directory synchronization is activated. If it is **False**, directory synchronization is deactivated.

## Resolution

Wait until directory synchronization is activated or deactivated. Note the following:

- If you enabled directory synchronization for the first time, activation may require up to 24 hours.
- If you **re-enabled** directory synchronization, activation may require up to 72 hours. For more information, see [Can't manage or remove objects that were synchronized through the Azure Active Directory Sync tool](/troubleshoot/azure/active-directory/cannot-manage-objects).
- If you disabled directory synchronization, deactivation may require up to 72 hours.

If directory synchronization isn't activated or deactivated after the expected time, follow these steps, and then contact [Microsoft Support](https://support.microsoft.com/):

1. In the same Windows PowerShell console that you used in step 2 of the "Cause" section, type the following cmdlet, and then press Enter:

    `(Get-MSOLCompanyInformation).DirectorySynchronizationStatus`

    > [!NOTE]
    > If the output indicates **"PendingEnabled"** or **"PendingDisabled"** after the 24-hour or 72-hour waiting period ends, this is a known issue that affects Exchange Online.

1. Collect the following information from the Windows PowerShell connection:

    - **Context ID**: To collect the context ID, type the following cmdlet, and then press Enter:

        `(Get-MSOLCompanyInformation).objectID`

    - **Service instance**: To collect the service instance, type the following cmdlet, and then press Enter:

        `(Get-MSOLCompanyInformation).AuthorizedServiceInstances`

1. Contact [Microsoft Support](https://support.microsoft.com/).

## More information

For more information about how to enable directory synchronization in Microsoft 365, Azure, and Intune, see [Prepare for directory synchronization to Microsoft 365](/office365/enterprise/prepare-for-directory-synchronization).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/Forums/en-US/home?forum=windowsazuread) website.
