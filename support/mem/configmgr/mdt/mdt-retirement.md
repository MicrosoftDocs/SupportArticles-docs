---
title: Microsoft Deployment Toolkit (MDT) - Immediate Retirement Notice
description: Microsoft announces the immediate retirement of Microsoft Deployment Toolkit (MDT). Learn about the impact and alternative deployment solutions.
ms.topic: article
author: umair0204
ms.author: umaikhan
manager: prakh
ms.localizationpriority: medium
ms.collection: 
- tier2
- ConfigMgr
ms.reviewer: kaushika, GRaposo
ms.custom: sap:Operating Systems Deployment (OSD)\MDT Integration or User Driven Installation (UDI)
ms.date: 01/06/2026
---

# Microsoft Deployment Toolkit (MDT) - immediate retirement notice

**Applies to**: Windows 11, Windows 10, Windows Server

## Summary

Microsoft is announcing the immediate retirement of Microsoft Deployment Toolkit (MDT). MDT will no longer receive updates, fixes, or support. Existing installations will continue to function as is. However, we encourage customers to transition to modern deployment solutions.

## Impact

- MDT is no longer supported, and won't receive future enhancements or security updates.
- MDT download packages might be removed or deprecated from official distribution channels.
- No future compatibility updates for new Windows releases will be provided.

## Alternative deployment solutions

### Windows Autopilot (recommended)

Windows Autopilot provides a modern, cloud-based deployment and provisioning experience that's designed to simplify device setup and reduce operational overhead.

**Learn more**: [Overview of Windows Autopilot](/autopilot/overview)

### Configuration Manager operating system deployment (OSD)

For customers who have on-premises infrastructure and existing Configuration Manager environments, operating system deployment (OSD) remains a fully supported option.

**Learn more**: [Deploy Windows with Configuration Manager](/intune/configmgr/osd/understand/introduction-to-operating-system-deployment)

## Recommended next steps

1. Begin planning a transition from MDT to Windows Autopilot or Configuration Manager OSD.
2. Review current OS deployment workflows, and identify components that are dependent on MDT.
3. For customers who use Configuration Manager, verify existing task sequences.
4. For cloud-first environments, evaluate Autopilot enrollment options.
5. Update internal documentation and processes to reflect MDT retirement.

## Frequently asked questions

**Q1: Does MDT stop working immediately?**

**A1:** No. Existing MDT deployments continue to function. However, no further updates, support, or fixes will be provided.

**Q2: Is there a direct in-place upgrade path from MDT to another tool?**

**A2:** No. Customers must transition deployment workflows into Windows Autopilot or Configuration Manager OSD.

## More information

- [Windows Autopilot documentation](/autopilot/overview)
- [Configuration Manager OSD documentation](/intune/configmgr/osd/understand/introduction-to-operating-system-deployment)

*This article was last updated on January 6, 2026. Information is subject to change based on Microsoft policy updates.*
