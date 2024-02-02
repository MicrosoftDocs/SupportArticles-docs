---
title: Troubleshoot failed Linux compute node agent extension installation
description: Troubleshoot a failed Linux compute node agent extension installation from Microsoft HPC Pack on a high-performance computing (HPC) cluster.
ms.date: 10/05/2022
editor: v-jsitser
ms.reviewer: cargonz, v-leedennis
ms.service: hpcpack
keywords: Linux compute node agent extension, high-performance computing, HPC Pack, HPC Pack Linux node agent extension, LinuxNodeAgent2016U1, compute node, extension log, Linux node agent
#Customer intent: As a Microsoft HPC Pack user, I want to troubleshoot a failed Linux compute node agent extension installation so that I can successfully connect to a Linux compute node from a head node on a high-performance computing (HPC) cluster.
---
# Troubleshoot failed Linux compute node agent extension installation

This article discusses how to troubleshoot a scenario in which the HPC Pack Linux node agent extension doesn't install successfully on a node in a high-performance computing (HPC) cluster.

## Troubleshooting checklist

To troubleshoot a failed installation of the Microsoft.HpcPack.LinuxNodeAgent2016U1 extension on a Linux compute node, examine the extension log file, and then install a new Linux compute node on an infrastructure as a service (IaaS) virtual machine (VM).

### Step 1: Examine the extension log

The extension log file might be able to help you determine why the node agent wasn't installed successfully. To find and view the extension log file, follow these steps:

1. Open an administrative PowerShell console.
1. Run the following commands to enable the Secure Shell (SSH) connection feature on the head node:

   ```powershell
   dism /Online /Add-Capability /CapabilityName:OpenSSH.Server~~~~0.0.1.0
   Start-Service sshd
   Set-Service -Name sshd -StartupType 'Automatic'
   Set-Service -Name ssh-agent -StartupType 'Automatic'
   Start-Service ssh-agent
   ```

1. On the head node, run the following command to sign in to the Linux compute node:

   ```powershell
   ssh <domain-administrator-name>@<private-ip-address-of-linux-compute-node>
   ```

1. Enter the account password of the domain administrator.
1. Run the following command to verify that the extension log file exists on the node:

   ```bash
   sudo su ls -la /var/log/azure/Microsoft.HpcPack.LinuxNodeAgent2016U1/extension.log
   ```

1. Run or open your preferred text viewer or editor, and then display the contents of the extension log file.

### Step 2: Do a local test to burst to an IaaS VM

To test locally how to burst to an IaaS VM, follow these steps:

1. Follow the steps to [create an Azure IaaS node template](/powershell/high-performance-computing/hpcpack-burst-to-azure-iaas-nodes#step-2-create-an-azure-iaas-node-template). When you reach the **Specify VM Image** section of the template creation wizard, specify the following settings before you finish creating the node template.

   | Field name      | Value                            |
   |-----------------|----------------------------------|
   | **Image Type**  | **MarketplaceImage**             |
   | **OS Type**     | **Linux**                        |
   | **Image Label** | **Red Hat Enterprise Linux 7.8** |

1. Follow the steps to [create the IaaS compute nodes and manage them](/powershell/high-performance-computing/hpcpack-burst-to-azure-iaas-nodes#step-3-create-the-iaas-compute-nodes-and-manage-them). When you reach the **Specify New Nodes** section of the Add Node wizard, specify the following settings before you finish adding the node.

   | Field name           | Value                                                   |
   |----------------------|---------------------------------------------------------|
   | **Node template**    | The name of the node template that you created earlier. |
   | **Number of nodes**  | 1                                                       |
   | **VM Size of nodes** | **A1 (1 core, 1.75 GB Memory)**                         |

1. Follow the steps to [create a new job](/powershell/high-performance-computing/create-a-new-job) in the HPC Cluster Manager. When you reach the **Resource Selection** section, select **LinuxNodes** on the **Available node groups** list, and then select the **Add** button to move the item to the **Selected node groups** list. After you submit the new job, the Linux node will be provisioned correctly.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
