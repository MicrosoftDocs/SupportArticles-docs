---
title: DNS zones do not load with event 4000 and 4007
description: DNS zones are not loaded on the DNS console. Provides a resolution.
ms.date: 07/24/2020
author: delhan
ms.author: Deland-Han
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: DNS
ms.technology: Networking
---
# DNS zones do not load and event ID 4000 and 4007 are logged

This article provides a resolution to solve the event ID 4000 and 4007 that are logged when the DNS zones are not loaded on the DNS console.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2751452

## Symptoms

You may encounter a situation where one of the DNS server's in the environment starts showing an issue where the zones are not loaded on the DNS console and you see Event ID 4000 and 4007 logged in the DNS event logs:

Event ID 4000:

> The DNS server was unable to open Active Directory. This DNS server is configured to obtain and use information from the directory for this zone and is unable to load the zone without it. Check that the Active Directory is functioning properly and reload the zone. The event data is the error code.

Event ID 4007:

> The DNS server was unable to open zone \<zone> in the Active Directory from the application directory partition \<partition name>. This DNS server is configured to obtain and use information from the directory for this zone and is unable to load the zone without it. Check that the Active Directory is functioning properly and reload the zone. The event data is the error code.

Also when you try to open the DNS console you get a pop-up giving **Access Denied**.

You notice that the DNS Server service is up and running.

When you try to perform any operation on the AD-integrated zones using DNSCMD, you receive the **Access Denied** error message.

## Cause

This happens when that particular DC/DNS server has lost its Secure channel with itself or PDC.

This can also happen in a single DC environment where that DC/DNS server holds all the FSMO roles and is pointing to itself as Primary DNS server.

## Resolution

In case you have other Domain Controller/DNS server present in the environment, then configure the server experiencing the issue to point to other active DNS server in TCP/IP properties.

1. Stop the KDC service on the DC experiencing the issue.

2. Run the following command with elevated rights:

    ```console
    netdom resetpwd /server:<PDC.domain.com> /userd:<Domain\domain_admin> /passwordd:*
    ```

    It will prompt for the password of the Domain Admin account that you used, enter that.

3. Once the command executes, reboot the server.

DNS zones should load now.

If this is the only DC in the environment and there are no other DNS Servers available, then perform the same steps but replace the `PDC.Domain.com` with the server's own IP address (since it itself is the PDC).
