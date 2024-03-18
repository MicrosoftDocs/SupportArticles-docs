---
title: The installation of Lync 2010 will not complete using Windows Installer (MSI)
description: Lync 2010 IT Managed installations that use the Lync.msi Windows Installer method can fail. This issue can be fixed by implementing the UseMSIForLyncInstallation Lync 2010 Group Policy setting.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: v-six
appliesto: 
  - Lync 2010
ms.date: 03/31/2022
---

# The installation of Lync 2010 will not complete using Windows Installer (MSI)

## Symptoms

You may experience one or more of the following symptoms:

- A local Windows Installer (MSI) installation for Microsoft Lync 2010 will not complete, and the following warning is displayed in the Microsoft Lync 2010 Setup dialog box:

    **Microsoft Lync 2010 must be installed by running the appropriate Lync setup executable**   
- The Active Directory Domain Services (AD DS) Software Installation Group Policy setting for MSI deployment methods will not complete when Lync.msi is deployed to supported Windows clients.   
- The Microsoft Systems Management Server (SMS) 2003 or Configuration Manager 2007 R2 automated deployments of the Lync.msi may not complete, or errors that are specific to the SMS environment or to the Configuration Manager environment may occur.   

## Cause

The Lync 2010 client must be installed by using the client executable file.

> [!NOTE]
> The initial installation of Lync 2010 on a supported Windows client creates the Lync.msi file in the following locations:

- %program files%\OCSetup   
- %program files(x86)%\OCSetup    

The Lync.msi file can be used to deploy the Lync 2010 client by using the local and automated deployment methods that are described in the "Symptoms" section.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: 
> 
> [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

Use the Lync 2010 UseMSIForLyncInstallation Group Policy setting to enable or block MSI deployments for Lync.msi as follows: 

```AsciiDoc
Name: UseMSIForLyncInstallation
Default: 0
Range: 1 or 0
Registry Location: HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Communicator
```

To enable MSI deployments for Lync.msi, follow these steps:

1. Click **Start**, click **Run**, type regedit, and then click **OK**.   
2. Locate and then click the following registry subkey:

    **HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Communicator**
1. On the **Edit** menu, point to **New**, and then click ** DWORD Value**.   
1. Type UseMSIForLyncInstallation, and then press ENTER to name the registry entry.   
1. Right-click **UseMSIForLyncInstallation**, and then click **Modify**.   
1. In the **Value data** box, type 1 if that value is not already displayed, and then click **OK**.   
1. Exit Registry Editor.   
1. Restart the Windows client.   

> [!NOTE]
> The Microsoft Windows Installer Tool (msiexec) should be used with at least the following parameters to ensure that the re-installation of Lync 2010 does not occur each time Lync 2010 is launched:

```powershell
C:\Lync2010\>msiexec /i C:\Lync2010\Lync.msi OCSETUPDIR="C:\Program Files\Microsoft Lync"
```

#### Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus/).

## More Information

The definition of the UseMSIForLyncInstallation Lync 2010 Group Policy setting is not included in the Communicator.adm file.

For detailed information about how to automate the Lync 2010 deployment methods, visit the following Microsoft TechNet website:

[IT-Managed Installation of Lync 2010](/previous-versions/office/skype-server-2010/gg425733(v=ocs.14))

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).