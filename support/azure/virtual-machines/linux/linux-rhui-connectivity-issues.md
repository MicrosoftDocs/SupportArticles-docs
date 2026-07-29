---
title: Troubleshoot Red Hat RHUI connectivity issues
description: Resolve RHUI connectivity issues for Red Hat RHEL VMs in Azure. Learn to diagnose and fix connection timeouts to Red Hat Update Infrastructure repositories.
author: kaushika-msft
ms.author: kaushika
editor: v-jsitser
ms.reviewer: azurevmlnxcic, divargas, v-leedennis, msaenzbo
ms.service: azure-virtual-machines
ms.custom: sap:Kernel Upgrades, Package Management issue (Yum, Zypper, RPM, DPKG, APT)
ms.collection: linux
ms.topic: troubleshooting
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-linux
ms.date: 07/28/2026
---

# Troubleshoot Red Hat RHUI connectivity issues

**Applies to:** :heavy_check_mark: Linux VMs

## Summary

Misconfigurations at the networking layer can cause common problems in the Red Hat Update Infrastructure (RHUI). This article helps you identify and resolve some of these problems.

Only virtual machines (VMs) that are within the Azure Datacenter IP address ranges can access the Microsoft Azure-hosted RHUI. For more information, see [Red Hat Update Infrastructure for on-demand Red Hat Enterprise Linux VMs in Azure](/azure/virtual-machines/linux/update-infrastructure-redhat).

Red Hat configured these Azure-hosted RHUI servers to allow traffic only from Azure public IP ranges. Because of this setup, if you use a virtual private network (VPN) or other means to reroute the traffic between Azure and the Azure-hosted RHUI servers, the Azure-hosted RHUI servers block that traffic.

