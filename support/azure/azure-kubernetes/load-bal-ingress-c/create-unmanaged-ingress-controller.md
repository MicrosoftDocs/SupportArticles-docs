---
title: Create an AKS unmanaged ingress controller
description: Create and configure an unmanaged ingress controller in an AKS cluster to route multiple apps through one IP address. Follow the steps to get started.
ms.reviewer: allensu, v-rekhanain, jamielo, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Load balancer and Ingress controller
ms.topic: how-to
ms.date: 03/10/2025
---
# Create an unmanaged ingress controller

## Summary

An ingress controller is a piece of software that provides reverse proxy, configurable traffic routing, and TLS termination for Kubernetes services. Use Kubernetes ingress resources to configure the ingress rules and routes for individual Kubernetes services. When you use an ingress controller and ingress rules, you can use a single IP address to route traffic to multiple services in a Kubernetes cluster.

This article shows you how to deploy the [NGINX ingress controller](https://github.com/kubernetes/ingress-nginx) in an Azure Kubernetes Service (AKS) cluster. You then run two applications in the AKS cluster, and each application is accessible over the single IP address.

> [!IMPORTANT]
> For ingress in AKS, use the Application routing add-on. For more information, see [Managed nginx Ingress with the application routing add-on](/azure/aks/app-routing).

> [!NOTE]
> Two open source ingress controllers for Kubernetes are based on NGINX: one is maintained by the Kubernetes community ([kubernetes/ingress-nginx](https://github.com/kubernetes/ingress-nginx)), and one is maintained by NGINX, Inc. ([nginxinc/kubernetes-ingress](https://github.com/nginxinc/kubernetes-ingress)). This article uses the Kubernetes community ingress controller.

## Before you begin

- This article uses Helm 3 to install the NGINX ingress controller on a [supported version of Kubernetes](/azure/aks/supported-kubernetes-versions). Make sure that you're using the latest release of Helm and have access to the *ingress-nginx* Helm repository. The steps outlined in this article might not be compatible with previous versions of the Helm chart, NGINX ingress controller, or Kubernetes.
- This article assumes you have an existing AKS cluster with an integrated Azure Container Registry (ACR). For more information about creating an AKS cluster with an integrated ACR, see [Authenticate with Azure Container Registry from Azure Kubernetes Service](/azure/aks/cluster-container-registry-integration#create-a-new-acr).
- The Kubernetes API health endpoint, `healthz`, was deprecated in Kubernetes v1.16. You can replace this endpoint with the `livez` and `readyz` endpoints instead. See [Kubernetes API endpoints for health](https://kubernetes.io/docs/reference/using-api/health-checks/#api-endpoints-for-health) to determine which endpoint to use for your scenario.
- If you're using Azure CLI, this article requires that you're running the Azure CLI version 2.0.64 or later. Run `az --version` to find the version. If you need to install or upgrade, see [Install Azure CLI][azure-cli-install].
- If you're using Azure PowerShell, this article requires that you're running Azure PowerShell version 5.9.0 or later. Run `Get-InstalledModule -Name Az` to find the version. If you need to install or upgrade, see [Install Azure PowerShell](/powershell/azure/install-azure-powershell).

## Basic ingress controller configuration

To create a basic NGINX ingress controller without customizing the defaults, use Helm. The following configuration uses the default configuration for simplicity. You can add parameters for customizing the deployment, like `--set controller.replicaCount=3`.

> [!NOTE]
> To enable [client source IP preservation](/azure/aks/concepts-network-ingress#ingress-controllers) for requests to containers in your cluster, add `--set controller.service.externalTrafficPolicy=Local` to the Helm install command. The client source IP is stored in the request header under *X-Forwarded-For*. When you use an ingress controller with client source IP preservation enabled, TLS pass-through won't work.

### [Azure CLI](#tab/azure-cli)

```console
NAMESPACE=ingress-basic

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --create-namespace \
  --namespace $NAMESPACE \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz \
  --set controller.service.externalTrafficPolicy=Local
```

### [Azure PowerShell](#tab/azure-powershell)

```powershell-interactive
$Namespace = 'ingress-basic'

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install ingress-nginx ingress-nginx/ingress-nginx `
  --create-namespace `
  --namespace $Namespace `
  --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz `
  --set controller.service.externalTrafficPolicy=Local
```

---

> [!NOTE]
> In this tutorial, set `service.beta.kubernetes.io/azure-load-balancer-health-probe-request-path` to `/healthz`. This setting means that if the response code for requests to `/healthz` isn't `200`, the entire ingress controller stops. You can change the value to another URI to fit your scenario. You can't delete this part or unset the value, or the ingress controller stops.
> The `ingress-nginx` package used in this tutorial, which [Kubernetes official](https://github.com/kubernetes/ingress-nginx) provides, always returns a `200` response code for requests to `/healthz`. It's designed as a [default backend](https://kubernetes.github.io/ingress-nginx/user-guide/default-backend/) so users can quickly get started, unless an ingress rule overwrites it.

## Customized ingress controller configuration

As an alternative to the basic configuration presented in the previous section, the next set of steps shows how to deploy a customized ingress controller. You can use an internal static IP address or a dynamic public IP address.

### Import the images used by the Helm chart into your ACR

### [Azure CLI](#tab/azure-cli)

To control image versions, import them into your own Azure Container Registry. The [NGINX ingress controller Helm chart](https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx) relies on three container images. Use `az acr import` to import those images into your ACR.

```azurecli
REGISTRY_NAME=<REGISTRY_NAME>
SOURCE_REGISTRY=registry.k8s.io
CONTROLLER_IMAGE=ingress-nginx/controller
CONTROLLER_TAG=v1.8.1
PATCH_IMAGE=ingress-nginx/kube-webhook-certgen
PATCH_TAG=v20230407
DEFAULTBACKEND_IMAGE=defaultbackend-amd64
DEFAULTBACKEND_TAG=1.5

az acr import --name $REGISTRY_NAME --source $SOURCE_REGISTRY/$CONTROLLER_IMAGE:$CONTROLLER_TAG --image $CONTROLLER_IMAGE:$CONTROLLER_TAG
az acr import --name $REGISTRY_NAME --source $SOURCE_REGISTRY/$PATCH_IMAGE:$PATCH_TAG --image $PATCH_IMAGE:$PATCH_TAG
az acr import --name $REGISTRY_NAME --source $SOURCE_REGISTRY/$DEFAULTBACKEND_IMAGE:$DEFAULTBACKEND_TAG --image $DEFAULTBACKEND_IMAGE:$DEFAULTBACKEND_TAG
```

### [Azure PowerShell](#tab/azure-powershell)

To control image versions, import them into your own Azure Container Registry. The [NGINX ingress controller Helm chart](https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx) relies on three container images. Use `Import-AzContainerRegistryImage` to import those images into your ACR.

```azurepowershell-interactive
$RegistryName = "<REGISTRY_NAME>"
$ResourceGroup = (Get-AzContainerRegistry | Where-Object {$_.name -eq $RegistryName} ).ResourceGroupName
$SourceRegistry = "registry.k8s.io"
$ControllerImage = "ingress-nginx/controller"
$ControllerTag = "v1.8.1"
$PatchImage = "ingress-nginx/kube-webhook-certgen"
$PatchTag = "v20230407"
$DefaultBackendImage = "defaultbackend-amd64"
$DefaultBackendTag = "1.5"

Import-AzContainerRegistryImage -ResourceGroupName $ResourceGroup -RegistryName $RegistryName -SourceRegistryUri $SourceRegistry -SourceImage "${ControllerImage}:${ControllerTag}"
Import-AzContainerRegistryImage -ResourceGroupName $ResourceGroup -RegistryName $RegistryName -SourceRegistryUri $SourceRegistry -SourceImage "${PatchImage}:${PatchTag}"
Import-AzContainerRegistryImage -ResourceGroupName $ResourceGroup -RegistryName $RegistryName -SourceRegistryUri $SourceRegistry -SourceImage "${DefaultBackendImage}:${DefaultBackendTag}"
```
---

> [!NOTE]
> In addition to importing container images into your ACR, you can also import Helm charts into your ACR. For more information, see [Push and pull Helm charts to an Azure Container Registry](/azure/container-registry/container-registry-helm-repos).

### Create an ingress controller

To create the ingress controller, use Helm to install *ingress-nginx*. The ingress controller needs to be scheduled on a Linux node. Windows Server nodes shouldn't run the ingress controller. Specify a node selector by using the `--set nodeSelector` parameter to tell the Kubernetes scheduler to run the NGINX ingress controller on a Linux-based node.

For added redundancy, deploy two replicas of the NGINX ingress controllers by using the `--set controller.replicaCount` parameter. To fully benefit from running replicas of the ingress controller, make sure there's more than one node in your AKS cluster.

The following example creates a Kubernetes namespace for the ingress resources named *ingress-basic* and is intended to work within that namespace. Specify a namespace for your own environment as needed. If your AKS cluster isn't Kubernetes role-based access control enabled, add `--set rbac.create=false` to the Helm commands.

> [!NOTE]
> To enable [client source IP preservation](/azure/aks/concepts-network-ingress#ingress-controllers) for requests to containers in your cluster, add `--set controller.service.externalTrafficPolicy=Local` to the Helm install command. The client source IP is stored in the request header under *X-Forwarded-For*. When you use an ingress controller with client source IP preservation enabled, TLS pass-through won't work.

### [Azure CLI](#tab/azure-cli)

```console
# Add the ingress-nginx repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Set variable for ACR location to use for pulling images
ACR_LOGIN_SERVER=<REGISTRY_LOGIN_SERVER>

# Use Helm to deploy an NGINX ingress controller
helm install ingress-nginx ingress-nginx/ingress-nginx \
    --version 4.7.1 \
    --namespace ingress-basic \
    --create-namespace \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."kubernetes\.io/os"=linux \
    --set controller.image.registry=$ACR_LOGIN_SERVER \
    --set controller.image.image=$CONTROLLER_IMAGE \
    --set controller.image.tag=$CONTROLLER_TAG \
    --set controller.image.digest="" \
    --set controller.admissionWebhooks.patch.nodeSelector."kubernetes\.io/os"=linux \
    --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz \
    --set controller.service.externalTrafficPolicy=Local \
    --set controller.admissionWebhooks.patch.image.registry=$ACR_LOGIN_SERVER \
    --set controller.admissionWebhooks.patch.image.image=$PATCH_IMAGE \
    --set controller.admissionWebhooks.patch.image.tag=$PATCH_TAG \
    --set controller.admissionWebhooks.patch.image.digest="" \
    --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux \
    --set defaultBackend.image.registry=$ACR_LOGIN_SERVER \
    --set defaultBackend.image.image=$DEFAULTBACKEND_IMAGE \
    --set defaultBackend.image.tag=$DEFAULTBACKEND_TAG \
    --set defaultBackend.image.digest=""
```

### [Azure PowerShell](#tab/azure-powershell)

```azurepowershell-interactive
# Add the ingress-nginx repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Set variable for ACR location to use for pulling images
$AcrUrl = (Get-AzContainerRegistry -ResourceGroupName $ResourceGroup -Name $RegistryName).LoginServer

# Use Helm to deploy an NGINX ingress controller
helm install ingress-nginx ingress-nginx/ingress-nginx `
    --namespace ingress-basic `
    --create-namespace `
    --set controller.replicaCount=2 `
    --set controller.nodeSelector."kubernetes\.io/os"=linux `
    --set controller.image.registry=$AcrUrl `
    --set controller.image.image=$ControllerImage `
    --set controller.image.tag=$ControllerTag `
    --set controller.image.digest="" `
    --set controller.admissionWebhooks.patch.nodeSelector."kubernetes\.io/os"=linux `
    --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz `
    --set controller.service.externalTrafficPolicy=Local `
    --set controller.admissionWebhooks.patch.image.registry=$AcrUrl `
    --set controller.admissionWebhooks.patch.image.image=$PatchImage `
    --set controller.admissionWebhooks.patch.image.tag=$PatchTag `
    --set controller.admissionWebhooks.patch.image.digest="" `
    --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux `
    --set defaultBackend.image.registry=$AcrUrl `
    --set defaultBackend.image.image=$DefaultBackendImage `
    --set defaultBackend.image.tag=$DefaultBackendTag `
    --set defaultBackend.image.digest=""
```

---

### Create an ingress controller using an internal IP address

By default, an NGINX ingress controller uses a dynamic public IP address. However, you might want to use an internal, private network and IP address. This approach restricts access to your services to internal users, with no external access.

Use the `--set controller.service.loadBalancerIP` and `--set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-internal"=true` parameters to assign an internal IP address to your ingress controller. Provide your own internal IP address for the ingress controller. Make sure that this IP address isn't already in use within your virtual network. If you use an existing virtual network and subnet, you must configure your AKS cluster with the correct permissions to manage the virtual network and subnet. For more information, see [Use kubenet networking with your own IP address ranges in Azure Kubernetes Service (AKS)](/azure/aks/configure-kubenet) or [Configure Azure CNI networking in Azure Kubernetes Service (AKS)](/azure/aks/configure-azure-cni?tabs=configure-networking-portal).

### [Azure CLI](#tab/azure-cli)

```console
# Add the ingress-nginx repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Set variable for ACR location to use for pulling images
ACR_LOGIN_SERVER=<REGISTRY_LOGIN_SERVER>

# Use Helm to deploy an NGINX ingress controller
helm install ingress-nginx ingress-nginx/ingress-nginx \
    --version 4.7.1 \
    --namespace ingress-basic \
    --create-namespace \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."kubernetes\.io/os"=linux \
    --set controller.image.registry=$ACR_LOGIN_SERVER \
    --set controller.image.image=$CONTROLLER_IMAGE \
    --set controller.image.tag=$CONTROLLER_TAG \
    --set controller.image.digest="" \
    --set controller.admissionWebhooks.patch.nodeSelector."kubernetes\.io/os"=linux \
    --set controller.service.loadBalancerIP=10.224.0.42 \
    --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-internal"=true \
    --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz \
    --set controller.admissionWebhooks.patch.image.registry=$ACR_LOGIN_SERVER \
    --set controller.admissionWebhooks.patch.image.image=$PATCH_IMAGE \
    --set controller.admissionWebhooks.patch.image.tag=$PATCH_TAG \
    --set controller.admissionWebhooks.patch.image.digest="" \
    --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux \
    --set defaultBackend.image.registry=$ACR_LOGIN_SERVER \
    --set defaultBackend.image.image=$DEFAULTBACKEND_IMAGE \
    --set defaultBackend.image.tag=$DEFAULTBACKEND_TAG \
    --set defaultBackend.image.digest="" 
```

### [Azure PowerShell](#tab/azure-powershell)

```azurepowershell-interactive
# Add the ingress-nginx repository
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Set variable for ACR location to use for pulling images
$AcrUrl = (Get-AzContainerRegistry -ResourceGroupName $ResourceGroup -Name $RegistryName).LoginServer

# Use Helm to deploy an NGINX ingress controller
helm install ingress-nginx ingress-nginx/ingress-nginx `
    --namespace ingress-basic `
    --create-namespace `
    --set controller.replicaCount=2 `
    --set controller.nodeSelector."kubernetes\.io/os"=linux `
    --set controller.image.registry=$AcrUrl `
    --set controller.image.image=$ControllerImage `
    --set controller.image.tag=$ControllerTag `
    --set controller.image.digest="" `
    --set controller.admissionWebhooks.patch.nodeSelector."kubernetes\.io/os"=linux `
    --set controller.service.loadBalancerIP=10.224.0.42 `
    --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-internal"=true `
    --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz `
    --set controller.admissionWebhooks.patch.image.registry=$AcrUrl `
    --set controller.admissionWebhooks.patch.image.image=$PatchImage `
    --set controller.admissionWebhooks.patch.image.tag=$PatchTag `
    --set controller.admissionWebhooks.patch.image.digest="" `
    --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux `
    --set defaultBackend.image.registry=$AcrUrl `
    --set defaultBackend.image.image=$DefaultBackendImage `
    --set defaultBackend.image.tag=$DefaultBackendTag `
    --set defaultBackend.image.digest="" `
```

---

## Check the ingress load balancer service

Check the load balancer service by using `kubectl get services`.

```console
kubectl get services --namespace ingress-basic -o wide -w ingress-nginx-controller
```

When you create the Kubernetes load balancer service for the NGINX ingress controller, it assigns an IP address under *EXTERNAL-IP*, as shown in the following example output:

```console
NAME                       TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)                      AGE   SELECTOR
ingress-nginx-controller   LoadBalancer   10.0.65.205   EXTERNAL-IP     80:30957/TCP,443:32414/TCP   1m   app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
```

If you browse to the external IP address at this stage, you see a 404 page displayed. This response appears because you still need to set up the connection to the external IP, which is done in the next sections.

## Run demo applications for ingress testing

To see the ingress controller in action, run two demo applications in your AKS cluster. In this example, use `kubectl apply` to deploy two instances of a simple *Hello world* application.

1. Create an `aks-helloworld-one.yaml` file and copy in the following example YAML:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: aks-helloworld-one  
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: aks-helloworld-one
      template:
        metadata:
          labels:
            app: aks-helloworld-one
        spec:
          containers:
          - name: aks-helloworld-one
            image: mcr.microsoft.com/azuredocs/aks-helloworld:v1
            ports:
            - containerPort: 80
            env:
            - name: TITLE
              value: "Welcome to Azure Kubernetes Service (AKS)"
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: aks-helloworld-one  
    spec:
      type: ClusterIP
      ports:
      - port: 80
      selector:
        app: aks-helloworld-one
    ```

1. Create an `aks-helloworld-two.yaml` file and copy in the following example YAML:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: aks-helloworld-two  
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: aks-helloworld-two
      template:
        metadata:
          labels:
            app: aks-helloworld-two
        spec:
          containers:
          - name: aks-helloworld-two
            image: mcr.microsoft.com/azuredocs/aks-helloworld:v1
            ports:
            - containerPort: 80
            env:
            - name: TITLE
              value: "AKS Ingress Demo"
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: aks-helloworld-two  
    spec:
      type: ClusterIP
      ports:
      - port: 80
      selector:
        app: aks-helloworld-two
    ```

1. Run the two demo applications using `kubectl apply`:

    ```console
    kubectl apply -f aks-helloworld-one.yaml --namespace ingress-basic
    kubectl apply -f aks-helloworld-two.yaml --namespace ingress-basic
    ```

## Create ingress routing rules

Both applications are now running on your Kubernetes cluster. To route traffic to each application, create a Kubernetes ingress resource. The ingress resource configures the rules that route traffic to one of the two applications.

In the following example, traffic to *EXTERNAL_IP/hello-world-one* is routed to the service named `aks-helloworld-one`. Traffic to *EXTERNAL_IP/hello-world-two* is routed to the `aks-helloworld-two` service. Traffic to *EXTERNAL_IP/static* is routed to the service named `aks-helloworld-one` for static assets.

1. Create a file named `hello-world-ingress.yaml` and copy in the following example YAML:

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: hello-world-ingress
      annotations:
        nginx.ingress.kubernetes.io/ssl-redirect: "false"
        nginx.ingress.kubernetes.io/use-regex: "true"
        nginx.ingress.kubernetes.io/rewrite-target: /$2
    spec:
      ingressClassName: nginx
      rules:
      - http:
          paths:
          - path: /hello-world-one(/|$)(.*)
            pathType: Prefix
            backend:
              service:
                name: aks-helloworld-one
                port:
                  number: 80
          - path: /hello-world-two(/|$)(.*)
            pathType: Prefix
            backend:
              service:
                name: aks-helloworld-two
                port:
                  number: 80
          - path: /(.*)
            pathType: Prefix
            backend:
              service:
                name: aks-helloworld-one
                port:
                  number: 80
    ---
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: hello-world-ingress-static
      annotations:
        nginx.ingress.kubernetes.io/ssl-redirect: "false"
        nginx.ingress.kubernetes.io/rewrite-target: /static/$2
    spec:
      ingressClassName: nginx
      rules:
      - http:
          paths:
          - path: /static(/|$)(.*)
            pathType: Prefix
            backend:
              service:
                name: aks-helloworld-one
                port: 
                  number: 80
    ```

1. Create the ingress resource using the `kubectl apply` command.

    ```console
    kubectl apply -f hello-world-ingress.yaml --namespace ingress-basic
    ```

## Test ingress controller routing

To test the routes for the ingress controller, browse to the two applications. Open a web browser to the IP address of your NGINX ingress controller, such as *EXTERNAL_IP*. The first demo application appears in the web browser, as shown in the following example:

 :::image type="content" source="../media/create-unmanaged-ingress-controller/app-one.png" alt-text="Screenshot of the first demo app running behind the unmanaged ingress controller in AKS." lightbox="../media/create-unmanaged-ingress-controller/app-one.png"  border="false":::


Now add the */hello-world-two* path to the IP address, such as *EXTERNAL_IP/hello-world-two*. The second demo application with the custom title appears:

 :::image type="content" source="../media/create-unmanaged-ingress-controller/app-two.png" alt-text="Screenshot of the second demo app running behind the unmanaged ingress controller in AKS." lightbox="../media/create-unmanaged-ingress-controller/app-two.png"  border="false":::

### Test an internal IP address

1. Create a test pod and attach a terminal session to it.

    ```console
    kubectl run -it --rm aks-ingress-test --image=mcr.microsoft.com/dotnet/runtime-deps:6.0 --namespace ingress-basic
    ```

1. Install `curl` in the pod by using `apt-get`.

    ```console
    apt-get update && apt-get install -y curl
    ```

1. Access the address of your Kubernetes ingress controller by using `curl`, such as *http://10.224.0.42*. Provide your own internal IP address specified when you deployed the ingress controller.

    ```console
    curl -L http://10.224.0.42
    ```

    You didn't provide a path with the address, so the ingress controller defaults to the */* route. The first demo application is returned, as shown in the following condensed example output:

    ```console
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <link rel="stylesheet" type="text/css" href="/static/default.css">
        <title>Welcome to Azure Kubernetes Service (AKS)</title>
    [...]
    ```

1. Add the */hello-world-two* path to the address, such as *http://10.224.0.42/hello-world-two*.

    ```console
    curl -L -k http://10.224.0.42/hello-world-two
    ```

    The second demo application with the custom title is returned, as shown in the following condensed example output:

    ```console
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <link rel="stylesheet" type="text/css" href="/static/default.css">
        <title>AKS Ingress Demo</title>
    [...]
    ```

---

## Clean up resources

This article used Helm to install the ingress components and sample apps. When you deploy a Helm chart, you create many Kubernetes resources. These resources include pods, deployments, and services. To clean up these resources, you can either delete the entire sample namespace or delete the individual resources.

### Delete the sample namespace and all resources

To delete the entire sample namespace, use the `kubectl delete` command and specify your namespace name. This command deletes all the resources in the namespace.

```console
kubectl delete namespace ingress-basic
```

### Delete resources individually

Alternatively, you can delete the individual resources created for a more granular approach. 

1. List the Helm releases by using the `helm list` command.

    ```console
    helm list --namespace ingress-basic
    ```

    Look for charts named *ingress-nginx* and *aks-helloworld*, as shown in the following example output:

    ```console
    NAME                    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
    ingress-nginx           ingress-basic   1               2020-01-06 19:55:46.358275 -0600 CST    deployed        nginx-ingress-1.27.1    0.26.1  
    ```

1. Uninstall the releases by using the `helm uninstall` command.

    ```console
    helm uninstall ingress-nginx --namespace ingress-basic
    ```

1. Remove the two sample applications.

    ```console
    kubectl delete -f aks-helloworld-one.yaml --namespace ingress-basic
    kubectl delete -f aks-helloworld-two.yaml --namespace ingress-basic
    ```

1. Remove the ingress route that directed traffic to the sample apps.

    ```console
    kubectl delete -f hello-world-ingress.yaml
    ```

1. Delete the namespace by using the `kubectl delete` command and specifying your namespace name.

    ```console
    kubectl delete namespace ingress-basic
    ```

## Next steps

To configure TLS with your existing ingress components, see [Use TLS with an ingress controller](/previous-versions/azure/aks/ingress-tls).

To configure your AKS cluster to use application routing, see [Application routing add-on](/azure/aks/app-routing).

This article includes some external components to AKS. To learn more about these components, see the following project pages:

- [Helm CLI](/azure/aks/kubernetes-helm)
- [NGINX ingress controller](https://github.com/kubernetes/ingress-nginx)

 