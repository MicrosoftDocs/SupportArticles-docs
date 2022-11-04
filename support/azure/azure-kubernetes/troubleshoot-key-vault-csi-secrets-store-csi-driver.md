---
title: Troubleshoot Azure Key Vault Provider for Secrets Store CSI Driver on Azure Kubernetes Service (AKS)
description: Troubleshoot and resolve common problems when you're using the Azure Key Vault Provider for Secrets Store CSI Driver on Azure Kubernetes Service (AKS).
author: DennisLee-DennisLee
ms.author: v-dele
editor: v-jsitser
ms.service: container-service
ms.date: 11/4/2022
ms.reviewer: nickoman
---

# Troubleshoot Azure Key Vault Provider for Secrets Store CSI Driver

This article discusses common issues that you might experience when you [use the Microsoft Azure Key Vault Provider for Secrets Store Container Storage Interface (CSI) Driver](/azure/aks/csi-secrets-store-driver) on Azure Kubernetes Service (AKS). The article provides troubleshooting tips for resolving these issues.

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- The client URL ([curl](/virtualization/community/team-blog/2017/20171219-tar-and-curl-come-to-windows)) tool.

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

You might see the following error entry in the logs or events:

> Warning  FailedMount  74s    kubelet            MountVolume.SetUp failed for volume "secrets-store-inline" : kubernetes.io/csi: mounter.SetupAt failed: rpc error: code = Unknown desc = failed to mount secrets store objects for pod default/test, err: rpc error: code = Unknown desc = failed to mount objects, **error: failed to get keyvault client: failed to get key vault token: nmi response failed with status code: 404**, err: \<nil>

This error occurs because a Node Managed Identity (NMI) component in *aad-pod-identity* returned an error for a token request.

### Solution 1: Check the NMI pod logs

For more information about the error and how to resolve it, check the NMI pod logs and refer to the [Azure Active Directory pod identity troubleshooting guide](https://azure.github.io/aad-pod-identity/docs/troubleshooting/).

> [!NOTE]
> Azure Active Directory (Azure AD) is abbreviated as *aad* in the *aad-pod-identity* string.

## Cause 2: "keyvault.BaseClient#GetSecret: Failure sending request: StatusCode=0" error

You might see the following error entry in the logs or events:

> E1029 17:37:42.461313       1 server.go:54] failed to process mount request, **error: keyvault.BaseClient#GetSecret: Failure sending request: StatusCode=0 -- Original Error: context deadline exceeded**

This error occurs because the provider pod can't access the key vault instance. Access might be prevented for any of the following reasons:

- A firewall rule is blocking egress traffic from the provider.

- Network policies that are configured in the AKS cluster are blocking egress traffic.

- The provider pods run on the host network. A failure might occur if a policy is blocking this traffic or there are network jitters on the node.

### Solution 2: Check network policies, allowlist, and node connection

To fix the issue, take the following actions:

- Put the provider pods on the allowlist.

- Check for policies that are configured to block traffic.

- Make sure that the node has connectivity to Azure AD and your key vault.

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

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