> [!IMPORTANT]
> RHUI is intended only for pay-as-you-go (PAYG) images. For golden images, also known as bring your own subscription (BYOS), you can receive updates only if the system is attached to Red Hat Subscription Manager (RHSM) or Red Hat Satellite. For more information, see [How to register and subscribe a RHEL system](https://access.redhat.com/solutions/253273).

## Symptoms

The [yum](http://yum.baseurl.org/index.html) repository list that RHUI manages is configured in your Red Hat Enterprise Linux (RHEL) instance during provisioning. You don't have to do any extra configuration. Just run `yum update` after your RHEL VM is ready for the latest updates. However, during the `yum update` operation, the connection eventually times out, and you see an error message that resembles one of the following output strings:

- **Output 1**

  > https\://rhui-3.microsoft.com/pulp/repos/microsoft-azure-rhel7/repodata/repomd.xml: [Errno 12] Timeout on https\://rhui-3.microsoft.com/pulp/repos/microsoft-azure-rhel7/repodata/repomd.xml: (28, **'Operation timed out after 30000 milliseconds with 0 out of 0 bytes received'**)

- **Output 2**

  > https\://rhui4-1.microsoft.com/pulp/repos/content/dist/rhel8/rhui/8/x86_64/baseos/os/repodata/repomd.xml [**OpenSSL SSL_connect: SSL_ERROR_SYSCALL in connection to http\://rhui4-1.microsoft.com:443** ]

- **Output 3**

  > DEBUG error: Curl error (28): Timeout was reached for https\://rhui-1.microsoft.com/pulp/repos/content/dist/rhel8/rhui/8/x86_64/baseos/os/repodata/repomd.xml [**Operation timed out after 30000 milliseconds with 0 out of 0 bytes received**] (https\://rhui-1.microsoft.com/pulp/repos/content/dist/rhel8/rhui/8/x86_64/baseos/os/repodata/repomd.xml).

- **Output 4**

  > https\://rhui-3.microsoft.com/pulp/repos/microsoft-azure-rhel7/repodata/repomd.xml: [Errno 14] curl#56 - "Network error recv()"
[Errno 12] Timeout on https\://rhui-3.microsoft.com/pulp/repos/microsoft-azure-rhel7/repodata/repomd.xml: (28, **'Operation timed out after 30000 milliseconds with 0 out of 0 bytes received'**)

## Troubleshooting checklist

### Troubleshooting step 1: Update IP addresses for RHUI version 4

Do you use a network configuration (custom firewall or UDR configurations) to further restrict `https` access from RHEL pay-as-you-go (PAYG) VMs? In this case, make sure that the correct IP addresses are allowed for `yum update` to work, depending on your environment. The following table shows the IP addresses to use for different regions in Azure Global for RHUI version 4.

| Region           | IP address       |
|------------------|------------------|
| West Europe      | `52.136.197.163` |
| South Central US | `20.225.226.182` |
| East US          | `52.142.4.99`    |
| Australia East   | `20.248.180.252` |
| Southeast Asia   | `20.24.186.80`   |

> [!NOTE]
>
> - As of October 12, 2023, all PAYG clients are directed to the RHUI 4 IP addresses in phase over the next two months. During this time, the RHUI 3 IP addresses remain in use for continued updates but are removed at a future date. For uninterrupted access to packages and updates, you must update existing routes and rules that allow access to the RHUI 3 IP addresses so that they also include the RHUI 4 IP addresses. To continue receiving updates during the transition period, don't remove the RHUI 3 IP addresses.
> 
> - All Azure government PAYG instances use the same RHUI IP addresses that were previously covered.

### Troubleshooting step 2: Run a validation script

Azure provides an RHUI repository validation script on GitHub. One of the many functions of the script is to validate the connectivity of the repository server and provide recommendations for a fix if it discovers a connectivity error. This Python script has the following features:

- Validates the RHUI client certificate.
- Validates RHUI rpm consistency.
- Performs a consistency check between EUS, non-EUS repository configuration, and their requirements.
- Validates connectivity to the RHUI repositories. Reports that repository connectivity is successful if no errors are observed.
- Validates SSL connectivity to the RHUI repositories.
- Focuses exclusively on the RHUI repositories.
- Validates a found error by using the defined conditions and provides recommendations for a fix.

#### Supported Red Hat images

This version of the validation script currently supports only the following Red Hat VMs that are deployed from the Azure Marketplace image:

- RHEL 7._x_ PAYG VMs
- RHEL 8._x_ PAYG VMs
- RHEL 9._x_ PAYG VMs
- RHEL 10._x_ PAYG VMs

#### How to run the validation script

To run the validation script, enter the following shell commands on a Red Hat VM:

#### [Red Hat 7.x](#tab/rhel7)

1. If the virtual machine has internet access, execute the script from the VM by using the following command:

    ```bash
    curl -sL https://raw.githubusercontent.com/Azure/azure-support-scripts/refs/heads/master/Linux_scripts/rhui-check/rhui-check.py | sudo python2 -
    ```

1. If the virtual machine doesn't have internet access, download the [RHUI check script](https://raw.githubusercontent.com/Azure/azure-support-scripts/refs/heads/master/Linux_scripts/rhui-check/rhui-check.py) and transfer it to the virtual machine. Then, execute the following command:

    ```bash
    sudo python2 ./rhui-check.py 
    ```

  The script generates a report that identifies any specific issues. The script output is also saved in `/var/log/rhuicheck.log` after execution. You can also inspect that log file separately.

#### [Red Hat 8.x, 9.x, and 10.x](#tab/rhel8910)

1. If the virtual machine has internet access, execute the script directly from the VM by using the following command:

    ```bash
    curl -sL https://raw.githubusercontent.com/Azure/azure-support-scripts/refs/heads/master/Linux_scripts/rhui-check/rhui-check.py | sudo python3 -
    ```

1. If the virtual machine doesn't have internet access, download the [RHUI check script](https://raw.githubusercontent.com/Azure/azure-support-scripts/refs/heads/master/Linux_scripts/rhui-check/rhui-check.py) and transfer it to the virtual machine. Then, execute the following command:

    ```bash
    sudo python3 ./rhui-check.py 
    ```

  > [!IMPORTANT]
  > Replace `python3` with `/usr/libexec/platform-python` if the `python3` command isn't found.
  
  The script generates a report that identifies any specific issues. The script output is also saved in `/var/log/rhuicheck.log` after execution. You can also inspect that log file separately.

---

## Cause

The following list contains the underlying causes of RHUI connection failures:

- You didn't configure user-defined routes (UDRs) with a next hop IP address to the internet.

- You didn't configure UDR rules to access any RHUI versions.

- You configured an incorrect or missing network security group (NSG) for the network interface.

- You didn't configure NSG rules to access any RHUI versions.

The following sections contain scenarios that cause these underlying failure causes. They outline solutions that fix the connection failures.

## Scenario 1: VMs are configured to use an internal load balancer

An internal load balancer doesn't provide outbound connectivity when you configure it for network interfaces.

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

## Scenario 2: An internal load balancer and a service endpoint cause a partial RHUI failure

In some environments, only one region's RHUI endpoint fails while other regions keep working. For example, `dnf` or `yum` reaches the East US endpoint (`52.142.4.99`) but times out (Curl error 28) for the West Europe endpoint (`rhui4-1.microsoft.com`, which resolves to `52.136.197.163`), even though other outbound traffic works.

This behavior occurs when a service endpoint (or any route that's more specific than `0.0.0.0/0`) for `AzureCloud.<region>`;for example, `52.136.192.0/18`;overrides the `0.0.0.0/0` user-defined route (UDR) that points to Azure Firewall. Because Azure selects routes by using longest-prefix match, the more-specific route wins, and traffic to that region's RHUI IP address is pulled off the firewall path and onto a direct path. If the VM's network interface is also a member of a Standard internal load balancer backend pool, it has no default outbound access and no explicit outbound rule. Therefore, the direct path has no return route. The TCP SYN packet is sent, but no SYN-ACK packet is received, and the connection times out.

### Solution 2: Verify the effective routes and add an explicit outbound path

To diagnose this scenario, take the following actions:

1. Check the network interface's [effective routes](/azure/virtual-network/diagnose-network-routing-problem), and confirm which route wins for the failing RHUI IP address. If a service endpoint or another more-specific prefix wins over the `0.0.0.0/0` UDR, that traffic bypasses the firewall.

1. Confirm whether the network interface is a member of a Standard internal load balancer backend pool, which removes default outbound access.

> [!NOTE]
> Verifying that a security rule allows the traffic confirms only the control plane (security-rule evaluation). It doesn't confirm the data plane (the route that the traffic actually takes). Check the effective routes and, if possible, run a packet capture to confirm whether a SYN packet is sent without a returning SYN-ACK packet.

To resolve this scenario, give the backend VMs an explicit outbound path. A NAT gateway on the subnet is recommended because it coexists with the internal load balancer. For more information, see [Solution 1c: Use a NAT gateway on the subnet](#solution-1c-use-a-nat-gateway-on-the-subnet). Alternatively, add a UDR for the RHUI prefixes that points to Azure Firewall so that the region's traffic stays on the firewall path.

> [!NOTE]
> RHUI is fronted by Azure Traffic Manager, so requests can be directed to any of the RHUI servers. If you allow specific IP addresses on a firewall, allow all of the RHUI IP addresses that are listed in [Troubleshooting step 1: Update IP addresses for RHUI version 4](#troubleshooting-step-1-update-ip-addresses-for-rhui-version-4), not just the endpoint of the region that's currently failing.

## Scenario 3: RHUI server connects to your on-premises network instead of an RHUI public IP address

Red Hat VMs in Azure must connect to the RHUI servers to use the RHUI repositories and complete the updates. The connection requires that the request be sent to RHUI servers. In the forced tunneling scenario (express route) or VPN, the connection fails because the server connects to your on-premises network instead of an RHUI public IP address.

### Solution 3: Create a UDR

Create a UDR to route the traffic to the RHUI servers. The following screenshot shows the UDRs that you have to create in a route table on the Azure portal. The UDRs are based on the Azure Global regions and IP addresses listed in [Troubleshooting step 1: Update IP addresses for RHUI version 4](#troubleshooting-step-1-update-ip-addresses-for-rhui-version-4). For more information, see [Create, change, or delete a route table](/azure/virtual-network/manage-route-table).

:::image type="content" source="media/linux-rhui-connectivity-issues/rhui-4-route.png" alt-text="Screenshot of the Azure portal that shows an example of a route table for connecting to different Azure Global regions." lightbox="media/linux-rhui-connectivity-issues/rhui-4-route.png":::

## Scenario 4: An Azure firewall or virtual appliance is between your virtual network and the internet

 An Azure firewall or virtual appliance might exist that acts as a protective barrier between your Azure virtual network and the internet. This barrier enforces security policies and provides features to control and monitor traffic effectively, by sending all traffic to the firewall. In this case, the firewall blocks the communication to RHUI servers.

### Solution 4: Make sure that the RHUI IP addresses are accessible

Make sure that you can access the RHUI IP addresses by taking the following actions:

1. Verify that firewall policies allow the destination RHUI IP addresses.

1. Verify that RHUI IP addresses are allowed if Secure Sockets Layer (SSL) inspection is active.

1. If you use a network security group (NSG), make sure that you add RHUI IP addresses to the allow list of the outbound rule of the network interface NSG or subnet NSG. The priority should be higher than the `Block_Internet_Access_outbound` rule.

## Scenario 5: A checkpoint firewall runs an SSL inspection

If the networking traffic route goes through a checkpoint firewall device that runs an SSL inspection, this process might alter the manner in which the RHUI certificate affects communication to the RHUI servers.

### Solution 5: Add RHUI IP addresses and URLs to the allow list

Make sure that the RHUI IP addresses and URLs are included in the allow list if SSL inspection is active.

## Scenario 6: A proxy is used for communication

Internet communication goes through a customer proxy that affects communication to the RHUI servers.

### Solution 6: Fix the proxy configuration settings

If you configure a proxy server in Microsoft Azure between the RHEL VM and RHUI, use the correct proxy configuration settings in the `/etc/yum.conf` or `/etc/dnf.conf` files, as shown in the following snippet:

> [!IMPORTANT]
> If the configured proxy server has a private IP address, make sure that it has connectivity within the Azure public address space.

```bash
proxy=http://myproxy.mydomain.com:3128
proxy_username=proxy-user
proxy_password=password
```

> [!IMPORTANT]
> If no proxy server exists between the RHEL VM and RHUI, search for and remove any proxy configuration settings that are in the `/etc/yum.conf` or `/etc/dnf.conf` files.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact information disclaimer](../../../includes/third-party-contact-disclaimer.md)]

 
