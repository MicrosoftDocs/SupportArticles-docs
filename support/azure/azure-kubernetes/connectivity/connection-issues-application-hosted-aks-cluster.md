---
title: Troubleshoot app connection issues in an AKS cluster
description: Troubleshoot app connection issues in an AKS cluster with basic steps to identify causes and restore connectivity. Start resolving issues now.
ms.date: 07/31/2026
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, pkc, rissing, ookour, v-leedennis, v-weizhu, dandshi
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to take basic troubleshooting steps so that I can successfully connect to an application that's hosted on an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Connectivity
---
# Troubleshoot app connection issues in an AKS cluster

## Summary

If you experience app connection problems in an AKS cluster, this article helps you troubleshoot and resolve them. You learn basic checks for application, service, ingress, and network configuration so you can restore connectivity faster.

> [!NOTE]
> To troubleshoot common problems when you try to connect to the AKS API server, see [Basic troubleshooting of cluster connection problems with the API server](troubleshoot-cluster-connection-issues-api-server.md).

## Prerequisites

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Factors to consider

This section covers troubleshooting steps to take if you're having problems connecting to the application that's hosted in an AKS cluster.

In any networking scenario, consider the following important factors when troubleshooting:

- What's the source and the destination for a request?
- What are the hops between the source and the destination?
- What's the request-response flow?
- Which hops have extra security layers on top, such as the following items:

  - Firewall
  - Network security group (NSG)
  - Kubernetes network policy

When you check each component, [get and analyze HTTP response codes](../connectivity/get-and-analyze-http-response-codes.md). These codes are useful to identify the nature of the problem, and are especially helpful in scenarios in which the application responds to HTTP requests.

> [!NOTE]
> The examples in this article use HTTP-based tools (such as `cURL`) and HTTP response codes because HTTP is the most common case. The same *inside-out* methodology applies to applications that use other protocols (for example, databases, gRPC, or other TCP/UDP-based services). For those applications, use protocol-specific clients whenever possible&mdash;`curl -v` still reports whether the underlying TCP connection succeeds at each hop&mdash;and rely more on packet captures, because HTTP response codes aren't available.

If other troubleshooting steps don't provide any conclusive outcome, take packet captures from the client and server. Packet captures are also useful when non-HTTP traffic is involved between the client and server. For more information about how to collect packet captures for an AKS environment, see the following articles in the data collection guide:

- [Capture a TCP dump from a Linux node in an AKS cluster](../logs/capture-tcp-dump-linux-node-aks.md).

- [Capture a TCP dump from a Windows node in an AKS cluster](../logs/capture-tcp-dump-windows-node-aks.md).

- [Capture TCP packets from a pod on an AKS cluster](../logs/packet-capture-pod-level.md).

Knowing how to get the HTTP response codes and take packet captures makes it easier to troubleshoot a network connectivity problem.

## Basic network flow for applications on AKS

In general, when you expose applications by using the Azure Load Balancer service type, the request flow to access them is as follows:

> Client >> DNS name >> AKS load balancer IP address >> AKS nodes >> Pods

Other situations might involve extra components. For example:

- You enable the managed NGINX ingress with the [application routing add-on](/azure/aks/app-routing) feature.
- You use the [Application Gateway Ingress Controller](/azure/application-gateway/ingress-controller-overview) (AGIC) instead of Azure Load Balancer.
- You use Azure Front Door and API Management on top of the load balancer.
- The process uses an internal load balancer.
- The connection might not end at the pod and the requested URL. This condition could depend on whether the pod can connect to another entity, such as a database or any other service in the same cluster.

It's important to understand the request flow for the application.

A basic request flow to applications in an AKS cluster resembles the flow that's shown in the following diagram.

:::image type="content" source="./media/connection-issues-application-hosted-aks-cluster/aks-cluster-app-request-flow.svg" alt-text="Screenshot of the basic request flow for app connection issues in an AKS cluster: client, DNS, load balancer IP, AKS nodes, and pods." lightbox="./media/connection-issues-application-hosted-aks-cluster/aks-cluster-app-request-flow.svg":::

## Quickly isolate the issue

Before troubleshooting inside the cluster, run a quick test to determine whether the problem is inside AKS or in the network outside it.

Use `curl` (or an equivalent command-line tool) for this test, for two reasons:

- It keeps the tooling consistent across the whole troubleshooting flow, which relies on `curl` at each hop.
- Its increased verbosity (`curl -v`) can reveal details about the nature of the problem itself, such as whether the failure is at the TCP connection level or the application level.

From outside the cluster, send a `curl` request to the `LoadBalancer` service IP address of the affected application:

```bash
curl -v -m 5 http://<service-ip-address>:<port>
```

If you can access the load balancer IP address, the application inside the cluster is serving traffic, so the issue is most likely in the network *outside* AKS (for example, client-side DNS that resolves the host name to a stale or incorrect public IP address, or a firewall on the client path). If you can't access the load balancer IP address, continue with the inside-out troubleshooting steps to find the failing hop inside the cluster.

