---
title: Support policy for Windows containers and Docker in on-premises scenarios
description: Summary of the configurations that Microsoft supports for Windows containers when you use them in an on-premises Windows deployment.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Containers\Management Of Containers , csstroubleshoot
---
# Support policy for Windows Server containers in on-premises scenarios

This article outlines Microsoft's support policy concerning Windows Server containers for on-premises implementations.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows 10 - all editions, and Windows 11 - all editions  
_Original KB number:_ &nbsp; 4489234

Microsoft supports Windows Server containers for the following Windows versions and releases:

- Windows Server 2022 Standard or Datacenter editions
- Windows Server 2019 Standard or Datacenter editions
- Windows Server 2016 Standard or Datacenter editions
- Windows 10 and Windows 11 Professional and Enterprise with Docker Desktop installed
- Azure Stack HCI (when hosting Azure Kubernetes Service on Azure Stack HCI)
- Windows IoT Core
- Windows Server Container hosts must have Windows installed to C:. This restriction doesn't apply if only Hyper-V isolated containers are deployed.

Refer to [Overview - Product end of support](/lifecycle/overview/product-end-of-support-overview) public doc for more information on the end of support.

> [!NOTE]
> For similar information about Microsoft's support policy for containers in Azure, see [Support policy for containers and related services on Azure](../../azure/general/support-policy-containers.md).

## Supported configurations for container hosts

Microsoft defines the supported host configurations in the following terms:

- Host operating system: Windows Server, Windows 10 or Windows 11. For more information, see [Windows containers requirements](/virtualization/windowscontainers/deploy-containers/system-requirements).
- Hypervisor: Windows 10 or Windows 11 must run Hyper-V to support containers; Windows Server, as shown in the table, has more flexibility.
- [Mirantis Container Runtime](https://www.mirantis.com/software/mirantis-container-runtime/) (MCR): Mirantis Container Runtime is a third-party application used to create and manage containers that run on Windows Server. For more information, see [Windows containers requirements](/virtualization/windowscontainers/deploy-containers/system-requirements).
- ContainerD: Used AKS Hybrid and AKS deployments.
- [Docker Desktop](https://www.docker.com/products/docker-desktop) for Windows runs on Windows 10.
- Container type: Microsoft supports Windows Server containers with Hyper-V isolation. However, not all host configurations can support any container type. For general information about Windows Server containers and container types, see [Container base images](/virtualization/windowscontainers/manage-containers/container-base-images) and [Windows container version compatibility](/virtualization/windowscontainers/deploy-containers/version-compatibility).

> [!NOTE]
> The Linux Containers on Windows (LCOW) feature on Windows Server has been deprecated.

## Host component support

Windows Server containers on [supported Windows Server versions](/virtualization/windowscontainers/deploy-containers/system-requirements) running on physical hardware or virtual machines (VM) on Hyper-V receive full support for issues that are related to the operating system, base container images and/or container feature.
Running Windows Server containers on a Windows Server 2016 and higher VM hosted on a [SVVP validated hypervisor](../virtualization/microsoft-server-software-support-policy.md) receive full support for issues that are related to the operating system, base container images and/or container feature.

## Supported configurations for Windows Server container hosts

To deploy Windows Server containers and Hyper-V container with isolation, the Mirantis Container Runtime must be installed (see [Get started: Prep Windows for containers](/virtualization/windowscontainers/quick-start/set-up-environment#windows-server)).

## Supported container types on physical container host

|Hypervisor|Support container types|
|---------|---------|
|None|Windows Server containers|
|Hyper-V|Hyper-V isolation and Windows Server containers|

## Supported container types on a virtual machine container host

|VM Host Hypervisor|Guests OS|Guest Hypervisor|Supported Container Types|
|---------|---------|---------|---------|
|Hyper-V|Windows Server (full or core)|None|Windows Server containers|
|Hyper-V|Windows Server (full or core)|Hyper-V (must be running in [nested virtualization mode](/virtualization/hyper-v-on-windows/user-guide/nested-virtualization))|Windows Server containers and Hyper-V isolated containers|
|SVVP validated hypervisor|Windows Server (full or core)|None (Hyper-V not supported on VMware ESX)|Windows Server containers|

For more information on SVVP validated hypervisors, see [Welcome to the Windows Server Virtualization Validation Program](https://www.windowsservercatalog.com/svvp.aspx).

## Supported configurations for Windows 10 and Windows 11 container hosts

Microsoft supports containers on Windows 10 or Windows 11 Professional or Enterprise under the following conditions:

- A physical computer operating system of Windows 1011 Professional or Enterprise with Anniversary Update (version 1607) or later.
- Hyper-V is installed.
- The container type is Hyper-V with isolation (default).
- Docker Desktop for Windows is installed (see [Install Docker Desktop for Windows](https://docs.docker.com/docker-for-windows/install/) on Docker's website). Docker Desktop for Windows is the Community Edition (CE) and is ideal for developers and small teams looking to get started with Docker and experimenting with container-based apps.
- Starting with the Windows 10 and Windows 11 October Update 2018, we no longer disallow users from running Windows Server containers in process isolation mode on Windows 10 and Windows 11 Enterprise or Professional for develop or test purposes. See the [FAQ](/virtualization/windowscontainers/about/faq) to learn more.

> [!NOTE]
> Users are no longer disallowed from running Windows Server containers in process isolation mode on Windows 10 Enterprise or Professional for dev/test purposes since Windows 10 October 2018 update. See the [FAQ](/virtualization/windowscontainers/about/faq) to learn more.

Microsoft doesn't provide support for the following configurations on Windows 10 and Windows 11 Professional or Enterprise:

- Docker Desktop. You can get support from the [Docker Community Forums](https://forums.docker.com/c/docker-desktop-for-windows) or from Docker support. For more information, see [Docker Desktop for Windows FAQ](https://docs.docker.com/desktop/faqs/).
- Windows Server containers or Hyper-V containers with isolation on virtual machines that are hosted on a Windows 10 or Windows 11 Professional or Enterprise system. To use containers on a virtual machine, use Windows Server as the host.
- Windows Server containers do work on Windows 10 or Windows 11 now but aren't fully supported.

## Requirement for container hosts

For information about requirements for containers hosts, see:

- [Windows container requirements](/virtualization/windowscontainers/deploy-containers/system-requirements)
- [System requirements for Hyper-V on Windows Server](/windows-server/virtualization/hyper-v/system-requirements-for-hyper-v-on-windows#general-requirements)
- [Run Hyper-V in a Virtual Machine with Nested Virtualization](/virtualization/hyper-v-on-windows/user-guide/nested-virtualization)
- [Windows Containers on Windows 10](/virtualization/windowscontainers/quick-start/quick-start-windows-10)
- [Docker Engine on Windows](/virtualization/windowscontainers/manage-docker/configure-docker-daemon)
- [Windows Container Version Compatibility](/virtualization/windowscontainers/deploy-containers/version-compatibility)
- [Linux containers on Windows 10](/virtualization/windowscontainers/deploy-containers/linux-containers)

For more information about requirements and compatibility issues for virtualization, see [Windows Server Catalog: Server Virtualization Validation Program](https://www.windowsservercatalog.com/svvp.aspx?svvppage=svvp.htm).

## Hyper-V isolated container requirements

To run Hyper-V containers, the container host must meet the requirements for running Hyper-V itself. To summarize Hyper-V requirements for Windows Server:

- 64-bit processor, with the following capabilities
  - Second-level address translation (SLAT): The Windows hypervisor functionality requires SLAT (the Hyper-V management tools don't).
  - Hardware-assisted virtualization: This is available in processors that include a virtualization option – specifically processors with Intel Virtualization Technology (Intel VT) or AMD Virtualization (AMD-V) technology.
  - Hardware-enforced Data Execution Prevention (DEP) must be available and enabled. For Intel systems, this is the XD bit (execute disable bit). For AMD systems, this is the NX bit (no execute bit).
- VM Monitor Mode extensions.
- At least 4 GB of RAM. More memory is better. You need enough memory for the host and all virtual machines that you want to run at the same time.
- Virtualization support turned on in the BIOS or UEFI.

For more information on system requirements:

- [System requirements for Hyper-V on Windows Server](/windows-server/virtualization/hyper-v/system-requirements-for-hyper-v-on-windows)
- [Windows 10 Hyper-V System Requirements](/virtualization/hyper-v-on-windows/reference/hyper-v-requirements)
- [How to enable nested virtualization in an Azure VM](/virtualization/hyper-v-on-windows/user-guide/nested-virtualization)

## Supported container images

Microsoft offers four container base images that users can build from. Each base image is a different type of Windows operating system, has a different on-disk footprint, and has a different set of Windows API. See [Container Base Images](/virtualization/windowscontainers/manage-containers/container-base-images) for more information.

- Windows Server core: supports traditional .NET framework applications
- Nano Server: built for .NET Core applications
- Windows Server: provides additional Windows API set
- Windows IoT Core: purpose-built for IoT applications

## Container base OS images that are supported on Windows container hosts

As outlined in Supported container hosts, not all host operating systems support both Windows Server containers and Hyper-V isolated containers. Similarly, not all the base images support both container types. The following table outlines which container types you can create using each base image on each of the host operating systems.

|Container host OS|Windows Server Core container base image|Nano Server container base image|Windows container base image|Windows IoT Core container base image|
|---|---|---|---|---|
|Windows Server 2016 or 2019 Standard or Datacenter|Windows Server containers and Hyper-V containers with isolation|Windows Server containers and Hyper-V containers with isolation|Windows Server containers and Hyper-V containers with isolation|Not supported|
|Windows 10 Professional or Enterprise|Hyper-V containers with isolation and Windows Server containers for dev/test|Hyper-V containers with isolation and Windows Server containers for dev/test|Hyper-V containers with isolation and Windows Server containers for dev/test|Not supported|
|Windows IoT Core|Not supported|Not supported|Not supported|Windows Server containers|

If you plan to use container hosts that run different versions and releases of Windows, you also need to consider the versions and releases of the container images. Some container features aren't backward compatible, so some newer container base images may not run on container hosts with old Operation System (OS) versions. See [Windows Container Version Compatibility](/virtualization/windowscontainers/deploy-containers/version-compatibility) for more information.

## Support for container workloads

Microsoft fully supports the container base images, as described in the "Supported container images" section.

For support of Microsoft applications like IIS, SQL and .NET running in containers, see [Microsoft repository on DockerHub](https://hub.docker.com/u/microsoft/) for the respective container image support guidance.

> [!NOTE]
> If you are trying to move a custom application or a third-party application to Windows Server containers running the Windows Server Core image and have issues with missing .DLLs or other components in the Windows Server core base image, try using the Windows Server container image as it has additional Windows API set.

Avoid copying .DLLs from the container host to the Windows Server Core base image as it may cause the application to misbehave. Microsoft provides some component .DLLs in Redistributable package form. Download Redistributable packages from official Microsoft Download Center and install it in the container image using a Dockerfile.

There isn't a “single source of truth” in terms of which .DLLs are offered in a Redistributable form or not.

For guidance on moving legacy apps, see [Lift and shift to containers](/virtualization/windowscontainers/quick-start/lift-shift-to-containers).

## Supported network configurations

Microsoft supports the [Windows container networking](/virtualization/windowscontainers/container-networking/architecture) functionality. This functionality includes the Host Networking Service (HNS) and Host Compute Service (HCS). HNS and HCS work together to create containers (HCS) and attach endpoints to a network (HNS). Additionally, it includes the following container network drivers (for full descriptions of these drivers, see [Windows Container Network Drivers](/virtualization/windowscontainers/container-networking/network-drivers-topologies)):

See this article for [Unsupported features and network options](/virtualization/windowscontainers/container-networking/architecture#unsupported-features-and-network-options).

## Supported service accounts for containers

Microsoft supports [Active Directory group Managed Service Accounts](/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview) (gMSA) for containers.

Containers can't be domain-joined but gMSA supports non-domain-joined and domain joined container hosts.
By using gMSA, Windows Server containers themselves and the service they host can be configured to use a specific gMSA as their domain identity. Any service running with the Local System or Network Service use the Windows Server containers' identity just like they use the domain-joined host's identity. See [Create gMSAs for Windows containers](/virtualization/windowscontainers/manage-containers/manage-serviceaccounts) for more information.

## Supported endpoint security options for containers and container hosts

Windows Defender has been optimized to protect container hosts and is fully supported. However, Microsoft doesn't support Windows Defender running in Windows Server containers.

When using a third-party endpoint security/anti-virus software, verify with the vendor that Windows Server containers are supported and refer to the vendor's public docs for recommendations and exclusions. See [Anti-virus optimization for Windows Containers](/windows-hardware/drivers/ifs/anti-virus-optimization-for-windows-containers) for more information.

## Supported Container Runtime on Windows Server

_Mirantis Container Runtime (MCR)_ is a recommended and supported container runtime interface used to create, manage, and run Windows Server containers on Windows Server. For more information, see [Mirantis](https://www.mirantis.com/software/docker/container-runtime/).

See [Get Started: Prep Windows for containers](/virtualization/windowscontainers/quick-start/set-up-environment) for the recommended and supported installation method on Windows Server.

After April 30, 2023, Microsoft will no longer be the first point of contact for customers running the Mirantis Container Runtime on Windows Server. Customers need to engage Mirantis first.

For more information, See the [Message from Mirantis](https://www.mirantis.com/docker-engine-enterprise-support/).

1. Microsoft will provide support for Mirantis Container Runtime until April 30, 2023.
2. Customers are licensed to run, in perpetuity, only the number of copies of Mirantis Container Runtime obtained before April 30, 2023, and no more.
3. After April 30, 2023, customers won't be able to get support, updates, or patches for the Mirantis container runtime from either Microsoft or Mirantis.
4. Customers can purchase a license to use a fully supported version of Mirantis Container Runtime from Mirantis at any time.

_ContainerD_ is an open-source industry-standard container runtime that is supported by the community. For more information, see [ContainerD project](https://containerd.io/). ContainerD running on Windows Server can create, manage, and run Windows Server Containers but Microsoft doesn't provide any support for it. For any issues or questions related to ContainerD, ask the [GitHub community](https://github.com/containerd/containerd/issues). For more information, see the [GitHub ContainerD project](https://github.com/containerd/containerd/issues).

## Supported Container Orchestrators

Several container orchestrators support Windows Server containers. Address any issues or questions with the vendor before engaging Microsoft support.

_Azure Kubernetes Service on Azure Stack HCI (AKS-HCI) or Windows Server_ is an on-premises implementation of Azure’s flag ship container service, which automates running containerized applications at scale. AKS makes it quicker to get started hosting Linux and Windows containers in your datacenter.

Microsoft provides end-to-end support for Azure Kubernetes Service on Azure Stack HCI or Windows Server, including a single node without high availability.

Microsoft won't provide support for the following.

- Custom application code
- Any non-in-box system services or drivers in the container or container host
- Container base images that aren't supported by Microsoft (such as Nginx) or container base images that aren't listed in the supported add-ons list

For more information on support policies, see [Support policies for AKS hybrid - AKS hybrid | Microsoft Learn](/azure/aks/hybrid/support-policies).

_Azure Kubernetes Service Edge Essentials (AKS EE)_ is an on-premises Kubernetes implementation of Azure Kubernetes Service (AKS) that automates running containerized applications at scale. AKS Edge Essentials includes a Microsoft-supported Kubernetes platform that includes a lightweight Kubernetes distribution with a small footprint and simple installation experience, making it easy for you to deploy Kubernetes on PC-class or "light" edge hardware.

Microsoft provides end-to-end support for Azure Kubernetes Service Edge Essentials except for the following.

- Custom application code
- Any non-in-box system services or drivers in the container or container host
- Container base images not supported by Microsoft like; Nginx or versions or base images that aren't listed in the supported add-ons list

For more information on support policies, see [Support policies for AKS hybrid - AKS hybrid | Microsoft Learn](/azure/aks/hybrid/support-policies).

_Azure Kubernetes Service (AKS)_ is Azure’s flag ship container service; customers can create Windows Server based node pools within an AKS cluster to run their Windows containers. This is a fully supported service; Any issues or questions should be opened using the [Help + Support in the Azure portal](/azure/azure-portal/supportability/how-to-create-azure-support-request).

_Kubernetes_ is an open-source project that supports Windows Server containers on Windows Server 2019 and higher starting with Kubernetes 1.14. For more information, see [Intro to Windows support in Kubernetes](https://kubernetes.io/docs/setup/production-environment/windows/intro-windows-in-kubernetes/#windows-containers-in-kubernetes) and [Support Functionality and Limitations](https://kubernetes.io/docs/setup/production-environment/windows/intro-windows-in-kubernetes/#supported-functionality-and-limitations). For more information, see [Kubernetes on Windows](/virtualization/windowscontainers/kubernetes/getting-started-kubernetes-windows).

For any issues and questions related to Kubernetes, see [Reporting Issues and Feature Requests](https://kubernetes.io/docs/setup/production-environment/windows/intro-windows-in-kubernetes/#reporting-issues-and-feature-requests).

Microsoft only provides support for Windows nodes participating in an on-premises Kubernetes cluster.

Microsoft doesn't provide support for the following items:

- Setting up and configuring Linux nodes
- Kubernetes binaries
- Linux containers
- Kubernetes plug-ins

Any question or issue related to nonsupported items should be addressed to relevant GitHub communities.

_Azure Service Fabric_ is fully supported and all issues or questions should be directed to Azure support using the [Help + Support in the Azure portal](/azure/azure-portal/supportability/how-to-create-azure-support-request). For more information, see [Introducing Service Fabric cluster resource manager](/azure/service-fabric/service-fabric-cluster-resource-manager-introduction) and [Service Fabric and containers](/azure/service-fabric/service-fabric-containers-overview).

_Docker swarm_ is a feature of the Mirantis Container Runtime that creates, manages, and runs Windows Server containers in a mixed node environment of Linux and Windows hosts. Docker swarm is fully supported by Mirantis. Mirantis support advises customers on whether Microsoft support should be engaged regarding issues or questions related to Windows Server. For more information about using Docker swarm with Windows Server containers, see [Getting started with swarm mode](/virtualization/windowscontainers/manage-containers/swarm-mode) and [Swarm mode overview](https://docs.docker.com/engine/swarm/) on Mirantis website.

_Moby_ is an open-source project intended for engineers, integrators and enthusiasts looking to modify, hack, fix, experiment, invent, and build systems based on containers. For more information, see the [Moby project](https://github.com/moby/moby) on GitHub.

Microsoft doesn't provide support for Moby in a stand-a-lone environment (a single-node container host running Windows Server). All questions and issues should be raised in the Moby project on GitHub.
