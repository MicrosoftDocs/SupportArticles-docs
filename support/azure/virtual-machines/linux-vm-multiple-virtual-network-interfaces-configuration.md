---
title: Configure multiple network interfaces in Azure Linux virtual machines
description: Describes how to configure multiple network interfaces in Azure Linux virtual machines running the most common Linux distributions.
ms.date: 07/28/2022
ms.author: genli
author: genlin
ms.reviewer: malachma
ms.service: virtual-machines
ms.subservice: vm-linux-setup-configuration
ms.collection: linux
---
# Configure multiple network interfaces in Azure Linux virtual machines

This article discusses how to configure multiple virtual network interfaces in Azure Linux virtual machines (VMs) that run the most common Linux distributions.

## Summary

You can create an Azure VM that has multiple network interfaces attached to it. A common scenario is to have different subnets for front-end and back-end connectivity, or a network that's dedicated to a monitoring or backup solution.

This article provides the required configuration for multiple network interfaces to work in an Azure Linux VM that's based on the following sample scenario:

- The VM has two network interfaces in the same subnet.
- Connectivity is tested from another VM in the same virtual network (VNET) or subnet.

For details, see the following screenshot.

:::image type="content" source="media/linux-vm-multiple-virtual-network-interfaces-configuration/vm-two-nics-same-subnet.png" alt-text="Diagram that shows networking configuration of the sample scenario.":::

The configuration can also be used on a VM that has more network interfaces on the same or different subnets in the same VNET.

## Configure guest OS for multiple network interfaces

When you add multiple network interfaces to a Linux VM, you have to create routing rules. These rules enable the VM to send and receive traffic that belongs to a specific network interface. Otherwise, traffic can't be processed correctly. For example, traffic that belongs to eth1 can't be processed correctly by the defined default route.

> [!IMPORTANT]
> Run all the commands in the following sections by using root privileges (by switching to the root or by using the `sudo` command utility).

## Configure multiple network interfaces for RHEL/CentOS 7.*x* VMs

1. Assume that the VM has two network interfaces that have the following settings:

    - Routing (the output of `ip route show`):

        ```Output
        default via 10.0.1.1 dev eth0 proto static metric 100
        10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.4 metric 100
        10.0.1.0/24 dev eth1 proto kernel scope link src 10.0.1.5 metric 101
        168.63.129.16 via 10.0.1.1 dev eth0 proto dhcp metric 100
        169.254.169.254 via 10.0.1.1 dev eth0 proto dhcp metric 100
        ```

    - Interfaces (the output of `ip address show`):

        ```Output
        lo: inet 127.0.0.1/8 scope host lo
        eth0: inet 10.0.1.4/24 brd 10.0.1.255 scope global eth0    
        eth1: inet 10.0.1.5/24 brd 10.0.1.255 scope global eth1
        ```
1. Add two routing tables to */etc/iproute2/rt_tables* by running the following commands:

    ```bash
    echo "200 eth0-rt" >> /etc/iproute2/rt_tables
    echo "201 eth1-rt" >> /etc/iproute2/rt_tables
    ```

