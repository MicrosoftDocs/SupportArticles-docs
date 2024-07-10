---
title: Troubleshoot Azure fence agent issues in an RHEL Pacemaker cluster
description: Provides troubleshooting guidance for Azure fence agent issues that occur in a Red Hat Enterprise Linux (RHEL) Pacemaker cluster.
ms.reviewer: divargas, rnirek, v-weizhu
ms.date: 07/10/2024
ms.service: virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker clustering, and fencing
---
# Troubleshoot Azure fence agent issues in an RHEL Pacemaker cluster

**Applies to:** :heavy_check_mark: Linux VMs

This article helps you troubleshoot Azure fence agent issues in a Pacemaker cluster that runs on Red Hat Enterprise Linux (RHEL) and that uses the Azure fence agent to implement a Shoot The Other Node in the Head (STONITH) device.

## Overview

The Azure fence agent uses the Python program located at */usr/sbin/fence_azure_arm*. The cluster resource agent (RA) used to implement a STONITH device calls this program with appropriate parameters and uses it to communicate with the Azure platform through API calls.

As introduced in [RHEL - Create a STONITH device](/azure/sap/workloads/high-availability-guide-rhel-pacemaker?tabs=msi#create-a-fencing-device), custom roles provide permissions for the fence agent to perform the following actions:

* `powerOff`
* `start`

When an unhealthy virtual machine (VM) is detected, the fence agent uses the previous actions to turn off the VM and restart it, thus providing a STONITH device.

## Symptoms

When you verify the cluster resource status by running the following command, the Azure fence agent resources fail to start, report an "unknown error," and show a `Stopped` state:

```bash
sudo pcs status
```

Here's a command output example:

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

## Cause 1: Endpoint connectivity issues

If you check the */var/log/messages* log file, you'll see an output that resembles the following example:

```output
2021-03-15T20:23:15.441083+00:00 NodeName pacemaker-fenced[2550]:  warning: fence_azure_arm[21839] stderr: [ 2021-03-15 20:23:15,398 ERROR: Failed: Azure Error: AuthenticationFailed ]
2021-03-15T20:23:15.441260+00:00 NodeName pacemaker-fenced[2550]:  warning: fence_azure_arm[21839] stderr: [ Message: Authentication failed. ]
2021-03-15T20:23:15.441668+00:00 NodeName pacemaker-fenced[2550]:  warning: fence_azure_arm[21839] stderr: [  ]
```

To troubleshoot the endpoint connectivity issues, follow these steps:

1. Test connectivity to the Azure management API public endpoints.

    As described in [Public endpoint connectivity for Virtual Machines using Azure Standard Load Balancer in SAP high-availability scenarios](/azure/sap/workloads/high-availability-guide-standard-load-balancer-outbound-connections#option-3-using-proxy-for-pacemaker-calls-to-azure-management-api), it's important to check outbound connectivity to the Azure management API public endpoints using the following URLs:
    
    * `https://management.azure.com`
    * `https://login.microsoftonline.com`
    
    Use the following `telnet`, `curl`, or `nc` command to test connectivity to both URLs.

    > [!NOTE]
    > `Telnet` or `curl` is generally not available for customer VMs.
    
    #### [Connectivity to https://management.azure.com](#tab/mngtconnectivity)
    
    ```bash
    telnet management.azure.com 443
    ```
    
    ```bash
    curl -v telnet://management.azure.com:443
    ```
    
    ```bash
    nc -z -v management.azure.com 443
    ```
    
    #### [Connectivity to https://login.microsoftonline.com](#tab/loginconnectivity)
    
    ```bash
    telnet login.microsoftonline.com 443
    ```
    
    ```bash
    curl -v telnet://login.microsoftonline.com:443
    ```
    
    ```bash
    nc -z -v login.microsoftonline.com 443
    ```
    
    ---

2. Verify that a valid username and password are set up for the STONITH device.

    - When using Service Principal:
    
        A common reason why the STONITH device fails is the use of invalid username or password values. To verify this, use the *fence_azure_arm* program as shown in the following command. The username and password values are created according to [RHEL - Create a STONITH device](/azure/sap/workloads/high-availability-guide-rhel-pacemaker?tabs=msi#create-a-fencing-device).
    
        ```bash
        sudo /usr/sbin/fence_azure_arm --action=list --username='<username>' --password='<password>' --tenantId=<tenant ID> --resourceGroup=<resource group> 
        ```
        
        > [!NOTE]
        > Replace the *`<username>`*, *`<password>`*, *`<tenant ID>`*, and *`<resource group>`* values accordingly.
        
        This command should return the node names of the VMs in the cluster. If the command fails to return, rerun it with the `-v` flag to enable verbose output and the `-D` flag to enable debug output, as shown in the following command:
        
        ```bash
        sudo /usr/sbin/fence_azure_arm --action=list --username='<user name>' --password='<password>' --tenantId=<tenant ID> --resourceGroup=<resource group> -v -D /var/tmp/debug-fence.out 
        ```
        
        > [!NOTE]
        > Replace the *`<user name>`*, *`<password>`*, *`<tenant ID>`*, and *`<resource group>`* values accordingly.
        
    - When using Managed Identity:

      Verify the username and password values by running the following command:
        
        ```bash
        sudo /usr/sbin/fence_azure_arm --action=list --msi --resourceGroup=<resource group> -v -D /var/tmp/debug-fence.out
        ```
        
        > [!NOTE]
        > Replace the *`<resource group>`* value accordingly.

## Cause 2: Authentication failures

If you check the */var/log/messages* log file, you'll see an output that resembles the following example:

```output
2020-04-06T10:06:47.779470+00:00 VM1 pacemaker-controld[29309]: notice: Result of probe operation for rsc_st_azure on VM1: 7 (not running)
2020-04-06T10:06:51.045519+00:00 VM1 pacemaker-execd[29306]: notice: executing - rsc:rsc_st_azure action:start call_id:52
2020-04-06T10:06:52.826702+00:00 VM1 /fence_azure_arm: Failed: AdalError: Get Token request returned http error: 400 and server response: {"error":"unauthorized_client","error_description":"AADSTS700016: Application with identifier '<application ID>'
was not found in the directory '<directory name>'. This can happen if the application has not been installed by the administrator of the tenant or consented to by any user in the tenant.
You may have sent your authentication request to the wrong tenant.\r\nTrace ID: 9d86f824-52c1-45a8-b24f-c81473122d00\r\nCorrelation ID: 7dd6de5d-1d6a-4950-be8b-9a2cb2df8553\r\nTimestamp:2020-04-06 10:06:52Z","error_codes":[700016],"timestamp":"2020-04-06 10:06:52Z","trace_id":"9d86f824-52c1-45a8-b24f-c81473122d00",
"correlation_id":"7dd6de5d-1d6a-4950-be8b-9a2cb2df8553","error_uri":"https://login.microsoftonline.com/error?code=700016 "}
```

To troubleshoot the authentication failures, follow these steps:

1. Verify the Microsoft Entra app tenant ID, application ID, sign-in, and password details from the Azure portal.

2. Reconfigure the fence agent in the cluster:

    ```bash
    sudo pcs property set maintenance-mode=true
    
    sudo pcs cluster edit
    ```

3. Change the parameters of the Azure fence agent resources, and then save the changes:

    ```bash
    sudo pcs property set maintenance-mode=false
    ```

4. Verify the cluster status to confirm that the fence agent issues are fixed:

    ```bash
    sudo pcs status
    ```

## Cause 3: Insufficient permissions

If you check the */var/log/messages* log file, you'll see an output that resembles the following example:

```output
Apr 2 00:49:57 heeudpgscs01 stonith-ng[105424]: warning: fence_azure_arm[109393] stderr: [ 2020-04-02 00:49:56,978 ERROR: Failed: Azure Error: AuthorizationFailed ]
Apr 2 00:49:57 heeudpgscs01 stonith-ng[105424]: warning: fence_azure_arm[109393] stderr: [ Message: The client '<client ID>' with object id '<object ID>' does not have authorization to perform action 'Microsoft.Compute/virtualMachines/read' over scope '/subscriptions/<subscription ID>/resourceGroups/<resource group name>/providers/Microsoft.Compute' or the scope is invalid. If access was recently granted, please refresh your credentials. ]
```

To troubleshoot the insufficient permissions, follow these steps:

1. Check the custom role definition for the `Linux Fence Agent Role` as described in [Create a custom role for the fence agent](/azure/sap/workloads/high-availability-guide-rhel-pacemaker?tabs=msi#1-create-a-custom-role-for-the-fence-agent). The role name may vary for different customers.
2. Check if the fence agent app has assigned this custom role to the affected VM. If not, assign the custom role to the VM via **Access Control**.
4. Start the Pacemaker cluster. It should start along with the fence agent.
5. Verify the cluster status to confirm that the fence agent issues are fixed:

    ```bash
    sudo pcs status
    ```

## Cause 4: SSL handshake failure

If you check the */var/log/messages* log file, you'll see an output that resembles the following example:

```output
warning: fence_azure_arm[28114] stderr: [ 2021-06-24 07:59:29,832 ERROR: Failed: Error occurred in request., SSLError: HTTPSConnectionPool(host='management.azure.com ', port=443): Max retries exceeded with url: /subscriptions/<subscription ID>/resourceGroups/<resource group>/providers/Microsoft.Compute/virtualMachines?api-version=2019-03-01 (Caused by SSLError(SSLError('bad handshake: SysCallError(-1, 'Unexpected EOF')',),)) ]
```

Test connectivity from the affected nodes by running the following `openssl` command:

```bash
openssl s_client -connect management.azure.com:443
```

You observe that the command output doesn't show the full certificate handshake:

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

Here are the possible causes of the certificate verification failure:

- A network device or firewall performs packet inspection or changes the Transparent Layer Socket (TLS) connections.
- Maximum Transmission Unit (MTU) size.

If you're using Azure Firewall to protect the nodes, make sure to add the following tags to the application or network rules to fix the fence agent issues:

```output
Application Rules:
ApiManagement, AppServiceManagement, AzureCloud
Network Rules:
AppServiceEnvironment
```

## Next steps

If you need further help, open a support request with a copy of the `debug-fence.out` file because it's required for troubleshooting purposes.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
