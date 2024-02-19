---
title: General guidance to troubleshoot DHCP
description: Introduces general guidance to troubleshoot DHCP.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-lianna
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
---
# General guidance to troubleshoot Dynamic Host Configuration Protocol (DHCP)

Before you begin to troubleshoot, check the following items. These items can help you find the root cause of the problem.

## Checklist

- When did the problem start?
- Are there any error messages?
- Was the DHCP server working previously, or has it never worked? If it worked previously, did anything change before the problem started. For example, was an update installed? Was a change made to the infrastructure?
- Is the problem persistent or intermittent? If it is intermittent, when did it last occur?
- Are address lease failures occurring for all clients or for only specific clients, such as a single-scope subnet?
- Are there any clients on the same network subnet as the DHCP server?
- If clients reside on the same network subnet, can they obtain IP addresses?
- If clients are not on the same network subnet, are the routers or VLAN switches correctly configured to have DHCP relay agents (also known as IP Helpers)?
- Is the DHCP server standalone or is it configured for high availability, such as split-scope or DHCP Failover?
- Check the intermediate devices for features such as VRRP/HSRP, Dynamic ARP Inspection, or DHCP snooping that are known to cause problems.
