---
title: Configure operating system deployment
description: Describes the step-by-step process for configuring System Center 2012 Configuration Manager to capture, deploy and install an existing Windows image.
ms.date: 06/16/2020
ms.prod-support-area-path: 
ms.reviewer: jarrettr
---
# Configure operating system deployment in System Center 2012 Configuration Manager

Most support issues that affect operating system deployment (OSD) in System Center 2012 Configuration Manager stem from product misconfigurations. Although there are no simple guidelines to implement something as powerful and complex as OSD, this article describes the step-by-step process for configuring System Center 2012 Configuration Manager (ConfigMgr 2012) to capture an existing Windows image. This article also guides you through creating a client package and task sequence to deploy and install that image.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2969096

## Introduction

This article assumes that you have an existing environment that has a Configuration Manager 2012 site installed and also a primary site that's running Configuration Manager 2012. These steps can also be used together with a stand-alone primary site that is running Configuration Manager 2012. Additionally, this article requires that the Network Access Account and Boundaries are configured correctly, and that ConfigMgr client agents are installed on the clients.

### Overview of the technology

OSD provides System Center 2012 Configuration Manager administrative users a tool to create operating system images that can be deployed both to computers that are managed by Configuration Manager and to unmanaged computers. You can do this by using bootable media, such as a CD set, DVD, or USB flash drives. A description of each component of the OSD process can be found in [Introduction to Operating System Deployment in Configuration Manager](/previous-versions/system-center/system-center-2012-R2/gg682108(v=technet.10)).

## Prerequisites

|Task|Detailed steps|
|---|---|
|Prerequisites|This article assumes you have an existing environment with a Configuration Manager 2012 site installed as well as a primary site running Configuration Manager 2012. These steps can also be used with a standalone primary site running Configuration Manager 2012. Further, this article requires that the Network Access Account and Boundaries are properly configured and that ConfigMgr client agents are installed on the clients.|
|Computers used in this exercise|GTRCM12CAS (ConfigMgr 2012 central administration site (CAS) server)<br/>GTRCM12PRI1 (ConfigMgr 2012 primary site server)<br/>GTRCM12WIN7B (ConfigMgr 2012 client)<br/>GTRCMXP01 (ConfigMgr 2012 client)<br/>|
|||  

## Configure the components

In this section, we will install the Windows Deployment Services (WDS) role on GTRCM12PRI1 and then share a folder. We will configure a distribution point (DP) to respond to incoming PXE requests, and then we will copy x86 and x64 boot images to it.

|Task|Detailed steps|
|---|---|
|| Complete the following steps on the primary site server (GTRCM12PRI1) |
|Open an elevated command prompt|1. On the **Start** menu, point to **All Programs**, point to **Accessories**, and then point to **Command Prompt**. Right-click it and select **Run as administrator** from the shortcut menu.|
|Share folder Flats as Sources|2. Run the `net share Sources=C:\Flats /Grant:System,Full /Grant:Administrators,Full` command to grant System and local admin permission to the Sources share.<br/><br/>![the screenshot of admin command prompt](./media/configure-operating-system-deployment/admin-command-prompt.png)<br/>|
|Log off GTRCM12PRI1||
|| Complete the following tasks on the CAS (GTRCM12CAS) |
|Start the Configuration Manager Console|1. On the **Start** menu, point to **All Programs**, point to **Microsoft System Center**, point to **Configuration Manager 2012**, and then select **ConfigMgr Console**.|
||2. Switch to the Administration Overview page. Expand **Site Configuration** > **Servers and Site System Roles**. Select the primary site server (GTRCM12PRI1). Look for **Distribution point** located in the **Site System Roles** area, then right-click it and select **Properties** from the menu.<br/><br/>![screenshot of Servers and Site System Roles](./media/configure-operating-system-deployment/servers-and-site-system-roles.png)|
||3. On the **PXE** tab, select **Enable PXE support for clients, Allow this distribution point to respond to incoming PXE requests**, and **Enable unknown computer support**.<br/><br/>![screenshot of PXE tab on Distribution point Properties](./media/configure-operating-system-deployment/pxe-tab.png)|
|Configure the image properties|4. Move to the **Software library Overview** page. Expand **Operating Systems** and then **Boot Images**. Select **Boot image (x64)**. Right-click it and select **Properties** from the shortcut menu. On the **Data Source** tab, enable **Deploy this boot image from PXE service point**, and then select **Apply**.<br/><br/>![screenshot of Data Source tab on Boot image properties](./media/configure-operating-system-deployment/data-source-tab.png)<br/><br/>Complete the wizard to update the boot image. Repeat these steps for **Boot image (x86)**.|
|Copy both boot images to your DP on GTRCM12PRI1|5. Select both boot images, and then select **Distribute Content** from the bar at the top. Be sure you select the primary site server (GTRCM12PRI1) as the destination.<br/><br/>![screenshot of Content Destination](./media/configure-operating-system-deployment/content-destination.png)|
|Optional|Monitor the distmgr.log file on GTRCM12PRI1. Notice that PXE configuration occurs when the first boot image has been copied to the DP.<br/><br/>![screenshot of Configuration Manager Trace Log Tool](./media/configure-operating-system-deployment/configuration-manager-trace-log-tool.png)|
|||  

