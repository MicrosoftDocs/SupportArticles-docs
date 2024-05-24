---
title: Troubleshoot common issues with APT on Ubuntu
description: Learn how to resolve common troubleshooting issues involving the apt package management for Ubuntu distribution.
author: msaenzbosupport
ms.author: msaenzbo
editor: 
ms.reviewer: adelgadohell
ms.service: virtual-machines
ms.collection: linux
ms.topic: troubleshooting-general
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.date: 04/15/2024
#customer intent: As an Azure Linux VM administrator, I want troubleshoot issues in the apt tools so that I can successfully install or update applications on my VMs.
---
# Troubleshoot common issues with APT on Ubuntu

This article discusses common issues that you might encounter when you use `apt` package management tools to install or update applications on Azure virtual machines (VMs), and provides solutions to these issues.

> [!CAUTION]
> [Canonical Ubuntu 18.04 LTS is out of standard support since May 31, 2023](/azure/virtual-machines/linux/upgrade-canonical-ubuntu-18dot04-lts).


## Overview

The `apt` command on Ubuntu is a powerful tool used for package management. It allows users to install, remove, update, and manage software packages on their Ubuntu system. With apt, users can search for available packages, install specific versions of packages, and handle dependencies efficiently. It simplifies the process of software management by providing a command-line interface to interact with the Advanced Package Tool (APT) libraries.



## Scenario 1: Connection timed out on azure.archive.ubuntu.com

During the `apt` update, upgrade or install operation, the connection eventually times out, and you see an error message that resembles one of the following output strings:

### Symptom

**Output 1**
```output
Err:2 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 dns-root-data all 2023112702~ubuntu0.22.04.1
  Unable to connect to azure.archive.ubuntu.com:http:
Ign:3 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 bind9 amd64 1:9.18.18-0ubuntu0.22.04.2
Err:1 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 bind9-utils amd64 1:9.18.18-0ubuntu0.22.04.2
  Could not connect to azure.archive.ubuntu.com:80 (52.147.219.192), connection timed out
Err:3 http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 bind9 amd64 1:9.18.18-0ubuntu0.22.04.2
  Unable to connect to azure.archive.ubuntu.com:http:
E: Failed to fetch http://azure.archive.ubuntu.com/ubuntu/pool/main/b/bind9/bind9-utils_9.18.18-0ubuntu0.22.04.2_amd64.deb  Could not connect to azure.archive.ubuntu.com:80 (52.147.219.192), connection timed out
E: Failed to fetch http://azure.archive.ubuntu.com/ubuntu/pool/main/d/dns-root-data/dns-root-data_2023112702%7eubuntu0.22.04.1_all.deb  Unable to connect to azure.archive.ubuntu.com:http:
E: Failed to fetch http://azure.archive.ubuntu.com/ubuntu/pool/main/b/bind9/bind9_9.18.18-0ubuntu0.22.04.2_amd64.deb  Unable to connect to azure.archive.ubuntu.com:http:
E: Unable to fetch some archives, maybe run apt-get update or try with --fix-missing?
```



**Output 2**
```output
W: Tried to start delayed item http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 distro-info-data all 0.52ubuntu0.7, but failed
W: Tried to start delayed item http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 distro-info-data all 0.52ubuntu0.7, but failed
W: Tried to start delayed item http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 distro-info-data all 0.52ubuntu0.7, but failed
W: Tried to start delayed item http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 distro-info-data all 0.52ubuntu0.7, but failed
W: Tried to start delayed item http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 distro-info-data all 0.52ubuntu0.7, but failed
```


The above errors may arise due to various scenarios. The following sections outline potential causes for these failures and provide solutions to resolve the connection issues.

## Cause 1: VMs are configured to use an internal load balancer

An internal load balancer doesn't provide outbound connectivity when it's configured for network interfaces.

### Solution 1a: Add a public IP address

Add a public IP address on the network interface of the VMs. For more information, see [Associate a public IP address to a virtual machine](/azure/virtual-network/ip-services/associate-public-ip-address-vm).

### Solution 1b: Use an external load balancer

Use an external Azure Load Balancer instead of an internal Azure Load Balancer. For more information, see [Quickstart: Create a public load balancer to load balance VMs using the Azure portal](/azure/load-balancer/quickstart-load-balancer-standard-public-portal).

