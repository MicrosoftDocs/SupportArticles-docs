---
title: SMB features don't work with non-default cluster network name configuration on Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012
description: Describes an issue in which some SMB features don't work correctly together with non-default cluster network name configuration in Windows Server 2012 R2.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, bhogen, v-jeffbo
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
---
# SMB features don't work with non-default cluster network name configuration on Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012

This article describes an issue in which some SMB features don't work correctly together with non-default cluster network name configuration in Windows Server 2012 R2.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4018013

## Symptoms

Consider the following scenario:

- You're using a Windows Server 2012, Windows Server 2012 R2, or Windows Server 2016 cluster.
- You changed the **Properties** for the cluster network name resource so that the **DNSName** and **Name** property are different than the **Name** of the cluster network name resource. For example, you run the following PowerShell cmdlet:

    ```powershell
    Get-ClusterResource "ClusterNetworkNameResource" | Get-ClusterParameter
    Object                          Name      Value            Type
    ------                          ----      -----            ----
    ClusterNetworkNameResource      Name      ServerNameX      String
    ClusterNetworkNameResource      DnsName   ServerNameX      String
    ```

- You create a file share in this cluster group with the **CA Feature** enabled.

In this scenario, the CA Feature doesn't work correctly, and you receive the following event in the SMBWitnessClient log:

> Log Name: WitnessClientAdmin  
Source: Microsoft-Windows-SMBWitnessClient  
Event ID: 8  
Level: Error  
Description:  
witness client failed to register with Witness Server for notification on NetName with error (The parameter is incorrect.)

> [!Note]
> This event could also be logged with for a file share without the CA feature enabled.

## Cause

This issue occurs because the SMB code expects the **Name** of the cluster network name resource and the property names of **DNSName** and **Name** to be identical.  

## Workaround

To work around this issue, you have to adjust the properties of the cluster network name resource to be identical to the **Name** of the resource.

## More information

The purpose of the SMB witness service is to speed up the detection of cluster node failures. This SMB witness service is only active for clustered CA shares. For Non-CA shares, the SMB witness service is not used.

If the Event ID 8 is logged and the witness client could not register for a cluster network name (CA file share), then this is equal to the SMB witness service is disabled.

A cluster node failure is first found during the cluster service health checks and the SMB witness service also gets this Information immediately from the cluster.

Next the SMB clients are notified from the SMB witness service that they need to reconnect to the remaining cluster nodes. This Process is finished in a few seconds. If the SMB witness service is not running, then the SMB client needs to rely on the TCP and SMB timeouts. Depending on the configuration, this can take about 45-90 Seconds until the client notices the cluster node outage and reconnects to the remaining cluster nodes. In some special configurations, it can take multiple minutes until the cluster node outage is notified.

The SMB witness service is not necessarily needed to enable CA but it is recommended to have this service running in default configurations as this speeds up the detection of node failures. Nevertheless the CA feature is fully supported with disabled SMB witness service.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
