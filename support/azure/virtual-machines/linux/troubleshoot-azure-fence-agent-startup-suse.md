---
title: Troubleshoot Azure Fence Agent startup issues in SUSE
description: Provides troubleshooting guidance if Azure Fence Agent does not start
author: rnirek
ms.author: rnirek
ms.reviewer: divargas
ms.topic: troubleshooting
ms.date: 07/04/2024
ms.service: virtual-machines
ms.collection: linux
ms.custom: sap:Issue with Pacemaker clustering, and fencing
---

# Troubleshoot Azure Fence Agent startup issues in SUSE

This article lists the common causes of startup issues for Microsoft Azure Fence Agent, offers guidance for identifying the causes through log reviews, and provides resolutions for the issues.

## How Azure Fence Agent works

Azure Fence Agent uses an Azure API based Python program that's located at `/usr/sbin/fence_azure_arm` to perform VM power off or start actions. When a failed cluster node is detected, the cluster resource agent (RA) calls this program with the appropriate parameters to implement node fencing (also known as STONITH). 

As documented in [SUSE - Create Azure Fence agent STONITH device](/azure/sap/workloads/high-availability-guide-suse-pacemaker?branch=main&branchFallbackFrom=pr-en-us-6719&tabs=msi#1-create-a-custom-role-for-the-fence-agent), the custom role should provide the fence agent with permissions to perform the following actions:

- `powerOff`
- `start`
   
If the virtual machine (VM) is detected as unhealthy, the fence agent uses these actions to power off the VM and then start it up again.

## Symptoms

An Azure Fencing Agent resource doesn't start. When you run `sudo crm status` command to check the status of the cluster resource, the command output it reports an "unknown error."

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
## Cause 1: Endpoint connectivity or credential issues

To resolve the issue, check the log in `/var/log/messages`. If 'Azure Error: AuthenticationFailed' appears in the log (as shown in the following screenshot), the issue could be related to endpoint connectivity or credentials issues. 

```output
/var/log/messages
2021-03-15T20:23:15.441083+00:00 NodeName pacemaker-fenced[2550]:  warning: fence_azure_arm[21839] stderr: [ 2021-03-15 20:23:15,398 ERROR: Failed: Azure Error: AuthenticationFailed ]
2021-03-15T20:23:15.441260+00:00 NodeName pacemaker-fenced[2550]:  warning: fence_azure_arm[21839] stderr: [ Message: Authentication failed. ]
```
### Resolution

1. Make sure that there is outbound connectivity on port 443 to the following Azure Management API endpoints:

    * management.azure.com
    * login.microsoftonline.com

    You can test the connectivity by using `nc1, `telnet`, or `curl` (replace the endpoint value as appropriate):

    ```bash
    nc -z -v <endpoint> 443
    ```

    ```bash
    telnet <endpoint> 443
    ```

    ```bash
    curl -v telnet://<endpoint>:443
    ```

2. Make sure that a valid username and password are set for the STONITH resource. One of the major causes of STONITH resource failure is the use of invalid values for the username or password when you use a service principal. You can test the values by using the `fence_azure_arm` command, as shown in the following example. To set username and password for the STONITH resource, see [Create Azure Fence agent STONITH device](/azure/sap/workloads/high-availability-guide-suse-pacemaker?branch=main&branchFallbackFrom=pr-en-us-6719&tabs=spn#create-an-azure-fence-agent-device).

    ``` bash
    sudo /usr/sbin/fence_azure_arm --action=list --username='<user name>' --password='<password>' --tenantId=<tenant ID> --resourceGroup=<resource group> 
    ```
    This command should return the node names of the VMs in the cluster. If the command isn't successful, rerun it together with the `-v` flag to enable verbose output and `-D` flag to enable debug output, as shown in the following example:

    ```bash
    sudo /usr/sbin/fence_azure_arm --action=list --username='<user name>' --password='<password>' --tenantId=<tenant ID> --resourceGroup=<resource group> -v -D /var/tmp/debug-fence.out 
    ```

    If Managed Identity is used in the STONITH resource, run the following command:

    ```bash
    sudo /usr/sbin/fence_azure_arm --action=list --msi --resourceGroup=<resource group> -v -D /var/tmp/debug-fence.out
    ```
    > [!NOTE]
    > Replace the `<user name>`, `<password>`, `<tenant ID>`, and `<resource group>` values as appropriate.

## Cause 2: Authentication failure

Check the log in `/var/log/messages`. If 'unauthorized_client' appears in the log, as shown in the following example, the problem could be related to authentication failure.

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

Verify the Microsoft Entra ID app tenant ID, application ID, login, and password details from the Azure portal. Follow these steps:

1. After the IDs are verified or updated, reconfigure the fence agent in the cluster:

    ```bash
    sudo crm configure property maintenance-mode=true
    sudo crm configure edit <fencing agent resource>
    ```

1. Change the parameters as appropriate, and save the changes:

   ```bash
    sudo crm configure property maintenance-mode=false
   ```

1. Check the cluster status to verify that the fencing agent issue is fixed:

    ```bash
    crm status
    ```

## Cause 3: Insufficient permissions

Check the log in `/var/log/messages`. If an entry for 'The client does not have authorization to perform action' appears in the log, as shown in the following example, the problem could be related to insufficient permissions：

``` output
/var/log/messages
Apr 2 00:49:56 VM1 fence_azure_arm: Please use '-h' for usage
Apr 2 00:49:57 VM1 stonith-ng[105424]: warning: fence_azure_arm[109393] stderr: [ 2020-04-02 00:49:56,978 ERROR: Failed: Azure Error: AuthorizationFailed ]
Apr 2 00:49:57 VM1 stonith-ng[105424]: warning: fence_azure_arm[109393] stderr: [ Message: The client 'client-id' with object id '<client-id>' does not have authorization to perform action 'Microsoft.Compute/virtualMachines/read' over scope '/subscriptions/<sub-id>/resourceGroups/<rg-name>/providers/Microsoft.Compute' or the scope is invalid.If access was recently granted, please refresh your credentials. ]
```
### Resolution

1. [Create a custom role for the fence agent](/azure/sap/workloads/high-availability-guide-suse-pacemaker?branch=main&tabs=msi#1-create-a-custom-role-for-the-fence-agent) to verify that the custom role definition is configured for the fence agent.
1. Verify that the fencing agent is assigned the necessary custom role on the affected VM. If it's not, assign the role to the VM by using Access Control.
1. Run `crm status` to check the cluster status to make sure that the fencing agent issue is resolved.

## Cause 4: SSL handshake failure 

If 'SSLError: HTTPSConnectionPool(host='management.azure.com ', port=443): Max retries exceeded with url' appears in the log, as as shown in the following example, the problem could be related to SSL handshake failure：

```output
/var/log/messages
warning: fence_azure_arm[28114] stderr: [ 2021-06-24 07:59:29,832 ERROR: Failed: Error occurred in request., SSLError: HTTPSConnectionPool(host='management.azure.com ', port=443): Max retries exceeded with url: /subscriptions/<sub-id>/resourceGroups/<RG-name>/providers/Microsoft.Compute/virtualMachines?api-version=2019-03-01 (Caused by SSLError(SSLError('bad handshake: SysCallError(-1, 'Unexpected EOF')',),)) ]
```

### Resolution

1. Test connectivity from the affected nodes by using `openssl`:

    ```bash
    openssl s_client -connect management.azure.com:443
    ```

2. Check whether the output lacks the complete certificate handshake, as shown in the following example:

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
   These errors are most likely caused by a network appliance or firewall running a packet inspection or modifying Transparent Layer Socket (TLS) connections in a manner that disrupts certificate verification. Additionally, these issues can be caused by maximum transmission units (MTU) reaching their size limit.

3. If Azure Firewall is in front of the nodes, make sure that these tags are added to the application or network rules:

    - Application Rules: ApiManagement , AppServiceManagement, AzureCloud
    - Network Rules: AppServiceEnvironment

## Next Steps

If you need additional help, open a support request by using the following instructions. When you submit your request, attach a copy of `debug-fence.out` for troubleshooting.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
