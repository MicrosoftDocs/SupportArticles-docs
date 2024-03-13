---
title: Error (The computer must be joined to a domain) when you try to install the Azure Active Directory Sync Tool
description: Describes an error message that occurs when you try to install the Azure Active Directory Sync Tool. Provides a resolution.
ms.date: 06/22/2020
ms.reviewer: willfid
ms.service: active-directory
ms.subservice: enterprise-users
---
# Error when you try to install the Azure Active Directory Sync Tool: The computer must be joined to a domain

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), Microsoft Entra ID, Microsoft Intune, Azure Backup, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2419250

## Symptoms

When you try to install the Microsoft Azure Active Directory Sync Tool, you may receive the following error message:

> The computer must be joined to a domain.

## Cause

This issue may occur if the computer isn't joined to an Active Directory Domain Services (AD DS) domain or if the computer doesn't register a host (A) resource record with its Domain Name System (DNS).

## Resolution

To resolve this issue, use one of the following methods.

### Method 1: Computer isn't joined to an AD DS domain

Join the computer to an AD DS domain. To do this, follow these steps:

1. On the computer that you want to join to a domain, select **Start**, select **Control Panel**, and then double-click **System**.
2. Under **Computer name, domain, and workgroup settings**, select **Change settings**.
3. On the **Computer Name** tab, select **Change**.
4. Under **Member of**, select **Domain**, type the name of the domain that this computer will join, and then select **OK**.
5. Select **OK**, and then restart the computer.

### Method 2: Computer is already joined to an AD DS domain

If the computer is already joined to an AD DS domain, make sure that the computer's DNS settings are correct and that a host (A) resource record for the computer is registered with DNS. To do this, follow these steps:

1. Open Network Connections.
2. Right-click the network connection that you want to set up, and then select **Properties**.
3. Do one of the following, as appropriate for the connection that you want to set up:
   - For a local area connection: On the **General** tab, select **Internet Protocol (TCP/IP)**, and then select **Properties**.
   - For all other connections: On the **Networking** tab, select **Internet Protocol (TCP/IP)**, and then select **Properties**.
4. If you want to obtain DNS server addresses from a Dynamic Host Configuration Protocol (DHCP) server, select **Obtain DNS server address automatically**.
5. If you want to configure DNS server addresses manually, select **Use the following DNS server addresses.** In the **Preferred DNS server** box, type the IP addresses of the preferred DNS server. In the **Alternate DNS server** box, type the IP addresses of the alternative DNS server.
6. Select **OK** two times, and then close Network Connections.
7. At a command prompt, type the following commands, and press ENTER after each command:

    ```console
    ipconfig /flushdns
    ```

    ```console
    ipconfig /registerdns
    ```

8. If the issue isn't resolved, restart the computer that has Directory Sync Tool installed.
9. If the issue still isn't resolved, make sure that the computer that has the Directory Sync Tool is installed can communicate with the computer that's running AD DS.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
