---
title: Fix connection issues to an app that's hosted on an AKS cluster
description: Learn about basic troubleshooting steps if you experience connection issues to an application that's hosted on an Azure Kubernetes Service (AKS) cluster.
ms.date: 08/19/2022
ms.reviewer: chiragpa, pkc, rissing, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: cannot-connect-to-app-on-cluster
#Customer intent: As an Azure Kubernetes user, I want to take basic troubleshooting steps so that I can successfully connect to an application that's hosted on an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot connection issues to an app that's hosted on an AKS cluster

Connection issues to a Microsoft Azure Kubernetes Service (AKS) cluster can mean different things. In some cases, it might mean that the connection to the API server is affected (for example, by using kubectl). In other cases, it might mean that common connection issues affect an application that's hosted on the AKS cluster. This article discusses how to troubleshoot AKS cluster connection issues.

> [!NOTE]
> To troubleshoot common issues when you try to connect to the AKS API server, see [Basic troubleshooting of cluster connection issues with the API server](troubleshoot-cluster-connection-issues-api-server.md).

## Prerequisites

- The Client URL ([cURL](https://www.tecmint.com/install-curl-in-linux/)) tool, or a similar command-line tool.

- The [apt-get](https://linux.die.net/man/8/apt-get) command-line tool for handling packages.

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Factors to consider

This section covers troubleshooting steps to take if you're having issues when you try to connect to the application that's hosted on an AKS cluster.

In any networking scenario, administrators should consider the following important factors when troubleshooting:

- What's the source and the destination for a request?
- What are the hops in between the source and the destination?
- What's the request-response flow?
- Which hops have extra security layers on top, such as the following items:

  - Firewall
  - Network security group (NSG)
  - Network policy

When you check each component, [get and analyze HTTP response codes](get-and-analyze-http-response-codes.md). These codes are useful to identify the nature of the issue, and are especially helpful in scenarios in which the application responds to HTTP requests.

If other troubleshooting steps don't provide any conclusive outcome, take packet captures from the client and server. Packet captures are also useful when non-HTTP traffic is involved between the client and server. For more information about how to collect packet captures for AKS environment, see the following articles in the data collection guide:

- [Capture a TCP dump from a Linux node in an AKS cluster](capture-tcp-dump-linux-node-aks.md).

- [Capture a TCP dump from a Windows node in an AKS cluster](capture-tcp-dump-windows-node-aks.md).

- [Capture TCP packets from a pod on an AKS cluster](packet-capture-pod-level.md).

Knowing how to get the HTTP response codes and take packet captures makes it easier to troubleshoot a network connectivity issue.

## Basic network flow for applications on AKS

In general, the request flow for accessing applications that are hosted on an AKS cluster is as follows:

> Client >> DNS name >> AKS load balancer IP address >> AKS nodes >> Pods

There are other possible situations in which extra components might be involved. For example:

- The application gateway is used through the [Application Gateway Ingress Controller](/azure/application-gateway/ingress-controller-overview) (AGIC) instead of Azure Load Balancer.
- Azure Front Door and API Management might be used on top of the load balancer.
- The process uses an internal load balancer.
- The connection might not end at the pod and the requested URL. This could depend on whether the pod can connect to another entity, such as a database or any other service in the same cluster.

It's important to understand the request flow for the application.

A basic request flow to applications on an AKS cluster would resemble the flow that's shown in the following diagram.

:::image type="content" source="./media/connection-issues-application-hosted-aks-cluster/aks-cluster-app-request-flow.svg" lightbox="./media/connection-issues-application-hosted-aks-cluster/aks-cluster-app-request-flow.svg" alt-text="Diagram of a basic request flow to applications on an Azure Kubernetes Service (A K S) cluster." border="false":::

## Inside-out troubleshooting

Troubleshooting connectivity issues might involve many checks, but the *inside-out* approach can help find the source of the issue and identify the bottleneck. In this approach, you start at the pod itself, checking whether the application is responding on the pod's IP address. Then, check each component in turn up to the end client.

### Step 1: Check whether the pod is running and the app or container inside the pod is responding correctly

To determine whether the pod is running, run one of the following [kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) commands:

```bash
# List pods in the specified namespace.
kubectl get pods -n <namespace-name>

# List pods in all namespaces.
kubectl get pods -A
```

What if the pod isn't running? In this case, check the pod events by using the [kubectl describe](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#describe) command:

```bash
kubectl describe pod <pod-name> -n <namespace-name>
```

If the pod isn't in a `Ready` or `Running` state, or it restarted many times, check the `kubectl describe` output. The events will reveal any issues that prevent you from being able to start the pod. Or, if the pod has started, the application inside the pod might have failed, causing the pod to be restarted. [Troubleshoot the pod accordingly](https://github.com/feiskyer/kubernetes-handbook/blob/master/en/troubleshooting/pod.md) to make sure that it's in a suitable state.

If the pod is running, it can also be useful to check the logs of the pods and the containers that are inside them. Run the following series of [kubectl logs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs) commands:

```bash
kubectl logs <pod-name> -n <namespace-name>

# Check logs for an individual container in a multicontainer pod.
kubectl logs <pod-name> -n <namespace-name> -c <container-name>

# Dump pod logs (stdout) for a previous container instance.
kubectl logs <pod-name> --previous                      

# Dump pod container logs (stdout, multicontainer case) for a previous container instance.
kubectl logs <pod-name> -c <container-name> --previous      
```

Is the pod running? In this case, test the connectivity by starting a test pod in the cluster. From the test pod, you can directly access the application's pod IP address and check whether the application is responding correctly. Run the [kubectl run](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#run), `apt-get`, and `cURL` commands as follows:

```bash
# Start a test pod in the cluster:
kubectl run -it --rm aks-ssh --image=debian:stable

# After the test pod is running, you will gain access to the pod.
# Then you can run the following commands:
apt-get update -y && apt-get install dnsutils -y && apt-get install curl -y

# After the packages are installed, test the connectivity to the application pod:
curl -Iv http://<pod-ip-address>:<port>
```

For applications that listen on other protocols, you can install relevant tools inside the test pod and then check the connectivity to the application pod.

For more commands to troubleshoot pods, see [Debug running pods](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/).

### Step 2: Check whether the application is reachable from the service

For scenarios in which the application inside the pod is running, you can focus mainly on troubleshooting how the pod is exposed.

Is the pod exposed as a service? In this case, check the service events. Also, check whether the pod IP address and application port are available as an endpoint in the service description:

```bash
# Check the service details.
kubectl get svc -n <namespace-name>

# Describe the service.
kubectl describe svc <service-name> -n <namespace-name>
```

Check whether the pod's IP address is present as an endpoint in the service, as in the following example:

```console
$ kubectl get pods -o wide  # Check the pod's IP address.
NAME            READY   STATUS        RESTARTS   AGE   IP            NODE                                
my-pod          1/1     Running       0          12m   10.244.0.15   aks-agentpool-000000-vmss000000  

$ kubectl describe service my-cluster-ip-service  # Check the endpoints in the service.
Name:              my-cluster-ip-service
Namespace:         default
Selector:          app=my-pod
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.0.174.133
IPs:               10.0.174.133
Port:              <unset>  80/TCP
TargetPort:        80/TCP
Endpoints:         10.244.0.15:80     # <--- Here

$ kubectl get endpoints  # Check the endpoints directly for verification.
NAME                      ENDPOINTS           AGE
my-cluster-ip-service     10.244.0.15:80      14m
```

If the endpoints aren't pointing to the correct pod IP address, verify the `Labels` and `Selectors` for the pod and the service.

Are the endpoints in the service correct? If so, access the service, and check whether the application is reachable.

### Access the ClusterIP service

For the `ClusterIP` service, you can start a test pod in the cluster and access the service IP address:

:::image type="content" source="./media/connection-issues-application-hosted-aks-cluster/test-pod-access-cluster-ip-address.svg" lightbox="./media/connection-issues-application-hosted-aks-cluster/test-pod-access-cluster-ip-address.svg" alt-text="Diagram of using a test pod in an Azure Kubernetes Service (A K S) cluster to access the cluster I P address." border="false":::

```bash
# Start a test pod in the cluster:
kubectl run -it --rm aks-ssh --image=debian:stable
  
# After the test pod is running, you will gain access to the pod.
# Then, you can run the following commands:
apt-get update -y && apt-get install dnsutils -y && apt-get install curl -y
  
# After the packages are installed, test the connectivity to the service:
curl -Iv http://<service-ip-address>:<port>
```

If the previous command doesn't return an appropriate response, check the service events for any errors.

### Access the LoadBalancer service

For the `LoadBalancer` service, you can access the load balancer IP address from outside the cluster.

:::image type="content" source="./media/connection-issues-application-hosted-aks-cluster/access-load-balancer-ip-address-outside-cluster.svg" lightbox="./media/connection-issues-application-hosted-aks-cluster/access-load-balancer-ip-address-outside-cluster.svg" alt-text="Diagram of a test user accessing the load balancer I P address from outside an Azure Kubernetes Service (A K S) cluster." border="false":::

```bash
curl -Iv http://<service-ip-address>:<port>
```

Does the `LoadBalancer` service IP address return a correct response? If it doesn't, follow these steps:

1. Verify the events of the service.

1. Verify that the network security groups (NSGs) that are associated with the AKS nodes and AKS subnet allow the incoming traffic on the service port.

For more commands to troubleshoot services, see [Debug services](https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/).

## Scenarios that use an ingress instead of a service

For scenarios in which the application is exposed by using an `Ingress` resource, the traffic flow resembles the following progression:

> Client >> DNS name >> Load balancer or application gateway IP address >> Ingress pods inside the cluster >> Service or pods

:::image type="content" source="./media/connection-issues-application-hosted-aks-cluster/ingress-resource-app-traffic-flow.svg" lightbox="./media/connection-issues-application-hosted-aks-cluster/ingress-resource-app-traffic-flow.svg" alt-text="Diagram of the network traffic flow when an app inside an Azure Kubernetes Service (A K S) cluster is exposed by using an ingress resource." border="false":::

You can apply the inside-out approach of troubleshooting here, too. You can also check the ingress and ingress controller details for more information:

```console
$ kubectl get ing -n <namespace-of-ingress>  # Checking the ingress details and events.
NAME                         CLASS    HOSTS                ADDRESS       PORTS     AGE
hello-world-ingress          <none>   myapp.com            20.84.x.x     80, 443   7d22h

$ kubectl describe ing -n <namespace-of-ingress> hello-world-ingress
Name:             hello-world-ingress
Namespace:        <namespace-of-ingress>
Address:          20.84.x.x
Default backend:  default-http-backend:80 (<error: endpoints "default-http-backend" not found>)
TLS:
  tls-secret terminates myapp.com
Rules:
  Host                Path  Backends
  ----                ----  --------
  myapp.com
                      /blog   blog-service:80 (10.244.0.35:80)
                      /store  store-service:80 (10.244.0.33:80)

Annotations:          cert-manager.io/cluster-issuer: letsencrypt
                      kubernetes.io/ingress.class: nginx
                      nginx.ingress.kubernetes.io/rewrite-target: /$1
                      nginx.ingress.kubernetes.io/use-regex: true
Events:
  Type    Reason  Age    From                      Message
  ----    ------  ----   ----                      -------
  Normal  Sync    5m41s  nginx-ingress-controller  Scheduled for sync
  Normal  Sync    5m41s  nginx-ingress-controller  Scheduled for sync
```

This example contains an `Ingress` resource that:

- Listens on the `myapp.com` host.
- Has two `Path` strings configured.
- Routes to two `Services` in the back end.

Verify that the back-end services are running, and respond to the port that's mentioned in the ingress description:

```console
$ kubectl get svc -n <namespace-of-ingress>
NAMESPACE       NAME                                     TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                      
ingress-basic   blog-service                             ClusterIP      10.0.155.154   <none>        80/TCP                       
ingress-basic   store-service                            ClusterIP      10.0.61.185    <none>        80/TCP             
ingress-basic   nginx-ingress-ingress-nginx-controller   LoadBalancer   10.0.122.148   20.84.x.x     80:30217/TCP,443:32464/TCP   
```

Verify the logs for the ingress controller pods if there's an error:

```console
$ kubectl get pods -n <namespace-of-ingress>  # Get the ingress controller pods.
NAME                                                     READY   STATUS    RESTARTS   AGE
aks-helloworld-one-56c7b8d79d-6zktl                      1/1     Running   0          31h
aks-helloworld-two-58bbb47f58-rrcv7                      1/1     Running   0          31h
nginx-ingress-ingress-nginx-controller-9d8d5c57d-9vn8q   1/1     Running   0          31h
nginx-ingress-ingress-nginx-controller-9d8d5c57d-grzdr   1/1     Running   0          31h

$ # Check logs from the pods.
$ kubectl logs -n ingress-basic nginx-ingress-ingress-nginx-controller-9d8d5c57d-9vn8q
```

What if the client is making requests to the ingress host name or IP address, but no entries are seen in the logs of the ingress controller pod? In this case, the requests might not be reaching the cluster, and the user might be receiving a `Connection Timed Out` error message.

Another possibility is that the components on top of the ingress pods, such as Load Balancer or Application Gateway, aren't routing the requests to the cluster correctly. If this is true, you can check the back-end configuration of these resources.

If you receive a `Connection Timed Out` error message, check the network security group that's associated with the AKS nodes. Also, check the AKS subnet. It could be blocking the traffic from the load balancer or application gateway to the AKS nodes.

For more information about how to troubleshoot ingress (such as Nginx Ingress), see [ingress-nginx troubleshooting](https://github.com/kubernetes/ingress-nginx/blob/main/docs/troubleshooting.md).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
