---
title: Incremental zone transfer doesn't work for DNS zones
description: Helps resolve an issue in which incremental zone transfer doesn't occur for a DNS zone.
author: Deland-Han
ms.author: delhan
ms.date: 11/13/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, ANRATH, brianoakes, v-lianna
ms.custom: sap:dns, csstroubleshoot, ikb2lmc
ms.technology: networking
---
# Incremental zone transfer doesn't work for DNS zones

This article helps resolve an issue in which Incremental Zone Transfer doesn't occur for a Domain Name System (DNS) zone.

You configure multiple IP addresses on a network adapter, and the DNS server is configured to listen to all IP addresses. If you allow zone transfers with the **Only to server listed on the Name Servers tab** option enabled under the **Zone Transfers** tab of a DNS zone, incremental zone transfer (IXFR) doesn't occur. In addition, when the **Notify** option is enabled, creating records on the primary server doesn't replicate to the secondary server unless you force Authoritative Transfer (AXFR). When the DNS zone is paused or resumed, you receive the following error message:

> Zone Not Loaded by DNS Server  
  The DNS server encountered a problem while attempting to load the zone. The transfer of zone data from the master server failed.  
  Correct the problem then either press F5, or on the Action menu, click Refresh.  
  For more information about troubleshooting DNS zone problems, see Help.  

To work around this issue, set the **Allow zone transfers** setting to one of the following options:

- **To any server**
- **Only to the following servers**
