---
title: Error when you try to install a shared network printer
description: Describes an issue in which you can't install a shared network printer locally on a Windows Server 2003-based or a Windows XP SP1-based computer.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: yongrhee, v-jomcc, kaushika
ms.custom: sap:errors-and-troubleshooting-general-issues, csstroubleshoot
---
# Error message when you try to install a shared network printer

This article describes an issue where you can't install a shared network printer locally on a Windows Server or Windows-based computer.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 888046

## Symptoms

If you try to install a shared network printer, you experience symptoms if the following conditions are true:

- You have a shared network printer that is installed on a Microsoft Windows 2000 Advanced Server-based print server.
- You try to install the shared network printer locally on a computer that is part of a Windows domain.
- You try to install the shared network printer locally on a computer that is running one of the following operating systems:

  - Windows XP Service Pack 1 (SP1)
  - Windows Server 2003

In this scenario, you experience the following symptoms if you try to install a shared network printer:

- If you try to install the printer on a Windows XP SP1-based client by using the Add Printer Wizard or by using the printer share name from the *\\\PrintServerName\PrinterShareName* location, you receive the following error message:

    > A policy is in effect on your computer which prevents you from connecting to this print queue. Please contact your system administrator.

- If you use the Add Printer Wizard to try to install the printer on a Windows Server 2003-based client, you receive the following error message when you click **Finish** to complete the printer installation:

    > Unable to Install Printer. The printer driver is not compatible with a policy enabled on your computer that blocks Windows NT 4.0 drivers. If you want to use this driver, contact your system administrator about disabling this policy.

## Cause

This issue occurs if the printer driver that is installed on the print server is a third-party printer driver. You can't install a shared network printer that has a third-party printer driver locally on a Windows XP SP1-based computer if you're a regular user or a member of the Power Users group. Windows XP SP1 doesn't enable regular users or members of the Power Users group to install third-party drivers. In Windows XP SP1, only the following people have permission to install a third-party driver:

- Local administrator
- Members of the Administrators group
- Members of the Power Users group that have the Load and unload device drivers policy permissions

If the Windows XP SP1-based computer is joined to a Microsoft Windows NT 4.0-based domain, regular users and members of the Power Users group can install third-party printer drivers to the Windows XP SP1-based client computer. You may experience issues in installing a third-party printer driver on a Windows XP SP1-based computer if the Windows XP SP1-based computer is part of a workgroup or part of a Microsoft Windows 2000-based domain.

In Windows Server 2003, you can't install a shared network printer locally if the printer driver that is installed on the print server uses third-party kernel-mode printer drivers. A policy setting in Windows Server 2003 prevents users from installing printers that use third-party kernel-mode print drivers.

This issue may also occur if the following conditions are true:

- DNS reverse zone lookup isn't configured.
- DNS is configured incorrectly on the print server.
- DNS issues on the print server.

## Resolution

To resolve this issue, modify the Group Policy settings for the Group Policy object (GPO) that has printer policies defined for the domain users on the domain controller. To do this, use one of the following methods.

### Method 1

1. Configure the Load and unload device drivers policy setting for the Power Users group. To do this, follow these steps:
      1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
      2. In the navigation pane, right-click your domain name, and then click **Properties**.
      3. Click the **Group Policy** tab, click the GPO that you want to modify, and then click **Edit**.
      4. In Group Policy Object Editor, locate and then click the **Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment** folder.
      5. Locate and then double-click **Load and unload device drivers**.
      6. Click to select the **Define these policy settings** check box, and then click **Add User or Group to add the Power Users** domain group.
      7. In the **Add User or Group** dialog box, click **Browse to locate the Power Users** domain group. Under **Enter the object names to select**, type *Power Users*, and then click **Check Names** to resolve the group name. Click **OK** three times.
