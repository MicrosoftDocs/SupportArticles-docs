---
title: Connection creation fails with MissingOnPremSidForMachineDomainJoined
description: Solves an error that occurs when you create a desktop flow connection using the connect with sign-in option in Microsoft Power Automate for desktop.
author: QuentinSele
ms.author: quseleba
ms.date: 10/09/2024
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
---
# Connection creation fails with "MissingOnPremSidForMachineDomainJoined"

This article provides resolutions for the "MissingOnPremSidForMachineDomainJoined" error code that occurs when you create a desktop flow connection using the [connect with sign-in](/power-automate/desktop-flows/desktop-flow-connections#connect-with-sign-in-for-attended-runs) option in Microsoft Power Automate for desktop.

## Symptoms

When you create a desktop flow connection using the [connect with sign-in](/power-automate/desktop-flows/desktop-flow-connections#connect-with-sign-in-for-attended-runs) option, the connection creation fails with the following error:

```json
{
    "error":{
        "code": "MissingOnPremSidForMachineDomainJoined",
        "message": "Could not map connection MSEntraID to AD user on the target domain-joined machine. Please check with your domain admin that onpremisesSecurityIdentifier is synced with MSEntra."  
    }    
}
```

## Cause

You use an Active Directory (AD) domain-joined machine and the synchronization between the domain controller and Microsoft Entra ID isn't properly done. When you use an AD domain-joined machine, this synchronization is a [prerequisite](/power-automate/desktop-flows/desktop-flow-connections#prerequisites) to using sign-in connections for desktop flows.

## Resolution

#### Resolution 1: Contact your administrator

Check with your administrator if the domain controller properly synchronizes the domain identities with Microsoft Entra ID.

#### Resolution 2: Use another connection option

If you can't join your device to Microsoft Entra ID, you can update your connections and select the option to [connect with username and password](/power-automate/desktop-flows/desktop-flow-connections#connect-with-username-and-password).

## More information

[Integrate on-premises Active Directory domains with Microsoft Entra ID](/azure/architecture/reference-architectures/identity/azure-ad)
