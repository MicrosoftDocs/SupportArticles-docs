---
title: Organization Preparation FAILED error
description: Resolves an error that occurs when you try to install Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: sidd, v-six
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
ms.date: 01/24/2024
---
# Error when you install Exchange Server: Organization Preparation FAILED

_Original KB number:_ &nbsp; 2872882

## Symptoms

When you try to install Microsoft Exchange Server, you receive the following error message:

> Configuring Microsoft Exchange Server
>
> Organization Preparation FAILED  
> The following error was generated when "$error.Clear(); install-ResourceConfig -DomainController $RoleDomainController" was run: "Active Directory operation failed on \<Domain Controller>. This error is not retriable. Additional information: The parameter is incorrect. Active directory response: 00000057: LdapErr: DSID-0C090D11, comment: Error in attribute > conversion operation, data 0, v23f0".The Exchange Server setup operation didn't complete. More details can be found in ExchangeSetup in the \<SystemDrive>:\ExchangeSetupLogs folder.

When you check the Exchange Setup log (ExchangeSetup.log), you see the following information:

> [Time] [2] Processing object "Resource Schema".  
> [Time] [2] The properties changed are: "{ Id='Resource Schema' }".  
> [Time] [2] Saving object "Resource Schema" of type "ResourceBookingConfig" and state "New".  
> [Time] [2] Previous operation run on domain controller 'dc.domain.com'.  
> [Time] [2] [ERROR] Active Directory operation failed on dc. domain.com. This error is not retriable. Additional information: The parameter is incorrect.  
> Active directory response: 00000057: LdapErr: DSID-0C090B38, comment: Error in attribute conversion operation, data 0, vece  
> [Time] [2] [ERROR] The requested attribute does not exist.

## Cause

This issue occurs because the **lDAPDisplayName** attribute is incorrect.

## Resolution

To resolve this issue, follow these steps:

1. Open Active Directory Service Interfaces (ADSI) Edit. To do this, click **Start**, click **Run**, type *ADSIEdit.msc*, and then click **OK**.
2. After the ADSI Edit window is loaded, right-click **ADSI Edit** in the navigation pane, and then click **Connect To**.
3. In the **Connection Settings** window, click **Select a well known Naming Context** in the **Connection Point** area, and then click **Schema**.
4. Expand the **Schema [DC.domain.com]** node, and then click **CN=Schema, CN=Configuration,DC=domain,DC=com**.
5. In the result pane, right-click **CN= ms-Exch-Resource-Schema**, click **Property**, and then change the value of the **lDAPDisplayName** attribute to **msExchResourceSchema**.
6. In the result pane, right-click **ms-Exch-Resource-Property-Schema**, click **Property**, and then change the value of the **lDAPDisplayName** attribute to **msExchResourcePropertySchema**.
7. Force Active Directory replication between the domain controllers.
8. Run the `Setup.exe /PrepareAD` command to install Exchange Server, this command must be run as Administrator in PowerShell or Command Prompt.
