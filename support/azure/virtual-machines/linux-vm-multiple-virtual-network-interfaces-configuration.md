---
title: Configure multiple NICs in Azure Linux virtual machines
description: Describes how to configure multiple NICs in Azure Linux virtual machines running the most common Linux distributions.
ms.date: 07/28/2022
ms.author: genli
author: genlin
ms.reviewer: malachma
ms.service: virtual-machines
ms.collection: linux
---
# Configure multiple NICs in Azure Linux virtual machines

This article introduces how to configure multiple virtual network interfaces (NICs) in Azure Linux virtual machines (VMs) running the most common Linux distributions.

## Summary

You can create an Azure VM that has multiple NICs attached to it. A common scenario is to have different subnets for front-end and back-end connectivity, or a network that's dedicated to a monitoring or backup solution.

This article provides the required configuration for multiple NICs to work in an Azure Linux VM based on the following sample scenario:

- The VM has two NICs in the same subnet.
- Connectivity is tested from another VM in the same virtual network (VNET) or subnet.

See the following screenshot for details:

:::image type="content" source="media/linux-vm-multiple-virtual-network-interfaces-configuration/vm-two-nics-same-subnet.png" alt-text="Image alt text.":::

The configuration can also be used on a VM with more NICs on the same or different subnets in the same VNET.

## Configure guest OS for multiple NICs

When you add multiple NICs to a Linux VM, you need to create routing rules. These rules allow the VM to send and receive traffics that belongs to a specific NIC. Otherwise, traffics can't be processed correctly. For example, traffics that belongs to eth1 can't be processed correctly by the defined default route.

> [!IMPORTANT]
> Run all the commands in the following sections by using root privileges (switching to root or with `sudo`).

## Configure multiple NICs for RHEL/CentOS 7.x VMs

1. Add two routing tables to */etc/iproute2/rt_tables* by running the following commands:

    ```bash
    # echo "200 eth0-rt" >> /etc/iproute2/rt_tables
    # echo "201 eth1-rt" >> /etc/iproute2/rt_tables
    ```

2. Make sure a configuration file exists for each network interface in the */etc/sysconfig/network-scripts/* directory. You can create new network interface configuration files based on the *ifcfg-eth0* file (modifying the `DEVICE` line and removing the `DHCP_HOSTNAME` and `HWADDR` lines from the new file). To do this, run the following commands:

    ```bash
    # cat /etc/sysconfig/network-scripts/ifcfg-eth0 > /etc/sysconfig/network-scripts/ifcfg-eth1
    # sed -i  's/DEVICE=eth0/DEVICE=eth1/' /etc/sysconfig/network-scripts/ifcfg-eth1
    # sed -i '/DHCP_HOSTNAME/,$d' /etc/sysconfig/network-scripts/ifcfg-eth1
    # sed -i '/HWADDR/,$d' /etc/sysconfig/network-scripts/ifcfg-eth1
    ```

3. To make the change persistent and applied during network stack activation, edit */etc/sysconfig/network-scripts/ifcfg-eth0* and */etc/sysconfig/network-scripts/ifcfg-eth1* (eth2, eth3, and so on, and so forth if the VM has more than two NICs). Change the value of `NM_CONTROLLED` from `yes` to `no`. To do this, run the following commands:

    ```bash
    # cp -rp /etc/sysconfig/network-scripts/ifcfg-eth0 /tmp/ifcfg-eth0.bkp
    # cp -rp /etc/sysconfig/network-scripts/ifcfg-eth1 /tmp/ifcfg-eth1.bkp
    # sed -i 's/NM_CONTROLLED=yes/NM_CONTROLLED=no/' /etc/sysconfig/network-scripts/ifcfg-eth0
    # sed -i 's/NM_CONTROLLED=yes/NM_CONTROLLED=no/' /etc/sysconfig/network-scripts/ifcfg-eth1
    ```

    > [!NOTE]
    > Validate that the `NM_CONTROLLED=no` line is added to both */etc/sysconfig/network-scripts/ifcfg-eth0* and */etc/sysconfig/network-scripts/ifcfg-eth1* files. If the line isn't there, add it manually.

4. Run the following command to make sure that the network services are restarted:

    ```bash
    # systemctl restart network
    ```