## Create a custom task sequence to capture an image

Here we will create a custom task sequence to capture an image from a client named GTRCM12WIN7B. After a successful capture, we will then use this image to reinstall a second client (GTRCM12XP1) with Windows 7.

|Task|Detailed Steps|
|---|---|
||Complete the following task on the CAS (GTRCM12CAS)|
|Start the Configuration Manager Console|1. On the **Start** menu, point to **All Programs**, point to **Microsoft System Center**, point to **Configuration Manager 2012**, and then select **ConfigMgr Console**. <br/><br/>**Note** The **System Center Configuration Manager Console** window appears and displays the Administration Overview page.|
||2. In the navigation pane, select **Software Library**. Expand **Operating Systems** and then select **Task Sequences**. Select **Create Task Sequence** from the bar at the top.<br/><br/>![screenshot of Create task sequence](./media/configure-operating-system-deployment/create-task-sequence.png)|
|Create a custom task sequence|1. Select **Create a new custom task sequence**.<br/><br/>![screenshot of Create a new custom task sequence](./media/configure-operating-system-deployment/create-a-new-custom-task-sequence.png)|
||2. Name it **Capture Reference Computer**, select **Boot Image (x86)**, and then finish the wizard.<br/><br/>![screenshot of Specify task sequence info](./media/configure-operating-system-deployment/specify-task-sequence-info.png)<br/><br/>3. Right-click **Capture Reference Computer** and select **Edit** from the shortcut menu.<br/><br/>![screenshot of Capture Reference Computer](./media/configure-operating-system-deployment/capture-reference-computer.png)|
||4. Select **Add** and select **New Group**. Name it **Capture Image**.<br/><br/>![screenshot of adding a new group](./media/configure-operating-system-deployment/add-a-new-group.png)<br/><br/>![screenshot of adding a new group named Capture Image](./media/configure-operating-system-deployment/name-a-new-group.png)<br/><br/>5. Add the following three steps from **Images** underneath your **Capture Image** group as shown in the following screenshot.<br/><br/>![screenshot of the new created group settings](./media/configure-operating-system-deployment/settings-of-new-added-group.png)<br/><br/>*Prepare ConfigMgr Client for Capture*<br/><br/>![screenshot of Prepare ConfigMgr Client for Capture](./media/configure-operating-system-deployment/prepare-configmgr-client-for-capture.png)|
|| *Prepare Windows for Capture* <br/><br/>![screenshot of Prepare Windows for Capture](./media/configure-operating-system-deployment/prepare-windows-for-capture.png)<br/><br/>*Capture Operating System Image* <br/><br/>![screenshot of Capture Operating System Image](./media/configure-operating-system-deployment/capture-operating-system-image.png)|
||6. Theoretically, we could use the task sequence to do the capture now. However, we should first make sure the target is not part of a domain. If it is, we will add a step to move the target computer to a workgroup.<br/><br/>![note icon](./media/configure-operating-system-deployment/icon-of-note.png)**NOTE**<br/> Systems that are part of a domain cannot be captured and your task sequence will fail!<br/><br/>7. Add another group, and name it Domain membership check.<br/><br/>![screenshot of adding a new group](./media/configure-operating-system-deployment/add-a-new-group.png)<br/><br/>![screenshot of naming a new created group](./media/configure-operating-system-deployment/name-a-new-created-group.png)<br/><br/><br/>8. Use the following WMI query to verify domain membership on the **Options** page.<br/><br/> `SELECT * from Win32_ComputerSystem WHERE Workgroup = NULL`<br/> <br/>![screenshot of Query WMI](./media/configure-operating-system-deployment/query-wmi.png)<br/>![screenshot of WMI Query properties](./media/configure-operating-system-deployment/wmi-query-properties.png)<br/>|
||Run the test, which should return an instance count of 1. This means that the current system (in our case the CAS named GTRCM12CAS) is member of a domain.<br/><br/>![screenshot of instance count of 1](./media/configure-operating-system-deployment/instance-count-of-1.png)<br/><br/>9. Add a final step to join the system to a workgroup.<br/><br/> **NOTE**<br/>The target system will restart after executing this task.<br/><br/>![screenshot of join domain or workgroup](./media/configure-operating-system-deployment/join-domain-or-workgroup.png)<br/><br/>![screenshot of joining a system to a workgroup](./media/configure-operating-system-deployment/join-to-a-workgroup.png)|
|Create a device collection|1. Select the **Assets and Compliance** workspace. In the navigation pane, select **Device Collections**. Select **Create Device Collection** from the bar at the top.<br/><br/>![screenshot of Device Collections](./media/configure-operating-system-deployment/device-collections.png)<br/><br/>2. Name it **Capture Image**.<br/><br/>![screenshot of specifying details for this collection](./media/configure-operating-system-deployment/specify-details-for-this-collection.png)|
||3. Add the reference computer (here it is the client GTRCM12WIN7B) as direct member, and then finish the wizard.<br/><br/>![screenshot of defining membership rules for this collection](./media/configure-operating-system-deployment/define-membership-rules-for-this-collection.png)|
|Deploy your task sequence to the new collection.|1. Right-click your new collection and select **Deploy** > **Task Sequence** from the shortcut menu. Click through the wizard and finish it.<br/><br/>![screenshot of specifying general info for deployment](./media/configure-operating-system-deployment/specify-general-information-for-this-deployment.png)|
|Log on to the reference computer (GTRCM12WIN7B) and run the task sequence|1. Log on to GTRCM12WIN7B.<br/><br/>![screenshot of installation status in software center](./media/configure-operating-system-deployment/installation-status.png)<br/><br/>Confirm and run the task sequence.<br/><br/>![Stop! Confirm operating system installation](./media/configure-operating-system-deployment/stop-confirm-operating-system-installation.png)<br/><br/>![screenshot of installation progress](./media/configure-operating-system-deployment/installation-progress.png)|
|||

