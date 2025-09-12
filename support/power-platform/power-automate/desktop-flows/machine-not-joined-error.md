---
title: Computer not joined Microsoft Entra or domain or MachineNotJoined
description: Solves errors that occur when you create a desktop flow connection using the connect with sign-in option in Microsoft Power Automate for desktop.
author: QuentinSele
ms.author: quseleba
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
ms.date: 10/09/2024
---
# Connection creation fails with "This computer has not joined Microsoft Entra or the domain" or "MachineNotJoined"

This article provides resolutions for errors that occur when you create a desktop flow connection using the [connect with sign-in](/power-automate/desktop-flows/desktop-flow-connections#connect-with-sign-in-for-attended-runs) option in Microsoft Power Automate for desktop.

## Symptoms

When you create a desktop flow connection using the [connect with sign-in](/power-automate/desktop-flows/desktop-flow-connections#connect-with-sign-in-for-attended-runs) option, the connection creation fails with one of the following errors:

> Failed to create OAuth connection: ClientError: Test connection failed.
> 
> Details: Connection failed: [Machine \<machineID>] This computer has not joined Microsoft Entra or the domain.


```json
 {
    "error":{
        "code": "MachineNotJoined",
        "message": "The machine is neither Microsoft Entra nor domain joined."  
    }    
  }
```

## Cause

Your machine isn't properly joined to either Microsoft Entra ID or an Active Directory (AD) domain, which is a [prerequisite](/power-automate/desktop-flows/desktop-flow-connections#prerequisites) to using the "connect with sign-in" feature.

## Resolution

#### Resolution 1: Join your device to Microsoft Entra ID

Microsoft Entra join can be accomplished using self-service options like the Windows Out of Box Experience (OOBE), bulk enrollment, or Windows Autopilot. For more information, see [Microsoft Entra joined devices](/entra/identity/devices/concept-directory-join).

#### Resolution 2: Use another connection option

If you can't join your device to Microsoft Entra ID, you can update your connections and select the option to [connect with username and password](/power-automate/desktop-flows/desktop-flow-connections#connect-with-username-and-password).

#### Resolution 3: Join your machine to an AD domain and synchronize the domain to Microsoft Entra ID

Join your machine to an AD domain and [synchronize the domain to Microsoft Entra ID](/entra/identity/hybrid/cloud-sync/how-to-configure#configure-provisioning).
