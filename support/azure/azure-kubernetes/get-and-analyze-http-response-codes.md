---
title: Get and analyze HTTP response codes to determine app behavior
description: Learn how to get HTTP response codes using cURL or a browser to analyze the behavior of an app that's hosted on an Azure Kubernetes Service (AKS) cluster.
ms.date: 03/17/2022
ms.reviewer: chiragpa, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: cannot-connect-to-app-on-cluster
#Customer intent: As an Azure Kubernetes user, I want to get HTTP response codes by using the Client ULR (cURL) command or a browser so that I can analyze the behavior of an application that's hosted on an Azure Kubernetes Service (AKS) cluster.
---
# Get and analyze HTTP response codes

If an application responds to HTTP or HTTPS requests, you can check the HTTP response codes to determine the behavior of the application.

## Prerequisites

- The Client URL ([cURL](https://curl.se)) tool, or another similar command-line tool.

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool, or a similar tool to connect to the cluster. To install kubectl by using [Azure CLI](/cli/azure/install-azure-cli), run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Get HTTP response codes by using cURL

The [cURL](https://curl.se) command-line tool can send an HTTP request to an application endpoint and get the response. For a load balancer service (that responds on the path "/" on port 80), a curl request can be initiated by running the following command:

```bash
curl -Iv http://<load-balancer-service-ip-address>:80/
```

For example, you can use cURL together with the [kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) command, as follows:

```console
$ kubectl get service
NAME                      TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)        AGE
my-loadbalancer-service   LoadBalancer   10.0.81.95     20.62.x.x       80:32131/TCP   18h
  
$ curl -Iv http://20.62.x.x:80/
*   Trying 20.62.x.x:80...
* Connected to 20.62.x.x (20.62.x.x) port 80 (#0)
> HEAD / HTTP/1.1
> Host: 20.62.x.x
> User-Agent: curl/7.79.1
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
HTTP/1.1 200 OK
< ...
...
< Server: Apache/2.4.52 (Unix)
Server: Apache/2.4.52 (Unix)
< ...
...
<
* Connection #0 to host 20.62.x.x left intact
```

The response from this URI is `HTTP 200`.

## Get HTTP response codes by using a browser

You can also get the HTTP response of an HTTP endpoint from a browser. Follow these steps:

1. In a browser window, press Ctrl+Shift+I or F12. The developer tools window or pane appears.

1. Select the **Network** tab, and then access the endpoint. The details about the HTTP response appear in the developer tools window or pane.

To make API requests to the application and get details about the response, you can choose from many other command-line and GUI tools. These tools include the following.

| Tool | Link |
| ---- | ---- |
| Postman | [Postman API platform](https://www.postman.com/) |
| wget | [GNU Wget 1.21.1-dirty Manual](https://www.gnu.org/software/wget/manual/wget.html) |
| PowerShell | [Invoke-WebRequest cmdlet](/powershell/module/microsoft.powershell.utility/invoke-webrequest) |

After the response code becomes available, you should try to better understand the behavior of the issue. For more information about the HTTP status codes and the behavior that they indicate, see the following content.

| Information source | Link |
| ------------------ | ---- |
| Internet Assigned Numbers Authority (IANA) | [Hypertext Transfer Protocol (HTTP) status code registry](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml) |
| Mozilla | [HTTP response status codes](https://developer.mozilla.org/docs/Web/HTTP/Status) |
| Wikipedia | [List of HTTP status codes](https://wikipedia.org/wiki/List_of_HTTP_status_codes) |

The following HTTP status codes might indicate the listed issues.

| HTTP status code | Issue |
| ---------------- | ----- |
| `4xx` | <p>An issue affects the client request. For example, the requested page doesn't exist, or the client doesn't have permission to access the page.</p> <p>OR</p> <p>A network blocker exists between the client and the server. For example, traffic is being blocked by a network security group or a firewall.</p> |
| `5xx` | An issue affects the server. For example, the application is down, or a gateway isn't working. |

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
