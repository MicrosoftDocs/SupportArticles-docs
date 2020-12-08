---
title: SMB features don't work with non-default Cluster Network Name Configuration on Windows Server 2016, Windows Server 2012 R2 and Windows Server 2012
description: Describes an issue in which some SMB features don't work correctly together with non-default Cluster Network Name Configuration in Windows Server 2012 R2.
ms.date: 12/04/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: bhogen
---
# SMB features don't work with non-default Cluster Network Name Configuration on Windows Server 2016, Windows Server 2012 R2 and Windows Server 2012

_Original product version:_ &nbsp; Windows Server 2012 R2 Datacenter, Windows Server 2012 Datacenter  
_Original KB number:_ &nbsp; 4018013

## Symptoms

Consider the following scenario: 

- You're using a Windows Server 2012, Windows Server 2012 R2, or Windows Server 2016 cluster.
- You changed the **Properties** for the Cluster Network Name Resource so that the **DNSName** and **Name** Property are different than the **Name** of the Cluster Network Name Resource. For example, you run the following PowerShell cmdlet:

**Get-ClusterResource "ClusterNetworkNameResource" | Get-ClusterParameter** Object Name Value Type ------ ---- ----- ---- ClusterNetworkNameResource Name ServerNameX String ClusterNetworkNameResource DnsName ServerNameX String

- You create a file share in this cluster group with the **CA Feature** enabled. In this scenario, the CA Feature doesn't work correctly, and you receive the following event in the SMBWitnessClient log: 
Log Name: WitnessClientAdmin Source: Microsoft-Windows-SMBWitnessClient Event ID: 8 Level: Error Description: Witness Client failed to register with Witness Server for notification on NetName with error (The parameter is incorrect.) **Note** This event could also be logged with for a file share without the CA Feature enabled.

## Cause

This issue occurs because the SMB code expects the **Name** of the Cluster Network Name Resource and the property names of **DNSName** and **Name** to be identical.  

## Workaround

To work around this issue, you have to adjust the properties of the Cluster Network Name Resource to be identical to the **Name** of the Resource. 

## More information

The Purpose of the SMB Witness Service is to speed up the Detection of Cluster Node Failures. This SMB Witness Service is only active for clustered CA Shares. For Non-CA Shares the SMB Witness Service is not used. 
 If the Event ID 8 is logged and the Witness Client could not register for a Cluster Network Name / CA File Share then this is equal to if the SMB Witness Service is disabled. 
 A Cluster Node Failure is first found during the Cluster Service Health Checks and the SMB Witness Service also gets this Information immediately from the Cluster. 
 Next the SMB Clients are notified from the SMB Witness Service that they need to re-connect to the remaining Cluster Nodes. This Process is finished in a few Seconds. If the SMB Witness Service is not running then the SMB Client needs to rely on the TCP and SMB Timeouts. Depending on the Configuration this can take about 45-90 Seconds till the Client notices the Cluster Node Outage and re-connects to the remaining Cluster Nodes. In some special Configurations it can take multiple Minutes till the Cluster Node Outage is notified. 
 The SMB Witness Service is not necessarily needed to enable CA but it is recommended to have this Service running in Default Configurations as this speeds up the Detection of Node Failures. Nevertheless the CA Feature is fully supported with disabled SMB Witness Service. 

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