## Inside-out troubleshooting

Troubleshooting connectivity issues might involve many checks, but the *inside-out* approach can help you find the source of the issue and identify the bottleneck. In this approach, you start at the pod itself, checking whether the application is responding on the pod's IP address. Then, check each component in turn up to the end client.

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

If the pod isn't in a `Ready` or `Running` state, or it restarted many times, check the `kubectl describe` output. The events reveal any issues that prevent you from starting the pod. Or, if the pod starts, the application inside the pod might fail, causing the pod to restart. [Troubleshoot the pod accordingly](https://github.com/feiskyer/kubernetes-handbook/blob/master/en/troubleshooting/pod.md) to make sure that it's in a suitable state.

If the pod is running, it can also be useful to check the logs of the containers that are inside the pod. Run the following series of [kubectl logs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs) commands:

```bash
kubectl logs <pod-name> -n <namespace-name>

# Check logs for an individual container in a multicontainer pod.
kubectl logs <pod-name> -n <namespace-name> -c <container-name>

# Dump pod logs (stdout) for a previous container instance.
kubectl logs <pod-name> --previous                      

# Dump pod container logs (stdout, multicontainer case) for a previous container instance.
kubectl logs <pod-name> -c <container-name> --previous      
```

Is the pod running? In this case, test the connectivity by starting a test pod in the cluster. From the test pod, you can directly access the application's pod IP address and check whether the application is responding correctly. Use a test image that already includes `cURL` and DNS tools so that you don't have to install extra packages. Run the [kubectl run](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#run) and `cURL` commands as follows:

```bash
# Start a test pod that already includes curl and DNS tools (no package install needed):
kubectl run -it --rm aks-ssh --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11

# After the test pod is running, you will gain access to the pod.
# Then test the connectivity to the application pod:
curl -v -m 5 http://<pod-ip-address>:<port>
```

The verbose (`-v`) output reports the result of the TCP connection before any application-layer exchange. A `Connected to <pod-ip-address> port <port>` line confirms that the TCP connection succeeded, so the application is reachable at the network level. A `Connection refused` or `Connection timed out` message instead points to a network or TCP-level problem. Because `curl -v` already reports the TCP result, the same command also covers applications that use other TCP-based protocols - a separate `netcat` test isn't required.

For more commands to troubleshoot pods, see [Debug running pods](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/).

If the test pod can't reach the application pod's IP address, common causes include:

- **The application isn't listening correctly.** It's bound to `localhost` (`127.0.0.1`) instead of `0.0.0.0`, or it's using a different port. Confirm the listening address and port inside the container.
- **The pod isn't healthy.** A failing readiness or liveness probe, a `CrashLoopBackOff` state, or an `OOMKilled` event can interrupt the application. Recheck the `kubectl describe pod` output and the container logs.
- **A Kubernetes network policy is blocking the traffic.** Check whether a `NetworkPolicy` denies ingress to the destination pod or egress from the source pod.
- **Cross-node routing is broken (kubenet clusters).** Pods on different nodes can't connect if the [route table](/azure/aks/configure-kubenet) is missing routes, has incorrect routes, or isn't associated with the node subnet. Pods on the *same* node still work, so compare same-node against cross-node connectivity to isolate this cause.
- **An NSG or user-defined route (UDR) is blocking or redirecting the traffic.** Verify that the NSGs on the node subnet allow traffic between nodes and the pod CIDR, and that a custom UDR (such as forced tunneling to a firewall) isn't dropping or misrouting it.

### Step 2: Access the ClusterIP service

For scenarios in which the application inside the pod is running, focus mainly on troubleshooting how the pod is exposed.

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

For the `ClusterIP` service, you can start a test pod in the cluster and access the service IP address:

:::image type="content" source="./media/connection-issues-application-hosted-aks-cluster/test-pod-access-cluster-ip-address.svg" alt-text="Screenshot of a test pod in an AKS cluster accessing a ClusterIP service to validate app connectivity from inside the cluster." lightbox="./media/connection-issues-application-hosted-aks-cluster/test-pod-access-cluster-ip-address.svg":::

```bash
# Start a test pod that already includes curl and DNS tools (no package install needed):
kubectl run -it --rm aks-ssh --image=mcr.microsoft.com/aks/fundamental/base-ubuntu:v0.0.11

# After the test pod is running, you will gain access to the pod.
# Then test the connectivity to the service:
curl -v -m 5 http://<service-ip-address>:<port>
```

As with the pod check, the verbose (`-v`) output shows whether the TCP connection to the service succeeded (`Connected to <service-ip-address> port <port>`) or failed (`Connection refused` or `Connection timed out`), so the same command also covers services that use other TCP-based protocols.

If the previous command doesn't return an appropriate response, check the service events for any errors.

If the pod is reachable by its IP address but not through the service, common causes include:

- **The service has no endpoints.** The service `Selector` doesn't match the pod `Labels`, so no pods back the service. Confirm the endpoints as shown earlier in this section.
- **A port mismatch.** The service `targetPort` doesn't match the container's listening port, or the wrong `protocol` (TCP or UDP) is configured.
- **Unhealthy backends are excluded.** Pods that fail their readiness probe are removed from the service endpoints. Verify that the backing pods are `Ready`.
- **A Kubernetes network policy is blocking traffic** to the backend pods.
- **`kube-proxy` isn't programming the service rules.** For example, the `kube-proxy` pods aren't running, or the node's connection-tracking (`conntrack`) table is full.

### Step 3: Identify external to Kubernetes networking gap

For the `LoadBalancer` service, you can access the load balancer IP address from outside the cluster.

:::image type="content" source="./media/connection-issues-application-hosted-aks-cluster/access-load-balancer-ip-address-outside-cluster.svg" alt-text="Screenshot of external client access to a LoadBalancer IP for troubleshooting app connection issues in an AKS cluster." lightbox="./media/connection-issues-application-hosted-aks-cluster/access-load-balancer-ip-address-outside-cluster.svg":::

```bash
curl -v -m 5 http://<service-ip-address>:<port>
```

The verbose (`-v`) output shows whether the TCP connection to the load balancer succeeded or failed, so this command also works for services that use other TCP-based protocols.

Does the `LoadBalancer` service IP address return a correct response? If it doesn't, follow these steps:

1. Verify the events of the service.

1. Verify that the network security groups (NSGs) that are associated with the AKS nodes and AKS subnet allow the incoming traffic on the service port.

For more commands to troubleshoot services, see [Debug services](https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/).

If the `LoadBalancer` service IP address doesn't return a correct response, common causes include:

- **An NSG is blocking inbound traffic.** The NSG that's associated with the AKS node subnet must allow the service port from the load balancer or the client.
- **Load balancer health probes are failing,** so the backend nodes are marked unhealthy and traffic isn't forwarded. For more information, see [Troubleshoot health probe failures in Azure Load Balancer](/troubleshoot/azure/load-balancer/troubleshoot-load-balancer-health-probe-failures) and [Troubleshoot issues when enabling the AKS cluster service health probe mode](/troubleshoot/azure/azure-kubernetes/availability-performance/cluster-service-health-probe-mode-issues).
- **A user-defined route (UDR) breaks the return path.** Forced tunneling (a `0.0.0.0/0` route to a firewall or network virtual appliance) can cause asymmetric routing that resets or times out external connections. To mitigate this, route the inbound traffic through the same appliance so that the path is symmetric&mdash;for example, add a destination network address translation (DNAT) rule on the firewall or appliance that translates its public IP address to the load balancer's frontend IP address, or expose the application through an internal load balancer that's placed behind the appliance. For more information, see [Limit network traffic with Azure Firewall in AKS](/azure/aks/limit-egress-traffic).

## Scenarios that use an ingress instead of a service

For scenarios in which you expose the application by using an `Ingress` resource, the traffic flow follows this progression:

> Client >> DNS name >> Load balancer or application gateway IP address >> Ingress controller pods inside the cluster >> Service or pods

:::image type="content" source="./media/connection-issues-application-hosted-aks-cluster/ingress-resource-app-traffic-flow.svg" alt-text="Screenshot of ingress traffic flow in an AKS cluster from client and DNS to load balancer, ingress controller, and backend services." lightbox="./media/connection-issues-application-hosted-aks-cluster/ingress-resource-app-traffic-flow.svg":::

You can apply the inside-out approach of troubleshooting here, too. You can also check the ingress Kubernetes resource and ingress controller details for more information:

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

Verify that the back-end services are running and respond to the port that's mentioned in the ingress description:

```console
$ kubectl get svc -n <namespace-of-ingress>
NAMESPACE       NAME                                     TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                      
ingress-basic   blog-service                             ClusterIP      10.0.155.154   <none>        80/TCP                       
ingress-basic   store-service                            ClusterIP      10.0.61.185    <none>        80/TCP             
ingress-basic   nginx-ingress-ingress-nginx-controller   LoadBalancer   10.0.122.148   20.84.x.x     80:30217/TCP,443:32464/TCP   
```

Check the logs for the ingress controller pods if there's an error:

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

What if the client makes requests to the ingress host name or IP address, but you don't see any entries in the logs of the ingress controller pod? In this case, the requests might not reach the cluster, and the user might receive a `Connection Timed Out` error message.

Another possibility is that the components on top of the ingress pods, such as Load Balancer or Application Gateway, aren't routing the requests to the cluster correctly. If this condition is true, you can check the back-end configuration of these resources.

If you receive a `Connection Timed Out` error message, check the network security group that's associated with the AKS nodes. Also, check the AKS subnet. It could be blocking the traffic from the load balancer or application gateway to the AKS nodes.

For more information about how to troubleshoot ingress (such as Nginx Ingress), see [ingress-nginx troubleshooting](https://github.com/kubernetes/ingress-nginx/blob/main/docs/troubleshooting.md).

 

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
