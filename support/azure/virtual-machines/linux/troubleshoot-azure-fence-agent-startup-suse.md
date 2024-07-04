---
title: Troubleshoot Azure Fence Agent startup issues in SUSE
description: Provides troubleshooting guidance for Azure Fence Agent failing to start
author: rnirek
ms.author: rnirek
ms.reviewer: divargas
ms.topic: troubleshooting
ms.date: 07/04/2024
ms.service: virtual-machines
ms.collection: linux
---

#  Troubleshoot Azure Fence Agent startup issues in SUSE 

This article lists common causes of Azure Fence Agent startup issues and offers guidance on identifying these causes by reviewing the logs. It also provides corresponding solutions to resolve the issues.

## How Azure fence agent works

The Azure fence agent uses a Python program located at `/usr/sbin/fence_azure_arm`. The cluster Resource Agent (RA) which implements fencing a failed node (STONITH) calls this program with the appropriate parameters. Then uses it to communicate with the Azure platform via API calls.
As documented in [SUSE - Create Azure Fence agent STONITH device](/azure/sap/workloads/high-availability-guide-suse-pacemaker?branch=main&branchFallbackFrom=pr-en-us-6719&tabs=msi#1-create-a-custom-role-for-the-fence-agent), the custom role provides the fence agent with permissions to perform the following actions:

- `powerOff`
- `start`
   
When the virtual machine (VM) is detected as unhealthy, the fence agent uses the above actions to power off the VM, and then start it up again.

## Symptoms

Azure Fencing Agent resource fails to start, reports "unknown error", and shows in "stopped" status.

```bash  
sudo crm status
```
The following is the sample output of the crm status:

```output
Stack: corosync
Current DC: VM2 (version 2.0.1+20190417.13d370ca9-3.6.1-2.0.1+20190417.13d370ca9) - partition with quorum
Last updated: Mon Apr  6 13:58:59 2020
Last change: Mon Apr  6 13:58:53 2020 by root via crm_attribute on VM1
 
2 nodes configured
7 resources configured
 
Online: [ VM1 VM2 ]
 
Full list of resources:
 
Clone Set: cln_SAPHanaTopology_SS2_HDB00 [rsc_SAPHanaTopology_SS2_HDB00]
	 Started: [ VM1 VM2 ]
Clone Set: msl_SAPHana_SS2_HDB00 [rsc_SAPHana_SS2_HDB00] (promotable)
	 Main: [ VM1 ]
	 Sub: [ VM2 ]
Resource Group: g_ip_SS2_HDB00
	 rsc_ip_SS2_HDB00   (ocf::heartbeat:IPaddr2):       Started VM1
	 rsc_nc_SS2_HDB00   (ocf::heartbeat:azure-lb):      Started VM1
rsc_st_azure   (stonith:fence_azure_arm):      Stopped
 
Failed Resource Actions:
* rsc_st_azure_start_0 on VM2 'unknown error' (1): call=102, status=complete, exitreason='',
	last-rc-change='Mon Apr  6 13:50:57 2020', queued=0ms, exec=1790ms
* rsc_st_azure_start_0 on VM1 'unknown error' (1): call=121, status=complete, exitreason='',
	last-rc-change='Mon Apr  6 13:50:59 2020', queued=0ms, exec=1760ms
```

To resolve the issue, check the log in `/var/log/messages` and take appropriate steps in the following sections.

## Cause 1: Endpoint connectivity or credential issues

The following log points to endpoint connectivity or credential issues as the cause of the problem.

```output
/var/log/messages
2021-03-15T20:23:15.441083+00:00 NodeName pacemaker-fenced[2550]:  warning: fence_azure_arm[21839] stderr: [ 2021-03-15 20:23:15,398 ERROR: Failed: Azure Error: AuthenticationFailed ]
2021-03-15T20:23:15.441260+00:00 NodeName pacemaker-fenced[2550]:  warning: fence_azure_arm[21839] stderr: [ Message: Authentication failed. ]
2021-03-15T20:23:15.441668+00:00 NodeName pacemaker-fenced[2550]:  warning: fence_azure_arm[21839] stderr: [  ]
```
### Resolution

1. Ensure outbound connectivity on port 443 to the following Azure Management API endpoints:

    * management.azure.com
    * login.microsoftonline.com

    You test the connectivity by using `nc1, `telnet`, or `curl`:

    ```bash
    nc -z -v <endpoint> 443
    ```

    ```bash
    telnet <endpoint> 443
    ```

    ```bash
    curl -v telnet://<endpoint>:443
    ```

2. Ensure that a valid username and password are set for the STONITH resource.
    One of the major causes of STONITH resource failures is the use of invalid values for the username or password when using a Service Principal. You can test this using the `fence_azure_arm` command, as shown in the following example. To set username and password for the STONITH resource, see [SUSE - Create Azure Fence agent STONITH device](/azure/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#create-azure-fence-agent-stonith-device).

    ``` bash
    sudo /usr/sbin/fence_azure_arm --action=list --username='<user name>' --password='<password>' --tenantId=<tenant ID> --resourceGroup=<resource group> 
    ```
    This command should return the node names of the VMs in the cluster.

    If the command doesn't return successfully, it should be re-executed with the `-v` flag to enable verbose output and `-D` flag to enable debug output as shown in the following command:

    ```bash
    sudo /usr/sbin/fence_azure_arm --action=list --username='<user name>' --password='<password>' --tenantId=<tenant ID> --resourceGroup=<resource group> -v -D /var/tmp/debug-fence.out 
    ```

    If Managed Identity is used in the STONITH resource, run the following command:

    ```bash
    sudo /usr/sbin/fence_azure_arm --action=list --msi --resourceGroup=<resource group> -v -D /var/tmp/debug-fence.out
    ```
    > [!NOTE]
    > Replace `<user name>`, `<password>`, `<tenant ID>`, `<resource group>` values accordingly.

## Cause 2: Authentication failure

The following log indicates that the issue appears to be related to authentication failures:

```output
/var/log/messages
2020-04-06T10:06:47.779470+00:00 VM1 pacemaker-controld[29309]: notice: Result of probe operation for rsc_st_azure on VM1: 7 (not running)
2020-04-06T10:06:51.045519+00:00 VM1 pacemaker-execd[29306]: notice: executing - rsc:rsc_st_azure action:start call_id:52
2020-04-06T10:06:52.826702+00:00 VM1 /fence_azure_arm: Failed: AdalError: Get Token request returned http error: 400 and server response: {"error":"unauthorized_client","error_description":"AADSTS700016: Application with identifier '<app-id>'
was not found in the directory '<directory-id>. This can happen if the application has not been installed by the administrator of the tenant or consented to by any user in the tenant.
You may have sent your authentication request to the wrong tenant.\r\nTrace ID: <directory-id>\r\nCorrelation ID: 7ID\r\nTimestamp:2020-04-06 10:06:52Z","error_codes":[700016],"timestamp":"2020-04-06 10:06:52Z","trace_id":"<directory-id>",
"correlation_id":"ID","error_uri":"https://login.microsoftonline.com/error?code=700016 "}
```

### Resolution

Verify the Microsoft Entra ID app's tenant ID, application ID, login, and password details from the Azure portal.

1. Once the IDs are verified or updated, reconfigure the fence-agent in the cluster.

    ```bash
    sudo crm configure property maintenance-mode=true
    sudo crm configure edit <fencing agent resource>
    ```

2. Change the parameters accordingly and save the changes

   ```bash
    sudo crm configure property maintenance-mode=false
   ```

3. Verify the cluster status to confirm if fencing agent issue is fixed

    ```bash
    crm status
    ```

## Cause 3: Insufficient permissions

The following log indicates the issue appears to be related to Insufficient permissions:

``` output
/var/log/messages
Apr 2 00:49:56 VM1 fence_azure_arm: Please use '-h' for usage
Apr 2 00:49:57 VM1 stonith-ng[105424]: warning: fence_azure_arm[109393] stderr: [ 2020-04-02 00:49:56,978 ERROR: Failed: Azure Error: AuthorizationFailed ]
Apr 2 00:49:57 VM1 stonith-ng[105424]: warning: fence_azure_arm[109393] stderr: [ Message: The client 'd36bc109-bdfd-4b6d-bf28-d3990d3c22ea' with object id 'd36bc109-bdfd-4b6d-bf28-d3990d3c22ea' does not have authorization to perform action 'Microsoft.Compute/virtualMachines/read' over scope '/subscriptions/e2d1c3ed-77d2-47f5-a2af-27aa0f9d79a8/resourceGroups/DPG-RG-MAIN01-PROD/providers/Microsoft.Compute' or the scope is invalid.If access was recently granted, please refresh your credentials. ]
```
### Resolution

1. Referencing [create a custom role for the fence agent](/azure/sap/workloads/high-availability-guide-suse-pacemaker?branch=main&tabs=msi#1-create-a-custom-role-for-the-fence-agent), verify the custom role definition configured for the fence agent.
2. Confirm whether the fencing agent is assigned the necessary custom role on the affected VM. If not, assign the role to the VM using Access Control.
4. Verify the cluster status to ensure the fencing agent issue is resolved using `crm status`.

## Cause 4: SSL handshake failure 

The following log indicates the issue appears to be related to Insufficient permissions:

```output
/var/log/messages
warning: fence_azure_arm[28114] stderr: [ 2021-06-24 07:59:29,832 ERROR: Failed: Error occurred in request., SSLError: HTTPSConnectionPool(host='management.azure.com ', port=443): Max retries exceeded with url: /subscriptions/<sub-id>/resourceGroups/<RG-name>/providers/Microsoft.Compute/virtualMachines?api-version=2019-03-01 (Caused by SSLError(SSLError('bad handshake: SysCallError(-1, 'Unexpected EOF')',),)) ]
```

### Resolution

1. Tested connectivity from affected nodes using `openssl`:
    ```bash
    openssl s_client -connect management.azure.com:443
    ```

2. Check if the output lacks the complete certificate handshake, as shown below:

    ``` output
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
   If so, these errors are likely caused by a network appliance or firewall performs packet inspection or modifies Transparent Layer Socket (TLS) connections in a way that disrupts certificate verification. Additionally, issues with maximum transmission unit (MTU) sizes reaching their limit can also contribute to these issues.

3. If Azure Firewall is in front of the nodes, ensure that these tags are added to the application or network rules:

    - Application Rules: ApiManagement , AppServiceManagement, AzureCloud
    - Network Rules: AppServiceEnvironment


## Next Steps

If you require further help, open a support request using the following instructions. When submitting your request, attach a copy of `debug-fence.out` for troubleshooting purposes.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
