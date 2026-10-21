---
title: Understand Root Cause Analysis for Azure VM reboots
description: Learn how to use Root Cause Analysis (RCA) in Resource Health to find out why your Azure VM rebooted. View engineering findings in the portal today.
ms.date: 10/20/2026
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: macla
ms.topic: troubleshooting
ms.service: azure-virtual-machines
ai-usage: ai-assisted
---
# Understand Root Cause Analysis for Azure VM reboots

## Summary

This article explains how to use Root Cause Analysis (RCA) in Azure Resource Health to understand and resolve unplanned Azure virtual machine (VM) reboots.

Azure provides RCA for unplanned Azure VM reboot events directly in the [Azure portal](https://portal.azure.com). This feature delivers detailed, actionable information about why a VM experienced an unplanned reboot without the need to contact Azure support.

## How RCA works

Previously, understanding the root cause of an unplanned VM reboot required filing an Azure support request and waiting for engineering analysis. By using RCA, you can view this information automatically in the Azure portal:

- **Root cause and resolution details** for each unplanned reboot event.
- **Engineering actions** taken or underway to address the underlying issue.
- **Event timeline** showing when the reboot occurred.

### Benefits

The following list highlights the key benefits of using RCA for unplanned Azure VM reboots:

- **Immediate answers** — No waiting for support ticket responses to understand why a reboot occurred.
- **Self-service** — Access root cause details directly in the portal without needing to contact support.
- **Transparency** — See what engineering actions are being taken to prevent future occurrences.

## Access RCA

The following steps outline how to access RCA for unplanned Azure VM reboots:

1. Go to your VM. In the [Azure portal](https://portal.azure.com), go to your VM resource.
1. Open **Resource Health**. In the menu, in the **Help** section, select **Resource Health**.
1. View **Health History**. Go to **Health History** to see past availability events.
1. Review RCA. Select an unplanned reboot event to view the detailed RCA, including root cause explanation and engineering actions.

:::image type="content" source="media/resource-health-rca/resource-health-show-rca.png" alt-text="Screenshot of Resource Health page showing expanded RCA entry with Root Cause, Resolution, and Additional Information fields." lightbox="media/resource-health-rca/resource-health-show-rca.png":::

### Information displayed

The following table summarizes the information displayed in the RCA for unplanned Azure VM reboots.

| Section | Description |
|----------|---------|
| Event summary | Date, time, and type of availability event. |
| Root cause | Specific technical cause of the unplanned reboot (for example, host OS issue, hardware failure, or network connectivity problems). |
| Impact| How your VM was affected. |
| Additional information | Engineering actions taken or planned to address the root cause and prevent recurrence. This information describes the remediation approach, not customer-specific mitigation steps. |

## Availability

RCA is available for standalone Azure VMs and for Virtual Machine Scale Sets using Flexible orchestration. For Flexible orchestration scale sets, RCA is surfaced at the individual instance level. RCA isn't currently available for Virtual Machine Scale Sets using Uniform orchestration. 

You can access RCA only through Resource Health in the Azure portal.

## RCA availability timing after a VM reboot

RCA isn't available immediately after a reboot event. The analysis requires engineering investigation, which varies by root cause complexity.

The following list outlines the typical timing for RCA availability:

- Most RCA entries appear within 24–72 hours of the event.
- Complex root causes involving hardware diagnostics or multicomponent analysis can take longer.
- RCA entries remain visible in your Health History for 30 days for review after they are published.

If no RCA appears for a particular event, it might mean the root cause wasn't positively identified, or the event didn't meet the criteria described in [Limitations](#limitations).

## How RCA differs from Resource Health annotations

When you go to Resource Health for your VM, you encounter two types of information: the RCA and the Resource Health annotations. The following sections explain the differences between them.

### Real-time Resource Health annotations

Resource Health annotations provide real-time visibility into events affecting your VM's availability as they happen. These annotations tell you what is happening to your VM (for example, a live migration or a host crash) and include attributes such as whether it was planned or unplanned, and the type of availability impact. Resource Health annotations appear automatically in the Resource Health timeline whenever the platform detects an availability-impacting event and are designed to keep you informed in the moment.

For a complete reference of all Resource Health annotations, their meanings, and troubleshooting guidance, see [Resource Health virtual machine Health Annotations](/azure/service-health/resource-health-vm-annotation).

### RCA

RCA is a separate, deeper analysis that appears *after* an unplanned downtime event occurs. While a Flash annotation tells you *what* happened in real time, an RCA tells you *why* it happened and provides the specific engineering root cause, the standard remediation steps the platform is designed to take for this type of failure, and what is being done to prevent recurrence.

RCA entries are labeled **"Root Cause Analysis (RCA) - \[Category\] - \[Cause\]"** (for example, *"Root Cause Analysis (RCA) - Software - Unhealthy Node"*) and appear as distinct items in your Health History.

## Comparison of RCA and Flash annotations

The following table summarizes the key differences between RCA and Flash annotations.

| Aspect | RCA |  Flash annotations  |
|----------|----------------|-------------------|
| Purpose| Post-incident root cause explanation | Real-time notification of availability events |
| Timing | Appears after engineering analysis is complete (typically 24–72 hours) | Appears as events occur |
| What it tells you | *Why* it happened and what's being done to prevent it | *What* happened and the type of impact |
| Scope | Unplanned downtime events and specific scenarios (see [Limitations](#limitations) for more details) | All availability events (planned, unplanned, customer-initiated) |

> [!NOTE]
> Look for entries specifically labeled **"Root Cause Analysis (RCA)"** in Health History. These entries contain the detailed engineering findings that are the focus of this guidance.

## Limitations

RCA is available for select unplanned downtime events. To ensure that every RCA delivered is accurate and actionable, Azure generates RCA only for events where the root cause is positively identified. Azure generates RCA for unplanned events that cause your VM to experience downtime. Events that the platform resolves without any VM downtime (for example, live migration and host maintenance) don't produce an RCA.

### Level of detail

The RCA experience is meant to provide the same level of root cause information that is available through Microsoft Support, enabling access to RCA details directly through the Azure portal. Due to obligations around security, privacy, and the protection of proprietary Microsoft information in a shared infrastructure environment, there are limits to the details that Azure can disclose. This ensures a consistent experience regardless of whether you review the RCA in the portal or engage Microsoft Support directly.

The following list describes factors that can affect the level of detail available in an RCA:

- **Timing of the investigation.** Events that are investigated very soon after impact can have limited detail. Root cause analysis is most accurate when sufficient time has passed for platform diagnostics to complete. For best results, allow at least 24 hours after the unexpected restart before reviewing the RCA.
- **Event initiation classification.** RCA confirms the event type but doesn't identify the specific user or operation that triggered the event. Certain customer-initiated operations, including force delete, fast attach or detach, and redeploy, can result in the underlying restart being classified as unplanned.

To confirm whether your VM experienced a downtime event, check the Health History section in Resource Health for any availability impact records during the relevant time window and Activity Logs.

## References

- [Azure Resource Health overview](/azure/service-health/resource-health-overview)
- [Resource health checks and resource types](/azure/service-health/resource-health-checks-resource-types)
- [Resource Health virtual machine Health Annotations - Azure Service Health \| Microsoft Learn](/azure/service-health/resource-health-vm-annotation)