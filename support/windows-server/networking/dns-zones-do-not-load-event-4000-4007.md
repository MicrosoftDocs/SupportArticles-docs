---
title: DNS zones don't load with event 4000 and 4007
description: DNS zones aren't loaded on the DNS console. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
---
# DNS zones don't load and event ID 4000 and 4007 are logged

This article solves an issue that event IDs 4000 and 4007 are logged when the DNS zones aren't loaded on the DNS console.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2751452

## Symptoms

One of the DNS servers in your environment starts showing an issue that the zones aren't loaded on the DNS console. And Event IDs 4000 and 4007 are logged in the DNS event logs:

Event ID 4000:

```output
The DNS server was unable to open Active Directory. This DNS server is configured to obtain and use information from the directory for this zone and is unable to load the zone without it. Check that the Active Directory is functioning properly and reload the zone. The event data is the error code.
```

Event ID 4007:

```output
The DNS server was unable to open zone \<zone> in the Active Directory from the application directory partition \<partition name>. This DNS server is configured to obtain and use information from the directory for this zone and is unable to load the zone without it. Check that the Active Directory is functioning properly and reload the zone. The event data is the error code.
```

Also when you try to open the DNS console you get a pop-up giving **Access Denied**.

You notice that the DNS Server service is up and running.

When you try to perform any operation on the AD-integrated zones using DNSCMD, you receive the **Access Denied** error message.

## Cause

This issue happens when that particular DC/DNS server has lost its Secure channel with itself or PDC.

This issue can also happen in a single DC environment where that DC/DNS server holds all the FSMO roles and is pointing to itself as Primary DNS server.

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

If it's the only domain controller in the environment and there are no other DNS Servers available, follow the same steps but replace the `PDC.Domain.com` with the server's own IP address (since it itself is the PDC).
