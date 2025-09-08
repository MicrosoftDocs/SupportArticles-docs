---
title: Resolve batch node creation delays when restarting or reimaging
description: Resolve batch node creation delays when restarting or reimaging. Avoid delays and errors because of installing the large Python runtime and Python packages.
ms.date: 05/23/2025
author: JerryZhangMS
ms.author: zhangjerry
editor: v-jsitser
ms.reviewer: jaygong, biny
ms.service: azure-batch
#Customer intent: As an Azure Batch user, I want to be able to install the Python runtime and packages quickly so that I can avoid delays and unexpected errors when I create a batch node and a batch node pool to run Python applications.
ms.custom: sap:Azure Batch
---
# Resolve batch node creation delays when restarting or reimaging

This article discusses how to resolve batch node creation delays when you restart or reimage a node. Avoid problems in Microsoft Azure Batch that are caused by installing the large Python runtime and Python packages. This installation causes long delays and possible unexpected errors when a batch node is first added to a batch pool, or when the node is restarted or reimaged.

## Symptoms

When you create a batch pool and add a node to the pool, or you restart or reimage the node, application installation takes too long to finish, or it fails after a lengthy installation time.

## Cause 

This issue occurs because a Python package is too large to use as a start task.

When you create a batch pool in Azure Batch and add a batch node, the recommended process is to use a [start task](/azure/batch/jobs-and-tasks#start-task) to prepare the operating environment. This start task can do the following things:

- Install the applications that your tasks run.

- Start background processes when the batch node is first added to the pool, or when the node is restarted or reimaged.

However, for the Python language runtime and applications that require Python to run, the package might be so large that it takes a long time for the start task to install. Even after most of the installation has occurred, the installation might still fail because of an unexpected problem.

## Solution

To fix this issue, match the virtual machine (VM) and batch account locations and OS versions, and preinstall Python and its packages before you capture a Gen1 image.

Use a prepackaged custom image to allocate batch nodes. For general information about this process, see [Use a managed image to create a custom image pool](/azure/batch/batch-custom-images).

To prevent lengthy installation times and help avoid installation failure, follow these general practices:

- Specify the same location or region to use when you create the batch account and create the VM batch node.

- Select an image that has **Gen1** in the name, such as **Windows Server 2019 Datacenter - Gen1** (Windows node) or **Ubuntu Server 18.04 LTS - Gen1** (Linux node). A **Gen1** image is necessary because some VM families don't support **Gen2** images.

- When you create a pool of nodes in the Azure portal, make sure that the **Sku** list in the **Operating system** section contains the system version that you specified.

- Customize your Python installation so that it gets preinstalled on the image and works for all users.

### System-specific procedures

The following tabbed sections describe the steps that you have to take for a Windows batch node or a Linux batch node.

## [Windows](#tab/windows)

### Windows node: Install the required version of Python on the C drive, and manually append the system path

#### Procedure summary

After you create and start the VM, connect to the VM by using Remote Desktop Protocol (RDP). Then, install everything that you need on the VM, including the required version of the Python runtime (for example, Python 3.10.4), and edit the system path. Finally, capture the VM image, deploy it to a batch pool that uses the VM image, connect to the new batch pool node, and then test it to make sure the preinstalled Python runtime and packages work correctly.

#### Procedure steps

1. [Create a Windows VM in the Azure portal](/azure/virtual-machines/windows/quick-create-portal#create-virtual-machine) by specifying the following settings.

   | Setting name | Setting value                                                                                      |
   |--------------|----------------------------------------------------------------------------------------------------|
   | **Region**   | The same region that's assigned to your batch account                                              |
   | **Image**    | A Windows image that has **Gen1** (not **Gen2**) in the name and is supported by the batch service |

1. [Connect to the VM by using RDP](/azure/virtual-machines/windows/connect-rdp).
1. Run the Python Setup wizard, and then select the **Customize installation** option. Then, on the **Advanced Options** page, go to the **Customize install location** box, and specify a path on the C drive.
1. Edit the *system* environment variable for `Path` so that it includes the Python installation path (such as *C:\\Python\\*) and the path to the Python installed packages (such as *C:\\Python\\Scripts\\*).

   > [!NOTE]
   >
   > The Python Setup wizard adds these paths only to the *user* environment variable for `Path`. Therefore, you have to add the paths to the corresponding *system* environment variable. Otherwise, when you capture the VM image, the Python settings and the extra software packages that the user installed are deleted from the image.

   To append these paths to the system environment variable, follow these steps:

   1. Select **Start**, and then search for and select **Settings**.

   1. In the **Settings** app, select **System** > **About** > **Advanced system settings**.

   1. In the **System Properties** dialog box, select the **Advanced** tab, and then select **Environment variables**.

   1. In the **Environment Variables** dialog box, go to the **System variables** section, select the **Path** variable, and then select **Edit**.

   1. In the **Edit environment variable** dialog box, select **New**, and then enter the path to the Python installed packages. Then, repeat this step to enter the path to the Python runtime.

   1. Select **OK** three times to apply the changes in the three dialog boxes.

1. Test the Python installation in a console.

   For example, after you run `python --version` to verify the version of Python that you installed, you can run the Python interpreter to try to import a package that hasn't been installed yet (such as `numpy`). After you get the expected `ModuleNotFoundError` exception, run the `pip install <package-name>` command to install the package, and then run the Python interpreter again to import that package. The import command should now succeed.

1. Capture the VM image by following the steps in [Create an image of a VM in the portal](/azure/virtual-machines/capture-image-portal), but apply only the following settings on the **Create an image** page.

   | Setting name | Setting value |
   |--|--|
   | **Resource group** | Select from the list of resource groups, or select **Create new** to create a resource group. |
   | **Target Azure compute gallery** | Select from the list of Azure compute galleries, or select **Create new** to create an Azure compute gallery. |
   | **Target VM image definition** | Select **Create new**. In the **Create a VM image definition** page, enter only the **VM image definition name** that you want to give to the image. (The page will automatically provide the **Publisher**, **Offer**, and **SKU** settings.) |
   | **Version number** | Enter a version number that you want to give to the VM image. |

1. After you apply the VM image settings, select **Review + create** to verify the settings, and then select **Create** to create the image. This step creates the following three resource types:

   - Azure Compute Gallery
   - Custom Image Definition
   - Custom Image Definition Version

1. After the three resources are created, follow these steps to create a new batch pool that uses the VM image:

   1. In the [Azure portal](https://portal.azure.com), search for and select **Batch accounts**.
   1. In the list of batch accounts, select your account.
   1. In the menu pane of your batch account, select **Pools**, and then select **Add** to create a batch pool.
   1. In the **Add pool** page, make the following settings, and then select **OK**.

      | Setting name | Setting value |
      |--|--|
      | **Pool ID** | The new name for your pool |
      | **Image Type** | **Custom image - Shared Image Gallery** \* |
      | **Shared image gallery** | The name of the target Azure compute gallery that you specified when you created the VM image |
      | **Image** | The VM image definition name that you specified when you created the VM image |
      | **Version** | The version number that you specified when you created the VM image |
      | **Operating system** | **Windows** |
      | **OS distribution** | **windowsserver** |
      | **OS sku** | The product code of the OS version that you selected (for example, **microsoftwindowsserver-2019-datacenter**) |

      \* Shared Image Gallery is another name for Azure Compute Gallery. This is one of the resources that was created during your VM image creation. 

1. After the batch pool node is allocated, go to the batch pool node page, and then select **Connect** in the heading menu.
1. In the **Connect** pane, select the **Generate a user** option, select the **Generate a random user** button, and then select **Download RDP file**.
1. Run the downloaded RDP file to connect to the new batch node.
1. Test the Python installation again to make sure that the preinstalled version works correctly.

## [Linux](#tab/linux)

### Linux node: Run sudo to install Python 3.8 and its external packages

#### Procedure summary

After you create and start the VM, connect to the VM by using Secure Shell (SSH). Then, install everything that you need on the VM, including the 3.8 version of the Python runtime (a later version of the default 3.6 version). To do this, use the `sudo` command to make Python 3.8 and its packages available to all users. Finally, capture the VM image, deploy it to a batch pool that uses the VM image, connect to the new batch pool node, and then test it to make sure that the preinstalled Python 3.8 runtime and packages work correctly.

#### Procedure steps

1. [Create a Linux VM in the Azure portal](/azure/virtual-machines/linux/quick-create-portal#create-virtual-machine) by specifying the following settings.

   | Setting name | Setting value                                                                                    |
   |--------------|--------------------------------------------------------------------------------------------------|
   | **Region**   | The same region that's assigned to your batch account                                            |
   | **Image**    | A Linux image that has **Gen1** (not **Gen2**) in the name and is supported by the batch service |

1. [Connect to a Linux VM](/azure/virtual-machines/linux-vm-connect) by using SSH.
1. Run the following commands to install Python 3.8 and its package installation tool (`pip`):

   ```bash
   sudo apt-get update
   sudo apt install -y python3.8
   sudo apt-get -y install python3-pip
   sudo python3.8 -m pip install --upgrade pip
   ```

1. Run the following Python 3.8 commands to verify the version of Python and install the `requests` external package.

   ```bash
   python3.8 --version
   sudo python3.8 -m pip install requests
   ```

   > [!NOTE]
   >
   > - You should install Python packages by using the `sudo python3.8 -m pip install <package-name>` syntax. If you try to install a Python package by using `sudo pip install <package-name>` or `sudo pip3 install <package-name>`, the package might be installed into the default 3.6 version of Python. Doing this would make the package unavailable to applications that require Python 3.8.
   >
   > - You must use the `sudo` command when you install packages. If you don't include `sudo`, the installed package isn't recognized by other users.

1. Run the `python3.8` in interactive mode, and then enter `import requests` to verify that the `requests` package was installed successfully and can be imported into Python 3.8.

1. Deprovision the Linux VM by running the following command:

   ```bash
   sudo waagent -deprovision+user
   ```

   > [!WARNING]
   > - If you skip this step, the Batch nodes might become unusable.
   >
   > - After you run the [VM deprovisioning command](/azure/virtual-machines/linux/capture-image#step-1-deprovision-the-vm), you'll no longer be able to connect to this VM.

1. Capture the VM image by following the steps in [Create an image of a VM in the portal](/azure/virtual-machines/capture-image-portal), but apply only the following settings in the **Create an image** page.

   | Setting name | Setting value |
   |--|--|
   | **Resource group** | Select from the list of resource groups, or select **Create new** to create a resource group. |
   | **Target Azure compute gallery** | Select from the list of Azure compute galleries, or select **Create new** to create an Azure compute gallery. |
   | **Target VM image definition** | Select **Create new**. Then, enter only the **VM image definition name** that you want to give to the image on the **Create a VM image definition** page. (The page will automatically provide the **Publisher**, **Offer**, and **SKU** settings.) |
   | **Version number** | Enter a version number to assign to the VM image. |

1. After you apply the VM image settings, select **Review + create** to verify the settings, and then select **Create** to create the image. This step creates the following three resource types:

   - Azure Compute Gallery
   - Custom Image Definition
   - Custom Image Definition Version

1. After the three resources are created, follow these steps to create a new batch pool that uses the VM image:

   1. In the [Azure portal](https://portal.azure.com), search for and select **Batch accounts**.
   1. In the list of batch accounts, select your account.
   1. In the menu pane of your batch account, select **Pools**. Then, select **Add** to create a batch pool.
   1. In the **Add pool** page, make the following settings, and then select **OK**:

      | Setting name | Setting value |
      |--|--|
      | **Pool ID** | The new name for your pool |
      | **Image Type** | **Custom image - Shared Image Gallery** \*|
      | **Shared image gallery** | The name of the target Azure compute gallery that you specified when you created the VM image |
      | **Image** | The VM image definition name that you specified when you created the VM image |
      | **Version** | The version number that you specified when you created the VM image |
      | **Operating system** | **Linux** |
      | **OS distribution** | One of the Linux distribution names |
      | **OS sku** | The product code of the OS version that you selected |

      \* Shared Image Gallery is another name for Azure Compute Gallery. This is one of the resources that was created during your VM image creation.

1. After the batch pool node is allocated, connect to the node by using SSH.
1. Test the Python 3.8 installation again to make sure that the preinstalled version works correctly.

---

## References

- [Run your first batch job in the Azure portal](/azure/batch/quick-create-portal)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
