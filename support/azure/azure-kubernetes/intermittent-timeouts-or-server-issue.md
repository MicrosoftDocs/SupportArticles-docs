---
title: Fix intermittent time-outs or server issues during app access
description: Troubleshoot intermittent time-outs or server issues that occur when you try to access an application that's hosted on an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/17/2022
ms.reviewer: chiragpa, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: cannot-connect-to-app-on-cluster
#Customer intent: As an Azure Kubernetes user, I want to fix intermittent time-outs or server issues so that I can successfully access an application that's hosted on an Azure Kubernetes Service (AKS) cluster.
---
# Intermittent time-outs or server issues when accessing the application on AKS

This article describes how to troubleshoot intermittent connectivity issues that affect your applications that are hosted on an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The Client URL ([cURL](https://www.tecmint.com/install-curl-in-linux/)) tool, or a similar command-line tool.

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Symptoms

When you run a cURL command, you occasionally receive a "Timed out" error message. The output might resemble the following text:

```console
$ # One connection is successful, which results in a HTTP 200 response.
$ curl -Iv http://20.62.x.x
*   Trying 20.62.x.x:80...
* Connected to 20.62.x.x (20.62.x.x) port 80 (#0)
...
...
< HTTP/1.1 200 OK
HTTP/1.1 200 OK

$ # Another connection is unsuccessful, because it gets timed out.
$ curl -Iv http://20.62.x.x
*   Trying 20.62.x.x:80...
* connect to 20.62.x.x port 80 failed: Timed out
* Failed to connect to 20.62.x.x port 80 after 21050 ms: Timed out
* Closing connection 0
curl: (28) Failed to connect to 20.62.x.x port 80 after 21050 ms: Timed out

$ # Then the next connection is again successful.
$ curl -Iv http://20.62.x.x
*   Trying 20.62.x.x:80...
* Connected to 20.62.x.x (20.62.x.x) port 80 (#0)
...
...
< HTTP/1.1 200 OK
HTTP/1.1 200 OK
```

## Cause

Intermittent time-outs suggest component performance issues, as opposed to networking problems.

In this scenario, it's important to check the usage and health of the components. You can use the *inside-out* technique to check the status of the pods. Run the [kubectl top](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#top) and [kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) commands, as follows:

```console
$ kubectl top pods  # Check the health of the pods and the nodes.
NAME                            CPU(cores)   MEMORY(bytes)
my-deployment-fc94b7f98-m9z2l   1m           32Mi

$ kubectl top nodes
NAME                                CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
aks-agentpool-42617579-vmss000000   120m         6%     2277Mi          49%

$ kubectl get pods  # Check the state of the pod.
NAME                            READY   STATUS    RESTARTS   AGE
my-deployment-fc94b7f98-m9z2l   2/2     Running   1          108s
```

The output shows that the current usage of the pods and nodes appears to be acceptable.

Although the pod is in the `Running` state, one restart occurs after the first 108 seconds of the pod running. This occurrence might indicate that some issues affect the pods or containers that run in the pod.

If the issue persists, the status of the pod changes after some time:

```console
$ kubectl get pods
NAME                            READY   STATUS             RESTARTS   AGE
my-deployment-fc94b7f98-m9z2l   1/2     CrashLoopBackOff   42         3h53m
```

This example shows that the `Ready` state is changed, and there are several restarts of the pod. One of the containers is in `CrashLoopBackOff` state.

This situation occurs because the container fails after starting, and then Kubernetes tries to restart the container to force it to start working. However, if the issue persists, the application continues to fail after it runs for some time. Kubernetes eventually changes the status to `CrashLoopBackOff`.

To check the logs for the pod, run the following [kubectl logs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs) commands:

```console
$ kubectl logs my-deployment-fc94b7f98-m9z2l
error: a container name must be specified for pod my-deployment-fc94b7f98-m9z2l, choose one of: [webserver my-app]

$ # Since the pod has more than one container, the name of the container has to be specified.
$ kubectl logs my-deployment-fc94b7f98-m9z2l -c webserver
[...] [mpm_event:notice] [pid 1:tid 140342576676160] AH00489: Apache/2.4.52 (Unix) configured -- resuming normal operations
[...] [core:notice] [pid 1:tid 140342576676160] AH00094: Command line: 'httpd -D FOREGROUND'
10.244.0.1 - - ... "GET / HTTP/1.1" 200 45
10.244.0.1 - - ... "GET /favicon.ico HTTP/1.1" 404 196
10.244.0.1 - - ... "-" 408 -
10.244.0.1 - - ... "HEAD / HTTP/1.1" 200 -
10.244.0.1 - - ... "HEAD / HTTP/1.1" 200 -
10.244.0.1 - - ... "HEAD / HTTP/1.1" 200 -
10.244.0.1 - - ... "HEAD / HTTP/1.1" 200 -
10.244.0.1 - - ... "HEAD / HTTP/1.1" 200 -
10.244.0.1 - - ... "HEAD / HTTP/1.1" 200 -
10.244.0.1 - - ... "HEAD / HTTP/1.1" 200 -
10.244.0.1 - - ... "HEAD / HTTP/1.1" 200 -
10.244.0.1 - - ... "HEAD / HTTP/1.1" 200 -
10.244.0.1 - - ... "POST /boaform/admin/formLogin HTTP/1.1" 404 196

$ # The webserver container is running fine. Check the logs for other container (my-app).
$ kubectl logs my-deployment-fc94b7f98-m9z2l -c my-app

$ # No logs observed. The container could be starting or be in a transition phase.
$ # So logs for the previous execution of this container can be checked using the --previous flag:
$ kubectl logs my-deployment-fc94b7f98-m9z2l -c my-app --previous
<Some Logs from the container>
..
..
Started increasing memory
```

Log entries were made the previous time that the container was run. The existence of these entries suggests that the application did start, but it closed because of some issues.

The next step is to check the events of the pod by running the [kubectl describe](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#describe) command:

```console
$ kubectl describe pod my-deployment-fc94b7f98-m9z2l
Name:         my-deployment-fc94b7f98-m9z2l
Namespace:    default
...
...
Labels:       app=my-pod
...
...
Containers:
  webserver:
 ...
 ...
  my-app:
    Container ID:   containerd://a46e5062d53039d0d812c57c76b740f8d1ffb222de35203575bf8e4d10d6b51e
    Image:          my-repo/my-image:latest
    Image ID:       docker.io/my-repo/my-image@sha256:edcc4bedc7b...
    State:          Running
      Started:      <Start Date>
    Last State:     Terminated
      Reason:       OOMKilled
      Exit Code:    137
    Ready:          True
    Restart Count:  44
    Limits:
      memory:  500Mi
    Requests:
      cpu:        250m
      memory:     500Mi
...
...
Events:
  Type     Reason   Age                     From     Message
  ----     ------   ----                    ----     -------
  Normal   Pulling  49m (x37 over 4h4m)     kubelet  Pulling image "my-repo/my-image:latest"
  Warning  BackOff  4m10s (x902 over 4h2m)  kubelet  Back-off restarting failed container
```

Observations:

- The exit code is 137. For more information about exit codes, see the [Docker run reference](https://docs.docker.com/engine/reference/run/#exit-status) and [Exit codes with special meanings](https://tldp.org/LDP/abs/html/exitcodes.html).

- The termination reason is `OOMKilled`.

- The memory limit specified for the container is 500 Mi.

You can tell from the events that the container is being killed because it's exceeding the memory limits. When the container memory limit is reached, the application becomes intermittently inaccessible, and the container is killed and restarted.

## Solution

You can remove the memory limit and monitor the application to determine how much memory it actually needs. After you learn the memory usage, you can update the memory limits on the container. If the memory usage continues to increase, determine whether there's a memory leak in the application.

For more information about how to plan resources for workloads in Azure Kubernetes Service, see [resource management best practices](/azure/aks/developer-best-practices-resource-management).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