5. Extend the routing tables. Assume the following routing setup in place:

    - Routing (the output of `ip route show`):

        ```
        default via 10.0.1.1 dev eth0 proto static metric 100
        10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.4 metric 100
        10.0.1.0/24 dev eth1 proto kernel scope link src 10.0.1.5 metric 101
        168.63.129.16 via 10.0.1.1 dev eth0 proto dhcp metric 100
        169.254.169.254 via 10.0.1.1 dev eth0 proto dhcp metric 100
        ```

    - Interfaces (the output of `ip address`):

        ```
        lo: inet 127.0.0.1/8 scope host lo
        eth0: inet 10.0.1.4/24 brd 10.0.1.255 scope global eth0    
        eth1: inet 10.0.1.5/24 brd 10.0.1.255 scope global eth1
        ```

6. Create corresponding rule and route files and add proper rules and routes to each file. Follow the steps below to create one set of rule-eth# and route-eth# files per NICs. Replace the IP address and subnet information accordingly in every step. If you have more NICs, create the same set of rule-eth# and route-eth# files for each of them with the corresponding IP and subnet details.

    - Create rules and routes for eth0:

      1. Run the following command to create the rule file for eth0:

          ```bash
          # vi /etc/sysconfig/network-scripts/rule-eth0
          ```

      2. Add the following contents to the rule file (adjust the IP address accordingly, make sure you keep the 32 bit):

          ```
          from 10.0.1.4/32 table eth0-rt
          to 10.0.1.4/32 table eth0-rt
          ```

      3. Run the following command to create the route file for eth0:

        ```bash
        # vi /etc/sysconfig/network-scripts/route-eth0
        ```

      4. Add the following contents to the route file:
    
        ```
        10.0.1.0/24 dev eth0 table eth0-rt
        default via 10.0.1.1 dev eth0 table eth0-rt
        ```
    
    - Create rules and routes for eth1:
      1. Run the following command to create the rule file for eth1:
    
        ```bash
        # vi /etc/sysconfig/network-scripts/rule-eth1
        ```
      2. Add the following contents to the rule file (adjust the IP address accordingly, make sure you keep the 32 bit):
    
        ```
        from 10.0.1.5/32 table eth1-rt
        to 10.0.1.5/32 table eth1-rt
        ```
    
      3. Run the following command to create the route file for eth1:
    
        ```bash
        # vi /etc/sysconfig/network-scripts/route-eth1
        ```
    
      4. Add the following contents to the route file:
    
        ```
        10.0.1.0/24 dev eth1 table eth1-rt
        default via 10.0.1.1 dev eth1 table eth1-rt
        ```

7. To apply the changes, run the following command to restart the network service:

    ```bash
    # systemctl restart network
    ```

The routing rules are now correctly in place and you can connect with either interface as needed.

## Configure multiple NICs for RHEL/CentOS 8.x VM

1. Policy routing isn't installed by default in Red Hat Enterprise Linux (RHEL)/CentOS 8.x. To configure multiple NICs, install and enable the policy routing. To do this, run the following commands:

    ```bash
    # yum install NetworkManager-dispatcher-routing-rules -y
    # systemctl enable NetworkManager-dispatcher.service
    # systemctl start NetworkManager-dispatcher.service
    ```

