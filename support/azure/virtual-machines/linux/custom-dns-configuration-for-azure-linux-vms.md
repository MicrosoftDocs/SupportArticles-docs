---
title: Custom DNS configuration in Azure Linux virtual machines
description: Learn how to configure custom DNS and search domains on Azure Linux virtual machines running common Linux distributions.
ms.date: 09/09/2024
ms.author: vkchilak
author: vkchilak
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), Issue with DNS
ms.collection: linux
---

# Custom DNS configuration in Azure Linux Virtual Machines

**Applies to:** :heavy_check_mark: Linux VMs

This article provides instructions on configuring custom DNS servers and search domains in Azure Linux virtual machines (VMs).

> [!NOTE]
> This article uses the DNS servers `1.2.3.4` and `5.6.7.8` and the search domain `"test.example.com"` as examples. Replace these with your actual DNS server addresses and search domain path.

## [RHEL 8.x/9._x_](#tab/RHEL)

### Configure custom DNS servers
1. The initial configuration of the `/etc/resolv.conf` file in an Azure Linux VM is as follows:

    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-1.png" alt-text="Screenshot of default resolv.conf file in RHEL.":::
2. Configure custom DNS servers at the Azure virtual network or network interface level. For more information, see [Steps to change DNS servers at virtual network/network interface level](/azure/virtual-network/manage-virtual-network).

    > [!NOTE]
    > In Azure, you can set custom DNS servers at the virtual network level or the network interface level. If you set custom DNS servers at the network interface level, it will override the the custom DNS servers configuration in the virtual network.


3. Restart the `NetworkManager` service, and then check  `/etc/resolv.conf` file. It should contain the DNS servers you configured in the step 2.

    ```bash
      sudo systemctl restart NetworkManager
    ```

    Example of `/etc/resolv.conf` after configuring the DNS servers:
    
    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-2.png" alt-text="Screenshot of resolv.conf file post changing the DNS servers at portal level.":::

4. Run the following command to determinate whether the DNS servers are successfully added to the network interface.

    ```bash
    sudo systemd-resolve --status
    ```
    
   Example of the network interface after configuring the DNS servers:

    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-3.png" alt-text="Screenshot of above mentioned command's partial output.":::

### Configure search domains

1. To change the search domain, add the domain name as the following in `/etc/dhcp/dhclient.conf`. To specify multiple search domains, separate them with commas, such as `"test.example.com, test1.example.com, test2.example.com"`.
 
    ```config
    append domain-search "test.example.com";
    ```
     Example of `/etc/dhcp/dhclient.conf` file after adding the search domain:

    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-4.png" alt-text="Screenshot of dhclient.conf file post modification.":::

2. Restart the `NetworkManager` service, and then check if the search domain is updated in `/etc/resolv.conf`file.
    
    ```bash
    sudo systemctl restart NetworkManager
    ```
    Example of `/etc/resolv.conf` file after configuring the search domain:
    
    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-5.png" alt-text="Screenshot of resolv.conf file after restarting NM service.":::

3. Run the following command to determinate whether the search domain is successfully added to the network interface.

    ```bash
    sudo systemd-resolve --status
    ```

     Example of the network interface after configuring search domain:

    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-6.png" alt-text="Screenshot showing the search domain.":::

## [Ubuntu 20.04/22.04](#tab/Ubuntu)

### Configure DNS servers

1. The initial configuration of the `/etc/resolv.conf` file in an Azure Ubuntu VM is as follows:

   :::image type="content" source="./media/custom-dns-config-images/ubuntu-dns-1.png" alt-text="Screenshot of default resolv.conf file in Ubuntu.":::

2. Configure custom DNS servers at the Azure virtual network or network interface level. For more information, see [Steps to change DNS servers at virtual network/network interface level](/azure/virtual-network/manage-virtual-network).

    > [!NOTE]
    > In Azure, you can set custom DNS servers at the virtual network level or the network interface level. If you set custom DNS servers at the network interface level, it will override the the custom DNS servers configuration in the virtual network.
