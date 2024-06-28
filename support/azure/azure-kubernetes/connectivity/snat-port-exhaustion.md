---
title: Troubleshoot SNAT port exhaustion on AKS nodes
description: Provides guidance to troubleshoot Source Network Address Translation (SNAT) port exhaustion on Azure Kubernetes Service (AKS) nodes.
ms.date: 06/28/2024
ms.reviewer: v-rekhanain, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Connectivity
---
# Troubleshoot SNAT port exhaustion on Azure Kubernetes Service nodes

This article helps you find and troubleshoot Azure Kubernetes Service (AKS) nodes that experience Source Network Address Translation (SNAT) port exhaustion.

> [!NOTE]
> - To troubleshoot SNAT port exhaustion on AKS nodes in an AKS cluster running [Kubernetes jobs](https://kubernetes.io/docs/concepts/workloads/controllers/job/), perform the following steps only when the jobs are actively running on the AKS nodes.
> - To learn more about SNAT ports and their allocation per virtual machine, see [What SNAT ports are](/azure/load-balancer/load-balancer-outbound-connections#what-are-snat-ports).

## Step 1: Locate the node that experiences SNAT port exhaustion

1. Get the IP address of the AKS node that experiences active SNAT port exhaustion from the Azure portal.

    To do so, navigate to your AKS cluster in the Azure portal and select **Diagnose and Solve problems** > **Connectivity Issues** > **SNAT connection and Port Allocation**. The **SNAT connection and Port Allocation** tab displays the private IP address of the AKS node that experiences SNAT port exhaustion.

     :::image type="content" source="media/snat-port-exhaustion/diagnose-and-solve-problems.png" alt-text="Screenshot of the 'Diagnose and Solve problems' pane."  lightbox="media/snat-port-exhaustion/diagnose-and-solve-problems.png":::

     :::image type="content" source="media/snat-port-exhaustion/connectivity-issues.png" alt-text="Screenshot of the 'Connectivity Issues' pane." lightbox="media/snat-port-exhaustion/connectivity-issues.png":::

2. Connect to your AKS cluster and use the node IP address to get the node name by running the following `kubectl` command:

    ```console
    kubectl get nodes -o wide | grep <node IP>
    ```

## Step 2: Locate the Linux pod that has high outbound connections

> [!NOTE]
> - [Tcptracer](https://github.com/iovisor/bcc/blob/master/tools/tcptracer.py) is one of the [BPF Compiler Collection (BCC) tools](https://github.com/iovisor/bcc#contents) that are pre-installed on Linux nodes. It allows you to trace TCP established connections (`connect()`, `accept()`, and `close()`). You can use it to find high outbound connections from the source IP address and network namespace (netns) of a pod.
> - To access the BCC tools, use [kubectl node-shell](https://github.com/kvaps/kubectl-node-shell) *ONLY*.
> - All the following commands in this section are run as the root user on a Linux node that has the BCC tools installed.

1. On the Linux node that experiences SNAT port exhaustion, install [kubectl node-shell](https://github.com/kvaps/kubectl-node-shell):
    
    ```bash
    curl -LO https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell
    chmod +x ./kubectl-node_shell
    sudo mv ./kubectl-node_shell /usr/local/bin/kubectl-node_shell
    ```

2. Use SSH to connect to the node that experiences SNAT port exhaustion and use `tcptracer` to trace TCP established connections:

    ```bash
    kubectl node-shell <node name>
    cd /usr/share/bcc/tools
    /usr/share/bcc/tools# python3 tcptracer -t4v
    ```

    Here's a command output example:

    ```output
    Tracing TCP established connections. Ctrl-C to end.
    TIME(ns)     TYPE         PID   COMM             IP SADDR            DADDR            SPORT  DPORT  NETNS
    0           connect      18627  curl             4  1.2.3.4           5.6.7.8          53746  80     4026532785
    3xxx9       close        18627  curl             4  1.2.3.4           5.6.7.8          53746  80     4026532785
    1xxxx4      connect      18629  curl             4  1.2.3.4           9.10.11.12       35686  80     4026532785
    2xxxx9      close        18629  curl             4  1.2.3.4           9.10.11.12       35686  80     4026532785
    4xxxx5      connect      18631  curl             4  1.2.3.4           9.10.11.12       35688  80     4026532785
    4xxxx8      close        18631  curl             4  1.2.3.4           9.10.11.12       35688  80     4026532785
    7xxxx3      connect      18633  curl             4  1.2.3.4           13.14.15.16      35690  80     4026532785
    9xxxx7      close        18633  curl             4  1.2.3.4           13.14.15.16      35690  80     4026532785
    ```

3. Write the previous command output to a log file, and then sort the output to review a list of high connections:

    ```bash
    python3 tcptracer -t4v > log
    head -n +2 log | tail -n 1 | awk '{print "Count",$6,$10}'; awk '{print $6,$10}' log | sort | uniq -c | sort -nrk 1 | column -t
    ```

    Here's a command output example:

    ```output
    Count SADDR        NETNS
    387   1.2.3.4      4026532785
    8     11.22.33.44  4026532184
    8     55.66.77.88  4026531992
    ```

4. Map the IP address with the most connections from the previous output to a pod. If it doesn't work, you can continue.

5. Note the `SADDR` or `NETNS` value with the most connections from the previous output, and then run the following [lsns](https://man7.org/linux/man-pages/man8/lsns.8.html) command to map it to a PID. Lsns is a Linux tool that lists namespaces and maps namespaces to PIDs in the Linux process tree.

    ```bash
    lsns -t net
    ```

    Here's a command output example:

    ```output
    NS         TYPE NPROCS PID   USER  COMMAND
    4026532785 net  3      19832 root  bash
    ```

6. Map the previous PID to a containerd process by using [pstree](https://man7.org/linux/man-pages/man1/pstree.1.html). Pstree is a Linux tool that lists processes in a tree format for readability. 

    ```bash
    pstree -aps 19832
    ```

    Here's a command output example:

    ```output
    systemd,1
      `-containerd-shim,20946 -namespace k8s.io -id 2xxxf...
    ```

    Note the first five characters of the containerd `-id` in the command output. It will be used in step 7.

7. Map the previous containerd `-id` value to a POD ID by using [crictl](https://github.com/kubernetes-sigs/cri-tools/blob/master/docs/crictl.md). Crictl provides a CLI for CRI-compatible container runtimes.

    ```bash
    crictl ps -a
    ```

    Here's a command output example:

    ```output
    CONTAINER   IMAGE     CREATED      STATE     NAME    ATTEMPT    POD ID        POD
    6b5xxxxb    fbxxxxx1  6 hours ago  Running   ubuntu  0          2xxxxxxxxf    nginx
    ```

    Use the first five characters of the previous containerd `-id` value to match a POD ID.

8. Get all pods running on the node and use the previous POD ID to match the pod that has high outbound connections from the command output:
    
    ```bash
    kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=<nodename>
    ```

## Step 3: Find all outbound network connections made by the application

### [For a Linux pod](#tab/for-a-linux-pod)

1. Execute into the pod that's identified having high outbound connections in [Step 2: Locate the Linux pod that has high outbound connections](#step-2-locate-the-linux-pod-that-has-high-outbound-connections) by using one of the following commands:

    - ```bash
      kubectl exec -it <pod name> -n <namespace> /bin/bash
      ```
    
    
    - ```bash
      kubectl exec -it <pod name> -n <namespace> /bin/sh
      ```

2. Install the netstat command-line tool in the pod by running the following command. Netstat is a network troubleshooting tool for admins only.

    - On Debian, Ubuntu, or Linux Mint
    
        ```bash
        apt update
        apt install net-tools  
        ```
    
    - On RHEL, CentOS, Fedora, AlmaLinux, or Rocky Linux
    
        ```bash
        yum update
        yum install net-tools      
        ```
    
    - On Gentoo Linux
    
        ```bash
        emerge -a sys-apps/net-tools  
        ```
    
    - On Alpine Linux
    
        ```bash
        apk add net-tools    
        ```
    
    - On Arch Linux
    
        ```bash   
        pacman -S net-tools
        ```  
    
    - On OpenSUSE
    
        ```bash 
        zypper install net-tools
        ```

3. Once netstat is installed in the pod, run the following command:

    ```bash
    netstat -ptn | grep -i established
    ```

    Here's a command output example:
    
    ```output
    tcp        0      0 10.x.x.x:xxxx        20.x.x.x:443       ESTABLISHED xxxxx3/telnet
    ```

### [For a Windows pod](#tab/for-a-windows-pod)

1. Execute into a Windows pod by running the following command:

    ```console
    kubectl exec -it <Windows pod name> -- cmd.exe
    ```

2. Run the following netstat command to find established connections from the Windows application running in the pod:

    ```console
    netstat -aon | find /i "established"
    ```

    Here's a command output example:
    
    ```output
    C:\inetpub\wwwroot>netstat -aon | find /i "established"
      TCP    10.x.x.x:80            10.x.x.x:9818       ESTABLISHED     4
      TCP    10.x.x.x:80            10.x.x.x:15892      ESTABLISHED     4
      TCP    10.x.x.x:80            10.x.x.x:55785      ESTABLISHED     4
      TCP    10.x.x.x:49167         13.x.x.x:80         ESTABLISHED     9188 
    ```

---

In the command output, the local address is the pod's IP address, and the foreign address is the IP to which the application connects. The public IP connections in the `ESTABLISHED` state are the connections that utilize SNAT. Ensure that you count only the connections in the `ESTABLISHED` state to public IP addresses and ignore any connections in the `ESTABLISHED` state to private IP addresses.

Repeat the steps in this section for all other pods running on the node. The pod that has the most connections in the `ESTABLISHED` state to public IP addresses hosts the application that causes SNAT port exhaustion on the node. Work with your application developers to tune the application for improved network performance using the recommendations mentioned in [Design connection-efficient applications](/azure/load-balancer/troubleshoot-outbound-connection#design-connection-efficient-applications). After implementing the recommendations, verify that you see less SNAT port exhaustion.
 
[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