1. Make sure that a configuration file exists for each network interface in the */etc/sysconfig/network-scripts/* directory. You can create new network interface configuration files based on the *ifcfg-eth0* file (by modifying the `DEVICE` line and removing the `DHCP_HOSTNAME` and `HWADDR` lines from the new file). To do this, run the following commands:

    ```bash
    cat /etc/sysconfig/network-scripts/ifcfg-eth0 > /etc/sysconfig/network-scripts/ifcfg-eth1
    sed -i  's/DEVICE=eth0/DEVICE=eth1/' /etc/sysconfig/network-scripts/ifcfg-eth1
    sed -i '/DHCP_HOSTNAME/,$d' /etc/sysconfig/network-scripts/ifcfg-eth1
    sed -i '/HWADDR/,$d' /etc/sysconfig/network-scripts/ifcfg-eth1
    ```

1. To make the change persistent and applied during network stack activation, edit */etc/sysconfig/network-scripts/ifcfg-eth0* and */etc/sysconfig/network-scripts/ifcfg-eth1* (eth2, eth3, and so on, if the VM has more than two network interfaces). Change the value of `NM_CONTROLLED` from `yes` to `no`. To do this, run the following commands:

    ```bash
    cp -rp /etc/sysconfig/network-scripts/ifcfg-eth0 /tmp/ifcfg-eth0.bkp
    cp -rp /etc/sysconfig/network-scripts/ifcfg-eth1 /tmp/ifcfg-eth1.bkp
    sed -i 's/NM_CONTROLLED=yes/NM_CONTROLLED=no/' /etc/sysconfig/network-scripts/ifcfg-eth0
    sed -i 's/NM_CONTROLLED=yes/NM_CONTROLLED=no/' /etc/sysconfig/network-scripts/ifcfg-eth1
    ```

    > [!NOTE]
    > Verify that the `NM_CONTROLLED=no` line is added to both the */etc/sysconfig/network-scripts/ifcfg-eth0* and */etc/sysconfig/network-scripts/ifcfg-eth1* files. If the line isn't there, add it manually.

1. To make sure that the network services are restarted, run the following command:

    ```bash
    systemctl restart network
    ```

1. Create corresponding rule and route files, and add appropriate rules and routes to each file. Use the following steps to create one set of rule-eth# and route-eth# files per network interfaces. Replace the IP address and subnet information accordingly in every step. If you have more network interfaces, create the same set of rule-eth# and route-eth# files for each interface by using the corresponding IP and subnet details.

    - Create rules and routes for eth0:

      1. To create the rule file for eth0, run the following command:

          ```bash
          vi /etc/sysconfig/network-scripts/rule-eth0
          ```

      2. Add the following contents to the rule file (adjust the IP address accordingly, and make sure that you specify the IPv4 address in the configuration):

          ```Configuration
          from 10.0.1.4/32 table eth0-rt
          to 10.0.1.4/32 table eth0-rt
          ```

      3. To create the route file for eth0, run the following command:

          ```bash
           vi /etc/sysconfig/network-scripts/route-eth0
           ```

      4. Add the following contents to the route file:

          ```Configuration
            10.0.1.0/24 dev eth0 table eth0-rt
            default via 10.0.1.1 dev eth0 table eth0-rt
            ```
    
    - Create rules and routes for eth1:
      1. To create the rule file for eth1, run the following command:
    
            ```bash
            vi /etc/sysconfig/network-scripts/rule-eth1
            ```
      2. Add the following contents to the rule file (adjust the IP address accordingly, and make sure that you specify the IPv4 address in the command):
    
            ```Configuration
            from 10.0.1.5/32 table eth1-rt
            to 10.0.1.5/32 table eth1-rt
            ```
    
      3. To create the route file for eth1, run the following command:
    
            ```bash
            vi /etc/sysconfig/network-scripts/route-eth1
            ```
    
      4. Add the following contents to the route file:
    
            ```Configuration
            10.0.1.0/24 dev eth1 table eth1-rt
            default via 10.0.1.1 dev eth1 table eth1-rt
            ```

1. To apply the changes, run the following command to restart the network service:

    ```bash
    systemctl restart network
    ```

The routing rules are now correctly configured, and you can connect by using either interface, as appropriate.

## Configure multiple network interfaces for RHEL/CentOS 8._x_ VM

1. Assume that the VM has two network interfaces that have the following settings:

    - Routing (the output of `ip route show`):

        ```Output
        default via 10.0.1.1 dev eth0 proto static metric 100
        10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.4 metric 100
        10.0.1.0/24 dev eth1 proto kernel scope link src 10.0.1.5 metric 101
        168.63.129.16 via 10.0.1.1 dev eth0 proto dhcp metric 100
        169.254.169.254 via 10.0.1.1 dev eth0 proto dhcp metric 100
        ```

    - Interfaces (the output of `ip address show`):

        ```Output
        lo: inet 127.0.0.1/8 scope host lo
        eth0: inet 10.0.1.4/24 brd 10.0.1.255 scope global eth0    
        eth1:
        ```
 1. By default, policy routing isn't installed in Red Hat Enterprise Linux (RHEL)/CentOS 8._x_. To configure multiple network interfaces, install and enable the policy routing. To do this, run the following commands:

    ```bash
    yum install NetworkManager-dispatcher-routing-rules -y
    systemctl enable NetworkManager-dispatcher.service
    systemctl start NetworkManager-dispatcher.service
    ```

