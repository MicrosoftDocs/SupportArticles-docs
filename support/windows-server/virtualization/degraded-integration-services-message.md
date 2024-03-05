---
title: Fail to run non-Windows guest on Hyper-V
description: While running a non-Windows guest such as Linux on Hyper-V, the Hyper-V management console may display messages that indicate that the integration services for the non-Windows guest are degraded and no formal support will be provided unless the integration services are updated.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, abgupta
ms.custom: sap:integration-components, csstroubleshoot
---
# Degraded integration services message for non-Windows guests

This article provides a solution to an error that occurs when you run a non-Windows guest such as Linux on Hyper-V.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2956569

## Summary

While running a non-Windows guest such as Linux on Hyper-V, the Hyper-V management console may display messages that indicate that the integration services for the non-Windows guest are degraded and no formal support will be provided unless the integration services are updated. This message is overtly aggressive in warning and users should feel free to ignore it. Microsoft will provide required support despite of these messages being shown in the Hyper-V console or the Windows event log.

## Symptoms  

While running a non-Windows guest such as Linux on Hyper-V, the Hyper-V management console may display messages similar to the one shown below:

:::image type="content" source="media/degraded-integration-services-message/degraded-message-in-hyper-v-management-console.png" alt-text="A degraded message displays after running a non-Windows guest.":::

Furthermore, upon examination of the Windows server event log, you may also observe messages in the format shown below:

:::image type="content" source="media/degraded-integration-services-message/event-6-storvsp.png" alt-text="Messages upon examination of the Windows server event log.":::

:::image type="content" source="media/degraded-integration-services-message/event-23014.png" alt-text="Event 23014 indicates that no Microsoft technical support will be provided.":::

The message text in the above images suggests that no Microsoft technical support will be provided until the integration services are upgraded.

## Cause

The various messages shown in the symptoms section occur because the non-Windows guest integration services may not always have the code to interoperate with the latest Hyper-V protocols. This is due to the fact that Windows release cycles aren't in sync with the release cycles of other operating systems. As a hypothetical example, the latest Red Hat Enterprise Linux (RHEL) release may ship in January but the latest Windows release may ship in the following September. Between January and September, the Windows team may upgrade the Hyper-V protocols because of which the RHEL release shipped in January may have integration components that were written based on earlier Hyper-V protocols. Now, when a user tries to run an older RHEL release as a virtual machine on a newer Windows release, then they may observe messages suggesting that the RHEL integration components are degraded.

## Resolution

Users are hereby advised to ignore all messages and warnings that seem to indicate that no technical support will be provided because integration services for a non-Windows guest virtual machine are degraded. Microsoft will provide technical support even if when such messages are visible while running supported non-Windows guests on Hyper-V. Linux users may review a list of supported distributions on Hyper-V in this article: [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](/windows-server/virtualization/hyper-v/Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows).

It's safe to ignore these messages because Hyper-V protocols are implemented to be backward compatible. Therefore, even if a certain non-Windows guest has integration services that were based off earlier Hyper-V protocols, the guest is expected to run flawlessly on newer Hyper-V releases.
