---
title: Troubleshoot autoscale issues in Azure Virtual Desktop
description: Troubleshoot common autoscale issues for pooled host pools in Azure Virtual Desktop, including session consolidation behavior, scale-down expectations, and session host recovery after hibernate.
author: azarjindal007
ms.author: azarj
ms.service: azure-virtual-desktop
ms.topic: troubleshooting
ms.date: 04/14/2026
---

# Troubleshoot autoscale issues in Azure Virtual Desktop

This article helps you diagnose and fix common autoscale issues in Azure Virtual Desktop (AVD) pooled host pools.

The guidance applies to both autoscale methods:

- Power Management Autoscaling (generally available): powers session hosts on and off.
- Dynamic Autoscaling (preview): powers on/off and can create/delete session hosts.

For both methods, session consolidation and capacity calculations use the same logic.

## Table of contents

- [Troubleshoot autoscale issues in Azure Virtual Desktop](#troubleshoot-autoscale-issues-in-azure-virtual-desktop)
  - [Table of contents](#table-of-contents)
  - [Before you troubleshoot](#before-you-troubleshoot)
  - [How autoscale decides minimum running hosts](#how-autoscale-decides-minimum-running-hosts)
  - [Common issues and resolutions](#common-issues-and-resolutions)
  - [Issue 1: Hosts remain running with only disconnected sessions](#issue-1-hosts-remain-running-with-only-disconnected-sessions)
    - [Symptoms](#symptoms)
    - [Why this happens](#why-this-happens)
    - [How to verify](#how-to-verify)
    - [Recommended fix](#recommended-fix)
  - [Issue 2: "Force sign out users" does not immediately deallocate all hosts](#issue-2-force-sign-out-users-does-not-immediately-deallocate-all-hosts)
    - [Symptoms](#symptoms-1)
    - [Why this happens](#why-this-happens-1)
    - [How to verify](#how-to-verify-1)
    - [Recommended fix](#recommended-fix-1)
  - [Issue 3: Session hosts fail to become available after hibernate resume](#issue-3-session-hosts-fail-to-become-available-after-hibernate-resume)
    - [Symptoms](#symptoms-2)
    - [Known limitation](#known-limitation)
    - [How to verify](#how-to-verify-2)
    - [Immediate mitigation](#immediate-mitigation)
  - [Issue 4: Scale-down behavior differs from expectation across host pools](#issue-4-scale-down-behavior-differs-from-expectation-across-host-pools)
    - [Symptoms](#symptoms-3)
    - [Why this happens](#why-this-happens-2)
    - [How to verify](#how-to-verify-3)
    - [Recommended fix](#recommended-fix-2)
  - [Troubleshooting workflow](#troubleshooting-workflow)
  - [Data to capture before escalation](#data-to-capture-before-escalation)
  - [Related content](#related-content)

## Before you troubleshoot

Confirm the following on your host pool and scaling plan:

- A scaling plan is assigned to the target host pool.
- Ramp-up, peak, ramp-down, and off-peak schedules are configured as intended.
- **Minimum percentage of active hosts** and **capacity threshold** values are aligned with your expected scale-down behavior.
- If your goal is zero hosts after hours, your disconnected-session policy is configured (see Issue 1).
- The **Desktop Virtualization Power On Off Contributor** role is assigned to the Azure Virtual Desktop autoscale service principal at the host pool, resource group, or subscription scope. Without this role, autoscale can't start, stop, or deallocate session hosts.

## How autoscale decides minimum running hosts

During ramp-down/off-peak, autoscale keeps enough hosts running for current user sessions.

Required hosts are calculated as:

$$
\text{Required Hosts} = \left\lceil \frac{\text{Total User Sessions}}{\text{Max Session Limit} \times \text{Capacity Threshold}} \right\rceil
$$

Where:

- Total User Sessions includes connected and disconnected sessions.
- Capacity Threshold is expressed as a decimal in the formula (for example, 90% = 0.9). You can find this value in the scaling plan schedule under the ramp-down or off-peak phase configuration.

Example:

- 9 disconnected users
- Max session limit = 5
- Capacity threshold = 90%

$$
\text{Required Hosts} = \left\lceil \frac{9}{5 \times 0.9} \right\rceil = \left\lceil 2 \right\rceil = 2
$$

In this example, autoscale keeps 2 hosts running for possible user reconnections.

Autoscale determines the actual minimum host count during ramp-down and off-peak by using the higher of two values:

- The formula result based on current sessions
- The **Minimum percentage of active hosts** setting in your scaling plan phase

If your minimum percentage setting yields a higher number than the formula result, that setting takes precedence. This minimum percentage setting is a common reason hosts remain running even when the formula suggests a lower count.

## Common issues and resolutions

## Issue 1: Hosts remain running with only disconnected sessions

### Symptoms

- Scale-down doesn't reach zero hosts after hours.
- Hosts remain running even when no users appear actively connected.
- You enabled **Stop VMs when VMs have no active sessions**, but still see running hosts.

### Why this happens

Disconnected sessions are treated as active for capacity protection. Autoscale assumes disconnected users might reconnect quickly and keeps enough host capacity available.

### How to verify

- Review session state in the host pool for disconnected users.
- Check scaling plan settings:
  - Stop behavior during ramp-down.
  - Minimum percentage of active hosts.
  - Capacity threshold.
- To calculate expected required hosts, use the formula in the preceding section.

### Recommended fix

To reach zero hosts after hours:

1. Configure Group Policy (GPO) to sign out disconnected sessions after a timeout.
2. Set minimum active hosts to 0% during off-peak when appropriate.
3. Ensure disconnected-session timeout completes before ramp-down/off-peak end.

Group Policy path:

**Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Session Time Limits** > **Set time limit for disconnected sessions**

> [!NOTE]
> In domain-joined environments, apply this setting via a GPO linked to the OU containing your session hosts, not via Local Computer Policy on individual hosts.

## Issue 2: Force sign-out doesn't immediately deallocate all hosts

### Symptoms

- You enabled force sign-out, but scale-down still appears gradual.
- Hosts remain running for part of the ramp-down window.

### Why this happens

Force sign-out applies after the configured wait time. Before that point, autoscale still performs consolidation calculations and maintains required capacity. This delay means hosts don't deallocate immediately.

### How to verify

- Confirm force sign-out wait time in scaling plan.
- Compare timestamp of ramp-down start vs observed deallocation events.
- Validate whether users disconnected/signed out before wait-time expiry.

### Recommended fix

- Reduce wait time only if it doesn't harm user experience.
- Combine force sign-out with disconnected-session timeout policy.
- Re-test over one full ramp-down cycle.

## Issue 3: Session hosts fail to become available after hibernate resume

### Symptoms

- Autoscale resume action succeeds at compute layer.
- Session hosts remain unavailable or unhealthy for user connections.
- Session hosts don't recover until after reboot/deallocation or agent recovery action.

### Known limitation

When a session host resumes from hibernate, the Remote Desktop (RD) Agent can fail to re-register with the AVD control plane. If the **RDAgentBootLoader** and **RDAgent** Windows services don't reach a **Running** state within approximately 5 minutes of the VM resuming, the session host remains unavailable in the host pool.

### How to verify

- Confirm VM power state transitions in Activity Log.
- Check host pool session host status changes around resume time.
- Collect diagnostics for RD Agent and bootloader/service startup timing.
- Compare behavior when using deallocate instead of hibernate.

### Immediate mitigation

- Prefer Stop (deallocate) behavior if hibernate resume is unstable in your environment.
- Re-register/restart affected session host agents if needed.
- Keep this on an engineering investigation track when repeatable patterns are observed.

## Issue 4: Scale-down behavior differs from expectation across host pools

### Symptoms

- Two host pools with similar schedules produce different scale-down outcomes.
- One pool reaches lower host counts while another does not.

### Why this happens

Differences in one or more of the following often explain divergence:

- Max session limit per host pool.
- Capacity threshold.
- Session mix (connected vs disconnected).
- Minimum active host percentage.
- User sign-out/disconnect behavior.

### How to verify

- Compare host pool properties side-by-side.
- Compare scaling plan phase settings side-by-side.
- Calculate required hosts for each pool using current session counts.

### Recommended fix

1. Navigate to **Azure Virtual Desktop** → **Scaling plans** → your scaling plan → **Schedules**, then open each schedule phase.
2. Record the **Capacity threshold** and **Minimum percentage of active hosts** for each phase.
3. Navigate to each host pool → **Properties** and note the **Max session limit**.
4. Compare values across host pools and align any settings that should be identical.
5. Validate the change over at least one complete business cycle.

## Troubleshooting workflow

Use this workflow for repeatable triage:

1. Confirm expected behavior from autoscale formula and settings.
2. Identify whether disconnected sessions are blocking full scale-down.
3. Validate force sign-out timing and policy interactions.
4. Check diagnostics and monitor operation insights for failed evaluations.
5. Apply mitigation and observe one full ramp-down/off-peak cycle.
6. Escalate to engineering with evidence when behavior deviates from documented logic.

## Data to capture before escalation

Capture this minimum evidence set:

- Host pool name and region.
- Scaling plan schedule and phase settings.
- Max session limit, capacity threshold, minimum active hosts.
- Session state counts over time (connected/disconnected).
- Operation timestamps for resume/deallocate and host availability.
- Relevant diagnostics logs and failed-evaluation traces.

## Related content

- [Autoscale FAQ](/azure/virtual-desktop/autoscale-faq)
- [Autoscale scenarios](/azure/virtual-desktop/autoscale-scenarios)
- [Autoscale glossary](/azure/virtual-desktop/autoscale-glossary)
- [Create and assign scaling plans](/azure/virtual-desktop/autoscale-create-assign-scaling-plan)
- [Monitor autoscale operations and insights](/azure/virtual-desktop/autoscale-monitor-operations-insights)
- [Autoscale diagnostics](/azure/virtual-desktop/autoscale-diagnostics)