1. If the `NM_CONTROLLED` setting should be set to `yes` in each network configuration file (*/etc/sysconfig/network-scripts/ifcfg-eth#*), make sure that a corresponding file is created for each network interface. The following is the sample configuration for network configuration files:

    - */etc/sysconfig/network-scripts/ifcfg-eth0*:

        ```Configuration
        DEVICE=eth0
        ONBOOT=yes
        BOOTPROTO=dhcp
        TYPE=Ethernet
        USERCTL=no
        PEERDNS=yes
        IPV6INIT=no
        PERSISTENT_DHCLIENT=yes
        NM_CONTROLLED=yes
        ```

    - */etc/sysconfig/network-scripts/ifcfg-eth1*:
    
        ```Configuration
        DEVICE=eth1
        ONBOOT=yes
        BOOTPROTO=dhcp
        TYPE=Ethernet
        USERCTL=no
        PEERDNS=yes
        IPV6INIT=no
        PERSISTENT_DHCLIENT=yes
        NM_CONTROLLED=yes
        ```

1. Run the following commands to add two routing tables to */etc/iproute2/rt_tables*:

    ```bash
    echo "200 eth0-rt" >> /etc/iproute2/rt_tables
    echo "201 eth1-rt" >> /etc/iproute2/rt_tables
    ```

    If more network interfaces are attached to the VM, add extra routing tables (202 eth2-rt, 203, eth3-rt, and so on).

1. Create the corresponding files, and add the appropriate rules and routes to each of them. To create one set of rule-eth# and route-eth# files per network interfaces, follow these steps. Replace the IP address and subnet information accordingly in every step. If you have more network interfaces, create the same set of rule-eth# and route-eth# files for each interface by using the corresponding IP and subnet details.

    - Create rules and routes for eth0:

      1. Create the rule file for eth0 by running the following command:

          ```bash
          vi /etc/sysconfig/network-scripts/rule-eth0
          ```

      2. Add the following contents to the rule file (adjust the IP address accordingly, and make sure that you specify the IPv4 address in the command):

          ```Configuration
          from 10.0.1.4/32 table eth0-rt
          to 10.0.1.4/32 table eth0-rt
          ```
      3. Create the route file for eth0 by running the following command:
  
          ```bash
          vi /etc/sysconfig/network-scripts/route-eth0
          ```
      4. Add the following contents to the route file:
        
          ```Configuration
          10.0.1.0/24 dev eth0 table eth0-rt
          default via 10.0.1.1 dev eth0 table eth0-rt
          ```

    - Create rules and routes for eth1:

      1. Create the rule file for eth1 by running the following command:
      
          ```bash
          vi /etc/sysconfig/network-scripts/rule-eth1
          ```
      2. Add the following contents to the rule file (adjust the IP address accordingly, and make sure that you specify the IPv4 address in the command):
      
          ```Configuration
          from 10.0.1.5/32 table eth1-rt
          to 10.0.1.5/32 table eth1-rt
          ```
      3. Create the route file for eth1 by running the following command:
      
          ```bash
          vi /etc/sysconfig/network-scripts/route-eth1
          ```
      4. Add the following contents to the route file:
      
          ```Configuration
          10.0.1.0/24 dev eth1 table eth1-rt
          default via 10.0.1.1 dev eth1 table eth1-rt
          ```

6. To apply the changes, restart the network service by running the following command:

    ```bash
    systemctl restart NetworkManager
    ```

The routing rules are now correctly set, and connectivity should work from either network interface, as appropriate. You can test the connectivity by using Secure Shell (SSH), or by pinging both IPs from a VM in the same VNET.

You can verify the current routes and rules by using the following commands:

```bash
ip route show
ip rule show
```

If you encounter some issues, restart the VM by using the `reboot` command, and repeat the previous step to verify that the routes and rules are loaded.

## Configure multiple network interfaces for Ubuntu 18.04/20.04 VMs

1. Assume that the VM has two network interfaces that have the following settings:

    - Routing (the output of `ip route show`):

        ```Output
        default via 10.0.1.1 dev eth0 proto static metric 100
        10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.4 metric 100
        10.0.1.0/24 dev eth1 proto kernel scope link src 10.0.1.5 metric 101
        168.63.129.16 via 10.0.1.1 dev eth0 proto dhcp metric 100
        169.254.169.254 via 10.0.1.1 dev eth0 proto dhcp metric 100
        ```

    - Interfaces (the output of `ip address show`):

        ```Output
        lo: inet 127.0.0.1/8 scope host lo
        eth0: inet 10.0.1.4/24 brd 10.0.1.255 scope global eth0    
        eth1: inet 10.0.1.5/24 brd 10.0.1.255 scope global eth1
        ```

1. Add two routing tables to */etc/iproute2/rt_tables* by running the following commands:

    ```bash
    echo "200 eth0-rt" >> /etc/iproute2/rt_tables
    echo "201 eth1-rt" >> /etc/iproute2/rt_tables
    ```

1. If Cloud-Init automation is set (the default in the Azure Ubuntu images), make sure that the network CI automation is disabled so that the */etc/netplan/50-cloud-init.yaml* file doesn't get overwritten every time that the system is restarted.

    Create the */etc/cloud/cloud.cfg.d/99-disable-network-config.cfg* by using the following command and contents:

    ```bash
    vi /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
    ```

    ```yaml
    network:
       config: disabled
    ```

1. Modify the netplan configuration file */etc/netplan/50-cloud-init.yaml*, and include the following routes and policy-routing blocks in each network interface section:

    ```yaml
    routes:
     - to: <subnet>/24
       via: <gatewayIP>
       metric: 200
       table: 201
     - to: 0.0.0.0/0
       via: <gatewayIP>
       table: <routingTableID>
    routing-policy:
     - from: <NICIP>/32
       table: <routingTableID>
     - to: <NICIP>/32
       table: <routingTableID>
    ```

    Replace the subnet, MAC Address and IP address for each network interface (eth0 and eth1) accordingly.

    Here's the sample configuration file that uses the given sample details:

    ```bash
    vi /etc/netplan/50-cloud-init.yaml
    ```

    ```yaml
    network:
        ethernets:
            eth0:
                dhcp4: true
                dhcp4-overrides:
                    route-metric: 100
                dhcp6: false
                match:
                    driver: hv_netvsc
                    macaddress: 00:0d:3a:9d:60:e6
                set-name: eth0
                routes:
                 - to: 10.0.1.0/24
                   via: 10.0.1.1
                   metric: 200
                   table: 200
                 - to: 0.0.0.0/0
                   via: 10.0.1.1
                   table: 200
                routing-policy:
                 - from: 10.0.1.4/32
                   table: 200
                 - to: 10.0.1.4/32
                   table: 200
            eth1:
                dhcp4: true
                dhcp4-overrides:
                    route-metric: 200
                dhcp6: false
                match:
                    driver: hv_netvsc
                    macaddress: 00:0d:3a:9a:25:5f
                set-name: eth1
                routes:
                 - to: 10.0.1.0/24
                   via: 10.0.1.1
                   metric: 200
                   table: 201
                 - to: 0.0.0.0/0
                   via: 10.0.1.1
                   table: 201
                routing-policy:
                 - from: 10.0.1.5/32
                   table: 201
                 - to: 10.0.1.5/32
                   table: 201
          version: 2
    ```

1. Apply the changes by running the following command:

    ```bash
    netplan apply
    ```

1. To test the connectivity, ping or SSH both IPs from another VM in the same VNET:

    ```bash
    ping 10.0.1.4
    ping 10.0.1.5
    ```

## Configure multiple network interfaces for Debian 10 VMs

1. Assume that the VM has two network interfaces that have the following settings:

    - Routing (the output of `ip route show`):

        ```Output
        default via 10.0.1.1 dev eth0 proto static metric 100
        10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.4 metric 100
        10.0.1.0/24 dev eth1 proto kernel scope link src 10.0.1.5 metric 101
        168.63.129.16 via 10.0.1.1 dev eth0 proto dhcp metric 100
        169.254.169.254 via 10.0.1.1 dev eth0 proto dhcp metric 100
        ```

    - Interfaces (the output of `ip address show`):

        ```Output
        lo: inet 127.0.0.1/8 scope host lo
        eth0: inet 10.0.1.4/24 brd 10.0.1.255 scope global eth0    
        eth1: inet 10.0.1.5/24 brd 10.0.1.255 scope global eth1
        ```

1. Add two routing tables to */etc/iproute2/rt_tables* by running the following commands:

    ```bash
    # echo "200 eth0-rt" >> /etc/iproute2/rt_tables
    # echo "201 eth1-rt" >> /etc/iproute2/rt_tables
    ```

1. Create or modify the */etc/network/interfaces.d/50-cloud-init*  file by using the following configuration:

    ```Configuration
    auto lo
    iface lo inet loopback

    auto eth0
    iface eth0 inet dhcp
    metric 100
    up /usr/sbin/ip route add default via 10.24.0.1 dev eth0 table eth0-rt
    up /usr/sbin/ip rule add from 10.24.0.4/32 table eth0-rt
    up /usr/sbin/ip rule add to 10.24.0.4/32 table eth0-rt

    auto eth1
    iface eth1 inet dhcp
    metric 200
    up /usr/sbin/ip route add 10.24.1.0/24 dev eth1 table eth1-rt
    up /usr/sbin/ip route add default via 10.24.1.1 dev eth1 table eth1-rt
    up /usr/sbin/ip rule add from 10.24.1.4/32 table eth1-rt
    up /usr/sbin/ip rule add to 10.24.1.4/32 table eth1-rt
    ```

1. Activate the new configuration:

    ```bash
    systemctl restart networking
    ```

## Configure multiple network interfaces for SLES 11._x_/12._x_/15._x_ VMs

1. Assume that the VM has two network interfaces that have the following settings:

    - Routing (the output of `ip route show`):

        ```Output
        default via 10.0.1.1 dev eth0 proto static metric 100
        10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.4 metric 100
        10.0.1.0/24 dev eth1 proto kernel scope link src 10.0.1.5 metric 101
        168.63.129.16 via 10.0.1.1 dev eth0 proto dhcp metric 100
        169.254.169.254 via 10.0.1.1 dev eth0 proto dhcp metric 100
        ```

    - Interfaces (the output of `ip address show`):

        ```Output
        lo: inet 127.0.0.1/8 scope host lo
        eth0: inet 10.0.1.4/24 brd 10.0.1.255 scope global eth0    
        eth1: inet 10.0.1.5/24 brd 10.0.1.255 scope global eth1
        ```

1. Add two routing tables to */etc/iproute2/rt_tables* by running the following commands:

    ```bash
    echo "200 eth0-rt" >> /etc/iproute2/rt_tables
    echo "201 eth1-rt" >> /etc/iproute2/rt_tables
    ```

1. Extend the routing tables.

    Assume that the following routing setup is configured:

    - Routing:

      ```Output
      default via 10.0.1.1 dev eth0 proto static metric 100
      10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.4 metric 100
      10.0.1.0/24 dev eth1 proto kernel scope link src 10.0.1.5 metric 101
      168.63.129.16 via 10.0.1.1 dev eth0 proto dhcp metric 100
      169.254.169.254 via 10.0.1.1 dev eth0 proto dhcp metric 100
      ```

    - Interfaces:

      ```Output
      lo: inet 127.0.0.1/8 scope host lo
      eth0: link/ether 00:0d:3a:9d:60:e6 brd ff:ff:ff:ff:ff:ff
      inet 10.0.1.4/24 brd 10.0.1.255 scope global eth0    
      eth1: link/ether 00:0d:3a:9a:25:5f brd ff:ff:ff:ff:ff:ff
      inet 10.0.1.5/24 brd 10.0.1.255 scope global eth1
      ```

1. To create the scripts that have the routes and rules for each network interface in the */etc/sysconfig/network/scripts/* directory, run the following command:

    - */etc/sysconfig/network/scripts/ifup-route.eth0*
    
        ```bash
        vi /etc/sysconfig/network/scripts/ifup-route.eth0
        ```
    
        ```bash
        !/bin/bash
        
        /sbin/ip route add default via 10.0.1.1 dev eth0 table eth0-rt
        /sbin/ip rule add from 10.0.1.4/32 table eth0-rt
        /sbin/ip rule add to 10.0.1.4/32 table eth0-rt
        ```
    
    - */etc/sysconfig/network/scripts/ifup-route.eth1*

        ```bash
        vi /etc/sysconfig/network/scripts/ifup-route.eth1
        ```

        ```bash
        !/bin/bash
        
        /sbin/ip route add 10.0.1.0/24 dev eth1 table eth1-rt
        /sbin/ip route add default via 10.0.1.1 dev eth1 table eth1-rt
        /sbin/ip rule add from 10.0.1.5/32 table eth1-rt
        /sbin/ip rule add to 10.0.1.5/32 table eth1-rt
        ```

    Adjust the Network and IP address information accordingly. If there are more than two NICs, make sure that the corresponding IP rules and IP routes are included for each one.
  
1. Provide execution permissions to both scripts:

    ```bash
    chmod +x /etc/sysconfig/network/scripts/ifup-route.eth0
    chmod +x /etc/sysconfig/network/scripts/ifup-route.eth1
    ```

1. Modify the network configuration files for both eth0 and eth1 (*/etc/sysconfig/network/ifcfg-eth#*), and include the following line in both files to point to the corresponding script:

    ```Configuration
    POST_UP_SCRIPT='compat:suse:/etc/sysconfig/network/scripts/ifup-route.eth#'
    ```
  
    For SLES 11, exclude `compat:suse` from the following line: `POST_UP_SCRIPT='/etc/sysconfig/network/scripts/ifup-route.eth#'`.
  
    Here's a sample of both configuration files:
  
    ```bash
    vi /etc/sysconfig/network/ifcfg-eth0
    
    BOOTPROTO='dhcp'
    DHCLIENT6_MODE='managed'
    MTU=''
    REMOTE_IPADDR=''
    STARTMODE='onboot'
    CLOUD_NETCONFIG_MANAGE='yes'
    POST_UP_SCRIPT="compat:suse:/etc/sysconfig/network/scripts/ifup-route.eth0"
    
    vi /etc/sysconfig/network/ifcfg-eth1
    
    STARTMODE="hotplug"
    BOOTPROTO="dhcp"
    DHCLIENT_SET_DEFAULT_ROUTE="yes"
    DHCLIENT_ROUTE_PRIORITY="10100"
    CLOUD_NETCONFIG_MANAGE="yes"
    POST_DOWN_SCRIPT="compat:suse:cloud-netconfig-cleanup"
    POST_UP_SCRIPT="compat:suse:/etc/sysconfig/network/scripts/ifup-route.eth1"
    ```

    If */etc/sysconfig/network/ifcfg-eth1* doesn't exist, create it by using the contents from */etc/sysconfig/network/ifcfg-eth0*. To do this, run the following command:

    ```bash
    cp -rp /etc/sysconfig/network/ifcfg-eth0 /etc/sysconfig/network/ifcfg-eth1
    ```

1. To apply the changes, restart the network service:

    ```bash
    systemctl restart network
    ```

    For SUSE Linux Enterprise Server (SLES) 11, use `service network restart`.

After you make these changes, both IP addresses should be reachable from a VM within the same VNET. You can test this by using "ping" or SSH to access both IPs.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
