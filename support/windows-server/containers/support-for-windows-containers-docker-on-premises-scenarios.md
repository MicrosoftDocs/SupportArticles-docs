---
title: Support policy for Windows containers and Docker in on-premises scenarios
description: Summary of the configurations that Microsoft supports for Windows containers when you use them in an on-premises Windows deployment.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Management of Containers
ms.technology: windows-server-containers
---
# Support policy for Windows containers and Docker in on-premises scenarios

This article outlines Microsoft's support policy concerning Windows containers and Docker for on-premises deployments.

_Original product version:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 4489234

> [!NOTE]
> When customers experience issues with or have questions about Windows containers and related Docker functionality, Microsoft is their first point of contact. For similar information about Microsoft's support policy for containers in Azure, see [Support policy for containers and related services on Azure](https://support.microsoft.com/help/4035670/support-policy-for-containers-and-related-services-on-azure).

## Supported configurations for container hosts

Microsoft defines the supported host configurations in the following terms:

- **Host operating system**: Windows Server or Windows 10.

- **Hypervisor**: Windows 10 must run Hyper-V to support containers; Windows Server, as shown in the table, has more flexibility.

- **Docker engine**: Docker is a third-party application for managing containers. Docker Enterprise runs on Windows Server; Docker Desktop for Windows runs in Windows 10. For more information about Docker, see [Docker on Windows](/virtualization/windowscontainers/manage-docker/configure-docker-daemon).

- **Container type**: Microsoft supports Windows Server containers, Hyper-V containers, and Linux containers. However, not all host configurations can support all of the container types. For general information about Windows containers and container types, see [Containers on Windows](/virtualization/windowscontainers/about/index).

