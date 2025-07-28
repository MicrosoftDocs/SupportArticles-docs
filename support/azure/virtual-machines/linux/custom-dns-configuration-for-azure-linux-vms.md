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

This article provides instructions to configure custom DNS servers and search domains on Microsoft Azure Linux virtual machines (VMs).

> [!NOTE]
> This article uses DNS servers `1.2.3.4` and `5.6.7.8` and search domain `"test.example.com"` as examples. Replace these values with your actual DNS server addresses and search domain path.

## [RHEL 8._x_/9._x_](#tab/RHEL)

### Configure custom DNS servers
1. The initial configuration of the `/etc/resolv.conf` file in an Azure Linux VM is as shown in the following screenshot.

    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-1.png" alt-text="Screenshot of default resolv.conf file in RHEL.":::
2. Configure custom DNS servers at the Azure virtual network or network interface level. For more information, see [Steps to change DNS servers at virtual network/network interface level](/azure/virtual-network/manage-virtual-network#change-dns-servers).

    > [!NOTE]
    > In Azure, you can set custom DNS servers at the virtual network level or the network interface level. If you set custom DNS servers at the network interface level, it will override the custom DNS servers configuration in the virtual network.

3. Restart the `NetworkManager` service, and then check the `/etc/resolv.conf` file. The file should contain the DNS servers that you configured in the step 2.

    ```bash
      sudo systemctl restart NetworkManager
    ```

    The following screenshot shows an example of `/etc/resolv.conf` after you configure the DNS servers.
    
    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-2.png" alt-text="Screenshot of resolv.conf file post changing the DNS servers at portal level.":::

4. Run the following command to determinate whether the DNS servers are successfully added to the network interface:

    ```bash
    sudo systemd-resolve --status
    ```
    
   The following screenshot shows an example of the network interface after you configure the DNS servers.

    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-3.png" alt-text="Screenshot of command's partial output.":::

### Configure search domains

1. To change the search domain, add the domain name as follows in `/etc/dhcp/dhclient.conf`. To specify multiple search domains, separate them by using commas (for example: `"test.example.com, test1.example.com, test2.example.com"`):
 
    ```config
    append domain-search "test.example.com";
    ```
     Example of `/etc/dhcp/dhclient.conf` file after you add the search domain:

    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-4.png" alt-text="Screenshot of dhclient.conf file post modification.":::

2. Restart the `NetworkManager` service, and then check whether the search domain is updated in `/etc/resolv.conf`file:
    
    ```bash
    sudo systemctl restart NetworkManager
    ```
    The following screenshot shows an example of `/etc/resolv.conf` file after you configure the search domain.
    
    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-5.png" alt-text="Screenshot of resolv.conf file after restarting NM service.":::

3. Run the following command to determinate whether the search domain is successfully added to the network interface:

    ```bash
    sudo systemd-resolve --status
    ```

    The following screenshot shows an example of the network interface after you configure the search domain.

    :::image type="content" source="./media/custom-dns-config-images/rhel-dns-6.png" alt-text="Screenshot showing the search domain.":::

## [RHEL 10](#tab/RHEL10)

Guidance for configuring custom DNS on **RHEL 10** is currently being developed in collaboration with Red Hat. This section will be updated once validated instructions are available. Please check back for the latest information.

## [Ubuntu 20.04/22.04/24.04](#tab/Ubuntu)

### Configure DNS servers

1. The initial configuration of the `/etc/resolv.conf` file in an Azure Ubuntu VM is as shown in the following screenshot.

    :::image type="content" source="./media/custom-dns-config-images/ubuntu-dns-1.png" alt-text="Screenshot of default resolv.conf file in Ubuntu.":::

2. Starting with Ubuntu 20.04, `resolv.conf` file is a symbolic link to `/run/systemd/resolve/stub-resolv.conf`. For more information about this stub file, significance and usage of different `resolv.conf` files, and `systemd-resolved` service, see [systemd-resolved](https://manpages.ubuntu.com/manpages/bionic/man8/systemd-resolved.service.8.html#:~:text=systemd%2Dresolved%20is%20a%20system,an%20LLMNR%20resolver%20and%20responder)
   
    :::image type="content" source="./media/custom-dns-config-images/ubuntu-dns-2.png" alt-text="Screenshot of resolv.conf file linked to stub-resolv.conf file":::

3. Configure custom DNS servers at either the Azure virtual network or network interface level. For more information, see [Steps to change DNS servers at virtual network/network interface level](/azure/virtual-network/manage-virtual-network#change-dns-servers).

    > [!NOTE]
    > In Azure, you can set custom DNS servers at the virtual network level or the network interface level. If you set custom DNS servers at the network interface level, this will override the custom DNS servers configuration in the virtual network.

4. Run the following command to apply the custom DNS configuration:

   ```bash
   sudo netplan apply
   ```
5. Verify the contents of `/run/systemd/resolve/resolv.conf` file. It should list the DNS servers configured in step 3.
    
   The following screenshot shows an example of `/run/systemd/resolve/resolv.conf` after configuring custom DNS servers.

   :::image type="content" source="./media/custom-dns-config-images/ubuntu-dns-3.png" alt-text="Screenshot of non-stub Resolv.conf file after you make changes at portal level":::

6. Since `/etc/resolv.conf` is still linked to stub file, unlink and create a new link to `/run/systemd/resolve/resolv.conf`, so that DNS queries the updated custom DNS servers.

   ```bash
    unlink /etc/resolv.conf
    ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
    ```
   The following screenshot shows an example output of the `resolvecl status` command:

   :::image type="content" source="./media/custom-dns-config-images/ubuntu-dns-4.png" alt-text="Screenshot of resolvectl status command output.":::

### Configure search domains

1. Use a text editor (such as Nano or Vim) to create a YAML configuration file in the `/etc/netplan/` for the DNS servers. For example:

      ```
      sudo nano /etc/netplan/custom-dns-01.yaml
      ```

      or
   
      ```
      sudo vi /etc/netplan/custom-dns-01.yaml
      ```
   
3. Add the following configuration, and then save and exit. If you’re use Nano, press `CTRL + O` to save and `CTRL + X` to exit. If you use Vim, press ESC, type `:wq`, and then press Enter to save and exit. 

    ```yaml
    network:
        ethernets:
          eth0:
            nameservers:
              search: [ test.example.com ]
    ```
    The configuration might conatin multiple search domains separated by commas. For example: '["test.example.com", "test1.example.com", "test2.example.com"]`.
4. Run the following command to apply the search domain changes:
  
   ```bash
   sudo netplan apply
   ```

5. View the `resolvectl` status to determinate whether the search domain is added successfully:

   ```bash
   sudo resolvectl status
   ```

   :::image type="content" source="./media/custom-dns-config-images/ubuntu-dns-5.png" alt-text="Screenshot of resolvectl after final changes.":::
  	
## [SLES 12._x_/15._x_](#tab/SLES)

### Configure DNS servers

1. The initial configuration of the `/etc/resolv.conf` file in an Azure SLES VM is as shown in the following screenshot.

   :::image type="content" source="./media/custom-dns-config-images/sles-dns-1.png" alt-text="Screenshot of default resolv.conf file in SUSE.":::

2. Configure custom DNS servers at the Azure virtual network or network interface level. For more information, see [Steps to change DNS servers at virtual network/network interface level](/azure/virtual-network/manage-virtual-network#change-dns-servers).
    > [!NOTE]
    > In Azure, you can set custom DNS servers at the virtual network level or the network interface level. If you set custom DNS servers at the network interface level, this will override the custom DNS servers configuration in the virtual network.
3. Restart the `wicked.service`, and then check the `/etc/resolv.conf` file. The file should contain the DNS servers that you configured in step 2:

   ```bash
   sudo systemctl restart wicked.service
   ```

   :::image type="content" source="./media/custom-dns-config-images/sles-dns-2.png" alt-text="Screenshot of Resolv.conf after you restart wicked service.":::

### Configure search domains

1. Edit the `/etc/sysconfig/network/config` file.
1. Add a line for the search domain, as shown in the following example:

   ```config
   NETCONFIG_DNS_STATIC_SEARCHLIST="test.example.com"
   ```
   Multiple search domains can be declared by using a space separator, as follows:

   ```config
   NETCONFIG_DNS_STATIC_SEARCHLIST="test.example.com test1.example.com"
   ```
    
1. Restart `wicked.service` or update `netconfig`, and then check whether the search domain is updated in the `/etc/resolv.conf` file.

   ```bash
   sudo systemctl restart wicked.service
   ```
    or

   ```bash
   sudo netconfig update
   ```
   The following screenshot is an example of the `/etc/resolv.conf` file after you configure the search domains.

   :::image type="content" source="./media/custom-dns-config-images/sles-dns-3.png" alt-text="Screenshot of Resolv.conf after final changes":::
---

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
