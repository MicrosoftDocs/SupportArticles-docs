---
title: Troubleshoot Azure Fence Agent Issues in RHEL
description: Provides troubleshooting guidance for Azure Fence Agent failing to start
author: rnirek
ms.author: rnirek
ms.author: divargas
ms.topic: troubleshooting
ms.date: 06/26/20204
ms.service: virtual-machines
ms.collection: linux
---


# Overview

The Azure fence agent makes use of the python program located at `/usr/sbin/fence_azure_arm`. The cluster RA used to implement `STONITH` calls this program with the appropriate parameters and uses it to communicate with the Azure platform using API calls.

As documented in [RHEL - Create STONITH device](https://learn.microsoft.com/en-us/azure/sap/workloads/high-availability-guide-rhel-pacemaker?tabs=msi#create-a-fencing-device), the roles provide permissions to the fence agent to perform the following actions.

* `powerOff`
* `start`

When the VM is detected as being unhealthy, the fence agent uses the above actions to power off the VM and then start it up again thus providing a `STONITH` device.

## Prerequisites

Pacemaker clusters running on RHEL using Azure fence agent  for `STONITH` purposes.

## Description

Azure Fencing Agent resource fails to start and reports "unknown error" and shows in "stopped" state.

```bash
sudo pcs status
```

```output
Cluster name: nw1-azr
Cluster Summary:
  * Stack: corosync
  * Current DC: RHEL-SAP01 (version 2.0.5-9.el8_4.8-ba59be7122) - partition with quorum
  * Last updated: Fri Jun  7 01:34:38 2023
  * Last change:  Fri Jun  7 01:34:23 2023 by root via cibadmin on RHEL-SAP01
  * 2 nodes configured
  * 3 resource instances configured

Node List:
  * Online: [ RHEL-SAP01 RHEL-SAP02 ]

Full List of Resources:
  * rsc_st_azure        (stonith:fence_azure_arm):       Stopped
  * Clone Set: health-azure-events-clone [health-azure-events]:
    * Started: [ RHEL-SAP01 RHEL-SAP02 ]

Failed Resource Actions:
  * rsc_st_azure_start_0 on RHEL-SAP01 'error' (1): call=20, status='complete', exitreason='', last-rc-change='2023-06-04 01:34:24Z', queued=0ms, exec=4041ms
  * rsc_st_azure_start_0 on RHEL-SAP02 'error' (1): call=14, status='complete', exitreason='', last-rc-change='2023-06-04 01:34:28Z', queued=0ms, exec=4243ms

Daemon Status:
  corosync: active/disabled
  pacemaker: active/disabled
  pcsd: active/enabled
```

## Scenario 1 - Endpoint connectivity issues

```output
/var/log/messages
2021-03-15T20:23:15.441083+00:00 NodeName pacemaker-fenced[2550]:  warning: fence_azure_arm[21839] stderr: [ 2021-03-15 20:23:15,398 ERROR: Failed: Azure Error: AuthenticationFailed ]
2021-03-15T20:23:15.441260+00:00 NodeName pacemaker-fenced[2550]:  warning: fence_azure_arm[21839] stderr: [ Message: Authentication failed. ]
2021-03-15T20:23:15.441668+00:00 NodeName pacemaker-fenced[2550]:  warning: fence_azure_arm[21839] stderr: [  ]
```

### Resolution

1. Connectivity to the Azure management API public endpoints

As documented in Public endpoint connectivity for Virtual Machines using [Azure Standard Load Balancer in SAP high-availability scenarios](https://learn.microsoft.com/en-us/azure/sap/workloads/high-availability-guide-standard-load-balancer-outbound-connections#option-3-using-proxy-for-pacemaker-calls-to-azure-management-api), it is essential to check outbound connectivity to the Azure management API available at the URLs below:

* https://management.azure.com
* https://login.microsoftonline.com

This can be done by using either `telnet`, `curl` or `nc` (`telnet` or `curl` are not normally available on customer VMs) to test connectivity. The tests to both URLs must be done as shown below.

#### [Connectivity to https://management.azure.com](#tab/mngtconnectivity)

* Connectivity to https://management.azure.com 

```bash
telnet management.azure.com 443
```

OR

```bash
curl -v telnet://management.azure.com:443
```

OR

```bash
nc -z -v management.azure.com 443
```
#### [Connectivity to https://login.microsoftonline.com](#tab/loginconnectivity)


```bash
telnet login.microsoftonline.com 443
```

OR

```bash
curl -v telnet://login.microsoftonline.com:443
```

OR

```bash
nc -z -v login.microsoftonline.com 443
```

---

2. Valid information set up in username or password for the `STONITH` resource. 

One of the major causes of the `STONITH` resource failing is the use of invalid values for the username or password if using Service Principal. This can be tested using the `fence_azure_arm` command as shown below. The values for username and password are those created per the document [RHEL - Create STONITH device](https://learn.microsoft.com/en-us/azure/sap/workloads/high-availability-guide-rhel-pacemaker?tabs=msi#create-a-fencing-device), as appropriate for the customer distribution.

```bash
sudo /usr/sbin/fence_azure_arm --action=list --username='<user name>' --password='<password>' --tenantId=<tenant ID> --resourceGroup=<resource group> 
```

> [!NOTE]
> Replace `<user name>`, `<password>`, `<tenant ID>`, `<resource group>` values accordingly.

This command should return the node names of the VMs in the cluster.

If the command does'nt return successfully, it should be re executed with the `-v` flag to enable verbose output and `-D` flag to enable debug output as shown below.

```bash
sudo /usr/sbin/fence_azure_arm --action=list --username='<user name>' --password='<password>' --tenantId=<tenant ID> --resourceGroup=<resource group> -v -D /var/tmp/debug-fence.out 
```

> [!NOTE]
> Replace `<user name>`, `<password>`, `<tenant ID>`, `<resource group>` values accordingly.

If using Managed Identity:

```bash
sudo /usr/sbin/fence_azure_arm --action=list --msi --resourceGroup=<resource group> -v -D /var/tmp/debug-fence.out
```

> [!NOTE]
> Replace `<resource group>` value accordingly.

### Next Steps

If you require further help, see [Support and troubleshooting for Azure VMs](https://learn.microsoft.com/en-us/azure/virtual-machines/vm-support-help). That article can also help you file an Azure support incident, if necessary. As you follow the instructions, keep a copy of the `debug-fence.out` because it might be requested for inspection by the support engineer.

## Scenario 2 - Authentication failures

```output
/var/log/messages
2020-04-06T10:06:47.779470+00:00 VM1 pacemaker-controld[29309]: notice: Result of probe operation for rsc_st_azure on VM1: 7 (not running)
2020-04-06T10:06:51.045519+00:00 VM1 pacemaker-execd[29306]: notice: executing - rsc:rsc_st_azure action:start call_id:52
2020-04-06T10:06:52.826702+00:00 VM1 /fence_azure_arm: Failed: AdalError: Get Token request returned http error: 400 and server response: {"error":"unauthorized_client","error_description":"AADSTS700016: Application with identifier '5005c556-e620-4297-8398-abcc239fa706'
was not found in the directory 'b37c8d34-016c-4e9e-9283-56234092be50'. This can happen if the application has not been installed by the administrator of the tenant or consented to by any user in the tenant.
You may have sent your authentication request to the wrong tenant.\r\nTrace ID: 9d86f824-52c1-45a8-b24f-c81473122d00\r\nCorrelation ID: 7dd6de5d-1d6a-4950-be8b-9a2cb2df8553\r\nTimestamp:2020-04-06 10:06:52Z","error_codes":[700016],"timestamp":"2020-04-06 10:06:52Z","trace_id":"9d86f824-52c1-45a8-b24f-c81473122d00",
"correlation_id":"7dd6de5d-1d6a-4950-be8b-9a2cb2df8553","error_uri":"https://login.microsoftonline.com/error?code=700016 "}
```

### Resolution

Please check with customer and verify again the AAD app tenant ID, application ID, login and password details from the Azure portal.

1. Once the IDs are verified and replaced, reconfigure the fencing agent in the cluster.

```bash
sudo pcs property set maintenance-mode=true

sudo pcs cluster edit
```

2. Change the parameters for Azure Fence Agent resources and save the changes:

```bash
sudo pcs property set maintenance-mode=false
```

3. Now verify the cluster status to confirm if fencing agent issue is fixed

```bash
sudo pcs status
```

## Scenario 3 - Insufficient permissions

After reviewing the logs and outputs, found the agent is failing with authorization issues.

```output
/var/log/messages
Apr 2 00:49:57 heeudpgscs01 stonith-ng[105424]: warning: fence_azure_arm[109393] stderr: [ 2020-04-02 00:49:56,978 ERROR: Failed: Azure Error: AuthorizationFailed ]
Apr 2 00:49:57 heeudpgscs01 stonith-ng[105424]: warning: fence_azure_arm[109393] stderr: [ Message: The client 'd36bc109-bdfd-4b6d-bf28-d3990d3c22ea' with object id 'd36bc109-bdfd-4b6d-bf28-d3990d3c22ea' does not have authorization to perform action 'Microsoft.Compute/virtualMachines/read' over scope '/subscriptions/e2d1c3ed-77d2-47f5-a2af-27aa0f9d79a8/resourceGroups/DPG-RG-MAIN01-PROD/providers/Microsoft.Compute' or the scope is invalid. If access was recently granted, please refresh your credentials. ]
```

### Resolution

1. Based on [https://learn.microsoft.com/en-us/azure/sap/workloads/high-availability-guide-rhel-pacemaker?tabs=msi#1-create-a-custom-role-for-the-fence-agent](https://learn.microsoft.com/en-us/azure/sap/workloads/high-availability-guide-rhel-pacemaker?tabs=msi#1-create-a-custom-role-for-the-fence-agent), check the custom role definition for `Linux Fence Agent Role`. The role name may be different for different customers.
2. Check if the app `fencing-agent` has this custom role assigned to the impacted VM or not.
3. If it doesn't, assign the app to the VM via Access Control.
4. Start the pacemaker cluster and it should start along with the fencing agent (Azure Fencing Agent).
5. Verify the cluster status to confirm fencing agent issue is fixed `pcs status`.

## Scenario 4 - SSL handshake failure

/var/log/messages

```output
warning: fence_azure_arm[28114] stderr: [ 2021-06-24 07:59:29,832 ERROR: Failed: Error occurred in request., SSLError: HTTPSConnectionPool(host='management.azure.com ', port=443): Max retries exceeded with url: /subscriptions/a8964342-5414-40a0-aade-5c3d23482016/resourceGroups/rgglbp01/providers/Microsoft.Compute/virtualMachines?api-version=2019-03-01 (Caused by SSLError(SSLError('bad handshake: SysCallError(-1, 'Unexpected EOF')',),)) ]
```

### Resolution

1.Tested connectivity from affected nodes using openssl:

```bash
openssl s_client -connect management.azure.com:443
```

Noticed that the output was not showing the full certificate handshake:

```output

CONNECTED(00000003)
write:errno=0
---
no peer certificate available
---
No client certificate CA names sent
---
SSL handshake has read 0 bytes and written 176 bytes
Verification: OK
---
New, (NONE), Cipher is (NONE)
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : 0000
    Session-ID:
    Session-ID-ctx:
    Master-Key:
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    Start Time: 1625235527
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: no
```

2. These errors are likely due to a network appliance / firewall doing packet inspection or modifying the TLS connections in a way that is causing certificate verification to fail (mtu sizes can also cause these problems).
3. If you have Azure Firewall in front of the nodes, make sure these tags are added to the application/network rules:

```output
Application Rules:
ApiManagement , AppServiceManagement, AzureCloud
Network Rules:
AppServiceEnvironment
```
