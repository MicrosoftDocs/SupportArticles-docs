---
title: Can't enable the Device writeback option in Microsoft Entra Connect
description: Describes an issue in which you can't enable the Device writeback option in Microsoft Entra Connect. Provides a resolution.
ms.date: 07/06/2020
ms.reviewer: willfid
ms.service: active-directory
ms.subservice: enterprise-users
---
# Can't enable the Device writeback option in Microsoft Entra Connect

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Office 365 Identity Management, Microsoft Intune  
_Original KB number:_ &nbsp; 3085068

## Symptoms

When you run the Microsoft Entra Connect configuration wizard, you can't enable the **Device writeback**  option on the **Customize synchronization options** page.

## Cause

This issue can occur if one of the following conditions is true:

- Your Microsoft Entra organization isn't enabled for device writeback.
- One or more of the domain controllers that hold an operations master role (also known as a flexible single master operations or FSMO role) in your environment aren't replicating.

## Resolution

### Step 1: Troubleshoot FSMO role or replication issues

1. Run the `repadmin /showrepl` command to display a report that shows replication status. To do this, follow these steps:

   1. Open a command prompt as an administrator.
   2. Run the following command:

        ```console
        repadmin /showrepl * /csv > replication.csv
        ```

   3. Examine the Replication.csv file, and then troubleshoot and correct any errors.

2. Seize the FSMO role. In some instances, the server that holds an FMSO role may not be advertising itself correctly. Seizing itself may fix the issue. To do this, follow these steps:

   1. On a domain controller or a computer that has the Remote Server Administration Tools Pack installed, open a command prompt as an administrator.
   2. Run the following command:

        ```console
        netdom query FSMO
        ```

3. For each computer that's listed in the output, follow the steps in the "Seize FSMO roles" section of [Using Ntdsutil.exe to transfer or seize FSMO roles to a domain controller](https://support.microsoft.com/help/255504).

### Step 2: Enable the organization for device writeback

Follow these steps on the server on which Microsoft Entra Connect is installed:

1. Make sure that the Remote Server Administration Tools Pack is installed. For more information, see [Installing or Removing the Remote Server Administration Tools Pack](https://technet.microsoft.com/library/cc730825.aspx).
2. Open Active Directory Module for Windows PowerShell as an administrator. For more information, see [Active Directory Administration with Windows PowerShell](https://technet.microsoft.com/library/dd378937%28v=ws.10%29.aspx).
3. Go to `%ProgramFiles%\Microsoft Azure Active Directory Connect\AdPrep`, and then run the following commands:

    ```console
    Import-module .\AdSyncPrep.psm1
    ```

    ```console
    Initialize-ADSyncDeviceWriteBack -domainname <domain.com>
    ```

    In this command, the placeholder \<domain.com> represents your Active Directory domain. For example, run `Initialize-ADSyncDeviceWriteBack -domainname contoso.com`.

    You may have to run this command for each domain in your Active Directory environment.
4. When you're prompted, enter the enterprise administrator user name.
5. Open the Microsoft Entra Connect configuration wizard. You should now be able to enable device writeback.

## More information

On the server on which Microsoft Entra Connect is installed, review the logs in the following location:

`C:\Users\<UserAccount which AAD Connect was installed>\AppData\Local\AADConnect\trace-<DateTime>.log`

You may see an error message that resembles the following:

> [13:15:30.864] [ 18] [ERROR] ADPowerShellQueyProvider:SearchAdSyncDirectoryObjects Failed to run the ldap search query. Parameter values passed to PowerShell:  
ForestFqdn : \<Forest_Name>  
AdConnectorId : \<ID>  
PropertiesToRetrieve : msDS-DeviceLocation,name,displayName,distinguishedName,objectClass  
NamingContextType : Configuration  
BaseDnType : Relative  
AdConnectorUserName : \<Domain>\MSOL_d95558f154ee  
BaseDn : CN=Services  
LdapFilter : (objectClass=msDS-DeviceRegistrationService)  
SearchScope : Subtree  
Exception Details :  
System.Management.Automation.CmdletInvocationException: Error HRESULT E_FAIL has been returned from a call to a COM component. ---> System.Runtime.InteropServices.COMException: Error HRESULT E_FAIL has been returned from a call to a COM component. at MmsServerRCW.IMMSServer2.SearchADSyncDirectoryObjects(String forestFqdn, Guid& adConnectorGuid, String namingContextType, String baseDnType, String baseDn, String ldapFilter, String searchScope, String propertiesToLoad, String userName, String password, String& outputSerializedResult) at Microsoft.IdentityManagement.PowerShell.Cmdlet.AdSyncDirectorySearchResult.ProcessRecord()

You may also see the following event 2092 warning message logged in Event Viewer on the domain controller that's experiencing the issue:

> Event ID: 2092  
Task Category: Replicaiton  
Level: Warning  
Description:  
This server is the owner of the following FSMO role, but does not consider it valid. For the partition which contains the FSMO, this server has not replicated successfully with any of its partners since this server has been restarted. Replication errors are preventing validation of this role.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
