---
title: Troubleshoot common issues that involve APT on Ubuntu
description: Learn how to resolve common troubleshooting issues involving the APT package management tool for the Ubuntu Linux distribution on Azure virtual machines.
author: msaenzbosupport
ms.author: msaenzbo
editor: v-jsitser
ms.reviewer: adelgadohell, v-leedennis
ms.service: virtual-machines
ms.collection: linux
ms.topic: troubleshooting-problem-resolution
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.date: 06/04/2024
#customer intent: As an Azure Linux virtual machine (VM) administrator, I want troubleshoot issues in the APT tools so that I can successfully install or update applications on my VMs.
---
# Troubleshoot common issues with APT on Ubuntu

This article discusses and provides solutions to common issues that you might encounter when you use the `apt` command-line tool to install or update applications on Microsoft Azure virtual machines (VMs).

> [!CAUTION]
> Standard support for Canonical Ubuntu 18.04 LTS is no longer available. If you're affected, see [Canonical Ubuntu 18.04 LTS is out of standard support on May 31, 2023](upgrade-canonical-ubuntu-18dot04-lts.md) to review your options.

## Overview

The `apt` (Advanced Package Tool) command on Ubuntu is a powerful tool that's used for package management. It enables you to install, remove, update, and manage software packages on the Ubuntu system. You can use `apt` to search for available packages, install specific versions of packages, and handle dependencies efficiently. It simplifies the process of software management by providing a command-line interface to interact with the APT libraries.

## Prerequisites

