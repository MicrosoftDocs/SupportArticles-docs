---
title:  Troubleshoot connectivity issues by using Uncomplicated Firewall (UFW) in Azure Ubuntu VMs
description: Discusses how to use Uncomplicated Firewall (UFW) to diagnose and resolve connectivity problems in Azure Ubuntu VMs. 
author: msaenzbosupport
ms.author: msaenzbo
ms.reviewer: divargas-msft
editor: 
ms.date: 08/23/2024
ms.service: azure-virtual-machines
---

# Use UFW to troubleshoot connectivity issues in Azure Ubuntu VMs

**Applies to:** :heavy_check_mark: Linux VMs

This article describes how to use Uncomplicated Firewall (UFW) to diagnose and resolve connectivity issues on an Azure Ubuntu virtual machine (VM).

UFW is a user-friendly interface for managing a Netfilter firewall in Linux distributions, particularly in Ubuntu. Its primary goal is to make managing a firewall easier for users who might find that directly configuring `iptables` is challenging and complex. UFW is the default firewall configuration tool for Ubuntu.

## Prerequisites

- Root privileges.
- Access to the serial console.
- Installed `net-tools`, `iproute2`, and `netcat-openbsd` packages.

## How to check whether a port is closed in the Ubuntu VM with UFW

> [!NOTE]  
> By default, UFW isn't enabled on Ubuntu VMs that are created by using images from the Azure Marketplace. Enabling UFW on your VM will close all ports, including port 22 for SSH services.

1. Verify the UFW status:

     ```bash
     sudo ufw status
     ```
     In the output:

   - `Status: active` indicates that UFW is running.
          
   - `Status: inactive` indicates UFW isn't active, and the port won't be blocked by UFW.

2. List the current UFW rules:

     ```bash
     sudo ufw status numbered
     ```
     This command lists all the rules. It shows whether specific ports are allowed or denied. If a port doesn't appear in the list, it's denied by default.

3. Check the UFW rules to determine whether a particular port is denied. For example, to verify whether SSH port 22 is denied, run the following command:

     ```bash
     sudo ufw status | grep '22'
     ```

     - If the output displays `22/tcp ALLOW`, the port is allowed through the firewall.
     - If no output appears or the rule shows `22/tcp DENY`, the port is denied.

4. Use the `netstat` or `ss` command to check whether a port is in use.

     #### [netstat](#tab/netstat)

     ```bash
     sudo netstat -tuln | grep ':22'
     ```
     #### [ss](#tab/ss)
     
     ```bash
     sudo ss -tuln | grep ':22'
     ```
     ---
     ```output
     tcp6   0   0 :::22     :::*   LISTEN   
     ```
   - The example output shows that a service is using or listening on port 22. However, this doesn't confirm that the port is allowed or unblocked by the firewall. Even if a port is blocked by the firewall, it might still appear as **LISTEN** in the output.
   - No output indicates that the port isn't being listened to by any service.

6. Test Port Connectivity by using `nc`:

     ```bash
     sudo nc -zv <server-ip> 22
     ```

     - If the connection fails but the port is being listened to, this confirms that the port is denied by the firewall.
     - A successful connection means that the port is allowed.

If the port that you're checking doesn't appear in the UFW rules, or if it's marked as `DENY`, UFW is blocking the port. Additionally, if you can't connect to the port by using external tools, the port is blocked.

## Working with UFW

### Scenario 1: Allow SSH connectivity for all IP addresses

Run the following command:

```bash
sudo ufw allow ssh
```
```output
Rule added
```

Verify the rule:

```bash
sudo ufw status
```

```output
Status: active

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       Anywhere                  
```

### Scenario 2: Allow SSH (Port 22) for a specific IP address

Run the following command:

```bash
sudo ufw allow from 10.0.10.10 to any port 22 proto tcp
```

Verify the rule:

```bash
sudo ufw status
```

```output
Status: active

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       10.0.10.10             
```

### Scenario 3: Allow a subnet to connect to the port 22

Run the following command:

```bash
sudo ufw allow from 10.1.0.0/24 to any port 22 proto tcp
```

Verify the rule:

```bash
sudo ufw status
```

```output
Status: active
To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       10.0.10.10             
22/tcp                     ALLOW       10.1.0.0/24 
```

### Scenario 4: Deny SSH for all IP addresses

Run the following commands:

```bash
sudo ufw deny ssh
```

```bash
sudo ufw status
```

```output
Status: active
To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       10.0.10.10             
22/tcp                     ALLOW       10.1.0.0/24          
22/tcp                     DENY        Anywhere                     
```

> [!IMPORTANT]  
> The order of the rules is important because UFW processes the rules in the order in which they're listed. This means that after a rule matches, UFW will apply that rule and stop processing additional rules for that connection.

## Deleting a rule

If your rules aren't in the correct order, you can delete a rule and then restore it to change the order.

To delete a rule, you can use its number from the `ufw status numbered` output. For example, to delete rule number 3:

```bash
sudo ufw status numbered
```

```output
Status: active

     To                         Action      From
     --                         ------      ----
[ 1] 22/tcp                     ALLOW       10.0.10.10             
[ 2] 22                         ALLOW       10.1.0.0/24 
[ 3] 22/tcp                     DENY IN     Anywhere  
```

```bash
sudo ufw delete 3
```

For more information, see: [Ubuntu - UFW community](https://help.ubuntu.com/community/UFW)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
