---
title: Network disconnection after configuring the LLTDIO and RSPNDR group policy objects
description: Helps resolve the issue in which the network disconnects after configuring the LLTDIO and RSPNDR group policy objects.
ms.date: 05/09/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, nitilton, brianoakes, v-lianna
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot, ikb2lmc
ms.subservice: group-policy
---
# Network disconnection after configuring the LLTDIO and RSPNDR group policy objects

This article helps resolve the issue in which the network disconnects after configuring the LLTDIO and RSPNDR group policy objects.

_Applies to:_ &nbsp; Windows Server  
_Original KB number:_ &nbsp; 4645933

After you configure the LLTDIO and RSPNDR group policy objects (GPOs) and set the `NoGPOListChanges` subkey value to apply group policies even if the objects haven't changed, your network is disconnected. This issue typically occurs after a group policy update. The disconnection may also cause the following issues:

- Virtual private network (VPN) dropping the connection
- Remote Desktop Protocol (RDP) session temporary disconnection
- File transfer disruption
- Windows Firewall dropping packets with un-quarantine filters enabled

This is a design limitation. The LLTDIO and RSPNDR-related policies are changed in the registry. To reapply the policies, the two protocols (the Mapper I/O network protocol and the Responder network protocol) need to re-bind on the network interface card (NIC). This action requires an automatic restart of the NIC, which leads to the disruption of the network connectivity.

## Modify and remove related policy settings

To resolve this issue, use one of the following two methods:

- In the Local Group Policy Editor, go to **Computer Configuration** > **Administrative Templates** > **System** > **Group Policy**, double-click the policy setting **Configure registry policy processing**, and uncheck the option **Process even if the Group Policy objects have not changed**.
- Go to **Computer Configuration** > **Administrative Templates** > **Network** > **Link-Layer Topology Discovery**, and set the state of the following policy settings to **Not configured**:

    - **Turn on Mapper I/O (LLTDIO) driver**
    - **Turn on Responder (RSPNDR) driver**