3. Run the following command to apply the configuration of the custom DNS servers:

   ```bash
   sudo netplan apply

4. Check  `/run/systemd/resolve/stub-resolv.conf` file. It should contain the DNS servers you configured in the step 2.
  
    Starting from Ubuntu 20, `resolv.conf` file is a symbolic link of `/run/systemd/resolve/stub-resolv.conf` file. So that the updated DNS servers will be reflected in **/run/systemd/resolve/resolv.conf** file. For more information, see [systemd-resolved](https://manpages.ubuntu.com/manpages/bionic/man8/systemd-resolved.service.8.html#:~:text=systemd%2Dresolved%20is%20a%20system,an%20LLMNR%20resolver%20and%20responder).
    
   Example of `/run/systemd/resolve/stub-resolv.conf` after configuring custom DNS server.

   :::image type="content" source="./media/custom-dns-config-images/ubuntu-dns-3.png" alt-text="Screenshot of non-stub resolv.conf file after making changes at portal level":::

5. Run the following command to check if the custom DNS servers are successfully added to the network interface.

   ```bash
   sudo resolvectl status
   ```

   Example of the network interface after configuring search domain:

   :::image type="content" source="./media/custom-dns-config-images/ubuntu-dns-4.png" alt-text="Screenshot of resolvectl status command output.":::

### Configure search domains

1. Use a text editor (like nano or vim) to create a YAML configuration file in the `/etc/netplan/` for the DNS servers. For example:

      ```
      sudo nano /etc/netplan/custom-dns-01.yaml
      ```

      or
   
      ```
      sudo vi /etc/netplan/custom-dns-01.yaml
      ```
   
3. Add the following configuration, and then save and exit: If you’re using nano, press `CTRL + O` to save and `CTRL + X` to exit. If you’re using vim, press ESC, type `:wq`, and then hit Enter to save and exit. 

    ```yaml
    network:
    ethernets:
      eth0:
        nameservers:
          search: [ test.example.com ]
    ```
    Multiple search domains can be given, separated by commas, like `[test.example.com, test1.example.com, test2.example.com]`
4. Run the following command to apply the search domain changes.
  
   ```bash
   sudo netplan apply
   ```

5. View the `resolvectl` status to determinate whether the search domain is added successfully:

   ```bash
   sudo resolvectl status
   ```

   :::image type="content" source="./media/custom-dns-config-images/ubuntu-dns-5.png" alt-text="Screenshot of resolvectl post final changes.":::
  	
## [SLES 12.x/15.x](#tab/SLES)

### Configure DNS servers

1. The initial configuration of the `/etc/resolv.conf` file in an Azure SLES VM is as follows:

   :::image type="content" source="./media/custom-dns-config-images/sles-dns-1.png" alt-text="Screenshot of default resolv.conf file in SUSE.":::

2. Configure custom DNS servers at the Azure virtual network or network interface level. For more information, see [Steps to change DNS servers at virtual network/network interface level](/azure/virtual-network/manage-virtual-network).
    > [!NOTE]
    > In Azure, you can set custom DNS servers at the virtual network level or the network interface level. If you set custom DNS servers at the network interface level, it will override the the custom DNS servers configuration in the virtual network.
3. Restart the `wicked.service`, and then check  `/etc/resolv.conf` file. It should contain the DNS servers you configured in the step 2.

   ```bash
   sudo systemctl restart wicked.service
   ```

   :::image type="content" source="./media/custom-dns-config-images/sles-dns-2.png" alt-text="Screenshot of resolv.conf after restarting wicked service.":::

### Configure search domains

1. Edit the `/etc/sysconfig/network/config` file.
1. Add a line for the search domain, as shown in the example below:

   ```config
   NETCONFIG_DNS_STATIC_SEARCHLIST="test.example.com"
   ```
   Multiple search domains can be declared using a space separator, as demonstrated here:

   ```config
   NETCONFIG_DNS_STATIC_SEARCHLIST="test.example.com test1.example.com"
   ```
    
1. Restart `wicked.service` or update `netconfig`, and check if the search domain is updated in `/etc/resolv.conf` file.

   ```bash
   sudo systemctl restart wicked.service
   ```
    or

   ```bash
   sudo netconfig update
   ```
   Example of the `/etc/resolv.conf` file after configuring the search domains.
   :::image type="content" source="./media/custom-dns-config-images/sles-dns-3.png" alt-text="Screenshot of resolv.conf after final changes":::
---

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
