---
title: Troubleshoot Azure Key Vault Provider for Secrets Store CSI Driver on AKS
description: Troubleshoot and resolve common issues that occur when you use the Azure Key Vault Provider for Secrets Store CSI Driver on Azure Kubernetes Service (AKS).
editor: v-jsitser
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-extensions-add-ons
ms.date: 02/23/2024
ms.reviewer: nickoman, cssakscic, v-ntjandra, v-leedennis
ms.topic: troubleshooting-general
---

# Troubleshoot Azure Key Vault Provider for Secrets Store CSI Driver

This article discusses common issues that you might experience when you use the [Microsoft Azure Key Vault Provider for Secrets Store Container Storage Interface (CSI) Driver](/azure/aks/csi-secrets-store-driver) on Azure Kubernetes Service (AKS). The article provides troubleshooting tips for resolving these issues.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool (To install kubectl by using Azure CLI, run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.)

- The [Kubernetes Secrets Store CSI Driver](https://github.com/kubernetes-sigs/secrets-store-csi-driver) add-on, enabled on the AKS cluster

- The client URL ([curl](/virtualization/community/team-blog/2017/20171219-tar-and-curl-come-to-windows)) tool

- The [Netcat](https://linux.die.net/man/1/nc) (`nc`) command-line tool for TCP connections

## Troubleshooting checklist

Azure Key Vault logs are available in the provider and driver pods. To troubleshoot issues that affect the provider or driver, examine the logs from the provider or driver pod that's running on the same node that your application pod runs on.

### Troubleshooting step 1: Check the Secrets Store provider logs

To find the `secrets-store-provider-azure` pod that runs on the same node that your application pod runs on, run the following [kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) and [kubectl logs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs) commands that select the `secrets-store-provider-azure` application:

```bash
kubectl get pods --selector 'app in (csi-secrets-store-provider-azure, secrets-store-provider-azure)' \
    --all-namespaces \
    --output wide
kubectl logs <provider-pod-name> --since=1h | grep ^E
```

### Troubleshooting step 2: Check the Secrets Store CSI driver logs

To access the Secrets Store CSI Driver logs, run the same commands as in Step 1, but select the `secrets-store-csi-driver` application instead and specify the `secrets-store` container:

```bash
kubectl get pods --selector app=secrets-store-csi-driver --all-namespaces --output wide
kubectl logs <driver-pod-name> --container secrets-store --since=1h | grep ^E
```

> [!NOTE]  
> If you open a support request, it's a good idea to include the relevant logs from the Azure Key Vault provider and the Secrets Store CSI Driver.

## Cause 1: Couldn't retrieve the key vault token

You might see the following error entry in the logs or event messages:

> Warning  FailedMount  74s    kubelet            MountVolume.SetUp failed for volume "secrets-store-inline" : kubernetes.io/csi: mounter.SetupAt failed: rpc error: code = Unknown desc = failed to mount secrets store objects for pod default/test, err: rpc error: code = Unknown desc = failed to mount objects, **error: failed to get keyvault client: failed to get key vault token: nmi response failed with status code: 404**, err: \<nil>

This error occurs because a Node Managed Identity (NMI) component in *aad-pod-identity* returned an error message about a token request.

### Solution 1: Check the NMI pod logs

For more information about this error and how to resolve it, check the NMI pod logs, and refer to the [Microsoft Entra pod identity troubleshooting guide](https://azure.github.io/aad-pod-identity/docs/troubleshooting/).

## Cause 2: The provider pod can't access the key vault instance

You might see the following error entry in the logs or event messages:

> E1029 17:37:42.461313       1 server.go:54] failed to process mount request, **error: keyvault.BaseClient#GetSecret: Failure sending request: StatusCode=0 -- Original Error: context deadline exceeded**

This error occurs because the provider pod can't access the key vault instance. Access might be prevented for any of the following reasons:

- A firewall rule is blocking egress traffic from the provider.

- Network policies that are configured in the AKS cluster are blocking egress traffic.

- The provider pods run on the host network. A failure might occur if a policy is blocking this traffic or if network jitters occur on the node.

### Solution 2: Check network policies, allowlist, and node connection

To fix the issue, take the following actions:

- Put the provider pods on the allowlist.

- Check for policies that are configured to block traffic.

- Make sure that the node has connectivity to Microsoft Entra ID and your key vault.

To test the connectivity to your Azure key vault from the pod that's running on the host network, follow these steps:

1. Create the pod:

    ```bash
    cat <<EOF | kubectl apply --filename -
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
    kubectl exec --stdin --tty  curl -- sh
    ```

1. Authenticate by using your Azure key vault:

    ```bash
    curl -X POST 'https://login.microsoftonline.com/<aad-tenant-id>/oauth2/v2.0/token' \
         -d 'grant_type=client_credentials&client_id=<azure-client-id>&client_secret=<azure-client-secret>&scope=https://vault.azure.net/.default'
    ```

1. Try to get a secret that's already created in your Azure key vault:

    ```bash
    curl -X GET 'https://<key-vault-name>.vault.azure.net/secrets/<secret-name>?api-version=7.2' \
         -H "Authorization: Bearer <access-token-acquired-above>"
    ```

## Cause 3: The user-assigned managed identity is incorrect in the SecretProviderClass custom resource

If you encounter an HTTP error code "400" instance that's accompanied by an "Identity not found" error description, the user-assigned managed identity is incorrect in your `SecretProviderClass` custom resource. The full response resembles the following text:

```output
MountVolume.SetUp failed for volume "<volume-name>" :  
  rpc error:  
    code = Unknown desc = failed to mount secrets store objects for pod <namespace>/<pod>,  
    err: rpc error: code = Unknown desc = failed to mount objects,  
    error: failed to get objectType:secret, objectName:<key-vault-secret-name>, objectVersion:: azure.BearerAuthorizer#WithAuthorization:  
      Failed to refresh the Token for request to https://<key-vault-name>.vault.azure.net/secrets/<key-vault-secret-name>/?api-version=2016-10-01:  
        StatusCode=400 -- Original Error: adal: Refresh request failed.  
        Status Code = '400'.  
        Response body: {"error":"invalid_request","error_description":"Identity not found"}  
        Endpoint http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&client_id=<userAssignedIdentityID>&resource=https%!!(MISSING)A(MISSING)%!!(MISSING)F(MISSING)%!!(MISSING)F(MISSING)vault.azure.net
```

### Solution 3: Update SecretProviderClass by using the correct userAssignedIdentityID value

Find the correct user-assigned managed identity, and then update the `SecretProviderClass` custom resource to specify the correct value in the `userAssignedIdentityID` parameter. To find the correct user-assigned managed identity, run the following [az aks show](/cli/azure/aks#az-aks-show) command in Azure CLI:

```azurecli
az aks show --resource-group <resource-group-name> \
    --name <cluster-name> \
    --query addonProfiles.azureKeyvaultSecretsProvider.identity.clientId \
    --output tsv
```

For information about how to set up a `SecretProviderClass` custom resource in YAML format, see the [Use a user-assigned managed identity](/azure/aks/csi-secrets-store-identity-access#use-a-user-assigned-managed-identity) section of the *Provide an identity to access the Azure Key Vault Provider for Secrets Store CSI Driver* article.

## Cause 4: The Key Vault private endpoint is on a different virtual network than the AKS nodes

Public network access isn't allowed at the Azure Key Vault level, and the connectivity between AKS and Key Vault is made through a private link. However, the AKS nodes and the private endpoint of the Key Vault are on different virtual networks. This scenario generates a message that resembles the following text:

```output
MountVolume.SetUp failed for volume "<volume>" :  
  rpc error:  
    code = Unknown desc = failed to mount secrets store objects for pod <namespace>/<pod>,  
    err: rpc error: code = Unknown desc = failed to mount objects,  
    error: failed to get objectType:secret, objectName: :<key-vault-secret-name>, objectVersion:: keyvault.BaseClient#GetSecret:  
      Failure responding to request:  
        StatusCode=403 -- Original Error: autorest/azure: Service returned an error.  
        Status=403 Code="Forbidden"  
        Message="Public network access is disabled and request is not from a trusted service nor via an approved private link.\r\n  
        Caller: appid=<application-id>;oid=<object-id>;iss=https://sts.windows.net/<id>/;xms_mirid=/subscriptions/<subscription-id>/resourcegroups/<aks-infrastructure-resource-group>/providers/Microsoft.Compute/virtualMachineScaleSets/aks-<nodepool-name>-<nodepool-id>-vmss;xms_az_rid=/subscriptions/<subscription-id>/resourcegroups/<aks-infrastructure-resource-group>/providers/Microsoft.Compute/virtualMachineScaleSets/aks-<nodepool-name>-<nodepool-id>-vmss \r\n  
        Vault: <keyvaultname>;location=<location>" InnerError={"code":"ForbiddenByConnection"}
```

### Solution 4a: Set up a virtual network link and virtual network peering to connect the virtual networks

Fixing the connectivity issue is generally a two-step process:

- Create a [virtual network link](/azure/dns/private-dns-virtual-network-links) for the virtual network of the AKS cluster at the [private Azure DNS zone](/azure/dns/private-dns-overview) level.

- Add [virtual network peering](/azure/virtual-network/virtual-network-peering-overview) between the virtual network of the AKS cluster and the virtual network of the Key Vault private endpoint.

These steps are described in more detail in the following sections.

##### Step 1: Create the virtual network link

[Connect to the AKS cluster nodes](/azure/aks/node-access) to determine whether the fully qualified domain name (FQDN) of the Key Vault is resolved through a public IP address or a private IP address. If you receive the "Public network access is disabled and request is not from a trusted service nor via an approved private link" error message, the Key Vault endpoint is probably resolved through a public IP address. To check for this scenario, run the [nslookup](/windows-server/administration/windows-commands/nslookup) command:

```bash
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

In this case, create a virtual network link for the virtual network of the AKS cluster at the private DNS zone level. (A virtual network link is already created automatically for the virtual network of the Key Vault private endpoint.)

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
   | **Virtual network** | Select the name of the virtual network of the AKS cluster.                                  |

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

After the virtual network link is added, the FQDN should be resolvable through a private IP address.

##### Step 2: Add virtual network peering between virtual networks

If you're using a private endpoint, you've probably disabled public access at the Key Vault level. Therefore, no connectivity exists between AKS and the Key Vault. You can test that configuration by using the following Netcat (nc) command:

```bash
nc -v -w 2 <key-vault-name>.vault.azure.net 443
```

If connectivity isn't available between AKS and the Key Vault, you see output that resembles the following text:

```output
nc: connect to <key-vault-name>.vault.azure.net port 443 (tcp) timed out: Operation now in progress
```

To establish connectivity between AKS and the Key Vault, add virtual network peering between the virtual networks by following these steps:

1. Go to the [Azure portal](https://portal.azure.com).
1. Use one of the following options to follow the instructions from the [Create virtual network peer](/azure/virtual-network/tutorial-connect-virtual-networks-portal#peer-virtual-networks) section of the *Tutorial: Connect virtual networks with virtual network peering using the Azure portal* article to peer the virtual networks and verify that the virtual networks are connected (from one end):

   - Go to your AKS virtual network, and peer it to the virtual network of the Key Vault private endpoint.

   - Go to the virtual network of the Key Vault private endpoint, and peer it to the AKS virtual network.
1. In the Azure portal, search for and select the name of the other virtual network (the virtual network that you peered to in the previous step).
1. In the virtual network navigation pane, locate the **Settings** heading, and then select **Peerings**.
1. In the virtual network peering page, verify that the **Name** column contains the **Peering link name** of the **Remote virtual network** that you specified in step 2. Also, make sure that the **Peering status** column for that peering link has a value of **Connected**.

After you complete this procedure, you can run the Netcat command again. The DNS resolution and connectivity between AKS and the Key Vault should now succeed. Also, make sure that the Key Vault secrets are successfully mounted and work as expected, as shown by the following output:

```output
Connection to <key-vault-name>.vault.azure.net 443 port [tcp/https] succeeded!
```

### Solution 4b: Troubleshoot error code 403

Troubleshoot error code "403" by reviewing the [HTTP 403: Insufficient Permissions](/azure/key-vault/general/rest-error-codes#http-403-insufficient-permissions) section of the [Azure Key Vault REST API Error Codes][error-codes] reference article.

## Cause 5: The secrets-store.csi.k8s.io driver is missing from the list of registered CSI drivers

If you receive the following error message about a missing `secrets-store.csi.k8s.io` driver in the pod events, then the Secrets Store CSI Driver pods aren't running on the node in which the application is running:

> Warning FailedMount 42s (x12 over 8m56s) kubelet, akswin000000 MountVolume.SetUp failed for volume "secrets-store01-inline" : kubernetes.io/csi: mounter.SetUpAt failed to get CSI client: **driver name secrets-store.csi.k8s.io not found in the list of registered CSI drivers**

### Solution 5a: Install the Secrets Store CSI Driver

If you installed the Key Vault provider by using deployment manifests, follow the [instructions to install the Secrets Store CSI Driver](https://azure.github.io/secrets-store-csi-driver-provider-azure/docs/getting-started/installation).

### Solution 5b: Redeploy the Secrets Store CSI Driver and Key Vault provider by adding taint toleration

If you already deployed the Secrets Store CSI Driver, check whether the node is tainted. If the node is tainted, redeploy the Secrets Store CSI Driver and Key Vault provider by adding toleration for the taints.

### Solution 5c: (Windows only) Use Helm configuration values when installing the Secrets Store CSI Driver and Key Vault provider

If your application is running on a Windows node, install the Secrets Store CSI Driver and Key Vault provider on Windows nodes by using the Helm configuration values.

## Cause 6: The driver can't communicate with the provider

If you receive the following error message in the logs or events, then the driver can't communicate with the provider:

> Warning FailedMount 85s (x10 over 5m35s) kubelet, aks-default-28951543-vmss000000 MountVolume.SetUp failed for volume "secrets-store01-inline" : kubernetes.io/csi: mounter.SetupAt failed: rpc error: code = Unknown desc = failed to mount secrets store objects for pod default/nginx-secrets-store-inline-user-msi, err: **failed to find provider binary azure, err: stat /etc/kubernetes/secrets-store-csi-providers/azure/provider-azure: no such file or directory**

### Solution 6a: (Provider versions earlier than version 0.0.9) Make sure that provider pods run on all nodes

If your installed Key Vault provider version is earlier than version 0.0.9, make sure that the provider pods are running on all nodes.

### Solution 6b: (Provider version 0.0.9 and later) Use gRPC for provider communication

If you installed Key Vault provider version 0.0.9 or a later version, [configure the driver to communicate with the provider](https://azure.github.io/secrets-store-csi-driver-provider-azure/docs/upgrading/#upgrading-to-key-vault-provider-009) by using [gRPC](/dotnet/architecture/cloud-native/grpc).

## Cause 7: The CSI driver can't create the Kubernetes secret

If you receive the following error message in the secret-store container in the CSI driver, then you haven't installed the role-based access control (RBAC) cluster role and cluster role binding. The cluster role and cluster role binding are necessary for the CSI driver to synchronize the mounted content as a Kubernetes secret.

> E0610 22:27:02.283100       1 secretproviderclasspodstatus_controller.go:325] **"failed to create Kubernetes secret" err="secrets is forbidden: User \\"system:serviceaccount:default:secrets-store-csi-driver\\" cannot create resource \\"secrets\\" in API group \\"\\" in the namespace \\"default\\""** spc="default/azure-linux" pod="default/busybox-linux-5f479855f7-jvfw4" secret="default/dockerconfig" spcps="default/busybox-linux-5f479855f7-jvfw4-default-azure-linux"

### Solution 7: Install the required cluster role and cluster role binding

When you install or upgrade the CSI driver and Key Vault provider by using Helm charts from the [secrets-store-csi-driver-provider-azure GitHub repository](https://github.com/Azure/secrets-store-csi-driver-provider-azure/tree/master/charts/csi-secrets-store-provider-azure), set the `secrets-store-csi-driver.syncSecret.enabled` Helm parameter to `true`. This configuration change installs the required cluster role and cluster role binding.

To verify that the cluster role and cluster role binding are installed, run the following `kubectl get` commands:

```bash
# Synchronize as Kubernetes secret cluster role.
kubectl get clusterrole/secretprovidersyncing-role

# Synchronize as Kubernetes secret cluster role binding.
kubectl get clusterrolebinding/secretprovidersyncing-rolebinding
```

## Cause 8: The request is unauthenticated

The request is unauthenticated for Key Vault, as indicated by a "401" error code.

### Solution 8: Troubleshoot error code 401

Troubleshoot error code "401" by reviewing the ["HTTP 401: Unauthenticated Request"](/azure/key-vault/general/rest-error-codes#http-401-unauthenticated-request) section of the [Azure Key Vault REST API Error Codes][error-codes] reference article.

## Cause 9: The number of requests exceeds the stated maximum

The number of requests exceeds the stated maximum for the timeframe, as indicated by a "429" error code.

### Solution 9: Troubleshoot error code 429

Troubleshoot error code "429" by reviewing the ["HTTP 429: Too Many Requests"](/azure/key-vault/general/rest-error-codes#http-429-too-many-requests) section of the [Azure Key Vault REST API Error Codes][error-codes] reference article.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[error-codes]: /azure/key-vault/general/rest-error-codes
