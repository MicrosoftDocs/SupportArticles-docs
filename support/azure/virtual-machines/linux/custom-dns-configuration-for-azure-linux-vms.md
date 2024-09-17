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

Domain Name System (DNS) translates human-readable domain names into IP addresses that servers use to identify each other on the network. Essentially, DNS acts as the internet's phonebook.".

> [!NOTE]
> In Azure you can configure multiple custom DNS servers at the Virtual Network(VNET) level or at the Network Interface(NIC) level. The DNS servers configured at the NIC level will override the configuration done at VNET level.

## Summary

You can configure multiple custom DNS servers and 'search domains' across various Linux distributions, such as, Redhat, SUSE, and Ubuntu. A common use case is configuring different custom DNS servers at the OS level, after setting them up at the Virtual Network or Network Interface level.

This article provides the necessary steps to add multiple DNS servers and search domains in Azure Linux Virtual Machines.

> [!NOTE]
> This document uses the DNS servers “1.2.3.4” and “5.6.7.8” and the search domain “test.example.com” as examples. Please replace these with your actual DNS server addresses and search domain entries.


## [RHEL 8.x/9._x_](#tab/RHEL)

1. Prior to making any modifications, the entries in /etc/resolv.conf file will look something like this:

    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-1.png" alt-text="Screenshot of default resolv.conf file in RHEL.":::

2. To configure DNS at the Virtual Network or Network Interface level, follow the instructions mentioned in this article: [Steps to change DNS servers at virtual network/network interface level](/azure/virtual-network/manage-virtual-network)

3. Restart the NetworkManager service to see the updated entries in /etc/resolv.conf file.

    ```bash
      sudo systemctl restart NetworkManager
    ```

    Post restarting the NetworkManager service, /etc/resolv.conf file will look like this:
    
    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-2.png" alt-text="Screenshot of resolv.conf file post changing the DNS servers at portal level.":::

4. You can verify that the updated entries are reflected under the eth0 section in DNS queries by running the command mentioned here:

    ```bash
    sudo systemd-resolve --status
    ```
    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-3.png" alt-text="Screenshot of above mentioned command's partial output.":::

5. To change the search domain as per your requirement, need to add a line like this in /etc/dhcp/dhclient.conf

    ```bash
    append domain-search "test.example.com";
    ```
    Post appending the line as mentioned above, the file looks like this:

    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-4.png" alt-text="Screenshot of dhclient.conf file post modification.":::

    > [!NOTE]
    > Multiple search domains can be given, separated by commas, like “test.example.com”,”test1.example.com”,”test2.example.com”

6. Restart the NetworkManager service to see the search domain being updated in /etc/resolv.conf file.
    
    ```bash
    sudo systemctl restart NetworkManager
    ```
    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-5.png" alt-text="Screenshot of resolv.conf file after restarting NM service.":::

7. You can also verify by running this command and checking the eth0 section in the output:

    ```bash
    sudo systemd-resolve --status
    ```
    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-6.png" alt-text="Screenshot showing the search domain.":::

## [Ubuntu 20.04/22.04](#tab/Ubuntu)

1. Prior to making any modifications, the entries in /etc/resolv.conf file will look something like this:

   :::image type="content" source="./media/custom-dns-config-images/ubuntu-dns-1.png" alt-text="Screenshot of default resolv.conf file in Ubuntu.":::

2. Starting from Ubuntu 20, resolv.conf file is a symbolic link of /run/systemd/resolve/stub-resolv.conf file:

   :::image type="content" source="./media/custom-dns-config-images/ubuntu-dns-2.png" alt-text="Screenshot of symlink for default resolv.conf file":::

3. To configure DNS at the Virtual Network or Network Interface level, follow the instructions mentioned in this article: [Steps to change DNS servers at virtual network/network interface level](/azure/virtual-network/manage-virtual-network#change-dns-servers)

4. Run the following command to apply the custom DNS entries:
    
   ```bash
   sudo netplan apply
   ```
   Note that the updated custom entries will be reflected in **/run/systemd/resolve/resolv.conf** file.

   More information about this stub file, significance, and usage of different resolv.conf files, systemd-resolved service can be found in this man-page:
   https://manpages.ubuntu.com/manpages/bionic/man8/systemd-resolved.service.8.html#:~:text=systemd%2Dresolved%20is%20a%20system,an%20LLMNR%20resolver%20and%20responder.
    
   :::image type="content" source="./media/custom-dns-config-images/ubuntu-dns-3.png" alt-text="Screenshot of non-stub resolv.conf file after making changes at portal level":::

5. Alternatively, you can verify the updated DNS entries using the following command as well:

   ```bash
   sudo resolvectl status
   ```
    
   :::image type="content" source="./media/custom-dns-config-images/ubuntu-dns-4.png" alt-text="Screenshot of resolvectl status command output.":::

6. To add a custom search domain, create a file similar to the one mentioned here:

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

7. Run the following command to apply the search domain changes.
  
   ```bash
   sudo netplan apply
   ```

8. Verify the updated search domain by running the following command:

   ```bash
   sudo resolvectl status
   ```

   :::image type="content" source="./media/custom-dns-config-images/ubuntu-dns-5.png" alt-text="Screenshot of resolvectl post final changes.":::
  	
## [SLES 12.x/15.x](#tab/SLES)

1. Prior to making any modifications, the entries in /etc/resolv.conf file will look something like this:

   :::image type="content" source="./media/custom-dns-config-images/sles-dns-1.png" alt-text="Screenshot of default resolv.conf file in SUSE.":::

2. To configure DNS at the Virtual Network or Network Interface level, follow the instructions mentioned in this article: [Steps to change DNS servers at virtual network/network interface level](/azure/virtual-network/manage-virtual-network#change-dns-servers)

3. Restart the wicked service to see the updated entries in /etc/resolv.conf file.

   ```bash
   sudo systemctl restart wicked.service
   ```

   :::image type="content" source="./media/custom-dns-config-images/sles-dns-2.png" alt-text="Screenshot of resolv.conf after restarting wicked service.":::

4. To have the custom search domains listed, need to update the file **/etc/sysconfig/network/config** with your search domain entry. For example:

   ```bash
   NETCONFIG_DNS_STATIC_SEARCHLIST="test.example.com"
   ```
   Multiple domains can be declared using a space separator, as demonstrated here:

   ```bash
   NETCONFIG_DNS_STATIC_SEARCHLIST="test.example.com test1.example.com"
   ```
    
5. Then, restart wicked service or update netconfig, to see the search domains being updated in /etc/resolv.conf file.

   ```bash
   sudo systemctl restart wicked.service
   ```
   Alternatively, you can also use this command to get this configuration updated:

   ```bash
   sudo netconfig update
   ```

   :::image type="content" source="./media/custom-dns-config-images/sles-dns-3.png" alt-text="Screenshot of resolv.conf after final changes":::

---

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
