---
title: Error (Target Principal Name is incorrect) when manually replicating data between domain controllers
description: Provides a solution to an error that occurs when you manually replicate data between domain controllers.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# Error (Target Principal Name is incorrect) when manually replicating data between domain controllers

This article provides a solution to an error that occurs when you manually replicate data between domain controllers.

_Applies to:_ &nbsp; Supported versions of Windows Server  
_Original KB number:_ &nbsp; 288167

## Symptoms

When you use Repadmin.exe or the Active Directory Sites and Services snap-in to manually replicate data between domain controllers, you may receive one of the following error messages:

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

To resolve this issue, first determine which domain controller is the current primary domain controller (PDC) Emulator operations master role holder. To do this, run the following command from Elevated command prompt:

  ```console
  netdom query fsmo
  ```
  
On domain controllers that are experiencing this issue, stop the Kerberos Key Distribution Center service (KDC):

1. From Elevated command prompt, run **net stop KDC** 

Or from the Services Snap-in:

1. By running **Services.msc** and on the Serices Snap-in, Right-click on the **Kerberos Key Distribution Center** (**KDC) service and** click on **Stop**.
Purge the System Account Kerberos tickets by running **klist -li 0x3e7 purge** from the elevated command prompt.

Use the Netdom utility to reset the secure channels between these domain controllers and the PDC Emulator operations master role holder. To do so, run the following command from the effected domain controllers:

```console
netdom resetpwd /server:server_name /userd:domain_name\administrator /passwordd:administrator_password
```

Where **server_name** is the name of the server that is the PDC Emulator operations master role holder.

After you reset the secure channel, start the KDC service from the Services Snap-in or using the command **net start KDC**. 

Attempt replication again.

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
