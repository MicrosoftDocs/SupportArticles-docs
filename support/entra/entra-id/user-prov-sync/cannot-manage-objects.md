---
title: Can't manage or remove objects that were synchronized through the Azure Active Directory Sync tool
description: Resolves an issue that you can't manage or remove objects created through directory synchronization from Microsoft Entra ID.
ms.date: 08/30/2021
ms.reviewer: 
ms.service: entra-id
ms.custom: sap:Microsoft Entra Connect Sync, no-azure-ad-ps-ref
---
# Can't manage or remove objects that were synchronized through the Azure Active Directory Sync tool

This article describes an issue that you can't manage or remove objects that were created through directory synchronization from Microsoft Entra ID. It provides two resolutions for this issue according to different reasons.

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2619062

## Symptoms

You try to manually manage or remove objects that were created through directory synchronization from Microsoft Entra ID:

For example, you want to remove an orphaned user account that was synced to Microsoft Entra ID from your on-premises Active Directory Domain Services (AD DS).

In this scenario, you can't remove the orphaned user account by using the Microsoft cloud service portal in Office 365, Azure, or Microsoft Intune, or by using Windows PowerShell.

## Cause

This issue may occur if one or more of the following conditions are true:

- The on-premises AD DS is no longer available. So you can't manage or delete the object from the on-premises environment.
- You deleted an object from the on-premises AD DS. However, the object wasn't deleted from your cloud service organization. This behavior is unexpected.

## Resolution

### The on-premises AD DS is no longer available. Therefore, you can't manage or delete the object from the on-premises environment

You want to manage objects in Office 365, Azure, or Intune and you no longer want to use directory synchronization.

1. Make sure that [Microsoft Graph PowerShell is installed](/powershell/microsoftgraph/installation).
2. Use the `Connect-MgGraph` command to sign in with the required scopes such as `Organization.ReadWrite.All`. For more information, see [Get started with the Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/get-started). 
1. Disable directory synchronization by running the [update-mgorganization](/powershell/module/microsoft.graph.identity.directorymanagement/update-mgorganization) command. 

    ```powershell
    
    $organizationId = (Get-MgOrganization).Id
    
    # Store the False value for the DirSyncEnabled Attribute
  $params = @{
  onPremisesSyncEnabled = $False
  }
 
      # Perform the update
  Update-MgOrganization -OrganizationId $organizationId -BodyParameter $params
    ```

1. Check that directory synchronization was fully disabled. To do it, run the following command:

    ```powershell
     Get-MgOrganization | Select OnPremisesSyncEnabled
    ```

    This command will return **True** or ***False**. Continue to run this command periodically until it returns **False**, and then go to the next step.

    It may take 72 hours for deactivation to be completed. The time depends on the number of objects that are in your cloud service subscription account.

1. Try to update an object by using Windows PowerShell or by using the cloud service portal.

     Step 4 may take a while to be completed. There's a process in the cloud service environment that computes attribute values. The process must be completed before the objects can be changed by using Windows PowerShell or by using the cloud service portal.

### You delete an object from an on-premises AD DS. However, the object isn't deleted from your cloud service subscription account

Force directory synchronization by using the steps on this article: [Start the Scheduler](/azure/active-directory/hybrid/how-to-connect-sync-feature-scheduler#start-the-scheduler)

- If some updates and deletions are propagated, but some deletions aren't synchronized to the cloud service, follow typical directory synchronization troubleshooting procedures.
- If all updates and deletions aren't synchronized to the cloud service, contact Support.

    > [!NOTE]
    > As an alternative resolution for this scenario, an object can be manually deleted in the cloud service. However, the object can't be updated in the cloud service. For more information about how to resolve this issue, see the following Microsoft Knowledge Base article: [Object deletions aren't synchronized to Microsoft Entra ID when using the Azure Active Directory Sync tool](https://support.microsoft.com/help/2709902).  

## More information

To re-enable directory synchronization, run the following command:

```powershell
Set-MsolDirSyncEnabled -EnableDirSync $true
```

It's important to plan carefully when you re-enable directory synchronization. If you used the cloud service portal or Windows PowerShell to make any changes directly to the objects that were originally synchronized from on-premises AD DS, the changes will be overwritten by on-premises attributes and settings the first time that synchronization occurs after directory synchronization is re-enabled.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
