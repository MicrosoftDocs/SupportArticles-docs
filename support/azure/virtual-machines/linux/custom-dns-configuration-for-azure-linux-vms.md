---
title: Custom DNS configuration in Azure Linux Virtual Machines
description: Describes how to configure custom DNS and search domains in Azure Linux virtual machines running the most common Linux distributions.
ms.date: 09/09/2024
ms.author: vkchilak
author: vkchilak
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), Issue with DNS
ms.collection: linux
---

# Custom DNS configuration in Azure Linux Virtual Machines

**Applies to:** :heavy_check_mark: Linux VMs

This article discusses how to configure custom DNS and search domains in Azure Linux virtual machines (VMs) that run the most common Linux distributions.

## Overview of DNS

Domain Name System (DNS) is a hierarchical and decentralized naming system used to translate human-readable domain names (like www.example.com) into IP addresses (like 192.0.2.1) that computers use to identify each other on the network. Essentially, DNS acts as the phonebook of the internet.

> [!NOTE]
> In Azure you can configure multiple custom DNS servers at the Virtual Network(VNET) level or at the Network Interface(NIC) level. The DNS servers configured at the NIC level will override the configuration done at VNET level.

## Purpose of this Document

The purpose of this document is to provide a comprehensive guide on configuring custom DNS servers and search domain, across different Linux distributions, specifically Redhat, SUSE, and Ubuntu.
By following the guidelines and procedures outlined in this document, users can ensure their Linux systems are configured with optimal and secure DNS settings, leading to improved network performance and reliability.

> [!NOTE]
> This document uses the DNS servers “1.2.3.4” and “5.6.7.8” and the search domain “test.example.com” as examples. Please replace these with your actual DNS server addresses and search domain entries.


## [RHEL 8.x/9._x_](#tab/RHEL)

1. Before Before making any changes, the entries in /etc/resolv.conf file will look something like this:

    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-1.png" alt-text="Screenshot of default resolv.conf file.":::

2. Follow the instructions mentioned in this article to configure DNS at VNET or NIC level: https://docs.microsoft.com/en-us/azure/virtual-network/manage-virtual-network#change-dns-servers

3. Restart the NetworkManager service to see the updated entries in /etc/resolv.conf file.

    ```bash
      sudo systemctl restart NetworkManager
    ```

    After restarting the NetworkManager service, /etc/resolv.conf file will look like this:
      Image-2
4. You can verify that the updated entries are reflected under the eth0 section in DNS queries by running the command below:

    ```bash
    sudo systemd-resolve --status
    ```
    Image-3

5. To change the search domain as per your requirement, need to add a line as mentioned below in /etc/dhcp/dhclient.conf

    ```bash
    append domain-search "test.example.com";
    ```
    After adding the above mentioned line, the file looks like this:

    Image -4

    > [!NOTE]
    > Multiple search domains can be given, separated by commas, like “test.example.com”,”test1.example.com”,”test2.example.com”

6. Restart the NetworkManager service to see the search domain being updated in /etc/resolv.conf file.
    
    ```bash
    sudo systemctl restart NetworkManager
    ```
    Image - 5

7. You can also verify the same by running the command below and checking under the eth0 section:

    ```bash
    sudo systemd-resolve --status
    ```
    Image - 6

## [Ubuntu 20.04/22.04](#tab/Ubuntu)

1. Before making any changes, the entries in /etc/resolv.conf file will look something like this:

    Image-1

2. Starting from Ubuntu 20, resolv.conf file is a symbolic link of /run/systemd/resolve/stub-resolv.conf file:

    Image -2

3. Follow the instructions mentioned in this article to configure DNS at VNET or NIC level: https://docs.microsoft.com/en-us/azure/virtual-network/manage-virtual-network#change-dns-servers

4. Run the following command to apply the custom DNS entries:
    
    ```bash
    sudo netplan apply
    ```
    Please note that the updated custom entries will be reflected in **/run/systemd/resolve/resolv.conf** file.

    More information about this stub file, significance and usage of different resolv.conf files, systemd-resolved service can be found in this man page:
    https://manpages.ubuntu.com/manpages/bionic/man8/systemd-resolved.service.8.html#:~:text=systemd%2Dresolved%20is%20a%20system,an%20LLMNR%20resolver%20and%20responder.
    
    Image-3

5. Alternatively, you can verify the updated DNS entries using the following command as well:

    ```bash
    sudo resolvectl status
    ```
    
    Image - 4

6. To add a custom search domain, create a file similar to the one mentioned below:

    ```bash
    root@Ubuntu22:~# cat /etc/netplan/99-dns.yaml
    network:
    ethernets:
      eth0:
        nameservers:
          search: [ test.example.com ]
    root@Ubuntu22:~#
    ```

    > [!NOTE]
    > Multiple search domains can be given, separated by commas, like “test.example.com”,”test1.example.com”,”test2.example.com”

7.	Run the following command to apply the search domain changes.
  
    ```bash
    sudo neplan apply
    ```

8.	Verify the updated search domain by running the following command:

    ```bash
    sudo resolvectl status
    ```

    Imaage-5
  	
## [SLES 12.x/15.x](#tab/SLES)

1. Before making any changes, the entries in /etc/resolv.conf file will look something like this:

    ```bash
    sudo yum install NetworkManager-dispatcher-routing-rules -y
    sudo systemctl enable NetworkManager-dispatcher.service
    sudo systemctl start NetworkManager-dispatcher.service
    ```
    Image-1

2. Follow the instructions mentioned in this article to configure DNS at VNET or NIC level: https://docs.microsoft.com/en-us/azure/virtual-network/manage-virtual-network#change-dns-servers

3. Restart the wicked service to see the updated entries in /etc/resolv.conf file.

    ```bash
    sudo systemctl restart wicked.service
    ```

     Image-2

4. To have the custom search domains listed, need to update the file **/etc/sysconfig/network/config** with your search domain entry. For example:

    ```bash
    NETCONFIG_DNS_STATIC_SEARCHLIST="test.example.com"
    ```
    Multiple domains can be declared using a space separator as shown below

    ```bash
    NETCONFIG_DNS_STATIC_SEARCHLIST="test.example.com test1.example.com"
    ```
    
5. Then, restart wicked service or update netconfig, to see the search domains being updated in /etc/resolv.conf file.

    ```bash
    sudo systemctl restart wicked.service
    ```
    Alternatively, you can use below command as well to get this configuration updated:

    ```bash
    sudo netconfig update
    ```

    Image-3

---
