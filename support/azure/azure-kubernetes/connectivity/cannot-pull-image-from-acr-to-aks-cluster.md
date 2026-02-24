---
title: Can't pull images from Azure Container Registry to Kubernetes
description: This article helps you troubleshoot the most common errors that you may encounter when pulling images from a container registry to an AKS cluster.
ms.date: 06/05/2025
author: JarrettRenshaw
ms.author: jarrettr
ms.reviewer: chiragpa, andbar, albarqaw, v-weizhu, v-leedennis, v-ryanberg
ms.service: azure-kubernetes-service
ms.custom: sap:Connectivity
---
# Troubleshoot failures when pulling images from Azure Container Registry to Azure Kubernetes Service cluster 

[!INCLUDE [Feedback](../../../includes/feedback.md)]

When you're using Microsoft Azure Container Registry together with Azure Kubernetes Service (AKS), an authentication mechanism must be established. You can set up the AKS to Container Registry integration by using a few simple Azure CLI or Azure PowerShell commands. This integration assigns either the [Container Registry Repository Reader role](/azure/role-based-access-control/built-in-roles#container-registry-repository-reader) (for attribute-based access control (ABAC)-enabled registries) or the [AcrPull role](/azure/role-based-access-control/built-in-roles#acrpull) (for non-ABAC-enabled registries) for the kubelet identity that's associated with the AKS cluster to pull images from a container registry. See [Microsoft Entra attribute-based access control (ABAC) for repository permissions](/azure/container-registry/container-registry-rbac-abac-repository-permissions?tabs=azure-portal) for more information on the necessary ACR role to assign based on whether your ACR registry is ABAC-enabled.

In some cases, trying to pull images from a container registry to an AKS cluster fails. This article provides guidance for troubleshooting the most common errors that you encounter when you pull images from a container registry to an AKS cluster.

## Before you begin

This article assumes that you have an existing AKS cluster and an existing container registry. See the following quick starts:

- If you need an AKS cluster, deploy one by using [the Azure CLI](/azure/aks/kubernetes-walkthrough) or [the Azure portal](/azure/aks/kubernetes-walkthrough-portal).

- If you need an Azure Container Registry (ACR), create one by using [the Azure CLI](/azure/container-registry/container-registry-get-started-azure-cli) or [the Azure portal](/azure/container-registry/container-registry-get-started-portal).