> [!NOTE]
> The Linux Containers on Windows (LCOW) feature is under active development. For more information, see [Linux Containers on Windows](/virtualization/windowscontainers/deploy-containers/linux-containers). You can track ongoing progress in the [Moby](https://github.com/moby/moby/issues/33850) project on GitHub.

### Host component support

Customers that deploy Windows Server containers on supported Windows Server versions running on physical hardware or virtual machine on Hyper-V will receive full support for issues that are related to the operating system and/or container engine.

## Supported configurations for Windows Server container hosts

Microsoft supports Windows containers on the following versions and releases of Windows Server:

- Windows Server 2019 (1809) Standard or Datacenter editions
- Windows Server 2016 (1803) Standard or Datacenter editions
- Windows Server 2016 (1709) Standard or Datacenter editions
- Windows Server 2016 (1607) Standard, Datacenter, or Nano Server editions
- Windows IoT core (only available to Windows Insider members)

> [!NOTE]
> You cannot host containers on Windows Server, Nano Server edition, on any Windows Server release later than 1607.
>
> Microsoft supports Windows containers on both LTSC and Semi-annual Channel (SAC) releases. For information about the support lifecycles for Windows versions and releases, see [Windows Server Semi-Annual Channel overview](/windows-server/get-started/semi-annual-channel-overview).

To deploy containers in Windows Server, you must install Docker Enterprise (see [Install Docker Engine - Enterprise on Windows Servers](https://docs.docker.com/install/windows/docker-ee/)). Docker provides full support for Docker Enterprise at [Docker support](https://success.docker.com/support).

On these versions of Windows, the types of containers that Microsoft supports depends on whether your host is a physical computer or a virtual machine, and whether Windows is running with Hyper-V enabled.

### Supported container types on a physical container host

|Hypervisor|Supported container types|
|---|---|
|None|Windows Server containers|
|Hyper-V| <ul><li>Windows Server containers</li> <li>Hyper-V containers</li> <li>Linux containers</li> </ul>|
|||

### Supported container types on a virtual machine container host

|VM host hypervisor|Guest OS|Guest hypervisor|Supported container types|
|---|---|---|---|
|Hyper-V|Windows Server (full or core)|None|Windows Server containers|
|Hyper-V|Windows Server (full or core)|Hyper-V  (must be running in nested virtualization mode)|Windows Server containers Hyper-V containers|
|Hyper-V|Linux|Linux|Linux containers|
|VMWare ESX|Windows Server (full or core)|None (Hyper-V not supported on VMWare ESX)|Windows Server containers|
|||||

## Supported configurations for Windows 10 container hosts

Microsoft supports containers on Windows 10 Professional or Enterprise with Anniversary Update (version 1607) or later, with the following requirements:

- Hyper-V must be enabled
- Docker Desktop for Windows must be installed (see [Install Docker Desktop for Windows](https://docs.docker.com/docker-for-windows/install/)). Docker Desktop for Windows is the Community Edition (Docker CE) and is ideal for developers and small teams looking to get started with Docker and experimenting with container-based apps.

    Microsoft does not provide support for Docker Desktop for Windows. Support is only provided through the [Docker Community Forums](https://forums.docker.com/c/docker-desktop-for-windows). For more information, see "What if I have problems or questions?" in the Docker for Windows FAQ at [Docker FAQ](https://docs.docker.com/docker-for-windows/faqs).

You can use Hyper-V containers or Linux containers on Windows 10. You cannot use Windows Server containers.

Microsoft does not support containers on virtual machines that are hosted on a Windows 10 computer. To use containers on a virtual machine, use Windows Server as the virtual machine host.

## Requirements for container hosts

For information about requirements for container hosts, see:

- [Windows container requirements](/virtualization/windowscontainers/deploy-containers/system-requirements)

- [System requirements for Hyper-V on Windows Server](/windows-server/virtualization/hyper-v/system-requirements-for-hyper-v-on-windows#general-requirements)

- [Run Hyper-V in a Virtual Machine with Nested Virtualization](/virtualization/hyper-v-on-windows/user-guide/nested-virtualization)

- [Windows Containers on Windows 10](/virtualization/windowscontainers/quick-start/quick-start-windows-10)

- [Docker Engine on Windows](/virtualization/windowscontainers/manage-docker/configure-docker-daemon)

- [Windows Container Version Compatibility](/virtualization/windowscontainers/deploy-containers/version-compatibility)

- [Linux Containers on Windows](/virtualization/windowscontainers/deploy-containers/linux-containers)

For information about requirements and compatibility issues for virtualization, see [Windows Server Catalog: Server Virtualization Validation Program](https://www.windowsservercatalog.com/svvp.aspx?svvppage=svvp.htm).

To run Hyper-V containers, the container host must meet the requirements for running Hyper-V itself. To summarize, Hyper-V requires:

- 64-bit processor, with the following capabilities:

  - **Second-level address translation (SLAT)**: The Windows hypervisor functionality requires SLAT (the Hyper-V management tools do not.
  
  - **Hardware-assisted virtualization**: This is available in processors that include a virtualization option - specifically processors with Intel Virtualization Technology (Intel VT) or AMD Virtualization (AMD-V) technology.
  
  - **Hardware-enforced Data Execution Prevention (DEP)** must be available and enabled. For Intel systems, this is the XD bit (execute disable bit). For AMD systems, this is the NX bit (no execute bit).

- VM Monitor Mode extensions.

- At least 4 GB of RAM. More memory is better. You'll need enough memory for the host and all virtual machines that you want to run at the same time.

- Virtualization support turned on in the BIOS or UEFI.

For more information, see [System requirements for Hyper-V on Windows Server](/windows-server/virtualization/hyper-v/system-requirements-for-hyper-v-on-windows#general-requirements).

## Supported container orchestrators

The Azure Service Fabric is not available to orchestrate on-premises containers. Windows does support Docker swarm, Kubernetes, and Red Hat orchestrators.

- **Docker swarm:** Docker swarm is a feature of the Docker engine. Docker swarm is fully supported by Docker. For more information about using Docker swarm with Windows containers, see [Getting started with swarm mode](/virtualization/windowscontainers/manage-containers/swarm-mode).

- **Kubernetes:** Kubernetes for on-premises Windows Server deployments is still in preview (Beta). Microsoft will not provide any support until the official announcement of general availability. Until then, use the following resources:
  
  - For the latest information about functionality with Windows Server 2016 and Windows Server 2019, see [Kubernetes on Windows](/virtualization/windowscontainers/kubernetes/getting-started-kubernetes-windows).
  
  - To track development and participate in community preview efforts, follow the Kubernetes [#SIG-Windows community](https://github.com/kubernetes/community/blob/master/sig-windows/README.md).

- **Red Hat OpenShift (Windows Server 2019 only):** Red Hat OpenShift on Windows Server 2019 is still in private preview. Microsoft will not provide support until the announcement of general availability.

## Supported container images

Microsoft offers four container base images for Windows:

- **Windows Server core**: If your application needs the full .NET framework, this is the best image to use.
- **Nano Server**: For applications that only require .NET Core, Nano Server will provide a much slimmer image.
- **Windows**: You may find your application depends on a component or .dll that is missing in Server Core or Nano Server images, such as GDI libraries. This image carries the full dependency set of Windows.
- **Windows IoT core**: This image is purpose-built for IoT applications. You should use this container image when targeting an IoT Core host.

> [!NOTE]
> The IoT Core base image is only available to members of the Windows Insider program.

As outlined in [Supported container hosts](#supported-configurations-for-container-hosts), not all host operating systems support both Windows Server containers and Hyper-V containers. Similarly, not all of the base images support both container types. The following table outlines which container types you can create using each base image on each of the host operating systems.

### Container base OS images that are supported on Windows container hosts

|Container host OS|Windows Server core|Nano Server|Windows|Windows IoT core|
|---|---|---|---|---|
|Windows Server 2016 or 2019 Standard or Datacenter|Windows Server containers<br/>Hyper-V containers|Windows Server containers<br/>Hyper-V containers|Windows Server containers<br/>Hyper-V containers|Not supported|
|Windows Server 2016 Nano Server|Not supported|Windows Server containers<br/>Hyper-V containers|Hyper-V containers|Not supported|
|Windows 10 Professional or Enterprise|Hyper-V containers|Hyper-V containers|Hyper-V containers|Not supported|
|Windows IoT core|Not supported|Not supported|Not supported|Windows Server containers|
|||

If you plan to work with container hosts that run different versions and releases of Windows, you will also need to consider the versions and releases of the container images. Some container features are not backward-compatible, so some newer base OS images may not run on container hosts with older OS versions. For more detailed information about compatibility issues between base OS image versions and host OS versions, see [Windows Container Version Compatibility](/virtualization/windowscontainers/deploy-containers/version-compatibility).

### Support for container workloads

Microsoft fully supports its container base OS images, as described in this section. For support of Microsoft applications in containers, see GitHub, the Microsoft forums, or the [Microsoft repository on DockerHub](https://hub.docker.com/u/microsoft/) for the custom container image in question.

When running third-party applications in Windows containers, refer to the application vendor for support. In particular, confirm with the application vendor that they support running the application in a Windows container.

## Supported networking configurations

Microsoft fully supports [Windows container networking](/virtualization/windowscontainers/container-networking/architecture) functionality. This functionality includes the Host Networking Service (HNS) and Host Compute Service (HCS). HNS and HCS work together to create containers (HCS) and attach endpoints to a network (HNS). Additionally, it includes the following container network drivers (for full descriptions of these drivers, see [Windows Container Network Drivers](/virtualization/windowscontainers/container-networking/network-drivers-topologies)):

- **Network Address Translation (NAT)**: This is the default driver for container networks. NAT networks support port forwarding and mapping from container hosts to container endpoints. Microsoft supports multiple NAT networks on Windows 10 container hosts that have [Windows 10, version 1703 (also known as the Creators Update)](/windows/whats-new/whats-new-windows-10-version-1703) installed.

- **Transparent**: When configured with a user-specified subnet, transparent networks support static IP addresses from the physical network or dynamic IP addresses assigned by an external DHCP server. When using a transparent network for containers on a virtual container host, you must configure MAC address spoofing.

- **Overlay**: Microsoft supports overlay networks for use with Docker swarm or Kubernetes orchestration. To use overlay networks, your configuration must meet the following requirements:

  - Your container hosts run Windows Server 2019, Windows Server 2016, or Windows 10 Creators Update.
  
  - Your deployment meets the requirements listed in [Using overlay networks](https://docs.docker.com/network/overlay/#operations-for-all-overlay-networks).
  
  - When using Kubernetes, you are using Flannel or OVN control panes.

    > [!NOTE]
    > Kubernetes for on-premises Windows Server deployments is still in preview (Beta). For information about Kubernetes support, see [Supported container orchestrators](#supported-container-orchestrators).

- **L2Bridge**: Microsoft supports L2Bridge networks to assign containers to the same IP subnet as the container host. To use L2Bridge networks, your configuration must meet the following requirements:

  - Your container hosts run Windows Server 2019, Windows Server 2016, or Windows 10 Creators Update.
  
  - IP addresses must be assigned statically from the same prefix as the container host.
  
  - You configure MAC address spoofing.

- **L2Tunnel**: Microsoft primarily supports L2Tunnel networks for use in a Microsoft Cloud Stack. Otherwise, requirements for L2Tunnel networks resemble the requirements for L2Bridge networks.

## Advanced network options - supported and unsupported

Microsoft supports switch-embedded teaming for container host networks used by Docker. Microsoft does not support any other NIC teaming configuration for container networking. For more information, see [Advanced Network Options in Windows](/virtualization/windowscontainers/container-networking/advanced).

Microsoft does not support the following features for container networking:

- IPSec encryption for container communication

- HTTP proxy configuration for containers. You can track a preliminary PR for this feature at [Changes to support registry modification in containers](https://github.com/Microsoft/hcsshim/pull/163).

- Attaching endpoints to running Hyper-V containers (hot-add)

Microsoft does not support the following commands and options for Docker:

|Command|Unsupported options|
|---|---|
|`Docker run`|<ul><li>`--ip6`</li> <li> `--dns-option`</li> </ul>|
|`Docker network create`|<ul><li>`--aux-address` </li> <li> `--internal`</li> <li>  `--ip-range` </li> <li> `--ipam-driver`</li> <li>  `--ipam-opt` </li> <li> `--ipv6` </li> <li> `--opt encrypted`</li> </ul>|
|||

## Supported service accounts for containers

Microsoft supports Active Directory group Managed Service Accounts (gMSAs) for containers.

Containers cannot be domain-joined. By using Group Managed Service Accounts (gMSAs), Windows containers themselves and the services they host can be configured to use a specific gMSA as their domain identity. Any service running as Local System or Network Service will use the Windows container's identity just like they use the domain-joined host's identity. For information about using gMSAs, see:

- [Getting Started with Group Managed Service Accounts](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj128431%28v=ws.11%29)

- [Active Directory Service Accounts for Windows Containers](/virtualization/windowscontainers/manage-containers/manage-serviceaccounts)

## Supported endpoint security options for containers and container hosts

Microsoft supports Windows Defender to protect container hosts. However, it does not support Windows Defender to run within containers.

Docker provides information about third-party providers and their endpoint protection products at [Endpoint security for Windows containers](https://success.docker.com/article/endpoint-security-for-windows-containers). When using a third-party product, verify that the provider supports the product for containers. Be aware of any issues and limitations related to running the product within a container. Additionally, for recommendations about how to configure anti-virus protection to work with containers, see [Anti-virus optimization for Windows Containers](/windows-hardware/drivers/ifs/anti-virus-optimization-for-windows-containers).
