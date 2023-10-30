---
title: Troubleshoot Azure Key Vault Provider for Secrets Store CSI Driver on Azure Kubernetes Service (AKS)
description: Troubleshoot and resolve common problems when you're using the Azure Key Vault Provider for Secrets Store CSI Driver on Azure Kubernetes Service (AKS).
editor: v-jsitser
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-extensions-add-ons
ms.date: 12/20/2022
ms.reviewer: nickoman, v-leedennis
---

# Troubleshoot Azure Key Vault Provider for Secrets Store CSI Driver

This article discusses common issues that you might experience when you [use the Microsoft Azure Key Vault Provider for Secrets Store Container Storage Interface (CSI) Driver](/azure/aks/csi-secrets-store-driver) on Azure Kubernetes Service (AKS). The article provides troubleshooting tips for resolving these issues.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli).

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl by using Azure CLI, run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- The client URL ([curl](/virtualization/community/team-blog/2017/20171219-tar-and-curl-come-to-windows)) tool.

- The [Netcat](https://linux.die.net/man/1/nc) (`nc`) command-line tool for TCP connections.

## Troubleshooting checklist

Azure Key Vault Provider logs are available in the provider pods. To troubleshoot issues that affect the provider, examine the logs from the provider pod that's running on the same node as your application pod.

### Step 1: Check the Secrets Store provider logs

To find the `secrets-store-provider-azure` pod that runs on the same node as your application pod, run the following commands:

```bash
kubectl get pods -l app=secrets-store-provider-azure -n kube-system -o wide
kubectl logs -l app=secrets-store-provider-azure -n kube-system --since=1h | grep ^E
```

### Step 2: Check the Secrets Store CSI driver logs

To access the Secrets Store CSI Driver logs, run the following commands:

```bash
kubectl get pods -l app=secrets-store-csi-driver -n kube-system -o wide
kubectl logs -l app=secrets-store-csi-driver -n kube-system --since=1h | grep ^E
```

## Cause 1: "Failed to get key vault token... nmi response failed with status code: 404" error

You might see the following error entry in the logs or event messages:

> Warning  FailedMount  74s    kubelet            MountVolume.SetUp failed for volume "secrets-store-inline" : kubernetes.io/csi: mounter.SetupAt failed: rpc error: code = Unknown desc = failed to mount secrets store objects for pod default/test, err: rpc error: code = Unknown desc = failed to mount objects, **error: failed to get keyvault client: failed to get key vault token: nmi response failed with status code: 404**, err: \<nil>

This error occurs because a Node Managed Identity (NMI) component in *aad-pod-identity* returned an error for a token request.

### Solution 1: Check the NMI pod logs

For more information about this error and how to resolve it, check the NMI pod logs and refer to the [Microsoft Entra pod identity troubleshooting guide](https://azure.github.io/aad-pod-identity/docs/troubleshooting/).

> [!NOTE]
> Microsoft Entra ID is abbreviated as *Microsoft Entra ID* in the *aad-pod-identity* string.

## Cause 2: "keyvault.BaseClient#GetSecret: Failure sending request: StatusCode=0" error

You might see the following error entry in the logs or event messages:

> E1029 17:37:42.461313       1 server.go:54] failed to process mount request, **error: keyvault.BaseClient#GetSecret: Failure sending request: StatusCode=0 -- Original Error: context deadline exceeded**

This error occurs because the provider pod can't access the key vault instance. Access might be prevented for any of the following reasons:

- A firewall rule is blocking egress traffic from the provider.

- Network policies that are configured in the AKS cluster are blocking egress traffic.

- The provider pods run on the host network. A failure might occur if a policy is blocking this traffic or there are network jitters on the node.

### Solution 2: Check network policies, allowlist, and node connection

To fix the issue, take the following actions:

- Put the provider pods on the allowlist.

- Check for policies that are configured to block traffic.

- Make sure that the node has connectivity to Microsoft Entra ID and your key vault.

To test the connectivity to your Azure key vault from the pod that's running on the host network, follow these steps:

1. Create the pod:

    ```bash
    cat <<EOF | kubectl apply -f -
    apiVersion: v1
    kind: Pod
    metadata:
      name: curl
    spec:
      hostNetwork: true
      containers:
      - args:
        - tail
        - -f
        - /dev/null
        image: curlimages/curl:7.75.0
        name: curl
      dnsPolicy: ClusterFirst
      restartPolicy: Always
    EOF
    ```

1. Run [kubectl exec](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec) to run a command in the pod that you created:

    ```bash
    kubectl exec -it curl -- sh
    ```

1. Authenticate with your Azure key vault:

    ```bash
    curl -X POST 'https://login.microsoftonline.com/<AAD_TENANT_ID>/oauth2/v2.0/token' \
         -d 'grant_type=client_credentials&client_id=<AZURE_CLIENT_ID>&client_secret=<AZURE_CLIENT_SECRET>&scope=https://vault.azure.net/.default'
    ```

1. Try to get a secret that's already created in your Azure key vault:

    ```bash
    curl -X GET 'https://<KEY_VAULT_NAME>.vault.azure.net/secrets/<SECRET_NAME>?api-version=7.2' \
         -H "Authorization: Bearer <ACCESS_TOKEN_ACQUIRED_ABOVE>"
    ```

## Cause 3: The user-assigned managed identity is incorrect in the SecretProviderClass custom resource

If you experience an HTTP error code 400 that's accompanied by an "Identity not found" error description, the user-assigned managed identity is incorrect in your SecretProviderClass custom resource. The full response resembles the following text:

> MountVolume.SetUp failed for volume "\<volume-name>" :  
> &emsp;rpc error:  
> &emsp;&emsp;code = Unknown desc = failed to mount secrets store objects for pod \<namespace>/\<pod>,  
> &emsp;&emsp;err: rpc error: code = Unknown desc = failed to mount objects,  
> &emsp;&emsp;error: failed to get objectType:secret, objectName:\<key-vault-secret-name>, objectVersion:: azure.BearerAuthorizer#WithAuthorization:  
> &emsp;&emsp;&emsp;Failed to refresh the Token for request to https://\<key-vault-name>.vault.azure.net/secrets/\<key-vault-secret-name>/?api-version=2016-10-01:  
> &emsp;&emsp;&emsp;&emsp;StatusCode=400 -- Original Error: adal: Refresh request failed.  
> &emsp;&emsp;&emsp;&emsp;**Status Code = '400'.**  
> &emsp;&emsp;&emsp;&emsp;**Response body: {"error":"invalid_request","error_description":"Identity not found"}**  
> &emsp;&emsp;&emsp;&emsp;Endpoint http\://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&client_id=\<userAssignedIdentityID>&resource=https%!!(MISSING)A(MISSING)%!!(MISSING)F(MISSING)%!!(MISSING)F(MISSING)vault.azure.net

### Solution 3: Update the SecretProviderClass by using the correct userAssignedIdentityID value

Find the correct user-assigned managed identity, and then update the SecretProviderClass custom resource to specify the correct value in the `userAssignedIdentityID` parameter. To find the correct user-assigned managed identity, run the following [az aks show](/cli/azure/aks#az-aks-show) command in Azure CLI:

```azurecli
az aks show --resource-group <resource-group-name> \
    --name <cluster-name> \
    --query addonProfiles.azureKeyvaultSecretsProvider.identity.clientId \
    --output tsv
```

For information about how to set up a SecretProviderClass custom resource in YAML format, see the [Use a user-assigned managed identity](/azure/aks/csi-secrets-store-identity-access#use-a-user-assigned-managed-identity) section of the article that's titled *Provide an identity to access the Azure Key Vault Provider for Secrets Store CSI Driver*.

## Cause 4: Public network access to the Key Vault isn't allowed, but its private endpoint is on a different virtual network than the AKS nodes

Public network access isn't allowed at the Azure Key Vault level, and the connectivity between AKS and Key Vault is made through a private link. However, the AKS nodes and the Key Vault's private endpoint are on different virtual networks. This scenario generates a message that resembles the following text:

> MountVolume.SetUp failed for volume "\<volume>" :  
> &emsp;rpc error:  
> &emsp;&emsp;code = Unknown desc = failed to mount secrets store objects for pod \<namespace>/\<pod>,  
> &emsp;&emsp;err: rpc error: code = Unknown desc = failed to mount objects,  
> &emsp;&emsp;error: failed to get objectType:secret, objectName: :\<key-vault-secret-name>, objectVersion:: keyvault.BaseClient#GetSecret:  
> &emsp;&emsp;&emsp;Failure responding to request:  
> &emsp;&emsp;&emsp;&emsp;StatusCode=403 -- Original Error: autorest/azure: Service returned an error.  
> &emsp;&emsp;&emsp;&emsp;**Status=403 Code="Forbidden"**  
> &emsp;&emsp;&emsp;&emsp;**Message="Public network access is disabled and request is not from a trusted service nor via an approved private link.\r\n**  
> &emsp;&emsp;&emsp;&emsp;Caller: appid=\<application-id>;oid=\<object-id>;iss=https\://sts.windows.net/\<id>/;xms_mirid=/subscriptions/\<subscription-id>/resourcegroups/\<aks-infrastructure-resource-group>/providers/Microsoft.Compute/virtualMachineScaleSets/aks-\<nodepool-name>-\<nodepool-id>-vmss;xms_az_rid=/subscriptions/\<subscription-id>/resourcegroups/\<aks-infrastructure-resource-group>/providers/Microsoft.Compute/virtualMachineScaleSets/aks-\<nodepool-name>-\<nodepool-id>-vmss \r\n  
> &emsp;&emsp;&emsp;&emsp;Vault: \<keyvaultname>;location=\<location>" InnerError={"code":"ForbiddenByConnection"}

### Solution 4: Set up a virtual network link and virtual network peering to connect the virtual networks

Fixing the connectivity problem is generally a two-step process:

1. Create a [virtual network link](/azure/dns/private-dns-virtual-network-links) for the virtual network of the AKS cluster at the [private Azure DNS zone](/azure/dns/private-dns-overview) level.

1. Add [virtual network peering](/azure/virtual-network/virtual-network-peering-overview) between the virtual network of the AKS cluster and the virtual network of the Key Vault's private endpoint.

These steps are described in more detail in the following sections.

#### Create the virtual network link

First, [connect to the AKS cluster nodes](/azure/aks/node-access) to determine whether the fully qualified domain name (FQDN) of the Key Vault is resolved through a public IP address or a private IP address. If you receive the "Public network access is disabled and request is not from a trusted service nor via an approved private link" error message, the Key Vault endpoint is probably being resolved through a public IP address. To check for this scenario, run the [nslookup](/windows-server/administration/windows-commands/nslookup) command:

```console
nslookup <key-vault-name>.vault.azure.net
```

If the FQDN is resolved through a public IP address, the command output resembles the following text:

```console
root@aks-<nodepool-name>-<nodepool-id>-vmss<scale-set-instance>:/# nslookup <key-vault-name>.vault.azure.net
Server:         168.63.129.16
Address:        168.63.129.16#53

Non-authoritative answer:
<key-vault-name>.vault.azure.net  canonical name = <key-vault-name>.privatelink.vaultcore.azure.net.
<key-vault-name>.privatelink.vaultcore.azure.net  canonical name = data-prod.weu.vaultcore.azure.net.
data-prod-weu.vaultcore.azure.net  canonical name = data-prod-weu-region.vaultcore.azure.net.
data-prod-weu-region.vaultcore.azure.net  canonical name = azkms-prod-weu-b.westeurope.cloudapp.azure.com.
Name:   azkms-prod-weu-b.westeurope.cloudapp.azure.com
Address: 20.1.2.3
```

In this case, create a virtual network link for the virtual network of the AKS cluster at the private DNS zone level. (A virtual network link is already created automatically for the virtual network of the Key Vault's private endpoint.)

To create the virtual network link, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Private DNS zones**.
1. In the list of private DNS zones, select the name of your private DNS zone. In this example, the private DNS zone is **privatelink.vaultcore.azure.net**.
1. In the navigation pane of the private DNS zone, locate the **Settings** heading, and then select **Virtual network links**.
1. In the list of virtual network links, select **Add**.
1. In the **Add virtual network link** page, complete the following fields.

   | Field name          | Action                                                                                 |
   |---------------------|----------------------------------------------------------------------------------------|
   | **Link name**       | Enter a name to use for the virtual network link.                                      |
   | **Subscription**    | Select the name of the subscription that you want to contain the virtual network link. |
   | **Virtual network** | Select the name of the AKS cluster's virtual network.                                  |

1. Select the **OK** button.

After you finish the link creation procedure, run the `nslookup` command. The output should now resemble the following text that shows a more direct DNS resolution:

```console
root@aks-<nodepool-name>-<nodepool-id>-vmss<scale-set-instance>:/# nslookup <key-vault-name>.vault.azure.net
Server:         168.63.129.16
Address:        168.63.129.16#53

Non-authoritative answer:
<key-vault-name>.vault.azure.net  canonical name = <key-vault-name>.privatelink.vaultcore.azure.net.
Name:   <key-vault-name>.privatelink.vaultcore.azure.net
Address: 172.20.0.4
```

After the virtual network link is added, the FQDN should be able to be resolved through a private IP address.

#### Add virtual network peering between the two virtual networks

If you're using a private endpoint, you've probably disabled public access at the Key Vault level, so there's no connectivity between AKS and the Key Vault. You can test that configuration by using the following Netcat (nc) command:

```console
nc -v -w 2 <key-vault-name>.vault.azure.net 443
```

If connectivity isn't available between AKS and the Key Vault, you'll see output that resembles the following text:

```output
nc: connect to <key-vault-name>.vault.azure.net port 443 (tcp) timed out: Operation now in progress
```

To establish connectivity between AKS and the Key Vault, add virtual network peering between the virtual networks by following these steps:

1. Go to the [Azure portal](https://portal.azure.com).
1. Use one of the following two options to follow the instructions in [Peer virtual networks](/azure/virtual-network/tutorial-connect-virtual-networks-portal#peer-virtual-networks) to peer the virtual networks and verify that the virtual networks are connected (from one end):

   - Go to your AKS virtual network, and peer it to the virtual network of the Key Vault private endpoint.

   - Go to the virtual network of the Key Vault private endpoint, and peer it to the AKS virtual network.
1. In the Azure portal, search for and select the name of the other virtual network (the virtual network that you peered to in the previous step).
1. In the virtual network navigation pane, locate the **Settings** heading, and select **Peerings**.
1. In the virtual network peering page, verify that the **Name** column contains the **Peering link name** of the **Remote virtual network** that you specified in step 2, and make sure that the **Peering status** column for that peering link has a value of **Connected**.

After you complete this procedure, you can run the Netcat command again. The DNS resolution and connectivity between AKS and the Key Vault should now succeed. Also, make sure that the Key Vault secrets are successfully mounted and work as expected, as shown by the following output:

```output
Connection to <key-vault-name>.vault.azure.net 443 port [tcp/https] succeeded!
```

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
