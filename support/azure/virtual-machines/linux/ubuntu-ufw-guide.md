---
title:  Troubleshooting connectivity issues by using Uncomplicated Firewall (UFW) in Azure Ubuntu VMs
description: Describes how to use Uncomplicated Firewall (UFM) to diagnose and resolve connectivity problems in Azure Ubuntu VMs. 
author: msaenzbosupport
ms.author: msaenzbo
ms.reviewer: divargas-msft
editor: 
ms.date: 08/23/2024
ms.service: azure-virtual-machines
---

# Use UFM for troubleshooting connectivity in Azure Ubuntu VMs

**Applies to:** :heavy_check_mark: Linux VMs

This article describes how to use Uncomplicated Firewall (UFM) to diagnose and resolve connectivity problems in an Azure Ubuntu virtual machine(VM).

UFM is a user-friendly interface for managing a `netfilter` firewall in Linux distributions, particularly in Ubuntu. Its primary goal is to make managing a firewall easier for users who might find the complexity of directly configuring `iptables` daunting. UFM is the default firewall configuration tool.

## Prerequisites

- Root privileges.
- Access to the serial console.
- Ensure the `net-tools`, `iproute2`, and `netcat-openbsd` packages are installed.

## How to check if a port is closed in the Ubuntu VM with UFM

> [!NOTE]  
> By default, UFW is not enabled on Ubuntu VMs that are created by using images from the Azure Marketplace. Enabling UFW on your virtual machine will close all ports, including port 22 for SSH services.

1. Verify the UFW status.

```bash
sudo ufw status
```
In the output:

     - `Status: active` indicates that UFW is running.
     
     - `Status: inactive` indicates UFW isn't active, and the port won't be blocked by UFW.

2. List the current UFW rules.

```bash
sudo ufw status numbered
```

This command lists all the rules. It shows whether specific ports are allowed or denied. If a port doesn't appear in the list, it's closed by default.

3. Check the UFW rules to determine if a particular port is closed. For example, to verify if SSH port 22 is closed, use the following command:

```bash
sudo ufw status | grep '22'
```

     - If the output displays `22/tcp ALLOW`, the port is open.
     - If no output appears or the rule shows `22/tcp DENY`, the port is closed.

4. Verify port connectivity using the `netstat` or `ss` command:

```bash
sudo netstat -tuln | grep ':22'
``` 

```bash
sudo ss -tuln | grep ':22'
```

No output indicates that the port is not in use or being listened by any service. If a firewall rule is in place to block the port, it may still appear closed.

5. Test Port Connectivity using `nc`

```bash
sudo nc -zv <server-ip> 22
```

If the connection fails but the service is running, it confirms that the port is closed.

Successful connection means the port is open.

If the port you're checking doesn't appear in UFW's rules, or if it's marked as DENY, UFW is blocking the port. Additionally, if you can't connect to the port using external tools, the port is closed.


## Working with UFW

#### Scenario 1: Allow SSH connectivity for everybody

```bash
sudo ufw allow ssh
```
```output
Rule added
```
Verify the rule added:

```bash
sudo ufw status
```

```output
Status: active

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       Anywhere                  
```

#### Scenario 2: Allow SSH (Port 22) for a Specific IP Address:

```bash
sudo ufw allow from 10.0.10.10 to any port 22 proto tcp
```

Verify rule:

```bash
sudo ufw status
```

```output
Status: active

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       10.0.10.10             
```


#### Scenario 3: Allow the following subnet to reach port 22.


```bash
sudo ufw allow from 10.1.0.0/24 to any port 22 proto tcp
```

Verify rule:

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

#### Scenario 4: Deny SSH for all other IPs

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
> The order of the rules are important because UFW processes the rules in the order they are listed. This means that once a rule matches, ufw will apply that rule and stop processing further rules for that connection


## Deleting a Rule

If your rules are out of order, you can delete a rule and then readd it to change the order:

To delete a rule, you can use its number from the `ufw status numbered` output. For example, if the rule you want to delete is rule number 3:

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

For more information about UFW, see: [Ubuntu - UFW community](https://help.ubuntu.com/community/UFW)

