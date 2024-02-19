---
title: Error (Target Principal Name is incorrect) when manually replicating data between domain controllers
description: Provides a solution to an error that occurs when you manually replicate data between domain controllers.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Error (Target Principal Name is incorrect) when manually replicating data between domain controllers

This article provides a solution to an error that occurs when you manually replicate data between domain controllers.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 288167

> [!NOTE]
> This article applies to Windows 2000. Support for Windows 2000 ends on July 13, 2010. The Windows 2000 End-of-Support Solution Center is a starting point for planning your migration strategy from Windows 2000. For more information, see the [Microsoft Support Lifecycle Policy](/lifecycle/).

## Symptoms

When you use the Active Directory Sites and Services snap-in to manually replicate data between Windows 2000 domain controllers, you may receive one of the following error messages:

> The Target Principal Name is incorrect

Or

> Access is denied

In addition, the following event ID messages may be logged in the system log:

```output
Event Source: Netlogon  
Event Category: None  
Event ID: 3210  
User: N/A  
Event Description:  
Failed to authenticate with \\DOMAINDC, a Windows NT domain controller for domain DOMAIN.
```

```output
Event Source: Netlogon  
Event ID: 5722  
Event Category: None  
User: N/A  
Event Description:  
The session setup from the computer 1 failed to authenticate. The name of the account referenced in the security database is 2. The following error occurred: n3
```

## Resolution

To resolve this issue, first determine which domain controller is the current primary domain controller (PDC) Emulator operations master role holder. To do this, use either of the following methods:

- Install the Netdom.exe utility from Windows 2000 Support Tools, and then run the following command:

    ```console
    netdom query fsmo
    ```

- Start the Active Directory Users and Computers snap-in, right-click the domain, and then click **Operations Masters**. Click the **PDC** tab; the current role holder is displayed in the **Operations Master** window. On this tab, you can change the operations master role to the current computer in the second window (if this computer is not the current holder).

- Use the Ntdsutil.exe utility (that is included in Windows 2000), and the Resource Kit command-line utility. However, these interfaces are recommended for more advanced users. For additional information, see [How to find servers that hold flexible single master operations roles](find-servers-holding-fsmo-role.md).

On domain controllers that are experiencing this issue, disable the Kerberos Key Distribution Center service (KDC):

1. Click **Start**, point to **Programs**, click **Administrative Tools**, and then click **Services**.
2. Double-click **KDC**, set the startup type to **Disabled**, and then restart the computer.

After the computer restarts, use the Netdom utility to reset the secure channels between these domain controllers and the PDC Emulator operations master role holder. To do so, run the following command from the domain controllers other than the PDC Emulator operations master role holder:

```console
netdom resetpwd /server: server_name /userd: domain_name \administrator /passwordd: administrator_password
```

Where **server_name** is the name of the server that is the PDC Emulator operations master role holder.

After you reset the secure channel, restart the domain controllers. Even if you attempt to reset the secure channel using the Netdom utility, and the command does not complete successfully, proceed with the restart process.

If only the PDC Emulator operations master role holder is running, the KDC forces the other domain controllers to resynchronize with this computer, instead of issuing themselves a new Kerberos ticket.

After the computers have finished restarting, start the Services program, restart the KDC service, and then attempt replication again.

## More information

If there are multiple domain controllers in the domain, the error message that you receive when this issue occurs varies depending on which way replication is being attempted, and if one of the domain controllers that is involved is also the PDC Emulator operations master role holder.

In some cases, when you use the `net view \\computername` to attempt to connect to the domain controller that has the PDC Emulator operations master role from another domain controller, you may receive an "Access denied" error message. However, if you use the Internet protocol (IP) address, the command may succeed.

When this problem occurs, numerous errors may be reported in the event logs. These errors vary depending on any of the following conditions:

- The domain controller was not fully functional before the problem occurred.
- The domain controller did not successfully completed the Active Directory Installation Wizard process.
- The Sysvol folder on the domain controller was not shared out.
- The domain controller did not have the full file structure under the **Domain_name** folder and the Policies folder that is located in %SystemRoot%\\Sysvol\\Sysvol\\**Domain_name**\\Policies. The following event is an example of an event that may be reported:

  ```output
  Event ID: 3034  
  Type: Warning  
  Source: MRxSmb  
  Description: The redirector was unable to initialize security context or query context attributes.
  ```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