2. If the `NM_CONTROLLED` setting should be set to `yes` in each network configuration file (*/etc/sysconfig/network-scripts/ifcfg-eth#*), make sure that a corresponding file is created for each NIC. The following are the sample configuration for network configuration files:

    - */etc/sysconfig/network-scripts/ifcfg-eth0*:

        ```
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
    
        ```
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

3. Run the following commands to add two routing tables to */etc/iproute2/rt_tables*:

    ```bash
    # echo "200 eth0-rt" >> /etc/iproute2/rt_tables
    # echo "201 eth1-rt" >> /etc/iproute2/rt_tables
    ```

    If more NICs are attached to the VM, add extra routing tables (202 eth2-rt, 203, eth3-rt, and so on, and so forth).

4. Extend the routing tables.

    Assume the following routing setup in place:

    - Routing (the output of `ip route show`):

        ```
        default via 10.0.1.1 dev eth0 proto static metric 100
        10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.4 metric 100
        10.0.1.0/24 dev eth1 proto kernel scope link src 10.0.1.5 metric 101
        168.63.129.16 via 10.0.1.1 dev eth0 proto dhcp metric 100
        169.254.169.254 via 10.0.1.1 dev eth0 proto dhcp metric 100
        ```

    - Interfaces (the output of `ip address`):

        ```
        lo: inet 127.0.0.1/8 scope host lo
        eth0: inet 10.0.1.4/24 brd 10.0.1.255 scope global eth0    
        eth1: inet 10.0.1.5/24 brd 10.0.1.255 scope global eth1
        ```

5. Create the corresponding files and add the proper rules and routes to each of them. Follow these steps to create one set of rule-eth# and route-eth# files per NICs. Replace the IP address and subnet information accordingly in every step. If you have more NICs, create the same set of rule-eth# and route-eth# files for each of them with the corresponding IP and subnet details.

    - Create rules and routes for eth0:

      1. Create the rule file for eth0 by running the following command:

        ```bash
        # vi /etc/sysconfig/network-scripts/rule-eth0
        ```

      2. Add the following contents to the rule file (adjust the IP address accordingly, make sure you keep the 32 bit):

        ```
        from 10.0.1.4/32 table eth0-rt
        to 10.0.1.4/32 table eth0-rt
        ```
      3. Create the route file for eth0 by running the following command:
  
        ```bash
        # vi /etc/sysconfig/network-scripts/route-eth0
        ```
      4. Add the following contents to the route file:
        
        ```
        10.0.1.0/24 dev eth0 table eth0-rt
        default via 10.0.1.1 dev eth0 table eth0-rt
        ```

    - Create rules and routes for eth1:
    
      1. Create the rule file for eth1 by running the following command:
      
        ```bash
        # vi /etc/sysconfig/network-scripts/rule-eth1
        ```
      2. Add the following contents to the rule file (adjust the IP address accordingly, make sure you keep the 32 bit):
        ```
        from 10.0.1.5/32 table eth1-rt
        to 10.0.1.5/32 table eth1-rt
        ```
      3. Create the route file for eth1 by running the following command:
      
        ```bash
        # vi /etc/sysconfig/network-scripts/route-eth1
        ```
      4. Add the following contents to the route file:
      
        ```
        10.0.1.0/24 dev eth1 table eth1-rt
        default via 10.0.1.1 dev eth1 table eth1-rt
        ```

6. To apply the changes, restart the network service by running the following command:

    ```bash
    # systemctl restart NetworkManager
    ```

The routing rules are now correctly in place and connectivity should work from either network interface as needed. You can test the connectivity by using Secure Shell (SSH) or pinging both IPs from a VM in the same VNET.

You can validate the current routes and rules by using the following commands:

```bash
# ip route show
# ip rule show
```

If you encounter some issues, reboot the VM by using the `# reboot` command, and repeat the previous step to validate if the routes and rules are loaded.

## Configure multiple NICs for Ubuntu 18.04/20.04 VMs

1. Add two routing tables to */etc/iproute2/rt_tables* by running the following commands:

    ```bash
    # echo "200 eth0-rt" >> /etc/iproute2/rt_tables
    # echo "201 eth1-rt" >> /etc/iproute2/rt_tables
    ```

2. If Cloud-Init automation is in place (the default in the Azure Ubuntu images), make sure the network CI automation is disabled so that the file */etc/netplan/50-cloud-init.yaml* doesn't get overwritten every time the system is rebooted.

    Create the file */etc/cloud/cloud.cfg.d/99-disable-network-config.cfg* with the following command and contents:

    ```bash
    # vi /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
    ```

    ```yml
    network:
    config: disabled
    ```

3. Extend the routing tables. Assume the following routing setup in place:

    - Routing:

      ```
      default via 10.0.1.1 dev eth0 proto static metric 100
      10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.4 metric 100
      10.0.1.0/24 dev eth1 proto kernel scope link src 10.0.1.5 metric 101
      168.63.129.16 via 10.0.1.1 dev eth0 proto dhcp metric 100
      169.254.169.254 via 10.0.1.1 dev eth0 proto dhcp metric 100
      ```
    
    - Interfaces:
    
        ```
        lo: inet 127.0.0.1/8 scope host lo
        eth0: link/ether 00:0d:3a:9d:60:e6 brd ff:ff:ff:ff:ff:ff
        inet 10.0.1.4/24 brd 10.0.1.255 scope global eth0    
        eth1: link/ether 00:0d:3a:9a:25:5f brd ff:ff:ff:ff:ff:ff
        inet 10.0.1.5/24 brd 10.0.1.255 scope global eth1
        ```

    Modify the netplan configuration file */etc/netplan/50-cloud-init.yaml* and include the following routes and policy-routing blocks in each NIC section:

    ```yml
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

    Replace the subnet, MAC Address and IP address for each NIC (eth0 and eth1) accordingly.

    Here's the sample configuration file that uses the given sample details:

    ```bash
    # vi /etc/netplan/50-cloud-init.yaml
    ```

    ```yml
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

4. Apply the changes by running the following command:

    ```bash
    # netplan apply
    ```

5. Ping or SSH both IPs from another VM in the same VNET to test the connectivity:

    ```bash
    # ping 10.0.1.4
    # ping 10.0.1.5
    ```

## Configure multiple NICs for Debian 10 VMs

1. Add two routing tables to */etc/iproute2/rt_tables* by running the following commands:

    ```bash
    # echo "200 eth0-rt" >> /etc/iproute2/rt_tables
    # echo "201 eth1-rt" >> /etc/iproute2/rt_tables
    ```

2. Extend the routing tables by adding the corresponding routes and rules to the network configuration file in the */etc/network/interfaces* directory.

    For Debian cloud images, the network configuration files are generated dynamically in the */run/network/interfaces* directory and they don't detect any configuration in the */etc/network/interfaces* directory. */etc/rc.local* is disabled by default in Debian 10 servers.

    In this specific scenario, the routing will be handled by a systemd unit file and a bash shell script to load the required rules and routes for multiple NICs to work.

3. Assume the following routing setup in place:

    - Routing:

      ```
      default via 10.0.1.1 dev eth0 proto static metric 100
      10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.4 metric 100
      10.0.1.0/24 dev eth1 proto kernel scope link src 10.0.1.5 metric 101
      168.63.129.16 via 10.0.1.1 dev eth0 proto dhcp metric 100
      169.254.169.254 via 10.0.1.1 dev eth0 proto dhcp metric 100
      ```

    - Interfaces:

      ```
      lo: inet 127.0.0.1/8 scope host lo
      eth0: link/ether 00:0d:3a:9d:60:e6 brd ff:ff:ff:ff:ff:ff
      inet 10.0.1.4/24 brd 10.0.1.255 scope global eth0    
      eth1: link/ether 00:0d:3a:9a:25:5f brd ff:ff:ff:ff:ff:ff
      inet 10.0.1.5/24 brd 10.0.1.255 scope global eth1
      ```

4. Run the `# vi /multinic.sh` command to create the */multinic.sh* script that includes the following content:

    ```bash
    #!/bin/bash
    #
    /usr/sbin/ip route add default via 10.0.1.1 dev eth0 table eth0-rt
    /usr/sbin/ip rule add from 10.0.1.4/32 table eth0-rt
    /usr/sbin/ip rule add to 10.0.1.4/32 table eth0-rt
    /usr/sbin/ip route add 10.0.1.0/24 dev eth1 table eth1-rt
    /usr/sbin/ip route add default via 10.0.1.1 dev eth1 table eth1-rt
    /usr/sbin/ip rule add from 10.0.1.5/32 table eth1-rt
    /usr/sbin/ip rule add to 10.0.1.5/32 table eth1-rt
    ```

    Adjust the network and IP address information accordingly. If there are more than two NICs, make sure that the corresponding IP rules and IP routes are included for each NIC.

5. Provide execution permissions to the script:

    ```bash
    # chmod +x /multinic.sh
    ```

6. Run the `# vi /etc/systemd/system/multinic.service` command to create the systemd unit service file that contains the following contents:

    ```
    [Unit]
    Description=To enable multinic for eth0 and eth1
    After=networking.service
    [Service]
    ExecStart=/multinic.sh
    Type=oneshot
    RemainAfterExit=true
    [Install]
    WantedBy=multi-user.target
    WantedBy=network-online.target
    ```

7. Once the service has been created, run the following command to enable it so that it can be automatically executed by the system at boot time:

    ```bash
    # systemctl enable multinic
    ```

8. To test the service, start the service manually or reboot the virtual machine by using the following commands:

    ```bash
    # systemctl start multinic
    ```

    Or

    ```bash
    # reboot
    ```

9. To validate the multinic configuration works, connect to another VM located in the same VNET and ping both IP addresses by using the following commands:

    ```bash
    # ping 10.0.1.4
    # ping 10.0.1.5
    ```

## Configure multiple NICs for SLES 11.x/12.x/15.x VMs

1. Add two routing tables to */etc/iproute2/rt_tables* by running the following commands:

    ```bash
    # echo "200 eth0-rt" >> /etc/iproute2/rt_tables
    # echo "201 eth1-rt" >> /etc/iproute2/rt_tables
    ```

2. Extend the routing tables.

    Assume the following routing setup in place:

    - Routing:

      ```
      default via 10.0.1.1 dev eth0 proto static metric 100
      10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.4 metric 100
      10.0.1.0/24 dev eth1 proto kernel scope link src 10.0.1.5 metric 101
      168.63.129.16 via 10.0.1.1 dev eth0 proto dhcp metric 100
      169.254.169.254 via 10.0.1.1 dev eth0 proto dhcp metric 100
      ```

    - Interfaces:

      ```
      lo: inet 127.0.0.1/8 scope host lo
      eth0: link/ether 00:0d:3a:9d:60:e6 brd ff:ff:ff:ff:ff:ff
      inet 10.0.1.4/24 brd 10.0.1.255 scope global eth0    
      eth1: link/ether 00:0d:3a:9a:25:5f brd ff:ff:ff:ff:ff:ff
      inet 10.0.1.5/24 brd 10.0.1.255 scope global eth1
      ```

3. Run the following command to create the scripts with the routes and rules for each NIC in the */etc/sysconfig/network/scripts/* directory:

    - */etc/sysconfig/network/scripts/ifup-route.eth0*
    
        ```bash
        # vi /etc/sysconfig/network/scripts/ifup-route.eth0
        ```
    
        ```bash
        #!/bin/bash
        #
        /sbin/ip route add default via 10.0.1.1 dev eth0 table eth0-rt
        /sbin/ip rule add from 10.0.1.4/32 table eth0-rt
        /sbin/ip rule add to 10.0.1.4/32 table eth0-rt
        ```
    
    - */etc/sysconfig/network/scripts/ifup-route.eth1*

        ```bash
        # vi /etc/sysconfig/network/scripts/ifup-route.eth1
        ```

        ```bash
        #!/bin/bash
        #
        /sbin/ip route add 10.0.1.0/24 dev eth1 table eth1-rt
        /sbin/ip route add default via 10.0.1.1 dev eth1 table eth1-rt
        /sbin/ip rule add from 10.0.1.5/32 table eth1-rt
        /sbin/ip rule add to 10.0.1.5/32 table eth1-rt
        ```

    Adjust the network and IP address information accordingly. If there are more than two NICs, make sure that the corresponding IP rules and IP routes are included for each NIC.

4. Provide execution permissions to both scripts:

    ```bash
    # chmod +x /etc/sysconfig/network/scripts/ifup-route.eth0
    # chmod +x /etc/sysconfig/network/scripts/ifup-route.eth1
    ```

5. Modify the network configuration files for both eth0 and eth1 (*/etc/sysconfig/network/ifcfg-eth#*) and include the following line in both files pointing to the corresponding script:

    ```
    POST_UP_SCRIPT='compat:suse:/etc/sysconfig/network/scripts/ifup-route.eth#'
    ```
    
    For SLES 11, exclude `compat:suse` from the line: `POST_UP_SCRIPT='/etc/sysconfig/network/scripts/ifup-route.eth#'`.
    
    Here's a sample of both configuration files:
    
    ```bash
    # vi /etc/sysconfig/network/ifcfg-eth0
    
    BOOTPROTO='dhcp'
    DHCLIENT6_MODE='managed'
    MTU=''
    REMOTE_IPADDR=''
    STARTMODE='onboot'
    CLOUD_NETCONFIG_MANAGE='yes'
    POST_UP_SCRIPT="compat:suse:/etc/sysconfig/network/scripts/ifup-route.eth0"
    
    # vi /etc/sysconfig/network/ifcfg-eth1
    
    STARTMODE="hotplug"
    BOOTPROTO="dhcp"
    DHCLIENT_SET_DEFAULT_ROUTE="yes"
    DHCLIENT_ROUTE_PRIORITY="10100"
    CLOUD_NETCONFIG_MANAGE="yes"
    POST_DOWN_SCRIPT="compat:suse:cloud-netconfig-cleanup"
    POST_UP_SCRIPT="compat:suse:/etc/sysconfig/network/scripts/ifup-route.eth1"
    ```

    If */etc/sysconfig/network/ifcfg-eth1* doesn't exist, create it by using the same contents from */etc/sysconfig/network/ifcfg-eth0*. To do this, run the following command:

    ```bash
    cp -rp /etc/sysconfig/network/ifcfg-eth0 /etc/sysconfig/network/ifcfg-eth1
    ```

6. Restart network service to apply the changes:

    ```bash
    # systemctl restart network
    ```

    For SUSE Linux Enterprise Server (SLES) 11, use `service network restart`.

Both IP addresses should be reachable from a VM within the same VNET now. This can be tested by using ping or SSH to both IPs.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
