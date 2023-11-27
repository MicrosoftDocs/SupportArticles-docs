---
title: DNS zone transfer fails when using Only to servers listed in the Name servers tab
description: Helps resolve an issue in which DNS zone transfer fails when using the Only to servers listed in the Name servers tab setting.
author: Deland-Han
ms.author: delhan
ms.date: 11/23/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, ANRATH, brianoakes, v-lianna
ms.custom: sap:dns, csstroubleshoot, ikb2lmc
ms.technology: networking
---
# DNS zone transfer fails when using the "Only to servers listed in the Name servers tab" setting

This article helps resolve an issue in which Domain Name System (DNS) zone transfer fails when using the **Only to servers listed in the Name servers tab** setting.

You configure multiple IP addresses on a network adapter, and the DNS server is configured to listen to all IP addresses. If you allow zone transfers with the **Only to server listed on the Name Servers tab** option enabled under the **Zone Transfers** tab of a DNS zone, incremental zone transfer (IXFR) doesn't occur. In addition, when the **Notify** option is enabled, creating records on the primary server doesn't replicate to the secondary server unless you force Authoritative Transfer (AXFR). When the DNS zone is paused or resumed, you receive the following error message:

> Zone Not Loaded by DNS Server  
  The DNS server encountered a problem while attempting to load the zone. The transfer of zone data from the master server failed.  
  Correct the problem then either press F5, or on the Action menu, click Refresh.  
  For more information about troubleshooting DNS zone problems, see Help.  

## Change the "Allow zone transfers" setting

To work around this issue, set the **Allow zone transfers** setting to one of the following options:

- **To any server**
- **Only to the following servers**

## Use zoneresetsecondaries command to set the zone transfers to name servers only option

You can use the following steps to set the zone transfers to name servers only option for the zone.

1. Close the Microsoft Management Console (MMC).
2. From an elevated command prompt, run the following command:

    ```console
    dnscmd <servername> /zoneresetsecondaries <zonename> /securens
    ```

3. Wait for 60 seconds, and then open the MMC.
4. Select **Refresh** to refresh the settings.
5. Open the zone transfer settings and check the settings. If the settings are correct, select **Cancel** and close the MMC.
6. Wait for 60 seconds and the transfer will be performed successfully.