## Create a configuration manager client package

In this exercise, we will create a Configuration Manager client package to use during operating system installations.

|Task|Detailed steps|
|---|---|
|| Complete the following tasks on the CAS (GTRCM12CAS) |
|Start the Configuration Manager Console|1. On the **Start** menu, point to **All Programs**, point to **Microsoft System Center**, point to **Configuration Manager 2012**, and then select **ConfigMgr Console**.<br/><br/>**NOTE**<br/>The System Center Configuration Manager Console window appears to display the Administration Overview page.|
|Create a package from Definition|2. In the navigation pane, select **Software Library**. Expand **Application Management**, and then select **Packages**. Select **Create Package from Definition** from the bar at the top.<br/><br/>![Create Package from Definition](./media/configure-operating-system-deployment/create-package-from-definition.png)|
||3. Select **Configuration Manager Client Upgrade 5.0**<br/><br/>![screenshot of specifying info about the package definition file to import](./media/configure-operating-system-deployment/specify-info-about-the-package-definition-file-to-import.png)|
||4. Select **Always obtain files source files from a source folder**.<br/><br/>![screenshot of specifying info about the package source files](./media/configure-operating-system-deployment/specify-info-about-the-package-source-files.png)|
||5. Specify the appropriate client source location. Here we will use \\\GTRCM12PRI1\sms_pr1\Client as our source location.<br/><br/>![screenshot of specifying the package source folder](./media/configure-operating-system-deployment/specify-the-package-source-folder.png)<br/><br/>Complete the wizard, and then distribute the content to your distribution points.|
|||  

## Create a task sequence to install your image

In this exercise, we will create a task sequence to install our new image to a client named GTRCM12XP1.