### Solution 1c: Use a NAT gateway on the subnet

Use a network address translation (NAT) gateway on the VMs subnet for outbound access. For more information, see [Azure NAT Gateway resource](/azure/nat-gateway/nat-gateway-resource).

### Solution 1d: Use an internal basic load balancer

Downgrade to use an internal basic load balancer instead of an internal standard load balancer.

> [!NOTE]
> This solution is only a temporary fix because the basic version of the load balancer is scheduled for retirement. For more information, see [Azure Basic Load Balancer will be retired on 30 September 2025—upgrade to Standard Load Balancer](https://azure.microsoft.com/updates/azure-basic-load-balancer-will-be-retired-on-30-september-2025-upgrade-to-standard-load-balancer/).

### Solution 1e: Use SNAT rules

Use source network address translation (SNAT) rules. For more information, see [Use SNAT for outbound connections](/azure/load-balancer/load-balancer-outbound-connections).


## Cause 2: External Load Balancer without Outbound rules and outbound SNAT disabled

An external Load balancer requires to have outbound connectivity in order to reach Ubuntu repositories.

### Solution 2: Configure outbound rule or verify outbound SNAT is enabled

Make sure your external Load Balancer has outbound rules or outbound SNAT is enabled. For more information, see [Configuring outbound rules](/azure/load-balancer/outbound-rules) and [Use SNAT for outbound connections](/azure/load-balancer/load-balancer-outbound-connections).

## Cause 3: An Azure firewall or virtual appliance is between your virtual network and the Internet

 An Azure firewall or virtual appliance might exist that acts as a protective barrier between your Azure virtual network and the internet. This barrier enforces security policies and provides features to control and monitor traffic effectively, by sending all traffic to the firewall. In this case, the firewall is blocking the communication to Ubuntu repositories.

### Solution 3: Make sure that the Ubuntu address is allowed

Make sure `azure.archive.ubuntu.com` and any other repository URLs are fully accessible by taking the following actions:

1. Verify that the destination URLs are allowed in firewall policies.

1. Verify that IP addresses are allowed if Secure Sockets Layer (SSL) inspection is active. 

1. If an NSG is used, make sure that Ubuntu IP addresses and port 80/443 are added to the allow list of the outbound rule of the network interface NSG or subnet NSG. The priority should be higher than the `Block_Internet_Access_outbound` rule. In addition,  [Check security rules applied to a virtual machine traffic](/azure/network-watcher/diagnose-network-security-rules?tabs=portal#check-security-rules-applied-to-a-virtual-machine-traffic)


## Cause 4: Virtual Machine is under a Private Subnet

Private subnets enhance security by not providing default outbound access. To enable outbound connectivity for virtual machines to access the Internet, it's necessary to explicitly grant outbound access. For more information, see: [Private Subnet](/azure/virtual-network/ip-services/default-outbound-access#add-the-private-subnet-feature)

### Solution 4: Provide outbound connectivity on the Subnet

A NAT gateway is the recommended way to provide outbound connectivity for virtual machines in the subnet; for more information, see [Nat Gateway.](/azure/nat-gateway/nat-overview)


## Cause 5: A proxy is used for communication

Internet communication goes through a customer proxy that affects communication to the Ubuntu repositories.

### Solution 5: Fix the proxy configuration settings

If a proxy server is configured in Microsoft Azure between the Ubuntu VM and Ubuntu repositories, use the correct proxy configuration settings in the `/etc/apt/apt.conf` files, as shown in the following snippet:

> [!IMPORTANT]
>If the configured proxy server hafs a private IP address, make sure that it has connectivity within the Azure public address space.

```bash
Acquire::http::Proxy "http://[username]:[password]@ [proxy-web-or-IP-address]:[port-number]";
Acquire::https::Proxy "http://[username]:[password]@ [proxy-web-or-IP-address]:[port-number]";
```

Additionally, for Ubuntu and other Unix-like operating systems, you can set a proxy for HTTP and HTTPS traffic using environment variables. The relevant environment variables are http_proxy and https_proxy. To verify if a proxy is configured, run the following command.

 
> [!IMPORTANT]
> If no proxy server exists between the Ubuntu VM and the Ubuntu repository addresses, search for and remove any proxy configuration settings that are in the */etc/apt/apt.conf* file.

```bash
env | grep -i proxy
```

## Scenario 2: APT command fails and returns Failed to fetch http:// 470 status code 470

When running `apt update`, the system attempts to fetch package information from multiple sources, including `azure.archive.ubuntu.com`, `packages.microsoft.com`, and `security.ubuntu.com`

```output
Err: 3 http://azure.archive.ubuntu.com/ubuntu focal-updates InRelease
  470  status code 470[IP: 23.101.248.31 80]
Err: 4 http://azure.archive.ubuntu.com/ubuntu focal-backports InRelease
  470  status code 470[IP: 23.101.248.31 80]
Ign:5 https://packages.microsoft.com/ubuntu/20.04/prod focal InRelease
Err:6 https://packages.microsoft.com/ubuntu/20.04/prod focal Release
  Could not handshake: The TLS connection was not properly terminated. [IP: 52.230.121.169  443]
Reading package lists...

[stderr]
E: The repository 'http://security.ubuntu.com/ubuntu focal-security InRelease' is no longer signed.
E: Failed to fetch http://security.ubuntu.com/ubuntu/dists/focal-security/InRelease 470 status code 470 [IP: 91.189.91.82 80]
E: The repository 'http://security.ubuntu.com/ubuntu focal InRelease' is no longer signed.
E: Failed to fetch http://security.ubuntu.com/ubuntu/dists/focal/InRelease 470 status code 470 [IP: 23.101.248.31 80

```

## Cause: Required URLs blocked by a Firewall or NSG

The traffic from your Ubuntu system was being routed through a virtual appliance (firewall), and this appliance was denying access to certain URLs, causing issues with package updates and installations.

NSG can be blocking outbound connectivity on port 80 or 443.


### Solution:  Allow required URLs on your firewall configuration 

- Ensuring that all necessary URLs and domains are allowed through the firewall when dealing with package management systems like `apt` in Ubuntu.

- If an NSG is used, make sure that Ubuntu IP addresses and port 80/443 are added to the allow list of the outbound rule of the network interface NSG or subnet NSG. The priority should be higher than the `Block_Internet_Access_outbound` rule.

## Scenario 4: An error occurred during the signature verification

When running apt update, the system attempts to fetch package information from multiple sources, including `azure.archive.ubuntu.com` and third party repositories like `download.opensuse.org` but it fails as we can see in the following example.


```output
sudo apt update
Hit:1 http://azure.archive.ubuntu.com/ubuntu jammy InRelease
Hit:2 http://azure.archive.ubuntu.com/ubuntu jammy-updates InRelease
Hit:3 http://azure.archive.ubuntu.com/ubuntu jammy-backports InRelease
Hit:4 http://azure.archive.ubuntu.com/ubuntu jammy-security InRelease
Get:5 http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_22.04  InRelease [1262 B]
Err:5 http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_22.04  InRelease
  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 4D64390375060AA4
Fetched 1262 B in 1s (1142 B/s)
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
16 packages can be upgraded. Run 'apt list --upgradable' to see them.
W: An error occurred during the signature verification. The repository is not updated and the previous index files will be used. GPG error: http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_22.04  InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 4D64390375060AA4
W: Failed to fetch http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/unstable/xUbuntu_22.04/InRelease  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 4D64390375060AA4
W: Some index files failed to download. They have been ignored, or old ones used instead.
root@ubu24vmlbe:/etc/apt# 
```

## Cause: GPG key missing for third party repositories

The reason for this failure is the new third party repo that was added in `/etc/apt/sources.list` or `sources.list.d/` is missing the public key file used for verifying the authenticity of packages in the repository. In Ubuntu, repositories often use GPG keys to ensure that the packages you download are from trusted sources and haven't been tampered with.

### Solution: Adding the GPG key for the third party repositories

When you add a new repository to your Ubuntu system, you often need to import the GPG key associated with that repository to ensure that your system trusts the packages from that source.

If you're adding this repository to your system, you want to ensure that the key is indeed from a trusted source, such as the official website or a trusted community member. Once you've verified its authenticity, you can add it to your system using the `apt-key` command or by placing it in the `/etc/apt/trusted.gpg.d/ directory`.


> [!IMPORTANT]
> Since this repository is a third-party repository, it's essential to verify the authenticity of the GPG key provided. Be sure to consult the documentation or official sources associated with the third-party repository to obtain the correct GPG key for your repository. Using incorrect or unauthorized GPG keys could pose security risks to your system."

Example:

```bash
sudo curl -fsSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:unstable/xUbuntu_22.04/Release.key | sudo tee /etc/apt/trusted.gpg.d/devel_kubic_libcontainers_unstable.gpg > /dev/null
```

We can also fetch the GPG key using curl, convert it into a format suitable for APT using `gpg --dearmor`, and then save it directly to the /etc/apt/trusted.gpg.d/ directory. This ensures that the GPG key is securely managed and trusted by your system without relying on apt-key.


Example:

```bash
curl -fsSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:unstable/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/devel_kubic_libcontainers_unstable.gpg > /dev/null
```

> [!NOTE]
>If you're unable to locate the correct GPG key for this third-party repository, it's advisable to remove the repository entry from either `/etc/apt/sources.list` or `/etc/apt/sources.list.d/`. This ensures that the `apt update` commands function properly and reduces the risk of encountering GPG key-related errors. Prioritize security and only add repositories from trusted sources with valid GPG keys."


## Scenario 5: Temporary failure resolving 'azure.archive.ubuntu'

When running apt update, the system attempts to fetch package information from multiple sources, including `azure.archive.ubuntu.com`, during the update or installation of a package we're getting a `Temporary failure resolving` error.

```output
Ign:4 http://azure.archive.ubuntu.com/ubuntu jammy-security InRelease
Err:1 http://azure.archive.ubuntu.com/ubuntu jammy InRelease
  Temporary failure resolving 'azure.archive.ubuntu.com'
Err:2 http://azure.archive.ubuntu.com/ubuntu jammy-updates InRelease
  Temporary failure resolving 'azure.archive.ubuntu.com'
Err:3 http://azure.archive.ubuntu.com/ubuntu jammy-backports InRelease
  Temporary failure resolving 'azure.archive.ubuntu.com'
Err:4 http://azure.archive.ubuntu.com/ubuntu jammy-security InRelease
  Temporary failure resolving 'azure.archive.ubuntu.com'
Reading package lists... Done              
Building dependency tree... Done
Reading state information... Done
16 packages can be upgraded. Run 'apt list --upgradable' to see them.
W: Failed to fetch http://azure.archive.ubuntu.com/ubuntu/dists/jammy/InRelease  Temporary failure resolving 'azure.archive.ubuntu.com'
W: Failed to fetch http://azure.archive.ubuntu.com/ubuntu/dists/jammy-updates/InRelease  Temporary failure resolving 'azure.archive.ubuntu.com'
W: Failed to fetch http://azure.archive.ubuntu.com/ubuntu/dists/jammy-backports/InRelease  Temporary failure resolving 'azure.archive.ubuntu.com'
W: Failed to fetch http://azure.archive.ubuntu.com/ubuntu/dists/jammy-security/InRelease  Temporary failure resolving 'azure.archive.ubuntu.com'
W: Some index files failed to download. They have been ignored, or old ones used instead.
```

## Cause: Custom DNS can't resolve Ubuntu repositories

When attempting to fetch updates from the Ubuntu package repository, the error message indicates a temporary failure resolving the domain `azure.archive.ubuntu.com`. One potential reason for this could be that we're using a custom DNS resolver, which isn't working properly. Another reason could be that the affected VM is on a different subnet than the DNS server

### Solution: Verify and Update your DNS resolver

- Verify if the custom DNS resolver is indeed the cause of the problem. We can try switching back to the default DNS servers provided by Azure at the NIC level. For more information, see [Change Azure DNS](/azure/virtual-network/manage-virtual-network#change-dns-servers)

- If Azure DNS is working as expected, verify your internal DNS and make sure you can reach it on port 53.

- If your DNS server is on Azure but resides in a different subnet, ensure that it has the correct User Defined Route (UDR) to reach the subnet of the affected VM.


## Scenario 6: dpkg: error processing package on Kernel installation

When attempting to reinstall or install a new kernel using the `apt` command, the following error is appearing.

```output
Processing triggers for linux-image-5.4.0-1051-azure (5.4.0-1051.53) ...
/etc/kernel/postinst.d/initramfs-tools:
update-initramfs: Generating /boot/initrd.img-5.4.0-1051-azure
/etc/kernel/postinst.d/zz-update-grub:
Sourcing file `/etc/default/grub'
/usr/sbin/grub-mkconfig: 34: /etc/default/grub: Syntax error: EOF in backquote substitution
run-parts: /etc/kernel/postinst.d/zz-update-grub exited with return code 2
dpkg: error processing package linux-image-5.4.0-1051-azure (--configure):
 installed linux-image-5.4.0-1051-azure package post-installation script subprocess returned error exit status 1
Errors were encountered while processing:
 linux-image-5.4.0-1051-azure
E: Sub-process /usr/bin/dpkg returned an error code (1)
```

## Cause: Syntax error in /etc/default/grub

A syntax error in the `/etc/default/grub` configuration file. The post-installation script for the linux-image-5.4.0-1051-azure package is likely encountering this error while trying to parse the configuration.

### Solution: Fix the syntax error in /etc/default/grub

Look for any syntax errors in the file, particularly around the line that the post-installation script is likely encountering. Fix any syntax errors that you find. The syntax for this file is crucial for the proper functioning of the GRUB boot loader.

In the below example, the missing closing quote in the `GRUB_CMDLINE_LINUX` line would indeed cause a syntax error in the GRUB configuration file.


```output
# cat /etc/default/grub
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.
# For full documentation of the options in this file, see:
#   info -f grub -n 'Simple configuration'

GRUB_DEFAULT=0
GRUB_TIMEOUT_STYLE=hidden
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
GRUB_CMDLINE_LINUX="    <---
```

To correct this error, you can simply add the closing quote at the end of the line. The corrected line should look like this:

```output
GRUB_CMDLINE_LINUX=" "
```
Once you've corrected the syntax error in the Grub configuration file, try reinstalling the kernel package.


## Scenario 7: The repository `http://archive.ubuntu.com/ubuntu/dists/focal/main/binary-armhf/Packages focal Release` doesn't have a Release file

When running apt update, the system attempts to fetch package information from multiple sources, we're getting the following error:


```bash
Ign:1 http://archive.ubuntu.com/ubuntu/dists/focal/main/binary-armhf/Packages focal InRelease
Hit:2 http://azure.archive.ubuntu.com/ubuntu focal InRelease                   
Hit:3 http://azure.archive.ubuntu.com/ubuntu focal-updates InRelease           
Hit:4 http://azure.archive.ubuntu.com/ubuntu focal-backports InRelease
Hit:5 http://azure.archive.ubuntu.com/ubuntu focal-security InRelease
Hit:6 https://packages.microsoft.com/ubuntu/20.04/prod focal InRelease
Err:7 http://archive.ubuntu.com/ubuntu/dists/focal/main/binary-armhf/Packages focal Release
  404  Not Found [IP: 91.189.91.83 80]
Reading package lists... Done
E: The repository 'http://archive.ubuntu.com/ubuntu/dists/focal/main/binary-armhf/Packages focal Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
```

## Cause: apt pointing to ARM package architecture on an x86_64 virtual machine

The main issue is that apt searches all architectures defined by APT::Architectures when downloading repository data.

In this scenario we are running a x86_64 Virtual machine but there were two lines on `/etc/apt/sources.list` referring to the ARM architecture.

```bash
sudo cat  /etc/apt/sources.list | grep -i armhf
```
```output
deb http://archive.ubuntu.com/ubuntu/dists/focal/main/binary-armhf/Packages focal main
deb-src  http://archive.ubuntu.com/ubuntu/dists/focal/main/binary-armhf/Packages focal main
```

### Solution: Remove or comment armhf information from sources.list

Just remember that if any application automatically edits the `sources.list` file or adds a repository under the `/etc/apt/sources.list.d/` directory, and includes the `armhf` repositories, the same error occurs.

To fix this issue, remove or comment out the lines that reference the ARM architecture in `/etc/apt/sources.list` or `/etc/apt/sources.list.d/*.list`.


