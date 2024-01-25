---
title: Users and groups can't be added to trusted forest
description: Describes an error that occurs when you try to add a user or a group from a trusted forest into a local domain group of a domain in a trusting forest.
ms.date: 11/10/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:domain-and-forest-trusts, csstroubleshoot
ms.subservice: windows-security
---
# RPC Endpoint Mapper client authentication prevents users and groups from being added to trusting forest

This article helps fix an error that occurs when you try to add a user or a group from a trusted forest into a local domain group of a domain in a trusting forest.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3073942

Enabling RPC Endpoint Mapper client authentication prevents security principals (that is, users and groups from trusted forests) from being added to a local domain group in the trusting forest. For information about other components and operations that are affected by enabling RPC Endpoint Mapper client authentication, see the following ASKDS blog post:  
[Restrictions for Unauthenticated RPC Clients: The group policy that punches your domain in the face](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/restrictions-for-unauthenticated-rpc-clients-the-group-policy/ba-p/399128)  

## Symptoms

Consider the following scenario:

- Domain controllers have Microsoft Remote Procedure Call (RPC) Endpoint Mapper client authentication enabled.
- You establish an Active Directory one-way, transitive forest trust between two Active Directory forests.
- You try to add a user or a group from the trusted forest into a local domain group of a domain in the trusting forest.

In this scenario, you receive the following error message:

>The Active Directory Domain Controllers required to find the selected objects in the following domains are not available:
>
>\<trusted-forest>
>
>Ensure the Active Directory Controllers are available, and try to select the objects again.

You receive this message as in the following screenshot:

:::image type="content" source="media/rpc-endpoint-mapper-prevents-users-added-to-trust-forest/error-message-dialog-box.png" alt-text="Screenshot of the Select Users, Computers, Service Accounts, or Groups window which shows the error message.":::

When you enable enhanced logging, the logging information that you receive does not provide any additional information except errors that state that domain controllers from the trusted forest are not available. Network monitoring traces do not provide additional details.

## Cause

When RPC Endpoint Mapper client authentication is enabled, unauthenticated RPC traffic from the trusted Active Directory forest is not accepted.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756)  in case problems occur.  

To resolve this issue, use one of the following methods.  

### Method 1

If settings were applied through Group Policy, change the following setting to "Disabled" through Group Policy on all domain controllers of the trusting Active Directory forest:

Computer Configuration -> Administrative Templates -> System -> Remote Procedure Call "RPC Endpoint Mapper Client Authentication"

> [!NOTE]
> Changing the setting to "Not Configured" will *not* remove the registry entries, and the problem will persist.

After you make this change, all domain controllers in the trusting forest must be restarted for the changes to take effect.

### Method 2

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.  

Remove the following registry entry from every domain controller in the trusting forest:

`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Rpc\RestrictRemoteClients`  
If it exists, also remove the following registry entry:

`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Rpc\EnableAuthEpResolution`  
Verify that Group Policy settings do not override these changes. All domain controllers in the trusting forest must be restarted after these settings are changed for the changes to take effect.  

## More information

Read the following blog about the problems that may result from enabling RPC Endpoint Mapper client authentication, especially on domain controllers:  
 [Restrictions for Unauthenticated RPC Clients: The group policy that punches your domain in the face](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/restrictions-for-unauthenticated-rpc-clients-the-group-policy/ba-p/399128)
