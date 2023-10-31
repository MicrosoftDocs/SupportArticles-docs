---
title: A faulty split-brain DNS configuration can prevent a seamless SSO sign-in experience
description: Describes the conditions in which Active Directory Federation Services (AD FS) doesn't behave as expected when you sign in to Office 365 services by using a single sign-on (SSO)-enabled user ID. Provides a resolution.
ms.date: 06/08/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: authentication
---
# A faulty split-brain DNS configuration can prevent a seamless SSO sign-in experience

This article describes the conditions in which Active Directory Federation Services (AD FS) doesn't behave as expected when you sign in to Office 365 services by using a single sign-on (SSO)-enabled user ID.

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2715326

## Symptoms

When you sign in to a Microsoft cloud service such as Office 365, Microsoft Azure, or Microsoft Intune by using a single sign-on (SSO) enabled user ID, the connection to Active Directory Federation Services (AD FS) does not behave as expected. The connection fails together with one of the following results:

- Computers that sign in from inside the on-premises network connect to the AD FS proxy IP address, and a forms-based authentication prompt appears. However, an Integrated Windows Authentication experience is expected.
- Computers that sign in from inside the on-premises network and then try to connect to the AD FS proxy service are denied because of firewall settings.

## Cause

These symptoms can be caused by a faulty split-brain DNS configuration that is required for correct internal and external name resolution of DNS services. One of the following causes is most likely:

- The split-brain internal DNS resolution isn't set up for the domain in which the AD FS service resides.
- AD FS service name resolution isn't set in the split-brain internal DNS resolution of the on-premises environment.

## Resolution

To resolve this issue, follow these steps:

### Step 1: Establish the split-brain DNS zone in internal DNS

To do this, follow these steps on the on-premises DNS server:

1. Open the DNS Management Console. To do this, open **Administrative Tools**, and then double-click **DNS**.
2. In the left navigation pane, expand **DNS**, expand the server name, and then select **Forward Lookup Zones**.
3. If there's no entry that's displayed for the DNS zone within which the AD FS service endpoint is hosted, create the zone. To do this, right-click **Forward Lookup Zones**, and then select **New Zone**.
4. Complete the wizard. When you do this, select **Primary Zone**, and then name the zone for the DNS domain of the AD FS server.

    > [!WARNING]
    > Completing this step effectively stops on-premises computers from resolving server names to public IP addresses by using the DNS server that resolves public requests for the domain. Any extranet service endpoints that have to be used by on-premises clients must have an A record created within the split-brain DNS configuration to enable the connection.

### Step 2: Advertise the AD FS service endpoint in the split-brain DNS domain

In the DNS Management Console that you opened earlier, follow these steps:

1. Browse to and then select the DNS zone for the domain of the AD FS server.
2. Right-click the domain name, and then select **New Host (A or AAAA)**.
3. Enter the following values:
   - Name: The AD FS service name
   - IP address: The on-premises private IP address of the AD FS Federation Service farm.

### Step 3: Clear the DNS cache on the server and client to test the solution

1. In the DNS Management Console that you opened earlier, right-click the server name, and then select **Clear Cache**.
2. On the client computer, select **Start**, select **All Programs**, select **Accessories**, right-click **Command Prompt**, and then select **Run As Administrator**.
3. Type the following command, and then press Enter:

    ```console
    Ipconfig /flushdns
    ```

Retest SSO sign-in to confirm that this resolves the issue.

## More information

Split-brain DNS is a common configuration that's used to make sure that on-premises client computers resolve a server name to internal IP addresses, even though public DNS resolution resolves the same service name to a different public IP address. When you set up AD FS for on-premises service, this configuration is needed to make sure that on-premises client computers' authentication experience to the AD FS service is handled differently (by the AD FS Federation Service farm) than external client computers that are being serviced by the AD FS Proxy Service.

Without this configuration, all AD FS clients will be serviced by the same IP address when they connect to the AD FS service, whether they are connected from the on-premises network or are accessing remotely from an Internet location. This limits the seamless authentication experience possible for on-premises, Active Directory-authenticated clients, because the AD FS Proxy Service that is exposing the AD FS service to the Internet does not expect the accessing client to be able to provide an Integrated Windows Authentication response without a prompt (because remote computers are not authentication to Active Directory).

To overcome this limitation, it's desirable to override the default name resolution that is given to on-premises clients by creating an identically named domain in on-premises DNS. Because the DNS distributed architecture returns the first response that is found to a forward lookup query, this effectively masks the public DNS domain advertisements for that domain for all on-premises client computer requests because their requests are handled by on-premises DNS servers first.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