- Advanced Packaging Tool ([apt](https://www.debian.org/doc/user-manuals#apt-guide))
- [curl](https://curl.se)
- GNU Privacy Guard ([GPG](https://gnupg.org))
- [tee](https://www.man7.org/linux/man-pages/man1/tee.1.html)

## Scenario 1: Connection timed out on azure.archive.ubuntu.com

<details>
<summary>Scenario 1 details</summary>

During an `apt` update, upgrade, or installation operation, the connection eventually times out. Additionally, you receive an error message that resembles one of the following output strings:

- **Output 1**

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

- **Output 2**

  ```output
  W: Tried to start delayed item http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 distro-info-data all 0.52ubuntu0.7, but failed
  W: Tried to start delayed item http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 distro-info-data all 0.52ubuntu0.7, but failed
  W: Tried to start delayed item http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 distro-info-data all 0.52ubuntu0.7, but failed
  W: Tried to start delayed item http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 distro-info-data all 0.52ubuntu0.7, but failed
  W: Tried to start delayed item http://azure.archive.ubuntu.com/ubuntu jammy-updates/main amd64 distro-info-data all 0.52ubuntu0.7, but failed
  ```

The following sections outline potential causes for these failures and provide solutions to resolve the connection issues.

### Cause 1: VMs are configured to use an internal load balancer

An internal load balancer doesn't provide outbound connectivity if it's configured for network interfaces.

#### Solution 1a: Add a public IP address

Add a public IP address for the network interface of the VMs. For more information, see [Associate a public IP address to a virtual machine](/azure/virtual-network/ip-services/associate-public-ip-address-vm).

#### Solution 1b: Use an external load balancer

Use an external Azure load balancer instead of an internal Azure load balancer. For more information, see [Quickstart: Create a public load balancer to load balance VMs using the Azure portal](/azure/load-balancer/quickstart-load-balancer-standard-public-portal).

#### Solution 1c: Use a NAT gateway on the subnet

Use a network address translation (NAT) gateway on the VM's subnet for outbound access. For more information, see [Azure NAT Gateway resource](/azure/nat-gateway/nat-gateway-resource).

#### Solution 1d: Use an internal basic load balancer

Downgrade to use an internal basic load balancer instead of an internal standard load balancer.

> [!NOTE]
> This solution is only a temporary fix because the basic version of the load balancer is scheduled for retirement. For more information, see [Azure Basic Load Balancer will be retired on 30 September 2025—upgrade to Standard Load Balancer](https://azure.microsoft.com/updates/azure-basic-load-balancer-will-be-retired-on-30-september-2025-upgrade-to-standard-load-balancer/).

#### Solution 1e: Use SNAT rules

Use source network address translation (SNAT) rules. For more information, see [Use SNAT for outbound connections](/azure/load-balancer/load-balancer-outbound-connections).

### Cause 2: External load balancer doesn't have outbound rules and disables outbound SNAT

An external load balancer must have outbound connectivity so that it can reach Ubuntu repositories.

#### Solution 2: Configure outbound rule or verify that outbound SNAT is enabled

Take one or more of the actions that are listed in the following table.

| Action                   | Guidance                                                                                     |
|--------------------------|----------------------------------------------------------------------------------------------|
| Set up an outbound rule. | [Configuring outbound rules](/azure/load-balancer/outbound-rules)                            |
| Enable outbound SNAT.    | [Use SNAT for outbound connections](/azure/load-balancer/load-balancer-outbound-connections) |

### Cause 3: An Azure firewall or virtual appliance is between your virtual network and the internet

An Azure firewall or virtual appliance might be acting as a protective barrier between your Azure virtual network and the internet. This barrier enforces security policies and provides features to control and monitor traffic effectively by sending all traffic to the firewall. In this case, the firewall is blocking communication to Ubuntu repositories.

#### Solution 3: Make sure that the Ubuntu address is allowed

Make sure that `azure.archive.ubuntu.com` and any other repository URLs are fully accessible. To do this, take the following actions:

1. Verify that the destination URLs are allowed in firewall policies.

1. If Secure Sockets Layer (SSL) inspection is active, verify that IP addresses are allowed.

1. If a network security group (NSG) is used, make sure that Ubuntu IP addresses and ports 80 and 443 are added to the allow list of the outbound rule of the network interface NSG or subnet NSG. These exceptions should take priority over the `Block_Internet_Access_outbound` rule. Additionally, see [Check security rules applied to a virtual machine traffic](/azure/network-watcher/diagnose-network-security-rules#check-security-rules-applied-to-a-virtual-machine-traffic).

### Cause 4: VM is connected to a private subnet

Private subnets enhance security by not providing default outbound access. To enable outbound connectivity for VMs to access the Internet, it's necessary to explicitly grant outbound access. For more information, see [Add the Private subnet feature](/azure/virtual-network/ip-services/default-outbound-access#add-the-private-subnet-feature).

#### Solution 4: Provide outbound connectivity for the subnet

We recommend that you use a NAT gateway to provide outbound connectivity for VMs in the subnet. For more information, see [What is Azure NAT Gateway?](/azure/nat-gateway/nat-overview)

### Cause 5: A proxy is used for communication

Internet communication goes through a customer proxy that affects communication to the Ubuntu repositories.

#### Solution 5: Fix the proxy configuration settings

If a proxy server is configured in Microsoft Azure between the Ubuntu VM and Ubuntu repositories, use the correct proxy configuration settings in the */etc/apt/apt.conf* file, as shown in the following snippet.

> [!IMPORTANT]
> If the configured proxy server has a private IP address, make sure that it has connectivity within the Azure public address space.

```bash
Acquire::http::Proxy "http://[username]:[password]@ [proxy-web-or-IP-address]:[port-number]";
Acquire::https::Proxy "http://[username]:[password]@ [proxy-web-or-IP-address]:[port-number]";
```

Additionally, for Ubuntu and other Unix-like operating systems, you can set up a proxy for HTTP and HTTPS traffic by using environment variables. The relevant environment variables are `http_proxy` and `https_proxy`. To verify whether a proxy is configured, run the following command.

> [!IMPORTANT]
> If no proxy server exists between the Ubuntu VM and the Ubuntu repository addresses, search for and remove any proxy configuration settings that are in the */etc/apt/apt.conf* file.

```bash
env | grep -i proxy
```

</details>

## Scenario 2: "apt update" command fails and returns "Failed to fetch \<url> 470 status code 470"

<details>
<summary>Scenario 2 details</summary>

When you try to run the `apt update` command, the system tries to fetch package information from multiple sources, including `azure.archive.ubuntu.com`, `packages.microsoft.com`, and `security.ubuntu.com`. However, the command returns a "Failed to fetch \<url> 470 status code 470" error message, as shown in the following example:

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

### Cause: A firewall or an NSG blocks the required URLs

The traffic from your Ubuntu system is routed through a virtual appliance (firewall), but this appliance denies access to certain URLs, causing issues that are related to package updates and installations.

Alternatively, an NSG might be blocking outbound connectivity on port 80 or 443.

#### Solution: Allow required URLs on your firewall configuration

Make sure that all necessary URLs and domains are allowed through the firewall when you use package management systems, such as `apt` in Ubuntu.

If an NSG is used, make sure that Ubuntu IP addresses and ports 80 and 443 are added to the allow list of the outbound rule of the network interface NSG or subnet NSG. These exceptions should take priority over the `Block_Internet_Access_outbound` rule.

</details>

## Scenario 3: An error occurred during the signature verification

<details>
<summary>Scenario 3 details</summary>

When you run the `apt update` command, the system tries to fetch package information from multiple sources, including `azure.archive.ubuntu.com` and third-party repositories, such as `download.opensuse.org`. However, the command fails, as shown in the following console output:

```console
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

### Cause: GPG key is missing for third-party repositories

A new third-party repository was added in the */etc/apt/sources.list* file or the */etc/apt/sources.list.d/* folder, but it's missing the public key file that's used to verify the authenticity of packages in the repository. In Ubuntu, repositories often use GPG keys to make sure that the packages that you download are from trusted sources and weren't tampered with.

#### Solution: Add the GPG key for the third-party repositories

When you add a new repository to your Ubuntu system, you often have to import the GPG key that's associated with that repository to make sure that your system trusts the packages from that source.

If you're adding this repository to your system, make sure that the key is actually from a trusted source, such as the official website or a trusted community member. After you verify the authenticity of the GPG key, you can add it to your system by running the `apt-key` command or by placing it in the */etc/apt/trusted.gpg.d/* folder, as shown in the following command:

> [!IMPORTANT]
> Because this repository is a third-party repository, you should verify the authenticity of the GPG key that was provided. To obtain the correct GPG key for your repository, refer to the documentation or consult with official sources who are associated with the third-party repository. Using incorrect or unauthorized GPG keys can pose security risks to your system.

```bash
sudo curl -fsSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:unstable/xUbuntu_22.04/Release.key | sudo tee /etc/apt/trusted.gpg.d/devel_kubic_libcontainers_unstable.gpg > /dev/null
```

After you fetch the GPG key by running curl, you can alternatively convert the GPG key into a format suitable for APT by running the `gpg --dearmor` command, and then save it directly to the */etc/apt/trusted.gpg.d/* . This alternative ensures that your system securely manages and trusts the GPG key without relying on the `apt-key` command:

```bash
curl -fsSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:unstable/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/devel_kubic_libcontainers_unstable.gpg > /dev/null
```

> [!NOTE]
> If you can't locate the correct GPG key for this third-party repository, we recommend that you remove the repository entry from either the */etc/apt/sources.list* file or the */etc/apt/sources.list.d/* . This action ensures that the `apt update` commands function correctly and reduce the risk of encountering errors related to GPG keys. Prioritize security, and only add repositories from trusted sources that have valid GPG keys.

</details>

## Scenario 4: A "Temporary failure resolving 'azure.archive.ubuntu.com'" error message occurs

<details>
<summary>Scenario 4 details</summary>

When you run the `apt update` command, the system tries to fetch package information from multiple sources, including `azure.archive.ubuntu.com`. However, during the update or installation of a package, you receive a "Temporary failure resolving 'azure.archive.ubuntu.com'" error message, as shown in the following output:

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

### Cause: Custom DNS can't resolve Ubuntu repositories

You're using a custom Domain Name System (DNS) resolver that isn't operating correctly. Or, the affected VM is on a different subnet than the DNS server is on.

#### Solution: Verify and update your DNS resolver

Verify whether the custom DNS resolver is actually the cause of the problem. You can try switching back to the default DNS servers provided by Azure at the network interface level. For more information, see [Change DNS servers](/azure/virtual-network/manage-virtual-network#change-dns-servers).

If Azure DNS is working as expected, verify your internal domain name, and make sure that you can reach it on port 53.

If your DNS server is on Azure but resides in a different subnet, make sure that it has the correct user-defined route (UDR) to reach the subnet of the affected VM.

</details>

## Scenario 5: A "dpkg: error processing package" error message appears during a kernel installation

<details>
<summary>Scenario 5 details</summary>

When you try to install or reinstall a kernel by running the `apt` command, an error message that resembles the following text appears:

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

### Cause: A syntax error exists in /etc/default/grub

A syntax error in the */etc/default/grub* configuration file exists. The post-installation script for the *linux-image-5.4.0-1051-azure* package is probably encountering this error while it tries to parse the configuration.

#### Solution: Fix the syntax error in /etc/default/grub

Look for any syntax errors in the */etc/default/grub* file, particularly around the line that the post-installation script is probably encountering. Fix any syntax errors that you find. The syntax for this file is crucial for the correct functioning of the GRand Unified Bootloader (GRUB).

In the following example, the missing closing quotation mark in the `GRUB_CMDLINE_LINUX` line causes a syntax error in the GRUB configuration file:

```console
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
GRUB_CMDLINE_LINUX="    # <---
```

To correct this particular error, add the closing quotation mark at the end of the line. The corrected line should resemble the following code:

```console
GRUB_CMDLINE_LINUX=" "
```

After you correct the syntax error in the GRUB configuration file, try again to reinstall the kernel package.

</details>

## Scenario 6: "The repository 'http:\//archive.ubuntu.com/ubuntu/dists/focal/main/binary-armhf/Packages focal Release' does not have a Release file"

<details>
<summary>Scenario 6 details</summary>

When you run the `apt update` command, the system tries to fetch package information from multiple sources. However, you receive an error message about a missing `Release` file, as shown in the following output:

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

### Cause: The apt tool points to ARM processor architecture package on an x86_64 virtual machine

The `apt` command searches all architectures that are defined by `APT::Architectures` when the command downloads repository data.

In this scenario, you're running an x86_64 VM, but two lines in the */etc/apt/sources.list* file refer to the ARM processor architecture:

```bash
sudo cat  /etc/apt/sources.list | grep -i armhf
```

```output
deb http://archive.ubuntu.com/ubuntu/dists/focal/main/binary-armhf/Packages focal main
deb-src  http://archive.ubuntu.com/ubuntu/dists/focal/main/binary-armhf/Packages focal main
```

If any application automatically edits the *sources.list* file or adds a repository under the */etc/apt/sources.list.d/* , and then includes the *armhf* repositories, the same error occurs.

#### Solution: Remove or comment out armhf information from sources.list

Remove or comment out the lines that reference the ARM processor architecture in the */etc/apt/sources.list* file or the */etc/apt/sources.list.d/\*.list*.

</details>

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
