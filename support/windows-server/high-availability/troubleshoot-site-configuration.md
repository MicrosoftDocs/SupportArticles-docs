---
title: Troubleshoot Site Configuration Issues
description: Describes how to troubleshoot site configuration issues.
ms.date: 12/05/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.author: jeffhugh
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:site configuration and high availability\site configuration issues
- pcy:WinComm Storage High Avail
---
# Troubleshoot site configuration issues 

## Summary

This article provides guidance on troubleshooting site configuration issues in Windows Server failover clustering. 

Site-aware configuration is essential for disaster recovery and high availability by enabling optimal distribution of resources and nodes across physical locations (*sites*). Misconfiguration or environmental issues can lead to problems including incorrect resource placement, dependency handling failures, connectivity issues, or impaired disaster recovery. You can use this article to identify and resolve common site configuration issues.

## Prerequisites

- Windows Server failover clustering is configured and operational.
- Admin privileges for both Active Directory and the cluster environment.
- Familiarity with tools like Failover Cluster Manager snap-in, PowerShell, and Active Directory Sites and Services.

## Potential workarounds

### Manually assign nodes to the correct site

1. Open PowerShell on the cluster node.
2. Specify the site for the node:

    ```powershell
    
    Set-ClusterFaultDomain -Name -Type Site -Location

    ```

3. Verify the assignment:

    ```powershell
    
    Get-ClusterFaultDomain

    ```

### Review and update Active Directory subnet mappings

1. Open Active Directory Sites and Services.
2. Confirm that subnets are correctly mapped to their respective sites.
3. Avoid overly broad subnet masks (like `/9`) and ensure precise subnet definitions.

## Troubleshooting checklist

### Check cluster site assignment

- Use Failover Cluster Manager or PowerShell to review site mappings for all nodes.
- Verify that subnet-to-site relationships are accurate and unambiguous.

### Check Active Directory subnets and sites

- Run the following command on each cluster node to verify the Active Directory site assignment:

    ```powershell
    
    nltest /dsgetsite

    ```

- Inspect Active Directory for duplicate or excessively broad subnet definitions.

### Review cluster configuration

Validate site and fault domain settings in Failover Cluster Manager or PowerShell.

### Check health and connectivity

- Confirm network communication between sites and nodes.
- Ensure firewall and network security rules allow cross-site traffic.

### Validate site-awareness in the cluster

- Check resource placement policies and dependency assignments.
- Review the placement of critical resources across sites.

### Update and review documentation

- Ensure all steps align with Microsoft recommendations for site-aware clusters.

## Cause: Incorrect automatic site assignment

### Solution: Manually assign sites and correct Active Directory subnets

1. Run the following command to manually assign nodes to fault domain sites:

    ```powershell
    
    Set-ClusterFaultDomain -Name -Type Site -Location

    ```

2. Review and correct Active Directory subnet definitions. Be sure to:

    - Remove overly broad subnets.
    - Define precise subnet masks, avoiding configurations that group multiple `/24` subnets under a single broad definition.

1. Confirm the changes:

    ```powershell
    
    Get-ClusterNode

    ```

4. Restart the cluster service to apply changes as needed.

## Cause: Inconsistent failover or resource placement

### Solution: Review fault domains and placement policies

1. Run the following command and verify fault domain configurations:

    ```powershell
    
    Get-ClusterFaultDomain

    ```

    - Ensure the nodes are correctly grouped under the appropriate sites.

2. Adjust the resource placement policies using PowerShell or Failover Cluster Manager with the following command:

    ```powershell
    
    Set-ClusterGroup -Name -PreferredOwner

    ``` 

3. Simulate failover to validate site-awareness:

    ```powershell

    Move-ClusterGroup -Name -Node

    ```

## Cause: Resource dependencies don't honor site assignment

### Solution: Configure and verify resource dependencies

1. Set dependencies in Failover Cluster Manager to align with site assignments.
2. Test cross-site storage and network connectivity for all resources.
3. Update resource metadata using PowerShell:

    ```powershell

    Set-ClusterResourceDependency -Resource -Dependency "[ResourceA] AND [ResourceB]"

    ```

## Cause: Cluster validation fails due to site assignment issues

### Solution: Update topology and rerun validation tests

1. Update Active Directory and cluster topology. Be sure to:    
    
    - Ensure each subnet is accurately mapped to a site.
    - Force Active Directory replication to ensure updates propagate across the environment.

1. Run the following command to perform cluster validation tests:

    ```powershell
    
    Test-Cluster

    ```

3. Resolve errors reported in the validation output and the rerun the tests to confirm all issues have been resolved.

### Commands for advanced troubleshooting and data collection

**View cluster fault domains**

```powershell
    
    Get-ClusterFaultDomain

```

**Manually assign sites**

```powershell
  
Set-ClusterFaultDomain -Name -Type Site -Location

```

**Verify Active Directory site assignment**

```powershell

    nltest /dsgetsite

```

**Generate cluster logs**

    ```powershell
    
    Get-ClusterLog -Node -TimeSpan

```

**Run cluster validation tests**

    ```powershell
    
    Test-Cluster

```

### Collect event logs

Use Event Viewer to export logs. Be sure to filter for FailoverClustering, System, and Application event logs.

### Common issues quick reference table

| Symptom | Likely cause | Resolution steps | Command or tool |
| --- | --- | --- | --- |
| Nodes assigned to the wrong site | Broad Active Directory subnet masks | Manually assign sites and review Active Directory subnet mapping | `Set-ClusterFaultDomain`, `nltest` |
| Resources don't failover to correct site | Misconfigured placement policies | Review fault domains and simulate failover | `Get-ClusterFaultDomain`, `Move-ClusterGroup` |
| Resource dependencies not honored by site | Dependency misconfiguration | Configure dependencies and verify resource locality | Failover Cluster Manager, `Set-ClusterResourceDependency` |
| Cluster validation errors on site or subnets | Incorrect Active Directory or subnet configuration | Update Active Directory topology and rerun validation tests | `Test-Cluster`, Active Directory Sites and Services |

## References

- [Fault domain awareness](https://learn.microsoft.com/en-us/windows-server/failover-clustering/fault-domains)