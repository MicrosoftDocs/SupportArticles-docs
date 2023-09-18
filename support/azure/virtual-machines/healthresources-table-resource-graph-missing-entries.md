---
title: HealthResources table in Resource Graph has missing entries
description: Understand how to react to a scenario in which the HealthResources table in Azure Resource Graph has missing entries.
ms.date: 06/07/2023
editor: v-jsitser
ms.reviewer: macla, pudesira, v-leedennis
ms.service: virtual-machines
ms.subservice: vm-health
---
# HealthResources table in Resource Graph has missing entries

This article discusses the possibility of missing virtual machine (VM) availability status or health annotations in the HealthResources and HealthResourceChanges tables in Microsoft Azure Resource Graph. The article also discusses how to react if this scenario occurs.

## Symptoms

In rare cases, you observe that a few entries are missing in the HealthResources table in Resource Graph.

## Cause

Although our monitoring service appropriately emits health data for the resources in question, the data might not contain the associated Resource identifier in the event metadata in certain cases. If this scenario occurs, this payload no longer meets the data emission specifications of Resource Graph. Therefore, the payload isn't registered.

Resource Graph requires that a Resource ID be attached to every incoming event payload for emission as an entry in the HealthResources table. We have implemented a fallback mechanism. However, this mechanism might not retrieve the associated Resource IDs in rare cases.

## Mitigation

This scenario is a known issue. We apologize for any inconvenience that occurs.

We're currently designing architectural changes across the Azure platform that allow us to receive and attach Resource IDs to every health report that's emitted to Resource Graph. This Resource ID handling is done reliably and at low latency. The improvement will reduce such cases of missing data in the future and build a more robust mechanism of health telemetry emission. We hope to test and deploy these changes in 2024.

Until a more permanent mitigation is available, we recommend that you select the **Resource health** or **Metrics** link in the VM resource's navigation pane to determine VM availability within the Azure portal.

## References

- [Reference: Monitoring Azure virtual machine data](/azure/virtual-machines/monitor-vm-reference)

- [Advancing Azure Virtual Machine availability monitoring (Project Flash)](https://azure.microsoft.com/blog/advancing-azure-virtual-machine-availability-monitoring-with-project-flash-update/)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
