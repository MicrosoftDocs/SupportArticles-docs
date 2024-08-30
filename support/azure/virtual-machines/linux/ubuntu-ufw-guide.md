---
title:  Troubleshooting UFW (Uncomplicated Firewall) in Ubuntu distribution.
description: Verifying UFW rules
author: msaenzbosupport
ms.author: msaenzbo
ms.reviewer: divargas-msft
editor: 
ms.date: 08/23/2024
ms.service: azure-virtual-machines
---

# Troubleshooting UFW (Uncomplicated Firewall) in Ubuntu distributions.

**Applies to:** :heavy_check_mark: Linux VMs

UFW (Uncomplicated Firewall) is a user-friendly interface for managing a netfilter firewall in Linux distributions, particularly in Ubuntu. Its primary goal is to make managing a firewall easier for users who might find the complexity of directly configuring iptables daunting and it is the default firewall configuration tool.

## Prerequisites

- Root privileges.
- Set up access to the serial console.
- Make sure the net-tools, iproute2 and netcat-openbsd packages are installed.

## How to Check if a Port is Closed on my Ubuntu Virtual machine with UFW

> [!IMPORTANT]  
> By default, ufw is disabled on Ubuntu images from the Azure Marketplace. If you enable ufw on your virtual machine, all ports, including port 22 for SSH services, will be closed by default..

1. Verify the UFW status.

```bash
sudo ufw status
```

Status: active indicates that UFW is running.

If it says Status: inactive, UFW is not active, and the port will not be blocked by UFW.


2. List Current UFW Rules.

```bash
sudo ufw status numbered
```

A list of all the rules, showing whether specific ports are allowed or denied. If a port does not appear in the list, it is closed by default


3. Check if a Specific Port is Closed.

If you want to check whether a particular port is closed, look for its status in the UFW rules.

Suppose we want to check if port 22 (SSHD) is closed

```bash
sudo ufw status | grep '22'
```

If the output shows 22/tcp ALLOW, the port is open.

If there is no output or the rule shows DENY, the port is closed.

4. Verify port connectivity is using `netstat` or `ss` command:

```bash
sudo netstat -tuln | grep ':22'
``` 

```bash
sudo ss -tuln | grep ':22'
```

No output means the port is not being used or listened to by any service, indicating it is closed.

5. Test Port Connectivity using `nc`

```bash
sudo nc -zv <server-ip> 22
```

If the connection fails, it confirms that the port is closed.

Successful connection means the port is open.

If the port you’re checking does not appear in UFW's rules or is explicitly marked as DENY, and you cannot connect to it using external tools, the port is closed.


## Working with UFW

#### Scenario 1: Allow SSH connectivity for everybody

```bash
sudo ufw allow ssh
```
```output
Rule added
Rule added (v6)
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

sudo ufw allow from 10.0.10.10 to any port 22 proto tcp

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
22/tcp                         ALLOW       10.1.0.0/24 
```

#### Scenario 4 : Deny SSH for all other IPs

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

If your rules are out of order, you can delete a rule and then re-add it to change the order:

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
sudo ufw delete 1
```

For more information about UFW, see: [Ubuntu - UFW community](https://help.ubuntu.com/community/UFW)

