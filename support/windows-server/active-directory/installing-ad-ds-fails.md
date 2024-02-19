---
title: Installing AD DS fails
description: Provides a solution to an issue where installing Active Directory Domain Services fails.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
---
# Installing Active Directory Domain Services Fails with Error "The specified user already exists."

This article provides a solution to an issue where installing Active Directory Domain Services fails with the error: The specified user already exists.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2000622

## Symptoms

When you attempt to install Active Directory Domain Services on a Windows Server computer, you may receive the following error:

> Error Joining Domain  
The operation failed because: The attempt to join this computer to the \<target DNS domain> failed. The specified user already exists.  

The %systemroot%\\debug\\DCPROMOUI.LOG contains the following text:

> dcpromoui  Enter ComposeFailureMessage  
dcpromoui  Enter GetErrorMessage 80070524  
dcpromoui  Enter State::GetOperationResultsMessage The attempt to join this computer to the \<target DNS domain> domain failed.  
dcpromoui  Enter State::GetOperationResultsFlags 0x0  
dcpromoui  Enter State::SetFailureMessage The operation failed because:  
The attempt to join this computer to the  \<target DNS domain> domain failed.  
"The specified user already exists."

## Cause

There is a computer account with the same name as the computer on which you are attempting to install Active Directory Domain Services.

## Resolution

1. If you are installing Active Directory Domain Services on a computer with the same name as a domain controller that previously existed in the domain, it is possible that metadata still remains.

    You can use one of the following methods to remove the metadata:

    - [Clean up server metadata](https://technet.microsoft.com/library/cc736378%28WS.10%29.aspx)
    - [216498](https://support.microsoft.com/kb/216498) How to remove data in Active Directory after an unsuccessful domain controller demotion

    For best results, remove the stale domain controller metadata on a domain controller in the same domain and site that the new domain controller is joining, or the helper domain controller specified in the Active Directory Installation Wizard or answer file.

2. If the Active Directory Installation Wizard continues to fail with error "The specified user already exists", review the %systemroot%\\debug\\DCPROMOUI.LOG to identify the name of the helper domain controller that the new domain controller is attempting to use.

    Sample output from DCPROMOUI.LOG:

    > dcpromoui          Enter DS::JoinDomain                                                  ← Search for this section of the %systemroot%\\debug\\dcpromoui.log  
    dcpromoui          Enter MassageUserName administrator  
    dcpromoui          contoso.com\\administrator  
    dcpromoui          Enter MyNetJoinDomain contoso.com\<helper DCs hostname>.contoso.com                     ← name of helper domain controller  
    dcpromoui          Calling NetJoinDomain  
    dcpromoui          lpServer         : (null)  
    dcpromoui          lpDomain         : contoso.com\<helper DCs hostname>.contoso.com  
    dcpromoui          lpAccountOU      : (null)  
    dcpromoui          lpAccount        : contoso.com\\administrator  
    dcpromoui          fJoinOptions : 0x27  
    dcpromoui          HRESULT = 0x80070524Error                ← 0x80070524 = 0x524 hex / 1316 decimal with symbolic error ERROR_USER_EXISTS  
    dcpromoui          HRESULT = 0x80070524

3. Verify that the helper domain controller identified in Step 2 has inbound replicated the removal of the conflicting domain controller machine account and NTDS Settings objects (metadata cleanup) performed in Step 1. If the domain controller machine account still exists, evaluate the possible reasons:

    - Replication latency such as a domain controller being several hops away from the domain controller originating the metadata cleanup.
    - Inbound replication failure on the helper domain controller.
    - The helper domain controller resides in a lag site that has been intentionally configured to inbound replicate changes in a delayed fashion.

4. For more information about other root causes for this error, click the following article number to view the articles in the Microsoft Knowledge Base:

    [938447](https://support.microsoft.com/kb/938447) You cannot add a user name or an object name that only differs by a character with a diacritic mark