You also need Azure CLI version 2.0.59 or a later version to be installed and configured. Run [az version](/cli/azure/reference-index#az-version) to determine the version. If you have to install or upgrade, see [Install Azure CLI](/cli/azure/install-azure-cli).

## Symptoms and initial troubleshooting

The Kubernetes pod's **STATUS** is **ImagePullBackOff** or **ErrImagePull**. To get detailed error information, run the following command and check **Events** from the output.

```console
kubectl describe pod <podname> -n <namespace>
```

We recommend that you start troubleshooting by checking the [container registry's health](/azure/container-registry/container-registry-check-health) and checking whether the container registry is accessible from the AKS cluster.

To check the container registry's health, run the following command:

```azurecli
az acr check-health --name <myregistry> --ignore-errors --yes
```

If a problem is detected, it provides an error code and description. For more information about the errors and possible solutions, see [Health check error reference](/azure/container-registry/container-registry-health-error-reference).

> [!NOTE]
> If you get Helm-related or Notary-related errors, it doesn't mean that this issue is affecting the container registry or AKS. It can indicate that Helm or Notary isn't installed or that Azure CLI isn't compatible with the current installed version of Helm or Notary.

To validate whether the container registry is accessible from the AKS cluster, run the following [az aks check-acr](/cli/azure/aks#az-aks-check-acr) command:

```azurecli
az aks check-acr --resource-group <MyResourceGroup> --name <MyManagedCluster> --acr <myacr>.azurecr.io
```

The following sections help you troubleshoot the most common errors that are displayed in **Events** in the output of the `kubectl describe pod` command.

## Cause 1: `401 Unauthorized` error

### Cause 1a: `401 Unauthorized` error due to incorrect authorization

An AKS cluster requires an identity. This identity can be either a managed identity or a service principal. If the AKS cluster uses a managed identity, the kubelet identity is used for authenticating with ACR. If the AKS cluster is using as an identity a service principal, the service principal itself is used for authenticating with ACR. No matter what the identity is, the proper authorization that's used to pull an image from a container registry is necessary. Otherwise, you might get the following `401 Unauthorized` error:

`Failed to pull image "\<acrname>.azurecr.io/\<repository\:tag>": [rpc error: code = Unknown desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository\:tag>": failed to resolve reference "\<acrname>.azurecr.io/\<repository\:tag>": failed to authorize: failed to fetch oauth token: unexpected status: 401 Unauthorized`

Several solutions can help you resolve this error, subject to the following constraints:

- Solutions [2][cause1-solution2], [3][cause1-solution3], and [5][cause1-solution5] are applicable only to [AKS clusters that use a service principal](/azure/aks/kubernetes-service-principal).

- Solutions [1][cause1-solution1], [2][cause1-solution2], [3][cause1-solution3], and [4][cause1-solution4] are applicable for the Azure method of [creating the role assignment at Container Registry level for AKS's identity](/azure/aks/cluster-container-registry-integration).

- Solutions [5][cause1-solution5] and [6][cause1-solution6] are applicable for the Kubernetes method of [pulling a Kubernetes secret](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/).

#### Solution 1: Make sure the correct ACR role assignment is created for identity

The integration between AKS and the container registry creates the correct role assignment at container registry level for the AKS cluster's kubelet identity.

> [!NOTE]
> Make sure that the correct role assignment is created (`Container Registry Repository Reader` for ABAC-enabled regisries, and `AcrPull` for non-ABAC-enabled registries).
> See See [Microsoft Entra attribute-based access control (ABAC) for repository permissions](/azure/container-registry/container-registry-rbac-abac-repository-permissions?tabs=azure-portal) for more information on the correct ACR role needed based on whether the registry is ABAC-enabled or not.

To check whether the correct ACR role assignment exists, use one of the following methods:

- Run the following command:

  ```azurecli
  az role assignment list --scope /subscriptions/<subscriptionID>/resourceGroups/<resourcegroupname>/providers/Microsoft.ContainerRegistry/registries/<acrname> -o table
  ```

- Check in the Azure portal by selecting **Azure Container Registry** > **Access control (IAM)** > **Role assignments**. For more information, see [List Azure role assignments using the Azure portal](/azure/role-based-access-control/role-assignments-list-portal).

Besides either the `Container Registry Repository Reader` role (for ABAC-enabled registries) and `AcrPull` role (for non-ABAC-enabled registries), some [built-in roles](/azure/role-based-access-control/built-in-roles) and [custom roles](/azure/role-based-access-control/custom-roles) can also contain the necessary Microsoft Entra permissions for image pull. Check those roles as needed.

If either the `Container Registry Repository Reader` role (for ABAC-enabled registries) or `AcrPull` role (for non-ABAC-enabled registries) don't exist, you can create the role assignment.

For non-ABAC-enabled registries, you can assign the `AcrPull` role with the following command:

```azurecli
az aks update -n <myAKSCluster> -g <myResourceGroup> --attach-acr <acr-resource-id>
```

For ABAC-enabled registries, the `az aks --attach-acr` command doesn't support adding the `Container Registry Repository Reader` role. You must manually assign this role to the AKS kubelet identity using either the Azure portal or the `az role assignment` CLI commands.

#### Solution 2: Make sure service principal isn't expired

Make sure that the secret of the service principal that's associated with the AKS cluster isn't expired. To check the expiration date of your service principal, run the following commands:

```azurecli
SP_ID=$(az aks show --resource-group <myResourceGroup> --name <myAKSCluster> \
    --query servicePrincipalProfile.clientId -o tsv)

az ad app credential list --id "SP_ID" --query "[].endDateTime" --output tsv
```

For more information, see [Check the expiration date of your service principal](/azure/aks/update-credentials#check-the-expiration-date-of-your-service-principal).

If the secret is expired, [update the credentials for the AKS cluster](/azure/aks/update-credentials).

#### Solution 3: Make sure the correct ACR role is assigned to correct service principal

In some cases, the container registry role assignment still refers to the old service principal. For example, when the service principal of the AKS cluster is replaced with a new one. To make sure that the container registry role assignment refers to the correct service principal, follow these steps:

1. To check the service principal that's used by the AKS cluster, run the following command:

    ```azurecli
    az aks show --resource-group <myResourceGroup> \
        --name <myAKSCluster> \
        --query servicePrincipalProfile.clientId \
        --output tsv
    ```

1. To check the service principal that's referenced by the container registry role assignment, run the following command:

    ```azurecli
    az role assignment list --scope /subscriptions/<subscriptionID>/resourceGroups/<resourcegroupname>/providers/Microsoft.ContainerRegistry/registries/<acrname> -o table
    ```

1. Compare the two service principals. If they don't match, integrate the AKS cluster with the container registry again.

#### Solution 4: Make sure the kubelet identity is referenced in the AKS Virtual Machine Scale Sets

When a managed identity is used for authentication with the ACR, the managed identity is known as the kubelet identity. By default, the kubelet identity is assigned at the AKS Virtual Machine Scale Setslevel. If the kubelet identity is removed from the AKS Virtual Machine Scale Sets, the AKS nodes can't pull images from the ACR.

To find the kubelet identity of your AKS cluster, run the following command:

```azurecli
az aks show --resource-group <MyResourceGroup> --name <MyManagedCluster> --query identityProfile.kubeletidentity
```

Then, you can list the identities of the AKS Virtual Machine Scale Sets by opening the Virtual Machine Scale Sets from the node resource group and selecting **Identity** > **User assigned** in the Azure portal or by running the following command:

```azurecli
az vmss identity show --resource-group <NodeResourceGroup> --name <AksVmssName>
```

If the kubelet identity of your AKS cluster isn't assigned to the AKS Virtual Machine Scale Sets, assign it back. 

> [!NOTE]
> [Modifying the AKS Virtual Machine Scale Sets using the internet-as-a-service (IaaS) APIs or from the Azure portal isn't supported](/azure/aks/support-policies#user-customization-of-agent-nodes) and no AKS operation can remove the kubelet identity from the AKS Virtual Machine Scale Sets. This means that something or someone removed it, like a manual removal performed by a team member. To prevent such removal or modification, consider using the [NRGLockdown feature](/azure/aks/cluster-configuration#fully-managed-resource-group-preview).

Because modifications to the AKS Virtual Machine Scale Sets aren't supported, they don't propagate at the AKS level. To reassign the kubelet identity to the AKS Virtual Machine Scale Sets, a reconciliation operation is needed. To do this, run the following command:

```azurecli
az aks update --resource-group <MyResourceGroup> --name <MyManagedCluster>
```

#### Solution 5: Make sure the service principal is correct and the secret is valid

If you pull an image by using an [image pull secret](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry), and that Kubernetes secret was created by using the values of a service principal, make sure that the associated service principal is correct and the secret is still valid. Follow these steps:

1. Run the following [kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) and [base64](https://ss64.com/bash/base64.html) command to see the values of the Kubernetes secret:

   ```console
   kubectl get secret <secret-name> --output="jsonpath={.data.\.dockerconfigjson}" | base64 --decode
   ```

1. Check the expiration date by running the following [az ad sp credential list](/cli/azure/ad/sp/credential#az-ad-sp-credential-list) command. The username is the service principal value.

   ```azurecli
   az ad sp credential list --id "<username>" --query "[].endDate" --output tsv
   ```

1. If necessary, reset the secret of that service principal by running the following [az ad sp credential reset](/cli/azure/ad/sp/credential#az-ad-sp-credential-reset) command:

   ```azurecli
   az ad sp credential reset --name "$SP_ID" --query password --output tsv
   ```

1. Update or recreate the Kubernetes secret accordingly.

#### Solution 6: Make sure the Kubernetes secret has the correct values of the container registry admin account

If you pull an image by using an [image pull secret](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/), and that Kubernetes secret was created by using values of [container registry admin account](/azure/container-registry/container-registry-authentication#admin-account), make sure that the values in the Kubernetes secret are the same as the values of the container registry admin account. Follow these steps:

1. Run the following [kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) and [base64](https://ss64.com/bash/base64.html) command to see the values of the Kubernetes secret:

   ```console
   kubectl get secret <secret-name> --output="jsonpath={.data.\.dockerconfigjson}" | base64 --decode
   ```

1. In the [Azure portal](https://portal.azure.com), search for and select **Container registries**.

1. In the list of container registries, select your container registry.

1. In the navigation pane for the container registry, select **Access keys**.

1. In the **Access keys** page for the container registry, compare the container registry values with the values in the Kubernetes secret.

1. If the values don't match, update or recreate the Kubernetes secret accordingly.

> [!NOTE]
> If a **Regenerate** password operation occurred, an operation named `Regenerate Container Registry Login Credentials` displays in the **Activity log** page of the container registry. The **Activity log** has a [90-day retention period](/azure/azure-monitor/essentials/activity-log#retention-period).

### Cause 1b: `401 Unauthorized` error due to incompatible architecture

You might encounter a `401 Unauthorized` error even when the AKS cluster identity is authorized (as described in the [Cause 1a: `401 Unauthorized` error due to incorrect authorization](#cause-1a-401-unauthorized-error-due-to-incorrect-authorization) section). This issue can happen if the container image in the ACR doesn't match the architecture (like ARM64 versus AMD64) of the node running the container. For example, deploying an ARM64 image on an AMD64 node or vice versa can result in this error.

The error message appears as follows:

`Failed to pull image "\<acrname>.azurecr.io/\<repository:\tag>": [rpc error: code = NotFound desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository:\tag>": no match for platform in manifest: not found, failed to pull and unpack image "\<acrname>.azurecr.io/\<repository\:tag>": failed to resolve reference "\<acrname>.azurecr.io/\<repository\:tag>": failed to authorize: failed to fetch anonymous token: unexpected status from GET request to https://\<acrname>.azurecr.io/oauth2/token?scope=repository%3A\<repository>%3Apull&service=\<acrname>.azurecr.io: 401 Unauthorized]`

When diagnosing this issue using the Azure CLI, you might see an unexpected `exec format` error if your system node pool runs a different architecture than the image in the ACR:

```azurecli
az aks check-acr --resource-group <MyResourceGroup> --name <MyManagedCluster> --acr <myacr>.azurecr.io

exec /canipull: exec format error
```

#### Solution: Push images with the correct architecture or push multi-architecture images

To resolve this issue, use one of the following methods:

- Ensure the container images pushed to ACR match the architecture of your AKS nodes (for example, ARM64 or AMD64).
- Create and push multi-architecture images that support both ARM64 and AMD64 architectures.

## Cause 2: Image not found error

The image not found error appears as follows:

`Failed to pull image "\<acrname>.azurecr.io/\<repository\:tag>": [rpc error: code = NotFound desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository\:tag>": failed to resolve reference "\<acrname>.azurecr.io/\<repository\:tag>": \<acrname>.azurecr.io/\<repository\:tag>: not found`

### Solution: Make sure the image name is correct

If you see this error, make sure that the image name is correct. Check the registry name, the registry sign-in server, the repository name, and the tag. 

> [!NOTE]
> A common mistake is that the sign-in server is specified as **azureacr.io** instead of **azurecr.io**.

If the image name isn't fully correct, the [401 Unauthorized error](#cause-1-401-unauthorized-error) can also occur because AKS always tries anonymous pull regardless of whether the container registry has enabled anonymous pull access.

## Cause 3: `403 forbidden` error

The `403 Forbidden` error message appears as follows:

`Failed to pull image "\<acrname>.azurecr.io/\<repository\:tag>": rpc error: code = Unknown desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository\:tag>": failed to resolve reference "\<acrname>.azurecr.io/\<repository\:tag>": failed to authorize: failed to fetch anonymous token: unexpected status: 403 Forbidden`

### Solution 1: Make sure the AKS virtual network link is set in the container registry's Private DNS zone

If the network interface of the container registry's private endpoint and the AKS cluster are in different virtual networks, make sure that the [virtual network link](/azure/dns/private-dns-virtual-network-links) for the AKS cluster's virtual network is set in the private DNS zone of the container registry. (That link is named **privatelink.azurecr.io** by default.) If the virtual network link isn't in the private DNS zone of the container registry, add it using one of the following methods:

- Use the Azure portal:

1. In the Azure portal, select the private DNS zone **privatelink.azurecr.io**.
1. In **Settings**, select **Virtual network links** > **Add**. 
1. Select a name and the virtual network of the AKS cluster, and then select **OK**.

  > [!NOTE]
  > It's optional to select the [Enable auto registration](/azure/dns/private-dns-autoregistration) feature.

- [Create a virtual network link to the specified private DNS zone by using Azure CLI](/cli/azure/network/private-dns/link/vnet#az-network-private-dns-link-vnet-create).

### Solution 2: Add the AKS load balancer's public IP address to the allowed IP address range of the container registry

If the AKS cluster connects publicly to the container registry (**not** through a private link or an endpoint) and the public network access of the container registry is limited to selected networks, add the AKS load balancer's public IP address to the allowed IP address range of the container registry using the following steps:

1. Verify that the public network access is limited to selected networks.

    1. In the Azure portal, navigate to the container registry. 
    1. In **Settings**, select **Networking**. 
    1. On the **Public access** tab, set **Public network access** to **Selected networks** or **Disabled**.

2. Obtain the AKS Load Balancer's public IP address by using one of the following ways:

    - Use the Azure portal;
        
        1. In the Azure portal, navigate to the AKS cluster. 
        1. In **Settings**, select **Properties**. 
        1. Select one of the Virtual Machine Scale Sets in the infrastructure resource group and check the public IP address of the AKS load balancer.
    
    - Run the following command:

      ```azurecli
      az network public-ip show --resource-group <infrastructure-resource-group> --name <public-IP-name> --query ipAddress -o tsv
      ```

3. Allow access from the AKS load balancer's public IP address by using one of the following ways:

    - Run the `az acr network-rule add` command as follows:

      ```azurecli
      az acr network-rule add --name acrname --ip-address <AKS-load-balancer-public-IP-address>
      ```

      For more information, see [Add network rule to registry](/azure/container-registry/container-registry-access-selected-networks#add-network-rule-to-registry).

    - Use the Azure portal:

      1. In the Azure portal, navigate to the container registry. 
      1. In **Settings**, select **Networking**. 
      1. On the **Public access** tab, in **Firewall**, add the AKS load balancer's public IP address to **Address range** and then select **Save**. 
      
      For more information, see [Access from selected public network - portal](/azure/container-registry/container-registry-access-selected-networks#access-from-selected-public-network---portal).

      > [!NOTE]
      > If **Public network access** is set to **Disabled**, switch it to **Selected networks** first.

      :::image type="content" source="./media/cannot-pull-image-from-acr-to-aks-cluster/add-aks-load-balancer-public-ip.png" alt-text="Screenshot about how to add AKS Load Balancer's public IP address to address range" lightbox="media/cannot-pull-image-from-acr-to-aks-cluster/add-aks-load-balancer-public-ip.png":::

## Cause 4: `i/o timeout` error

The `i/o timeout` error message appears as follows:

`Failed to pull image "\<acrname>.azurecr.io/\<repository\:tag>": rpc error: code = Unknown desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository\:tag>": failed to resolve reference "\<acrname>.azurecr.io/<repository\:tag>": failed to do request: Head "https://\<acrname>.azurecr.io/v2/\<repository>/manifests/v1": dial tcp \<acrprivateipaddress>:443: i/o timeout`

> [!NOTE]
> The `i/o timeout` error occurs only when you [connect privately to a container registry by using Azure Private Link](/azure/container-registry/container-registry-private-link).

### Solution 1: Make sure virtual network peering is used

If the network interface of the container registry's private endpoint and the AKS cluster are in different virtual networks, make sure that [virtual network peering](/azure/virtual-network/virtual-network-peering-overview) is used for both virtual networks. You can check virtual network peering by running the Azure CLI command `az network vnet peering list --resource-group <MyResourceGroup> --vnet-name <MyVirtualNetwork> --output table` or in the Azure portal by selecting the **VNETs** > **Peerings** in the **Settings** panel. For more information about listing all peerings of a specified virtual network, see [az network vnet peering list](/cli/azure/network/vnet/peering#az-network-vnet-peering-list).

If the virtual network peering is used for both virtual networks, make sure that the status is **Connected**. If the status is [Disconnected](/azure/virtual-network/virtual-network-troubleshoot-peering-issues#the-peering-status-is-disconnected), delete the peering from both virtual networks, and then recreate it. If the status is **Connected**, see the troubleshooting guide: [The peering status is "Connected"](/azure/virtual-network/virtual-network-troubleshoot-peering-issues#the-peering-status-is-connected).

For further troubleshooting, connect to one of the AKS nodes or [pods](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec) and then test the connectivity with the container registry at the TCP level by using the telnet or netcat utility. Check the IP address with the `nslookup <acrname>.azurecr.io` command and then run the `telnet <ip-address-of-the-container-registry> 443` command.

For more information about connecting to AKS nodes, see [Connect with SSH to Azure Kubernetes Service (AKS) cluster nodes for maintenance or troubleshooting](/azure/aks/ssh).

### Solution 2: Use Azure Firewall

If the network interface of the container registry's private endpoint and the AKS cluster are in different virtual networks (in addition to virtual network peering), you can use Azure Firewall  to set up a [Hub-spoke network topology in Azure](/azure/architecture/reference-architectures/hybrid-networking/hub-spoke?tabs=cli). When you set up the firewall rule, you need to use network rules to explicitly allow the [outbound connection](/azure/firewall/rule-processing#outbound-connectivity) to the container registry private endpoint IP addresses.

## Cause 5: No match for platform in manifest

The host operating system (node OS) is incompatible with the image that's used for the pod or container. For example, if you schedule a pod to run a Linux container on a Windows node, or a Windows container on a Linux node, the following error occurs:

`Failed to pull image "\<acrname>.azurecr.io/\<repository:tag>"\:\
[\
&nbsp; rpc error:\
&nbsp; code = NotFound\
&nbsp; desc = failed to pull and unpack image "\<acrname>.azurecr.io/\<repository:tag>": **no match for platform in manifest**: not found,\
]`

This error occurs for an image that's pulled from any source if the image is incompatible with the host OS. The error isn't limited to images that are pulled from the container registry.

### Solution: Configure the nodeSelector field correctly in your pod or deployment

Specify the correct `nodeSelector` field in the configuration settings of your pod or deployment. The correct value for this field's `kubernetes.io/os` setting ensures that the pod will be scheduled on the correct type of node. The following table shows how to set the `kubernetes.io/os` setting in YAML:

| Container type | YAML setting |
| -------------- | ------------ |
| Linux container | `"kubernetes.io/os": linux` |
| Windows container | `"kubernetes.io/os": windows` |

For example, the following YAML code describes a pod that needs to be scheduled on a Linux node:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: aspnetapp
  labels:
    app: aspnetapp
spec:
  containers:
  - image: "mcr.microsoft.com/dotnet/core/samples:aspnetapp"
    name: aspnetapp-image
    ports:
    - containerPort: 80
      protocol: TCP
  nodeSelector:
    "kubernetes.io/os": linux
```

## Cause 6: Kubelet exceeds the default image pull rate limit

When multiple jobs pull the same images, the kubelet default pull rate limit can be exceeded. In this case, an error message like the following one is displayed:

`Failed to pull image "acrname.azurecr.io/repo/nginx:latest": pull QPS exceeded. This occurred for pod \<podname\> at 4/22/2025, 12:48:32.000 PM UTC.`

For more information about the limit, see the [registryPullQPS configuration](https://kubernetes.io/docs/reference/config-api/kubelet-config.v1beta1/#kubelet-config-k8s-io-v1beta1-KubeletConfiguration).

### Solution: Change the value of imagePullPolicy to IfNotPresent

To resolve this issue, change the value of [imagePullPolicy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy) from `Always` to `IfNotPresent` in the deployment YAML file to prevent unnecessary pulls. `IfNotPresent` ensures that the image is pulled from the registry only if it's not already present on the node.

Here's an example of the deployment YAML file:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-container
        image: myacr.azurecr.io/my-image:latest
        imagePullPolicy: IfNotPresent
```

## Cause 7: TLS handshake timeout error happens when pulling images from ACR

The following events and messages might occur when pulling images from ACR to AKS:

```text
 Type     Reason     Age                From               Message

 ----     ------     ----               ----               -------

 Normal   Scheduled  59s                default-scheduler  Successfully assigned api/testapi-worker-51235 to aks-api-573618vmss00000

 Normal   BackOff    39s                kubelet            Back-off pulling image "test.azurecr.io/test-api:v1.1.3"

 Warning  Failed     39s                kubelet            Error: ImagePullBackOff

 Normal   Pulling    25s (x2 over 59s)  kubelet            Pulling image "test.azurecr.io/test-api:v1.1.3"

 Warning  Failed     5s (x2 over 39s)   kubelet            Failed to pull image "test.azurecr.io/test-api:v1.1.3": failed to pull and unpack image "test.azurecr.io/test-api:v1.1.3": failed to resolve reference "test.azurecr.io/test-api:v1.1.3": failed to do request: Head "https://test.azurecr.io/v2/test-api/manifests/v1.1.3": net/http: TLS handshake timeout

 Warning  Failed     5s (x2 over 39s)   kubelet            Error: ErrImagePull
```

### Solution: Update Azure Virtual Network Appliance (NVAs) with validated routes
 
when you get this `net/http: TLS handshake` timeout, we recommend checking your network configuration, including firewall, proxy, and network connectivity settings. 

## Other considerations

If the troubleshooting guidance in this article doesn't help you resolve the issue, here are some other things to consider:

- Check the network security groups and route tables associated with subnets (if you have any of these items).

- If a virtual appliance like a firewall controls the traffic between subnets, check the firewall and [Firewall access rules](/azure/container-registry/container-registry-firewall-access-rules).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

 

[cause1-solution1]: #solution-1-make-sure-the-correct-acr-role-assignment-is-created-for-identity
[cause1-solution2]: #solution-2-make-sure-service-principal-isnt-expired
[cause1-solution3]: #solution-3-make-sure-the-correct-acr-role-is-assigned-to-correct-service-principal
[cause1-solution4]: #solution-4-make-sure-the-kubelet-identity-is-referenced-in-the-aks-virtual-machine-scale-sets
[cause1-solution5]: #solution-5-make-sure-the-service-principal-is-correct-and-the-secret-is-valid
[cause1-solution6]: #solution-6-make-sure-the-kubernetes-secret-has-the-correct-values-of-the-container-registry-admin-account
