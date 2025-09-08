---
title: Error CredSSP encryption oracle remediation when you try to RDP to a Windows VM in Azure
description: Fixes an issue that you receive a CredSSP encryption oracle remediation error when you try to RDP to a Windows VM in Azure.
ms.date: 08/25/2023
ms.reviewer: 
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:Cannot connect to my VM
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "aartigoyle" for triage before making the further changes to the screenshots.
--->

# Error when you try to RDP to a Windows VM in Azure: CredSSP encryption oracle remediation

**Applies to:** :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 4295591

This article provides a solution to an issue in which you are not able to connect to a virtual machine (VM) using RDP with error: CredSSP encryption oracle remediation.

[!INCLUDE [Feedback](../../../includes/feedback.md)]

## Symptoms

Consider the following scenario:

- The [Credential Security Support Provider protocol (CredSSP) updates for CVE-2018-0886](https://support.microsoft.com/help/4093492/credssp-updates-for-cve-2018-0886-march-13-2018) are applied to a Windows VM (remote server) in Microsoft Azure or on a local client.
- You try to make a remote desktop (RDP) connection to the server from the local client.

In this scenario, you receive the following error message:

> An authentication error has occurred. The function requested is not supported. Remote computer: \<computer name or IP>. This could be due to CredSSP encryption oracle remediation. For more information, see [https://go.microsoft.com/fwlink/?linkid=866660](https://go.microsoft.com/fwlink/?linkid=866660).

### How to verify that the CredSSP update is installed

Check the **update history** for the following updates, or check the version of TSpkg.dll that is located at `%systemroot%\system32`.

|Operating system|TSpkg.dll version with CredSSP update|CredSSP update|
|---|---|---|
|Windows 7 Service Pack 1 / Windows Server 2008 R2 Service Pack 1|6.1.7601.24117| [KB4103718 (Monthly Rollup)](https://support.microsoft.com/kb/4103718) |
| [KB4103712 (Security-only update)](https://support.microsoft.com/kb/4103712) |
|Windows Server 2012|6.2.9200.22432| [KB4103730 (Monthly Rollup)](https://support.microsoft.com/kb/4103730) |
| [KB4103726 (Security-only update)](https://support.microsoft.com/kb/4103726) |
|Windows 8.1 / Windows Server 2012 R2|6.3.9600.18999| [KB4103725 (Monthly Rollup)](https://support.microsoft.com/kb/4103725) |
| [KB4103715 (Security-only update)](https://support.microsoft.com/kb/4103715) |
|RS1 - Windows 10 Version 1607 / Windows Server 2016|10.0.14393.2248| [KB4103723](https://support.microsoft.com/kb/4103723) |
|RS2 - Windows 10 Version 1703|10.0.15063.1088| [KB4103731](https://support.microsoft.com/kb/4103731) |
|RS3 - Windows 10 1709|10.0.16299.431| [KB4103727](https://support.microsoft.com/kb/4103727) |
  
## Cause

This error occurs if you are trying to establish an insecure RDP connection, and the insecure RDP connection is blocked by an **Encryption Oracle Remediation** policy setting on the server or client. This setting defines how to build an RDP session by using CredSSP, and whether an insecure RDP is allowed.

The following table summarizes the behavior of RDP connection based on the CredSSP update status and CredSSP policy setting (**AllowEncryptionOracle** value):

|Server CredSSP update status|Client CredSSP update status|Force updated clients (0)|Mitigated (1)| Vulnerable (2)|
|---|---|---|---|---|
|Installed|No| Block  |  Allow<sup> **1** </sup>  |  Allow |
|No|Installed| Block<sup> **2** </sup>  |  Block |  Allow |
|Installed|Installed|Allow   |Allow   | Allow  |

**Examples**

<sup> **1** </sup> The server has the CredSSP update installed, and **Encryption Oracle Remediation** is set to **Mitigated** on the server side. The server will accpect the RDP connection from clients that do not have the CredSSP update installed.

<sup> **2** </sup> The client has the CredSSP update installed, and **Encryption Oracle Remediation** is set to **Force updated clients** or **Mitigated** on the client side. This client will cannot connect to a server that does not have the CredSSP update installed.
## Resolution

To resolve the issue, install CredSSP updates for both client and server so that RDP can be established in a secure manner. For more information, see [CVE-2018-0886 | CredSSP Remote Code Execution Vulnerability](https://portal.msrc.microsoft.com/security-guidance/advisory/CVE-2018-0886).

### How to install this update by using Azure Serial console

1. Sign in to the [Azure portal](https://portal.azure.com), select **Virtual Machine**, and then select the VM.
2. Scroll down to the **Help** section, and then click **Serial console**. The serial console requires Special Administrative Console (SAC) to be enabled within the Windows VM. If you do not see **SAC>** in the console (as shown in the following screenshot), go to the "[How to install this update by using Remote PowerShell](#how-to-install-this-update-by-using-remote-powershell)" section in this article.

    :::image type="content" source="media/credssp-encryption-oracle-remediation/connected-sac.svg" alt-text="Screenshot of connected SAC." border="false":::
  
3. Type `cmd` to start a channel that has a CMD instance.

4. Type `ch -si 1` to switch to the channel that is running the CMD instance. You receive the following output:

    :::image type="content" source="media/credssp-encryption-oracle-remediation/launch-cmd.svg" alt-text="Screenshot of launching CMD in SAC." border="false":::

5. Press Enter, and then enter your login credentials that have administrative permission.
6. After you enter valid credentials, the CMD instance opens, and you will see the command at which you can start troubleshooting.

    :::image type="content" source="media/credssp-encryption-oracle-remediation/cmd-section.svg" alt-text="Screenshot of CMD section in SAC." border="false":::

7. To start a PowerShell instance, type `PowerShell`.
8. In the PowerShell instance, [run the Serial console script](#azure-serial-console-scripts) based on the VM operating system. This script performs the following steps:

   - Create a folder in which to save the download file.
   - Download the update.
   - Install the update.
   - Add the vulnerability key to allow non-updated clients to connect to the VM.
   - Restart the VM

### How to install this update by using Remote PowerShell

1. On any Windows-based computer that has PowerShell installed, add the IP address of the VM to the "trusted" list in the host file, as follows:

    ```powershell
    Set-item wsman:\localhost\Client\TrustedHosts -value <IP>
    ```

2. In the Azure portal, configure **Network Security Groups** on the VM to allow traffic to port 5986.
3. In the Azure portal, select **Virtual Machine** > < **your VM** >, scroll down to the **OPERATIONS** section, click the **Run command**, and then run **EnableRemotePS**.
4. On the Windows-based computer, [run the Remote PowerShell script](#remote-powershell-scripts) for the appropriate system version of your VM. This script performs the following steps:
   - Connect to Remote PowerShell on the VM.
   - Create a folder to which to save the download file.
   - Download the Credssp update.
   - Install the update.
   - Set the vulnerability registry key to allow non-updated clients to connect to the VM.
   - Enable Serial Console for future and easier mitigation.
   - Restart the VM.

## Workaround

> [!WARNING]
> After you change the following setting, an unsecure connection is allowed that will expose the remote server to attacks. Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

### Scenario 1: Updated clients cannot communicate with non-updated servers

The most common scenario is that the client has the CredSSP update installed, and the **Encryption Oracle Remediation** policy setting doesn't allow an insecure RDP connection to a server that does not have the CredSSP update installed.

To work around this issue, follow these steps:

1. On the client that has the CredSSP update installed, run **gpedit.msc**, and then browse to **Computer Configuration** > **Administrative Templates** > **System** > **Credentials Delegation** in the navigation pane.
2. Change the **Encryption Oracle Remediation policy** to **Enabled**, and then change **Protection Level** to **Vulnerable**.

    If you cannot use gpedit.msc, you can make the same change by using the registry, as follows:

    1. Open a Command Prompt window as Administrator.
    2. Run the following command to add a registry value:

        ```console
        REG ADD HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters\ /v AllowEncryptionOracle /t REG_DWORD /d 2
        ```

### Scenario 2: Non-updated clients cannot communicate with patched servers

If the Azure Windows VM has this update installed, and it is restricted to receiving non-updated clients, follow these steps to change the **Encryption Oracle Remediation** policy setting:

1. On any Windows computer that has PowerShell installed, add the IP of the VM to the "trusted" list in the host file:

    ```powershell
    Set-item wsman:\localhost\Client\TrustedHosts -value <IP>
    ```

2. Go to the [Azure portal](https://portal.azure.com), locate the VM, and then update the **Network Security group** to allow PowerShell ports 5985 and 5986.
3. On the Windows computer, connect to the VM by using PowerShell:

   **For HTTP:**  

    ```powershell
    $Skip = New-PSSessionOption -SkipCACheck -SkipCNCheck Enter-PSSession -ComputerName "<<Public IP>>" -port "5985" -Credential (Get-Credential) -SessionOption $Skip
    ```

   **For HTTPS:**  

    ```powershell
    $Skip = New-PSSessionOption -SkipCACheck -SkipCNCheck Enter-PSSession -ComputerName "<<Public IP>>" -port "5986" -Credential (Get-Credential) -useSSL -SessionOption $Skip
    ```

4. Run the following command to change the **Encryption Oracle Remediation** policy setting by using the registry:

    ```powershell
    Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters' -name "AllowEncryptionOracle" 2 -Type DWord
    ```

## Azure Serial Console scripts

|OS Version|Script|
|---|---|
| Windows 7 Service Pack 1 / Windows Server 2008 R2 Service Pack 1|#Create a download location<br/>`md c:\temp`<br/><br/>##Download the KB file<br/>`$source = "http://download.windowsupdate.com/d/msdownload/update/software/secu/2018/05/windows6.1-kb4103718-x64_c051268978faef39e21863a95ea2452ecbc0936d.msu"`<br/>`$destination = "c:\temp\windows6.1-kb4103718-x64_c051268978faef39e21863a95ea2452ecbc0936d.msu"`<br/>`$wc = New-Object System.Net.WebClient`<br/>`$wc.DownloadFile($source,$destination)`<br/><br/>#Install the KB<br/>`expand -F:* $destination C:\temp\`<br/>`dism /ONLINE /add-package /packagepath:"c:\temp\Windows6.1-KB4103718-x64.cab"`<br/><br/>#Add the vulnerability key to allow unpatched clients<br/>`REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2`<br/><br/>#Restart the VM to complete the installations/settings<br/>`shutdown /r /t 0 /f`|
| Windows Server 2012|<br/>#Create a download location<br/> `md c:\temp`<br/><br/><br/>##Download the KB file<br/> `$source = "http://download.windowsupdate.com/d/msdownload/update/software/secu/2018/04/windows8-rt-kb4103730-x64_1f4ed396b8c411df9df1e6755da273525632e210.msu"`<br/> `$destination = "c:\temp\windows8-rt-kb4103730-x64_1f4ed396b8c411df9df1e6755da273525632e210.msu"`<br/> `$wc = New-Object System.Net.WebClient`<br/> `$wc.DownloadFile($source,$destination)`<br/><br/><br/> #Install the KB<br/> `expand -F:* $destination C:\temp\`<br/>`dism /ONLINE /add-package /packagepath:"c:\temp\Windows8-RT-KB4103730-x64.cab"`<br/><br/><br/> #Add the vulnerability key to allow unpatched clients<br/> `REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2`<br/><br/><br/> #Restart the VM to complete the installations/settings<br/> `shutdown /r /t 0 /f`<br/><br/>|
| Windows 8.1 / Windows Server 2012 R2|<br/>#Create a download location<br/> `md c:\temp`<br/><br/><br/>##Download the KB file<br/> `$source = "http://download.windowsupdate.com/d/msdownload/update/software/secu/2018/05/windows8.1-kb4103725-x64_cdf9b5a3be2fd4fc69bc23a617402e69004737d9.msu"`<br/> `$destination = "c:\temp\windows8.1-kb4103725-x64_cdf9b5a3be2fd4fc69bc23a617402e69004737d9.msu"`<br/> `$wc = New-Object System.Net.WebClient`<br/> `$wc.DownloadFile($source,$destination)`<br/><br/><br/> #Install the KB<br/> `expand -F:* $destination C:\temp\`<br/>`dism /ONLINE /add-package /packagepath:"c:\temp\Windows8.1-KB4103725-x64.cab"`<br/><br/><br/> #Add the vulnerability key to allow unpatched clients<br/> `REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2`<br/><br/><br/> #Restart the VM to complete the installations/settings<br/> `shutdown /r /t 0 /f`<br/><br/>|
| RS1 - Windows 10 version 1607 / Windows Server 2016|<br/>#Create a download location<br/> `md c:\temp`<br/><br/><br/> ##Download the KB file<br/> `$source = "http://download.windowsupdate.com/d/msdownload/update/software/secu/2018/05/windows10.0-kb4103723-x64_2adf2ea2d09b3052d241c40ba55e89741121e07e.msu"`<br/> `$destination = "c:\temp\windows10.0-kb4103723-x64_2adf2ea2d09b3052d241c40ba55e89741121e07e.msu"`<br/> `$wc = New-Object System.Net.WebClient`<br/> `$wc.DownloadFile($source,$destination)`<br/><br/><br/>#Install the KB<br/> `expand -F:* $destination C:\temp\`<br/>`dism /ONLINE /add-package /packagepath:"c:\temp\Windows10.0-KB4103723-x64.cab"`<br/><br/><br/> #Add the vulnerability key to allow unpatched clients<br/> `REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2`<br/><br/><br/> #Restart the VM to complete the installations/settings<br/> `shutdown /r /t 0 /f`<br/><br/>|
| RS2 - Windows 10 version 1703|<br/> #Create a download location<br/> `md c:\temp`<br/><br/><br/> ##Download the KB file<br/> `$source = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2018/05/windows10.0-kb4103731-x64_209b6a1aa4080f1da0773d8515ff63b8eca55159.msu"`<br/> `$destination = "c:\temp\windows10.0-kb4103731-x64_209b6a1aa4080f1da0773d8515ff63b8eca55159.msu"`<br/> `$wc = New-Object System.Net.WebClient`<br/> `$wc.DownloadFile($source,$destination)`<br/><br/><br/> #Install the KB<br/> `expand -F:* $destination C:\temp\`<br/>`dism /ONLINE /add-package /packagepath:"c:\temp\Windows10.0-KB4103731-x64.cab"`<br/><br/><br/> #Add the vulnerability key to allow unpatched clients<br/> `REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2`<br/><br/><br/>#Restart the VM to complete the installations/settings<br/> `shutdown /r /t 0 /f`<br/><br/>|
| RS3 - Windows 10 version 1709 / Windows Server 2016 version 1709|<br/>#Create a download location<br/> `md c:\temp`<br/><br/><br/> ##Download the KB file<br/> `$source = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2018/05/windows10.0-kb4103727-x64_c217e7d5e2efdf9ff8446871e509e96fdbb8cb99.msu"`<br/> `$destination = "c:\temp\windows10.0-kb4103727-x64_c217e7d5e2efdf9ff8446871e509e96fdbb8cb99.msu"`<br/> `$wc = New-Object System.Net.WebClient`<br/> `$wc.DownloadFile($source,$destination)`<br/><br/><br/> #Install the KB<br/> `expand -F:* $destination C:\temp\`<br/>`dism /ONLINE /add-package /packagepath:"c:\temp\Windows10.0-KB4103727-x64.cab"`<br/><br/><br/> #Add the vulnerability key to allow unpatched clients<br/> `REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2`<br/><br/><br/> #Restart the VM to complete the installations/settings<br/> `shutdown /r /t 0 /f`<br/><br/>|
| RS4 - Windows 10 1803 / Windows Server 2016 version 1803|<br/> #Create a download location<br/> `md c:\temp`<br/><br/><br/> ##Download the KB file<br/> `$source = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2018/05/windows10.0-kb4103721-x64_fcc746cd817e212ad32a5606b3db5a3333e030f8.msu"`<br/> `$destination = "c:\temp\windows10.0-kb4103721-x64_fcc746cd817e212ad32a5606b3db5a3333e030f8.msu"`<br/> `$wc = New-Object System.Net.WebClient`<br/> `$wc.DownloadFile($source,$destination)`<br/><br/><br/> #Install the KB<br/> `expand -F:* $destination C:\temp\`<br/>`dism /ONLINE /add-package /packagepath:"c:\temp\Windows10.0-KB4103721-x64.cab"`<br/><br/><br/> #Add the vulnerability key to allow unpatched clients<br/> `REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2`<br/><br/><br/> #Restart the VM to complete the installations/settings<br/> `shutdown /r /t 0 /f`<br/><br/>|
  
## Remote PowerShell scripts

| **OS Version**| **Script** |
|---|---|
| Windows 7 Service Pack 1 / Windows Server 2008 R2 Service Pack 1|<br/>#Set up your variables:<br/> `$subscriptionID = "<your subscription ID>"`<br/> `$vmname = "<IP of your machine or FQDN>"`<br/> `$PSPort = "5986"` #change this variable if you customize HTTPS on PowerShell to another port<br/><br/><br/> #​​​​Log in to your subscription<br/> `Add-AzureRmAccount`<br/> `Select-AzureRmSubscription -SubscriptionID $subscriptionID`<br/> `Set-AzureRmContext -SubscriptionID $subscriptionID`<br/><br/><br/> #Connect to Remote PowerShell<br/> `$Skip = New-PSSessionOption -SkipCACheck -SkipCNCheck`<br/> `Enter-PSSession -ComputerName $vmname -port $PSPort -Credential (Get-Credential) -useSSL -SessionOption $Skip`<br/><br/><br/> #Create a download location<br/> `md c:\temp`<br/><br/><br/> ##Download the KB file<br/> `$source = "http://download.windowsupdate.com/d/msdownload/update/software/secu/2018/05/windows6.1-kb4103718-x64_c051268978faef39e21863a95ea2452ecbc0936d.msu"`<br/> `$destination = "c:\temp\windows6.1-kb4103718-x64_c051268978faef39e21863a95ea2452ecbc0936d.msu"`<br/> `$wc = New-Object System.Net.WebClient`<br/> `$wc.DownloadFile($source,$destination)`<br/><br/><br/> #Install the KB<br/> `expand -F:* $destination C:\temp\`<br/>`dism /ONLINE /add-package /packagepath:"c:\temp\Windows6.1-KB4103718-x64.cab"`<br/><br/><br/> #Add the vulnerability key to allow unpatched clients<br/> `REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2`<br/><br/><br/> #Set up Azure Serial Console flags<br/> `cmd`<br/> `bcdedit /set {bootmgr} displaybootmenu yes`<br/> `bcdedit /set {bootmgr} timeout 5`<br/> `bcdedit /set {bootmgr} bootems yes`<br/> `bcdedit /ems {current} on`<br/> `bcdedit /emssettings EMSPORT:1 EMSBAUDRATE:115200`<br/><br/><br/> #Restart the VM to complete the installations/settings<br/> `shutdown /r /t 0 /f`<br/><br/>|
| Windows Server 2012|<br/> #Set up your variables:<br/> `$subscriptionID = "<your subscription ID>"`<br/> `$vmname = "<IP of your machine or FQDN>"`<br/> `$PSPort = "5986"` #change this variable if you customize HTTPS on PowerShell to another port<br/><br/><br/> #​​​​Log in to your subscription<br/> `Add-AzureRmAccount`<br/> `Select-AzureRmSubscription -SubscriptionID $subscriptionID`<br/> `Set-AzureRmContext -SubscriptionID $subscriptionID`<br/><br/><br/> #Connect to Remote PowerShell<br/> `$Skip = New-PSSessionOption -SkipCACheck -SkipCNCheck`<br/> `Enter-PSSession -ComputerName $vmname -port $PSPort -Credential (Get-Credential) -useSSL -SessionOption $Skip`<br/><br/><br/> #Create a download location<br/> `md c:\temp`<br/><br/><br/> ##Download the KB file<br/> `$source = "http://download.windowsupdate.com/d/msdownload/update/software/secu/2018/04/windows8-rt-kb4103730-x64_1f4ed396b8c411df9df1e6755da273525632e210.msu"`<br/> `$destination = "c:\temp\windows8-rt-kb4103730-x64_1f4ed396b8c411df9df1e6755da273525632e210.msu"`<br/> `$wc = New-Object System.Net.WebClient`<br/> `$wc.DownloadFile($source,$destination)`<br/><br/><br/> #Install the KB<br/> `expand -F:* $destination C:\temp\`<br/>`dism /ONLINE /add-package /packagepath:"c:\temp\Windows8-RT-KB4103730-x64.cab"`<br/><br/><br/> #Add the vulnerability key to allow unpatched clients<br/> `REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2`<br/><br/><br/> #Set up Azure Serial Console flags<br/> `cmd`<br/> `bcdedit /set {bootmgr} displaybootmenu yes`<br/> `bcdedit /set {bootmgr} timeout 5`<br/> `bcdedit /set {bootmgr} bootems yes`<br/> `bcdedit /ems {current} on`<br/> `bcdedit /emssettings EMSPORT:1 EMSBAUDRATE:115200`<br/><br/><br/> #Restart the VM to complete the installations/settings<br/> `shutdown /r /t 0 /f`<br/><br/>|
| Windows 8.1 / Windows Server 2012 R2|<br/> #Set up your variables:<br/> `$subscriptionID = "<your subscription ID>"`<br/> `$vmname = "<IP of your machine or FQDN>"`<br/> `$PSPort = "5986"` #change this variable if you customize HTTPS on PowerShell to another port<br/><br/><br/> #​​​​Log in to your subscription<br/> `Add-AzureRmAccount`<br/> `Select-AzureRmSubscription -SubscriptionID $subscriptionID`<br/> `Set-AzureRmContext -SubscriptionID $subscriptionID`<br/><br/><br/> #Connect to Remote PowerShell<br/> `$Skip = New-PSSessionOption -SkipCACheck -SkipCNCheck`<br/> `Enter-PSSession -ComputerName $vmname -port $PSPort -Credential (Get-Credential) -useSSL -SessionOption $Skip`<br/><br/><br/> #Create a download location<br/> `md c:\temp`<br/><br/><br/> ##Download the KB file<br/> `$source = "http://download.windowsupdate.com/d/msdownload/update/software/secu/2018/05/windows8.1-kb4103725-x64_cdf9b5a3be2fd4fc69bc23a617402e69004737d9.msu"`<br/> `$destination = "c:\temp\windows8.1-kb4103725-x64_cdf9b5a3be2fd4fc69bc23a617402e69004737d9.msu"`<br/> `$wc = New-Object System.Net.WebClient`<br/> `$wc.DownloadFile($source,$destination)`<br/><br/><br/> #Install the KB<br/> `expand -F:* $destination C:\temp\`<br/>`dism /ONLINE /add-package /packagepath:"c:\temp\Windows8.1-KB4103725-x64.cab"`<br/><br/><br/> #Add the vulnerability key to allow unpatched clients<br/> `REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2`<br/><br/><br/> #Set up Azure Serial Console flags<br/> `cmd`<br/> `bcdedit /set {bootmgr} displaybootmenu yes`<br/> `bcdedit /set {bootmgr} timeout 5`<br/> `bcdedit /set {bootmgr} bootems yes`<br/> `bcdedit /ems {current} on`<br/> `bcdedit /emssettings EMSPORT:1 EMSBAUDRATE:115200`<br/><br/><br/> #Restart the VM to complete the installations/settings<br/> `shutdown /r /t 0 /f`<br/><br/>|
| RS1 - Windows 10 version 1607 / Windows Server 2016|<br/> #Set up your variables:<br/> `$subscriptionID = "<your subscription ID>"`<br/> `$vmname = "<IP of your machine or FQDN>"`<br/> `$PSPort = "5986"` #change this variable if you customize HTTPS on PowerShell to another port<br/><br/><br/> #​​​​Log in to your subscription<br/> `Add-AzureRmAccount`<br/> `Select-AzureRmSubscription -SubscriptionID $subscriptionID`<br/> `Set-AzureRmContext -SubscriptionID $subscriptionID`<br/><br/><br/> #Connect to Remote PowerShell<br/> `$Skip = New-PSSessionOption -SkipCACheck -SkipCNCheck`<br/> `Enter-PSSession -ComputerName $vmname -port $PSPort -Credential (Get-Credential) -useSSL -SessionOption $Skip`<br/><br/><br/> #Create a download location<br/> `md c:\temp`<br/><br/><br/> ##Download the KB file<br/> `$source = "http://download.windowsupdate.com/d/msdownload/update/software/secu/2018/05/windows10.0-kb4103723-x64_2adf2ea2d09b3052d241c40ba55e89741121e07e.msu"`<br/> `$destination = "c:\temp\windows10.0-kb4103723-x64_2adf2ea2d09b3052d241c40ba55e89741121e07e.msu"`<br/> `$wc = New-Object System.Net.WebClient`<br/> `$wc.DownloadFile($source,$destination)`<br/><br/><br/> #Install the KB<br/> `expand -F:* $destination C:\temp\`<br/>`dism /ONLINE /add-package /packagepath:"c:\temp\Windows10.0-KB4103723-x64.cab"`<br/><br/><br/> #Add the vulnerability key to allow unpatched clients<br/> `REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2`<br/><br/><br/> #Set up Azure Serial Console flags<br/> `cmd`<br/> `bcdedit /set {bootmgr} displaybootmenu yes`<br/> `bcdedit /set {bootmgr} timeout 5`<br/> `bcdedit /set {bootmgr} bootems yes`<br/> `bcdedit /ems {current} on`<br/> `bcdedit /emssettings EMSPORT:1 EMSBAUDRATE:115200`<br/><br/><br/> #Restart the VM to complete the installations/settings<br/> `shutdown /r /t 0 /f`<br/><br/>|
| RS2 - Windows 10 version 1703|<br/> #Set up your variables:<br/> `$subscriptionID = "<your subscription ID>"`<br/> `$vmname = "<IP of your machine or FQDN>"`<br/> `$PSPort = "5986"` #change this variable if you customize HTTPS on PowerShell to another port<br/><br/><br/> #​​​​Log in to your subscription<br/> `Add-AzureRmAccount`<br/> `Select-AzureRmSubscription -SubscriptionID $subscriptionID`<br/> `Set-AzureRmContext -SubscriptionID $subscriptionID`<br/><br/><br/> #Connect to Remote PowerShell<br/> `$Skip = New-PSSessionOption -SkipCACheck -SkipCNCheck`<br/> `Enter-PSSession -ComputerName $vmname -port $PSPort -Credential (Get-Credential) -useSSL -SessionOption $Skip`<br/><br/><br/> #Create a download location<br/> `md c:\temp`<br/><br/><br/> ##Download the KB file<br/> `$source = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2018/05/windows10.0-kb4103731-x64_209b6a1aa4080f1da0773d8515ff63b8eca55159.msu"`<br/> `$destination = "c:\temp\windows10.0-kb4103731-x64_209b6a1aa4080f1da0773d8515ff63b8eca55159.msu"`<br/> `$wc = New-Object System.Net.WebClient`<br/> `$wc.DownloadFile($source,$destination)`<br/><br/><br/> #Install the KB<br/> `expand -F:* $destination C:\temp\`<br/>`dism /ONLINE /add-package /packagepath:"c:\temp\Windows10.0-KB4103731-x64.cab"`<br/><br/><br/> #Add the vulnerability key to allow unpatched clients<br/> `REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2`<br/><br/><br/> #Set up Azure Serial Console flags<br/> `cmd`<br/> `bcdedit /set {bootmgr} displaybootmenu yes`<br/> `bcdedit /set {bootmgr} timeout 5`<br/> `bcdedit /set {bootmgr} bootems yes`<br/> `bcdedit /ems {current} on`<br/> `bcdedit /emssettings EMSPORT:1 EMSBAUDRATE:115200`<br/><br/><br/> #Restart the VM to complete the installations/settings<br/> `shutdown /r /t 0 /f`<br/><br/>|
| RS3 - Windows 10 version 1709 / Windows Server 2016 version 1709|<br/> #Set up your variables:<br/> `$subscriptionID = "<your subscription ID>"`<br/> `$vmname = "<IP of your machine or FQDN>"`<br/> `$PSPort = "5986"` #change this variable if you customize HTTPS on PowerShell to another port<br/><br/><br/> #​​​​Log in to your subscription<br/> `Add-AzureRmAccount`<br/> `Select-AzureRmSubscription -SubscriptionID $subscriptionID`<br/> `Set-AzureRmContext -SubscriptionID $subscriptionID`<br/><br/><br/> #Connect to Remote PowerShell<br/> `$Skip = New-PSSessionOption -SkipCACheck -SkipCNCheck`<br/> `Enter-PSSession -ComputerName $vmname -port $PSPort -Credential (Get-Credential) -useSSL -SessionOption $Skip`<br/><br/><br/> #Create a download location<br/> `md c:\temp`<br/><br/><br/> ##Download the KB file<br/> `$source = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2018/05/windows10.0-kb4103727-x64_c217e7d5e2efdf9ff8446871e509e96fdbb8cb99.msu"`<br/> `$destination = "c:\temp\windows10.0-kb4103727-x64_c217e7d5e2efdf9ff8446871e509e96fdbb8cb99.msu"`<br/> `$wc = New-Object System.Net.WebClient`<br/> `$wc.DownloadFile($source,$destination)`<br/><br/><br/> #Install the KB<br/> `expand -F:* $destination C:\temp\`<br/>`dism /ONLINE /add-package /packagepath:"c:\temp\Windows10.0-KB4103727-x64.cab"`<br/><br/><br/> #Add the vulnerability key to allow unpatched clients<br/> `REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2`<br/><br/><br/> #Set up Azure Serial Console flags<br/> `cmd`<br/> `bcdedit /set {bootmgr} displaybootmenu yes`<br/> `bcdedit /set {bootmgr} timeout 5`<br/> `bcdedit /set {bootmgr} bootems yes`<br/> `bcdedit /ems {current} on`<br/> `bcdedit /emssettings EMSPORT:1 EMSBAUDRATE:115200`<br/><br/><br/> #Restart the VM to complete the installations/settings<br/> `shutdown /r /t 0 /f`<br/><br/>|
| RS4 - Windows 10 1803 / Windows Server 2016 version 1803|<br/> #Set up your variables:<br/> `$subscriptionID = "<your subscription ID>"`<br/> `$vmname = "<IP of your machine or FQDN>"`<br/> `$PSPort = "5986"` #change this variable if you customize HTTPS on PowerShell to another port<br/><br/><br/> #​​​​Log in to your subscription<br/> `Add-AzureRmAccount`<br/> `Select-AzureRmSubscription -SubscriptionID $subscriptionID`<br/> `Set-AzureRmContext -SubscriptionID $subscriptionID`<br/><br/><br/> #Connect to Remote PowerShell<br/> `$Skip = New-PSSessionOption -SkipCACheck -SkipCNCheck`<br/> `Enter-PSSession -ComputerName $vmname -port $PSPort -Credential (Get-Credential) -useSSL -SessionOption $Skip`<br/><br/><br/> #Create a download location<br/> `md c:\temp`<br/><br/><br/> ##Download the KB file<br/> `$source = "http://download.windowsupdate.com/c/msdownload/update/software/secu/2018/05/windows10.0-kb4103721-x64_fcc746cd817e212ad32a5606b3db5a3333e030f8.msu"`<br/> `$destination = "c:\temp\windows10.0-kb4103721-x64_fcc746cd817e212ad32a5606b3db5a3333e030f8.msu"`<br/> `$wc = New-Object System.Net.WebClient`<br/> `$wc.DownloadFile($source,$destination)`<br/><br/><br/> #Install the KB<br/> `expand -F:* $destination C:\temp\`<br/>`dism /ONLINE /add-package /packagepath:"c:\temp\Windows10.0-KB4103721-x64.cab"`<br/><br/><br/> #Add the vulnerability key to allow unpatched clients<br/> `REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2`<br/><br/><br/> #Set up Azure Serial Console flags<br/> `cmd`<br/> `bcdedit /set {bootmgr} displaybootmenu yes`<br/> `bcdedit /set {bootmgr} timeout 5`<br/> `bcdedit /set {bootmgr} bootems yes`<br/> `bcdedit /ems {current} on`<br/> `bcdedit /emssettings EMSPORT:1 EMSBAUDRATE:115200`<br/><br/><br/> #Restart the VM to complete the installations/settings<br/> `shutdown /r /t 0 /f`<br/><br/>|

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
