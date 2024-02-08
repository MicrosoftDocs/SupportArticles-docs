---
title: Active Directory installation fails
description: Fixes an error that occurs when you start Active Directory installation.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, nedpyle
ms.custom: sap:domain-join-issues, csstroubleshoot
---
# Active Directory installation stalls at the Creating the NTDS settings object stage

This article provides a solution to an issue where Active Directory installation fails with an error: Creating the NTDS Settings object for this Active Directory Domain Controller on the remote AD DC.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 2737935

## Symptoms

After you start Active Directory installation in Windows Server by using Server Manager or the `AddsDeployment` Windows PowerShell module, the installation stalls at the stage at which you receive the following message:

> Creating the NTDS Settings object for this Active Directory Domain Controller on the remote AD DC dc1-full.corp.contoso.com

Regardless of how long you wait, the installation never proceeds beyond this point. Additionally, when you examine the Directory Services event logs, you see the following repeated events:  

- **Event 1**  

    > Log Name: Directory Service  
    Source: Microsoft-Windows-ActiveDirectory_DomainService  
    Date: *\<DateTime>*  
    Event ID: **1963**  
    Task Category: DS RPC Client  
    Level: Error  
    Keywords: Classic  
    User: ANONYMOUS LOGON  
    Computer: dc2-full  
    Description:  
    Internal event: The following local directory service received an exception from a remote procedure call (RPC) connection. Extensive RPC information was requested. This is intermediate information and might not contain a possible cause.
    >
    > Process ID: 556
    > Reported error information:  
    Error value:  
    **Could not find the domain controller for this domain. (1908)**  
    directory service:  
    `dc1-full.corp.contoso.com`
    >
    > Extensive error information:  
    Error value:  
    **A security package specific error occurred. 1825**  
    directory service:  
    DC2-FULL
    >
    > Additional Data
    > Internal ID: 5000dfc

- **Event 2**

    > Log Name: Directory Service  
    Source: Microsoft-Windows-ActiveDirectory_DomainService  
    Date: *\<DateTime>*  
    Event ID: **1962**  
    Task Category: DS RPC Client  
    Level: Error  
    Keywords: Classic  
    User: ANONYMOUS LOGON  
    Computer: dc2-full  
    Description:  
    Internal event: The local directory service received an exception from a remote procedure call (RPC) connection. Extended error information is not available.
    >
    > directory service:  
    `dc1-full.corp.contoso.com`
    >
    > Additional Data  
      Error value:  
      Could not find the domain controller for this domain. (1908)

- **Event 3**

    > Log Name: Directory Service  
    Source: Microsoft-Windows-ActiveDirectory_DomainService  
    Date: *\<DateTime>*  
    Event ID: **1125**  
    Task Category: Setup  
    Level: Error  
    Keywords: Classic  
    User: ANONYMOUS LOGON  
    Computer: dc2-full  
    Description:  
    The Active Directory Domain Services Installation Wizard (Dcpromo) was unable to establish connection with the following domain controller.
    >
    > Domain controller:  
    `dc1-full.corp.contoso.com`
    >
    > Additional Data  
    Error value:  
    1908 Could not find the domain controller for this domain.

## Cause

This issue occurs for one or more of the following reasons:

- The server's built-in Administrator account has the same password as the built-in domain Administrator account.
- The NetBIOS domain prefix or UPN was not provided as credentials for installation. Instead, only the user name *Administrator* was provided.

## Resolution

To resolve this issue, follow these steps:

1. Restart the server on which Active Directory could not be installed.
2. Use Dsa.msc or Dsac.exe on an existing domain controller to delete the failed server's computer account. (The domain controller will not yet be a domain controller object but only a member server.) Then, let Active Directory replication converge.
3. On the failed server, forcibly remove the server from the domain by using the System Properties Control Panel item or netdom.exe.
4. On the failed server, remove the Active Directory Domain Services (AD DS) role by using Server Manager or `Uninstall-WindowsFeature`.
5. Restart the failed server.
6. Install the AD DS role, and then try the promotion again. When you do this, make sure that you provide promotion credentials in the form domain\user or user@domain.tld.

## More information

This is a code defect in Windows Server 2012 and late.

If you set different passwords on the two Administrator accounts but do not provide the domain, you receive a bad password error.

We do not recommend that you use the built-in Administrator for domain administration. Instead, we recommend that you create a new domain user for each administrator in the environment. Then, the actions of administrators can be audited individually.

We strongly discourage you from using matching Administrator passwords on member servers and the domain Administrator account. Local passwords are more easily compromised than AD DS accounts, and knowledge of the matching Administrator passwords grants full enterprise administrative access.
