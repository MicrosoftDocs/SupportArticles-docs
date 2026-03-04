---
title: Troubleshoot Site Configuration Issues
description: Describes how to troubleshoot site configuration issues.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-ryanberg, v-gsitser
ms.custom:
- sap:site configuration and high availability\site configuration issues
- pcy:WinComm Storage High Avail
- appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshoot site configuration issues 

## Summary

This article provides guidance for troubleshooting site configuration issues in Windows Server failover clustering. 

Site-aware configuration is essential for disaster recovery and high availability. The process enables optimal distribution of resources and nodes across physical locations (*sites*). Misconfiguration or environmental issues can create various problems, including incorrect resource placement, dependency handling failures, connectivity issues, and impaired disaster recovery. This article helps you to identify and resolve common site configuration issues.

## Prerequisites

- Windows Server failover clustering that's configured and operational
- Administrator privileges for both Active Directory and the cluster environment
- Familiarity with tools such as Failover Cluster Manager snap-in, PowerShell, and Active Directory Sites and Services

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
2. Verify that subnets are correctly mapped to their respective sites.
3. Avoid overly broad subnet masks (such as `/9`), and make sure that you use precise subnet definitions.

## Troubleshooting checklist

### Check cluster site assignment

- Use Failover Cluster Manager or PowerShell to review site mappings for all nodes.
- Verify that subnet-to-site relationships are accurate and unambiguous.

### Check Active Directory subnets and sites

- To verify the Active Directory site assignment, run the following command on each cluster node:

    ```powershell
    
    nltest /dsgetsite

    ```

- Inspect Active Directory for duplicate or excessively broad subnet definitions.

### Review cluster configuration

Verify site and fault domain settings in Failover Cluster Manager or PowerShell.

### Check health and connectivity

- Verify network communication between sites and nodes.
- Make sure that firewall and network security rules allow cross-site traffic.

### Verify site-awareness in the cluster

- Check resource placement policies and dependency assignments.
- Review the placement of critical resources across sites.

### Update and review documentation

- Make sure that all steps align with Microsoft recommendations for site-aware clusters.

## Cause: Incorrect automatic site assignment

### Solution: Manually assign sites and correct Active Directory subnets

1. Run the following command to manually assign nodes to fault domain sites:

    ```powershell
    
    Set-ClusterFaultDomain -Name -Type Site -Location

    ```

2. Review and correct Active Directory subnet definitions. Make sure that you:

    - Remove overly broad subnets.
    - Define precise subnet masks, avoiding configurations that group multiple `/24` subnets under a single broad definition.

1. Verify the changes:

    ```powershell
    
    Get-ClusterNode

    ```

4. To apply the changes, restart the cluster service as necessary.

## Cause: Inconsistent failover or resource placement

### Solution: Review fault domains and placement policies

1. Run the following command, and verify fault domain configurations:

    ```powershell
    
    Get-ClusterFaultDomain

    ```

    - Make sure that the nodes are correctly grouped under the appropriate sites.

2. Adjust the resource placement policies using PowerShell or Failover Cluster Manager. Run the following command:

    ```powershell
    
    Set-ClusterGroup -Name -PreferredOwner

    ``` 

3. To validate site-awareness, simulate failover:

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

## Cause: Cluster validation fails because of site assignment issues

### Solution: Update topology and rerun validation tests

1. Update Active Directory and cluster topology. Make sure that you:    
    
    - Verify that each subnet is accurately mapped to a site.
    - Force Active Directory replication to make sure that updates propagate across the environment.

1. To perform cluster validation tests, run the following command:

    ```powershell
    
    Test-Cluster

    ```

3. Resolve errors that are reported in the validation output, and then rerun the tests to verify that all issues are resolved.

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

Use Event Viewer to export logs. Be sure to filter for FailoverClustering, system event logs, and Application event logs.

### Common issues quick reference table

| Symptom | Likely cause | Resolution steps | Command or tool |
| --- | --- | --- | --- |
| Nodes assigned to the wrong site | Broad Active Directory subnet masks | Manually assign sites and review Active Directory subnet mapping | `Set-ClusterFaultDomain`, `nltest` |
| Resources don't fail over to correct site | Misconfigured placement policies | Review fault domains and simulate failover | `Get-ClusterFaultDomain`, `Move-ClusterGroup` |
| Resource dependencies not honored by site | Dependency misconfiguration | Configure dependencies and verify resource locality | Failover Cluster Manager, `Set-ClusterResourceDependency` |
| Cluster validation errors on site or subnets | Incorrect Active Directory or subnet configuration | Update Active Directory topology and rerun validation tests | `Test-Cluster`, Active Directory Sites and Services |

## References

- [Fault domain awareness](/windows-server/failover-clustering/fault-domains)
