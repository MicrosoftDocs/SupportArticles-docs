---
title: Event ID 4105 when RD Licensing runs
description: Event ID 4105 occurs on a computer running Remote Desktop Licensing (RD Licensing). This issue occurs in various scenarios for which resolutions are provided.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, briansi
ms.custom: sap:remote-desktop-services-terminal-services-licensing, csstroubleshoot
ms.subservice: rds
---
# Event ID 4105: The Terminal Services license server cannot update the license attributes for user \<UserName> in Active Directory Domain \<DomainName>

This article provides a solution to an event ID 4105 that occurs on a computer that's running Remote Desktop Licensing (RD Licensing).

_Applies to:_ &nbsp; Windows Server 2008 R2  
_Original KB number:_ &nbsp; 2030310

## Symptoms

You may see the following Warning event on a computer that is running RD Licensing, formerly Terminal Services Licensing (TS Licensing).

> Log Name: System  
Source: Microsoft-Windows-TerminalServices-Licensing  
Event ID : 4105  
Level: Warning  
User: N/A  
Computer: \<computer name>  
Description:  
The Terminal Services license server cannot update the license attributes for user \<user name> in the Active Directory Domain \<domain name>. Ensure that the computer account for the license server is a member of Terminal Server License Servers group in Active Directory domain \<domain name>.  
If the license server is installed on a domain controller, the Network Service account also needs to be a member of the Terminal Server License Servers group.  
If the license server is installed on a domain controller, after you have added the appropriate accounts to the Terminal Server License Servers group, you must restart the Terminal Services Licensing service to track or report the usage of TS Per User CALs.  
Win32 error code: 0x80070005

## Cause

The event ID 4105 may be logged for one of the following reasons:

1. The license server is not a member of the Terminal Server License Servers group in the domain in which the users reside.
2. The license server is installed on a domain controller, and the Network Service account is not a member of the Terminal Server License Servers group.
3. If the user accounts existed before the domain were upgraded to Windows Server 2003, the Terminal Server License Servers group might be missing in the discretionary access control list (DACL) of the user objects in Active Directory directory service. Or, the group is in the DACL, but the group does not have permissions to update the Terminal Services Licensing information for the user account.

## Resolution

Scenario 1: The licensing server is not added to the Terminal Server License Servers group for the domain in which the users are located

For more information about this scenario and its resolution, see [Event ID 4105 - Terminal Services Per User Client Access License Tracking and Reporting](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc775179(v=ws.10)).

Scenario 2: The Terminal Server License Servers group is present but does not have permissions to update the user's account attributes in Active Directory directory service

The Windows Server 2003 License server will only update the teminalServer attribute. Newer Terminal Server License Servers will try to update additional attributes when available. To accommodate that, the Windows Server 2008 schema update defines a property set used to grant permissions to all attributes required.

> [!IMPORTANT]
> Based on the User Interface language, the account names and Property Set names might differ.

### Method 1: Use dsacls.exe

Use dsacls.exe to add the permissions to add the read\write permissions to the terminalServer attribute or to the Terminal Server License Server property set of the user object by the Terminal Server License Servers group.

- Windows Server 2003 level Schema

    ```console
    dsacls "CN=XXXX,OU=XXXX,OU=XXXX,OU=XXXX,DC=XXXX,DC=XXXX,DC=XXX" /G
    "BUILTIN\Terminal Server License Servers:WPRP;terminalServer"
    ```

    When you grant the permissions on a container, you should use the following command:

    ```console
    dsacls "OU=XXXX,DC=XXXX,DC=XXXX,DC=XXX" /I:S /G
    "BUILTIN\Terminal Server License Servers:WPRP;terminalServer;user"
    ```

- Windows Server 2008 and newer Schema  

    ```console
    dsacls "CN=XXXX,OU=XXXX,OU=XXXX,OU=XXXX,DC=XXXX,DC=XXXX,DC=XXX" /G
    "BUILTIN\Terminal Server License Servers:WPRP;Terminal Server License Server"
    ```

    When you grant the permissions on a container, you should use the following command:

    ```console
    dsacls "OU=XXXX,DC=XXXX,DC=XXXX,DC=XXX" /I:S /G
    "BUILTIN\Terminal Server License Servers:WPRP;Terminal Server License Server;user"
    ```

### Method 2: Use the Delegate Control Wizard

Use the Delegate Control Wizard to add the permissions to add read\write permissions to the terminalServer attribute or to the Terminal Server License Server attribute of the user object by the Terminal Server License Servers group. To do this, follow these steps:

1. Right-click the domain in Active Directory Users and Computers, and then click **Delegate Control**.
2. In the **Users and Groups** dialog box, click **Add**. Type *Terminal Server License Servers*, and then click **OK**. In the **Users and Groups** dialog box, click **Next**.
3. In the **Tasks to Delegate** dialog box, click **Create a custom task to delegate**, and then click **Next**.
4. In the **Active Directory Object Type** dialog box, click **Only the following objects in the folder**. In the list, click **User objects** (the last entry that is in the list), and then click **Next**.
5. For forests that are running Windows Server 2008 or newer Schema, in the **Permissions** dialog box, make sure that only the **General** check box is selected. In the **Permissions** list, click to select the **Read and Write Terminal Server license server** check box, and then click **Next**.
6. In the **Completing the Delegation of Control Wizard** dialog box, click **Finish**.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#terminal-server-licensing).
