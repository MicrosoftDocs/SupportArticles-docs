---
title: Troubleshoot connections to pods and services within an AKS cluster
description: Troubleshoot connections to pods and services in an AKS cluster to find internal traffic failures fast and restore app communication. Start now.
ms.date: 09/22/2026
manager: dcscontentpm
ms.topic: troubleshooting
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, rissing, v-leedennis, andraciobanu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot connections to pods and services so that I don't experience outbound connection issues from an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Connectivity
ai-usage: ai-assisted
---
# Troubleshoot connection issues to pods or services within an AKS cluster (internal traffic)

## Summary

This article helps you troubleshoot connections to pods and services for internal traffic within the same Azure Kubernetes Service (AKS) cluster. Use it to quickly identify and fix connectivity issues.

## Prerequisites

Ensure you meet these prerequisites by having the following items:

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

- The [apt-get](https://linux.die.net/man/8/apt-get) command-line tool for handling packages.

- The Client URL ([cURL](https://www.tecmint.com/install-curl-in-linux/)) tool, or a similar command-line tool.

- The [Netcat](https://linux.die.net/man/1/nc) (`nc`) command-line tool for TCP connections.

## Troubleshooting checklist

### Step 1: Set up the test pod and remote server port

Set up the test pod and ensure the remote server has the required port open. From within the source pod (or a test pod in the same namespace as the source pod), follow these steps:

1. Start a test pod in the cluster by running the [kubectl run](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#run) command.

   ```bash
   kubectl run -it --rm aks-ssh --namespace <namespace> --image=debian:stable
   ```

1. After you access the pod, run the following `apt-get` commands to install the DNS Utils, cURL, and Netcat packages.

   ```bash  
   apt-get update -y
   apt-get install dnsutils -y
   apt-get install curl -y
   apt-get install netcat-openbsd -y
   ```

1. After installing the packages, run the following cURL command to test connectivity to the IP address of the pod.

   ```bash
   curl -Iv http://<pod-ip-address>:<port>
   ```

1. Run the Netcat command to check whether the remote server opened the required port.

   ```bash
   nc -z -v <endpoint> <port>
   ```

### Step 2: View operational information about pods, containers, the Kubernetes services, and endpoints

Using kubectl and cURL at the command line, follow these steps to check that everything works as expected:

1. Verify that the destination pod is running.

   ```bash
   kubectl get pods -n <namespace-name>
   ```

   If the destination pod is working correctly, the pod status is shown as `Running`, and the pod is shown as `READY`.

   ```output
   NAME           READY   STATUS    RESTARTS   AGE
   my-other-pod   1/1     Running   0          44m
   my-pod         1/1     Running   0          44m
   ```

1. Search the pod logs for access errors.

   ```bash
   kubectl logs <pod-name> -n <namespace-name>
   ```

1. Search the pod logs for an individual container in a multicontainer pod.

   ```bash
   kubectl logs <pod-name> -n <namespace-name> -c <container-name>
   ```

1. If the application in the pod restarts repeatedly, view pod logs of a previous container instance to get the exit messages.

   ```bash
   kubectl logs <pod-name> --previous                      
   ```

   For the multicontainer case, use the following command:

   ```bash
   kubectl logs <pod-name> -c <container-name> --previous  
   ```

1. Check whether there are any network policies that might block the traffic.

   ```bash
   kubectl get networkpolicies -A
   ```

   You should see output that resembles the following table.

   ```output
   NAMESPACE     NAME                 POD-SELECTOR             AGE
   kube-system   konnectivity-agent   app=konnectivity-agent   4d1h
   ```

   If you see any other network policy that you created, check whether that policy is blocking access to or from the pods.

1. Check whether you can reach the application from the service IP address. First, show details about the service resource, such as the external IP address and port, by running the `kubectl get services` command.

   ```bash
   kubectl get services -n <namespace-name>
   ```

   ```output
   NAME         TYPE           CLUSTER-IP   EXTERNAL-IP      PORT(S)        AGE
   my-service   LoadBalancer   10.0.21.43   20.119.121.232   80:31773/TCP   28s
   ```

   Then, run cURL by using the service IP address and port to check whether you can reach the application.

   ```console
   curl -Iv http://20.119.121.232:80
   .
   .
   .
   < HTTP/1.1 200 OK
   HTTP/1.1 200 OK
   ```

1. Get more verbose information about the service.

   ```bash
   kubectl describe services <service-name> -n <namespace-name>
   ```

1. Check the pod's IP address.
  
   ```bash
   kubectl get pods -o wide  
   ```
  
   ```output
   NAME            READY   STATUS        RESTARTS   AGE   IP            NODE                                
   my-pod          1/1     Running       0          12m   10.244.0.15   aks-agentpool-000000-vmss000000  
   ```

1. Verify that the pod's IP address exists as an endpoint in the service.

   ```bash
   kubectl describe services my-cluster-ip-service
   ```

   ```output
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
   ```

1. Verify the endpoints directly.

   ```bash
   kubectl get endpoints
   ```

   ```output
   NAME                      ENDPOINTS           AGE
   my-cluster-ip-service     10.244.0.15:80      14m
   ```

1. If the connection to a service doesn't work, restart the `kube-proxy` and CoreDNS pods.

   ```bash
   kubectl delete pods -n kube-system -l component=kube-proxy
   kubectl delete pods -n kube-system -l k8s-app=kube-dns
   ```

1. Verify that the node isn't overused.

   ```bash
   kubectl top nodes
   ```

   > [!NOTE]
   > You can also use [Azure Monitor to get the usage data for the cluster](/azure/aks/monitor-aks).

   ## Before you begin

Verify that you have the following prerequisites:

- Access to the AKS cluster through `kubectl`.
- Permission to view pods, services, endpoint slices, events, and logs in the affected namespace.
- The source namespace and pod, destination service and port, and approximate failure time.
- The cluster network configuration, including the network plugin, network data plane, network policy, and outbound type.

Collect the cluster network profile.

```azurecli
az aks show \
  --resource-group <resource-group> \
  --name <cluster-name> \
  --query networkProfile \
  --output yaml
```

> [!NOTE]
> The applicable troubleshooting steps depend on the configured network data plane. Don't assume that every cluster uses the same service-routing implementation.


## Troubleshooting workflow

Follow these steps in order. Stop when you identify the first failing layer.

1. Confirm that the source and destination workloads are healthy.
1. Test the destination by service DNS name.
1. If name resolution fails, troubleshoot DNS.
1. If name resolution succeeds, test the service ClusterIP and port.
1. Validate the service selector and endpoint slices.
1. Test the destination pod IP directly.
1. Check network policies and the cluster network data plane.
1. Determine whether the issue is isolated to a node.
1. Use AKS diagnostics and network observability to inspect drops and flows.

## 1. Identify the affected path

Record all of the following information before changing the cluster. The following table summarizes the key items to collect.

| Item | Example |
|---|---|
| Source pod and namespace | `frontend-abc123` in `app` |
| Destination service and namespace | `orders` in `backend` |
| Destination port | `8080/TCP` |
| Expected service DNS name | `orders.backend.svc.cluster.local` |
| Service ClusterIP | Value from `kubectl get service` |
| Destination pod IPs | Values from endpoint slices |
| Scope | One pod, one node, one namespace, or cluster-wide |
| Symptom | DNS error, timeout, connection refused, or reset |

The error type narrows the investigation:

- **Name resolution error** - Start with DNS.
- **Connection refused** - Confirm that the application is listening on the expected target port and address.
- **Timeout** - Check endpoints, network policies, routes, node health, and the network data plane.
- **Intermittent failure** - Compare successful and failed destination endpoints and check whether affected pods share a node.

## 2. Create a temporary troubleshooting pod

Prefer a purpose-built troubleshooting image or an ephemeral debug container instead of installing packages interactively into a generic operating-system image. This reduces setup time and avoids changing the application container.

The following is an example of a temporary pod.

```bash
kubectl run network-debug \
  --rm -it \
  --restart=Never \
  --namespace <source-namespace> \
  --image=<approved-network-troubleshooting-image> \
  --command -- sh
```

If the problem occurs only from a specific application pod, use an ephemeral debug container when the cluster configuration and permissions allow it.

```bash
kubectl debug \
  --namespace <source-namespace> \
  -it pod/<source-pod> \
  --image=<approved-network-troubleshooting-image> \
  --target=<application-container>
```

> [!NOTE]
> Replace the placeholder image with an image approved for your environment. The image should contain only the troubleshooting tools required by your organization.

## 3. Test service discovery first

From the source pod or troubleshooting container, resolve the fully qualified service name.

```bash
nslookup <service>.<destination-namespace>.svc.cluster.local
```

Also verify the short forms that the application uses.

```bash
nslookup <service>
nslookup <service>.<destination-namespace>
```

If the fully qualified name resolves but a short name does not, inspect the pod's DNS search domains and `dnsPolicy`.

```bash
cat /etc/resolv.conf
kubectl get pod <source-pod> \
  --namespace <source-namespace> \
  -o jsonpath='{.spec.dnsPolicy}{"\n"}'
```

If name resolution fails, do not continue with application-layer troubleshooting until DNS is validated. Review CoreDNS health, configuration, logs, and upstream resolution by using the dedicated AKS DNS troubleshooting guidance.

## 4. Test the internal service endpoint

Get the service type, ClusterIP, ports, selector, and traffic policies.

```bash
kubectl get service <service> \
  --namespace <destination-namespace> \
  -o wide

kubectl describe service <service> \
  --namespace <destination-namespace>
```

Test the service DNS name and the ClusterIP from inside the cluster.

```bash
curl -v --connect-timeout 5 \
  http://<service>.<destination-namespace>.svc.cluster.local:<service-port>/

curl -v --connect-timeout 5 \
  http://<cluster-ip>:<service-port>/
```

For non-HTTP workloads, use a protocol-appropriate client. For a basic TCP reachability check.

```bash
nc -vz -w 5 <cluster-ip> <service-port>
```

> [!IMPORTANT]
> For an internal-connectivity investigation, test the service DNS name and ClusterIP before testing a load balancer IP. A load balancer IP exercises a different path and belongs in ingress or load balancer troubleshooting.

Interpret the results using the following list:

- DNS name fails but ClusterIP succeeds: Investigate DNS.
- DNS name and ClusterIP fail but a pod IP succeeds: Investigate service configuration or the service-routing data plane.
- ClusterIP and pod IP both fail: Investigate the destination workload, network policy, node, route, or data plane.
- Only one endpoint fails: Investigate the destination pod and the node that hosts it.

## 5. Validate selectors and endpoint slices

Make sure the service selector matches the pods you want.

```bash
kubectl get service <service> \
  --namespace <destination-namespace> \
  -o jsonpath='{.spec.selector}{"\n"}'

kubectl get pods \
  --namespace <destination-namespace> \
  --show-labels
```

Check the endpoint slices.

```bash
kubectl get endpointslice \
  --namespace <destination-namespace> \
  --selector kubernetes.io/service-name=<service> \
  -o wide
```

If there are no ready endpoints, follow these steps:

1. Confirm that the service selector matches the pod labels.
1. Make sure the destination pods are running and ready.
1. Check for readiness probe failures and recent events.
1. Make sure `targetPort` matches the port where the application listens.

```bash
kubectl get pods \
  --namespace <destination-namespace> \
  -o wide

kubectl describe pod <destination-pod> \
  --namespace <destination-namespace>

kubectl get events \
  --namespace <destination-namespace> \
  --sort-by=.lastTimestamp
```

## 6. Test a destination pod directly

Use an address from the endpoint slice and test the target port directly.

```bash
curl -v --connect-timeout 5 http://<pod-ip>:<target-port>/
```

From the destination pod, check that the application is listening on the expected port and not only on the loopback interface.

```bash
kubectl exec \
  --namespace <destination-namespace> \
  <destination-pod> \
  -- ss -lntp
```

If this command isn't available in the application image, use an ephemeral debug container rather than modifying the running container.

## 7. Check network policies

List policies in both source and destination namespaces.

```bash
kubectl get networkpolicy \
  --namespace <source-namespace>

kubectl get networkpolicy \
  --namespace <destination-namespace>
```

Review policies that select either workload.

```bash
kubectl describe networkpolicy <policy-name> \
  --namespace <namespace>
```

Use the following list to validate both directions:

- Source egress permits the destination namespace, pod labels, IP range, protocol, and port.
- Destination ingress permits the source namespace, pod labels, IP range, protocol, and port.
- DNS egress is permitted when an egress policy isolates the source pod.

Don't delete a production network policy as a diagnostic shortcut. Reproduce the issue in a controlled environment or apply a narrowly scoped temporary rule through your normal change-management process.

## 8. Use data-plane-specific checks

First identify the configured network data plane from the AKS network profile. Then follow the matching AKS troubleshooting guidance.

### Azure CNI Powered by Cilium

For clusters that use Azure CNI Powered by Cilium, follow these steps:

- Validate the health of the Cilium-managed networking components.
- Use supported Cilium and AKS observability tooling to inspect flows, policy verdicts, and packet drops.
- Don't rely only on `kube-proxy` checks, because those checks might not represent the active service-routing data plane.

### Other supported AKS network configurations

For clusters that don't use the Cilium data plane, follow these steps:

- Validate the components that the network configuration uses for service routing and policy enforcement.
- Check component health and logs only through the support procedures documented for the cluster's AKS version and network profile.

> [!CAUTION]
> Avoid restarting system networking components until evidence identifies the affected component. A restart can remove transient evidence and affect additional workloads.

## 9. Determine whether the issue is node-specific

Compare the nodes that host the source and destination pods.

```bash
kubectl get pod <source-pod> \
  --namespace <source-namespace> \
  -o wide

kubectl get pod <destination-pod> \
  --namespace <destination-namespace> \
  -o wide
```

Review node conditions, pressure, and recent events.

```bash
kubectl describe node <node-name>
kubectl top node <node-name>
kubectl get events --all-namespaces --sort-by=.lastTimestamp
```

If failures consistently follow a node, preserve the relevant timestamps, pod placement, node conditions, and network evidence before remediation.

## 10. Use AKS diagnostics and network observability

Before you make disruptive changes, use the AKS **Diagnose and solve problems** experience to check for known cluster, node, and networking conditions.

If Advanced Container Networking Services and network observability are enabled for the cluster, use the available flow and packet-drop signals to answer these questions:

- Did traffic leave the source pod?
- Did policy deny the traffic?
- Did traffic reach the destination node and pod?
- Were packets dropped, and where was the drop observed?
- Is the failure limited to a destination endpoint or node?

Correlate your observations with the recorded failure time, source and destination identities, protocol, and port.

> [!NOTE]
> If you didn't enable network observability, preserve the non-disruptive evidence you collected in the earlier steps and follow your standard support or escalation process.

## Escalation data to collect

Collect the following information before escalation. Remove secrets, tokens, and customer data before sharing the bundle:

- AKS resource ID, region, Kubernetes version, and network profile.
- Failure time with time zone and whether the issue is continuous or intermittent.
- Source pod, namespace, IP, and node.
- Destination service, namespace, ClusterIP, port, endpoint slices, pod IPs, and nodes.
- Exact client error and a successful comparison test, if available.
- Relevant pod, CoreDNS, network-component, and application logs for the same time window.
- Applicable network policies.
- AKS diagnostic results and network observability evidence.
- Recent cluster, node-pool, networking, policy, or application changes.

## Proposed related-content links

Add or update the article's related-content section with the current Microsoft Learn pages for the following items:

- Troubleshoot DNS resolution problems in AKS.
- DNS in Azure Kubernetes Service.
- Configure Azure CNI Powered by Cilium in AKS.
- Diagnose and resolve AKS network issues with Advanced Container Networking Services.
- Monitor Azure Kubernetes Service.
- Connect to Azure Kubernetes Service cluster nodes for maintenance or troubleshooting.

## Editorial notes for the article owner

Follow these editorial notes when updating the article:

1. Replace the external load balancer IP example in the internal-traffic workflow with service DNS and ClusterIP examples. Move external or internal load balancer validation to a clearly labeled cross-link.
1. Replace the Debian `apt-get` setup as the primary workflow with a purpose-built troubleshooting image or `kubectl debug`. Keep package installation only as a fallback if required.
1. Add a DNS decision branch immediately after the first service-name test.
1. Add endpoint-slice commands and explain how to distinguish service-routing issues from destination-pod issues.
1. Add an explicit network-data-plane decision point, including Azure CNI Powered by Cilium.
1. Add AKS Diagnose and solve problems and Advanced Container Networking Services network observability before disruptive remediation.
1. Add a compact escalation checklist so that customers preserve actionable evidence.
1. Validate all example commands against the versions supported when the change is published, and replace placeholder links and image names with approved values.

## Suggested validation checklist

Use this checklist to validate the article updates:

- [ ] Commands tested on a supported AKS cluster that uses Azure CNI Powered by Cilium.
- [ ] Commands tested on another currently supported AKS network configuration.
- [ ] Service DNS, ClusterIP, endpoint slice, and pod-IP branches produce distinct, actionable outcomes.
- [ ] Network policy guidance reviewed by the AKS networking team.
- [ ] Debug image reviewed for security and supportability.
- [ ] All Microsoft Learn links resolve to current pages.
- [ ] No instruction requires modifying a production application container.
- [ ] No disruptive remediation is suggested before evidence collection.