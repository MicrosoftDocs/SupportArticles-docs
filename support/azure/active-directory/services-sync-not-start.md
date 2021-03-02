---
title: Azure Active Directory sync services don't start
description: Describes an issue that prevents Azure Active Directory synchronization services from starting. Provides a resolution.
ms.date: 05/12/2020
ms.prod-support-area-path: 
ms.reviewer: willfid
---
# One or more Azure Active Directory sync services don't start

This article describes an issue that prevents Azure Active Directory synchronization services from starting.

_Original product version:_ &nbsp; Azure Active Directory, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2995030

## Symptoms

You discover that one or more Azure Active Directory synchronization services don't start. For example, the Microsoft Azure AD Sync service or the Windows Azure Active Directory Synchronization Service doesn't start.

## Resolution 1: Make sure that the logon account is set to the directory synchronization service account  

**If you're using the Azure Active Directory Sync tool**:

1. Click **Start**, type services.msc in the search box, and then press Enter.
2. In the list of services, right-click **Microsoft Azure AD Sync**, and then click **Properties**.
3. Click the **Log On** tab.
4. Make sure that the account is set to the directory synchronization service account. For example: AAD_<*nnnnnnnnnnnn*> or MSOL_<*nnnnnnnnnnnn*>.
5. If the account isn't set to the directory synchronization service account, select the directory synchronization service account.

    The directory synchronization service account is located in the Users organizational unit (OU) of the forest domain. If this account is in another location, move it to the Users OU of the forest domain.

    > [!NOTE]
    > If the account does not exist, run the Azure Active Directory Sync tool Configuration Wizard.  

**If you're using Azure Active Directory Sync (AAD Sync) Services**:

1. Select **Start**, type services.msc in the search box, and then press Enter.
2. In the list of services, right-click **Windows Azure Active Directory Synchronization Service**, and then select **Properties**.
3. Select the **Log On** tab.
4. Make sure that the account is set to the directory synchronization service account. For example: AAD_<*nnnnnnnnnnnn*> or MSOL_<*nnnnnnnnnnnn*>.
5. If the account isn't set to the directory synchronization service account, select the directory synchronization service account.

    The directory synchronization service account is located in the Users OU of the forest domain. If this account is in another location, move it to the Users OU of the forest domain.

    > [!NOTE]
    > If the account doesn't exist, run the Azure Active Directory Synchronization tool Configuration Wizard.
6. Repeat steps 2-5 for the Forefront Identity Manager Synchronization Service.  

## Resolution 2: Make sure that the directory synchronization account is set to log on as a service in Group Policy

1. Select **Start**, type gpedit.msc in the search box, and then press Enter.
2. Expand **Computer Configuration**, expand **Window Settings**, expand **Security Settings**, expand **Local policies**, and then select **User rights assignment**.
3. Confirm that the directory synchronization service account is added to the following policies:
   - Log on as a service
   - Log on as batch job
   - Log on locally
4. If you made changes to the local policy, restart the computer to apply the changes.

## Resolution 3: Reinstall the directory synchronization appliance

If neither resolution 1 nor resolution 2 resolves the issue, remove and then reinstall the directory synchronization appliance.

For example, if you're using the Azure Active Directory Sync tool, remove and then reinstall it. Or, if you're using AAD Sync, remove and then reinstall it.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/Forums) website.