2. Turn off the Disallow installation of printers using kernel-mode drivers policy. To do this, follow these steps:
      1. In the left pane, locate and then click the **Computer Configuration\Administrative Templates\Printers** folder.
      2. Locate and then double-click **Disallow installation of printers using kernel-mode drivers**, click **Disabled**, and then click **OK**.
3. Disable the Point and Print Restrictions policy. To do this, follow these steps:
      1. In the left pane, locate and then click the **User Configuration\Administrative Templates\Control Panel\Printers** folder.
      2. Locate and then double-click **Point and Print Restrictions**, click **Disabled**, and then click **OK**.
4. On the **File** menu, click **Exit**.
5. Click **Start** > **Run**, type *cmd.exe*, and then click **OK**.
6. At the command prompt, type *gpupdate /force*, and then press ENTER.
7. Repeat steps 5 through 6 on the Windows XP SP1-based and Windows Server 2003-based client computers of the domain.

### Method 2

1. On the Windows Server 2003-based print server, click **Start** > **Run**, type *Cmd*, and then click **OK**.
2. At the command prompt, type *C:\\*, and then press ENTER.
3. Type *Cd\\*, and then press ENTER.
4. Type *Ipconfig /all*, and then press ENTER.
5. Write down the IP address of the print server computer.

    > [!NOTE]
    > The output for the `Ipconfig /all` command may resemble the following:
    >
    > Windows IP Configuration  
     Host Name . . . . . . . . . . . . : MachineName  
     Primary Dns Suffix . . . . . . . : `DomainName.com`  
     DNS Suffix Search List. . . . . . : `DomainName.com`  
    Ethernet adapter LAN:  
     IP Address. . . . . . . . . . . . : 169.0.0.10  
     Subnet Mask . . . . . . . . . . . : 255.255.252.0  
     DNS Servers . . . . . . . . . . . : 169.0.0.1
                                         169.0.0.2
                                         169.0.0.3  
6. On the Windows XP-based client computer, click **Start** > **Run**, type *Cmd*, and then click **OK**.
7. At the command prompt, type *C:\\*, and then press ENTER.
8. Type *Cd\\*, and then press ENTER.
9. Type *Nslookup **PrintServer_IP***, and then press ENTER.

    > [!NOTE]
    > **PrintServer_IP** is the IP address that you wrote down in step 5.
10. Make sure that the output of the NsLookup command contains the correct fully qualified domain name (FQDN) of the print server. If it is incorrect, you must contact the network administrator to resolve the DNS issue.

## More information

When you disable the Point and Print Restrictions policy that is located under **User Configuration\Administrative Templates\Control Panel\Printers**, users can use the Point and Print functionality to select any shared printer to which they have access.

### How to use the registry to set the Point and Print Restrictions policy

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

The Point and Print Restrictions policy can also be set under the following registry subkey:

`HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint`  
Value: InForest  
Type: REG_DWORD  
Data: 0 or 1  

A setting of 0 disables this entry. A setting of 1 restricts printer access to printers in the forest.

Value: Restricted  
Type: REG_DWORD  
Data: 0 or 1  

A setting of 0 disables this entry. A setting of 1 restricts all printers.

Value: TrustedServers  
Type: REG_DWORD  
Data: 0 or 1  

A setting of 0 disables this entry. A setting of 1 allows printers to appear in the server list dialog box.

For more information about printer installation related issues, click the following article number to view the article in the Microsoft Knowledge Base:

[282011](https://support.microsoft.com/help/282011) Printer driver is not compatible if a policy is enabled on your computer

### Technical support for x64-based versions of Microsoft Windows

If your hardware came with a Microsoft Windows x64 edition already installed, your hardware manufacturer provides technical support and assistance for the Windows x64 edition. In this case, your hardware manufacturer provides support because a Windows x64 edition was included with your hardware. Your hardware manufacturer might have customized the Windows x64 edition installation by using unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you need technical help with a Windows x64 edition. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware. If you purchased a Windows x64 edition such as a Microsoft Windows Server 2003 x64 edition separately, contact Microsoft for technical support.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