|Task|Detailed steps|
|---|---|
|| Complete the following tasks on the CAS (GTRCM12CAS) |
|Start the Configuration Manager Console|1. On the **Start** menu, point to **All Programs**, point to **Microsoft System Center**, point to **Configuration Manager 2012**, and then select **ConfigMgr Console**.<br/>**NOTE**<br/>The System Center Configuration Manager Console window appears to display the Administration Overview page.|
|Add your Operating System image|2. In the navigation pane, select **Software Library**. Expand **Operating Systems** and select **Operating System Images**. Select **Add Operating System Image** from the bar at the top.<br/><br/>![screenshot of Add Operating System Image](./media/configure-operating-system-deployment/operating-system-image.png)|
||3. Select the capture folder on the primary site server (here it is \\\GTRCM12PRI1\sources\mycapture.wim) as the data source. This is where we previously captured our image.<br/><br/>![screenshot of Browse to the data source for the operating system image](./media/configure-operating-system-deployment/browse-to-the-data-source.png)|
||4. Name your image, then complete the wizard and distribute it to your distribution points.<br/><br/>![screenshot of Type general info for the operating system image](./media/configure-operating-system-deployment/type-general-info.png)|
|Create a new task sequence to install your image|1. In the navigation pane, select **Software Library**. Expand **Operating Systems** and select **Task Sequences**. Select **Create Task Sequence** from the bar at the top.<br/><br/>![screenshot of creating a task sequence](./media/configure-operating-system-deployment/create-task-sequence.png)|
||2. Select **Install an existing image package**.<br/><br/>![screenshot of the Install an existing image package option](./media/configure-operating-system-deployment/install-an-existing-image-package-option.png)|
||3. Name your task sequence, and then select your **Boot Image (x86**).<br/><br/>![tip icon](./media/configure-operating-system-deployment/icon-of-tip.png)Tip: In this case, you can use either your x86 or x64 boot image. We aren't running an architecture-based setup.exe like we do when using an Operating System Install package.<br/><br/>![screenshot of Specify task sequence information](./media/configure-operating-system-deployment/specify-task-sequence-information.png)|
||4. Select your image, and then provide the administrator password used for that image.<br/><br/>![screenshot of Install the Windows operating system](./media/configure-operating-system-deployment/install-the-windows-operating-system.png)|
||5. Select **Join a domain**, and provide an appropriate domain account and password. This account should have **domain join** and **reset computer passwords** permissions.<br/><br/>![warning icon](./media/configure-operating-system-deployment/icon-of-warning.png) Warning: Never use a domain admin account to do this in production environments! You just need domain join permissions and the right to reset computer passwords.<br/><br/>![screenshot of Configure the network](./media/configure-operating-system-deployment/configure-the-network.png)|
||6. Select your Configuration Manager client package, and then provide your FSP as an installation parameter. Here, we will use our primary site server (FSP=GTRCM12PRI1).<br/><br/>![screenshot of Install the Configuration Manager client](./media/configure-operating-system-deployment/install-the-configuration-manager-client.png)|
||7. Clear the **This action will capture the user specific settings** check box.<br/><br/>![screenshot of Configure State Migration](./media/configure-operating-system-deployment/configure-state-migration.png)<br/><br/><br/>![tip icon](./media/configure-operating-system-deployment/icon-of-tip.png)Tip: Capture network settings will ensure that our custom network settings are reapplied during deployment.<br/><br/>Don't install updates or software, and then complete the wizard.|
|Create a new device collection|1. Select the **Assets and Compliance** workspace. In the navigation pane, select **Device Collections**. Select **Create Device Collection** from the bar at the top.<br/><br/>![screenshot of Device Collections](./media/configure-operating-system-deployment/device-collections.png)|
||2. Name the collection as **Windows 7 Enterprise x64**.<br/><br/>![screenshot of the General Settings of collection](./media/configure-operating-system-deployment/general-settings-of-collection.png)|
||3. Add our target computer (in this case GTRCM12XP1) as a direct member.<br/><br/>![screenshot of Define membership rules](./media/configure-operating-system-deployment/define-membership-rules.png)|
|Distribute the task sequence to this collection|1. Right-click your new collection, and then select **Deploy** > **Task Sequence** from the shortcut menu. Click through the wizard, and then finish.<br/><br/>![screenshot of distributing task sequence to collection](./media/configure-operating-system-deployment/distribute-task-sequence-to-collection.png)|
|Run the task sequence on GTRCM12XP1 to install the operating system image.|1. Log on to GTRCM12XP1, and then run the new task sequence to install your new operating system.<br/><br/>![Installation status of Win 7 Enterprise x64](./media/configure-operating-system-deployment/installation-status-of-win-7-enterprise-x64.png)<br/><br/>![STOP! Confirm operating system installation](./media/configure-operating-system-deployment/stop-confirm-operating-system-installation.png)<br/><br/>![screenshot of Installation progress of Win 7 Enterprise x64](./media/configure-operating-system-deployment/installation-progress-of-win-7-enterprise-x64.png)|
|||

## OSD task sequences known issues

- [You cannot stage a Windows PE 3.1 boot image to a Windows XP-based computer in Configuration Manager](https://support.microsoft.com/help/2910552)
- [Task sequence fails in Configuration Manager if software updates require multiple restarts](https://support.microsoft.com/help/2894518)
- [FIX: Task sequence to install an operating system doesn't run when you use custom port settings in System Center Configuration Manager 2012 SP1](https://support.microsoft.com/help/2838585)
- [An update is available for the "Operating System Deployment" feature of Configuration Manager](https://support.microsoft.com/help/2905002)

The above and a number of other issues with task sequences are addressed in [Description of Cumulative Update 1 for System Center 2012 R2 Configuration Manager](https://support.microsoft.com/help/2938441).
