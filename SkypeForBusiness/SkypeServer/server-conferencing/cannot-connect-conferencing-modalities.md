---
title: Cannot connect conference modalities after install Security Bulletin MS16-065
description: Describes an issue that prevents some clients from connecting to conferencing modalities after you install Security Bulletin MS16-065 in Lync Server 2010, Lync Server 2013, or Skype for Business Server 2015. Provides workarounds.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business Server 2015
  - Microsoft Lync 2013
  - Microsoft Lync 2010
ms.date: 03/31/2022
---

# Some clients can't connect to conferencing modalities after you install Security Bulletin MS16-065

## Symptoms

After you install the Microsoft .NET Framework Security Update MS16-065 on a Front End or Standard Edition server for Lync Server 2010, Lync Server 2013, or Skype for Business Server 2015, some internal clients can't connect to certain conferencing modalities.

**Notes**

- External clients that connect from outside your corporate network through Edge servers are not affected.   
- All clients can continue to join meetings, use instant messaging, see Presence information, and hear meeting audio.   
- This problem affects on-premises environments. This problem does not affect the Microsoft 365 Skype for Business Online service.   
For a complete list of the .NET Framework updates that can cause this problem, see the [Microsoft Security Bulletin MS16-065 - Important](/security-updates/SecurityBulletins/2016/ms16-065) topic on the Microsoft TechNet website. 

The following are the known modalities that are affected by this problem:

- Whiteboards   
- Uploading PowerPoint Presentations   
- Sharing Notes   
- Polls   
- Q&A   

The error messages that users may receive when this problem occurs include the following:

- **We can't connect to the server for presenting right now.**   
- **Network issues are keeping you from sharing notes and presenting whiteboards, polls and uploaded Pow…**   
- **An error occurred during the Skype Meeting.**   

## Cause

This problem occurs because an information disclosure vulnerability exists in the Transport Layer Security protocol and the Secure Sockets Layer protocol (TLS/SSL) as they are implemented in the encryption component of the Microsoft .NET Framework. An attacker who successfully exploits this vulnerability can decrypt encrypted TLS/SSL traffic.

This vulnerability is fixed by the security update that's discussed in [Microsoft Security Bulletin MS16-065](/security-updates/SecurityBulletins/2016/ms16-065). This update changes the way that the .NET Framework encryption component sends and receives encrypted network packets.

The changes that are introduced in this security update affect how Skype for Business; Lync desktop clients for PC; and Skype for Business for Crestron RL, Polycom CX8000, and SMART Room System communicate together with the Web Conferencing Service on the Front End and Standard Edition servers. These changes cause the problems that are mentioned in the "Symptoms" section.

## Resolution

### Manual downloads

Fixes are now available for the following MSI-based clients.

#### Lync 2010

- [June 2016 update for Lync 2010 (KB3171499) ](https://support.microsoft.com/help/3171499)
- [Description of the cumulative update for the Lync 2010 Attendee - Administrator level installation: June 2016 ](https://support.microsoft.com/help/3171502)
- [Description of the cumulative update for the Lync 2010 Attendee – User level installation: June 2016 ](https://support.microsoft.com/help/3171496)

#### Lync 2013 (Skype for Business)

- [June 7, 2016, update for Lync 2013 (Skype for Business) (KB3115033) ](https://support.microsoft.com/help/3115033)

#### Skype for Business 2016

- [June 7, 2016, update for Skype for Business 2016 (KB3115087) ](https://support.microsoft.com/help/3115087)

#### Skype for Business for Crestron RL, Polycom CX8000, and SMART Room System

- [Skype for Business August 2016 cumulative update for Crestron RL, Polycom CX8000, and SMART Room System (KB3193855)](https://support.microsoft.com/help/3193855)

#### Surface Hub

Fixed in [Windows 10 Team Anniversary Update 1607](https://www.microsoft.com/surface/support/surface-hub/surface-hub-update-history)

> [!NOTE]
> After further investigation, it has been determined Lync for Mac 2011 is not affected by this issue.

#### Click-to-Run installations

These fixes apply to the following Click-to-Run installations:

- Deferred Channel (DC): Office version 16.0.6741.2048 and later versions   
- All other channels: Office version 16.0.6965.2058 and later versions   
- Lync 2013 (Skype for Business): Builds 15.0.4833.1001 and later versions   
To update Lync 2013 (Skype for Business) immediately, see [Update Office 2013 or Microsoft 365](/officeupdates/update-history-office-2013).

To determine whether your Office installation is Click-to-Run or MSI-based, follow these steps:

1. Start an Office 2016 application.    
2. On the **File **menu, select **Account**.   
3. For Office 2016 Click-to-Run installations, an **Update Options **item is displayed. For MSI-based installations, the **Update Options **item isn't displayed.   

|Office 2016 Click-to-Run installation|MSI-based Office 2016|
|-|-|
|:::image type="content" source="./media/cannot-connect-conferencing-modalities/click-to-run.png" alt-text="Screenshot that shows the Word click to run installation option.":::|:::image type="content" source="./media/cannot-connect-conferencing-modalities/word-msi.png" alt-text="Screenshot that shows the Word M S I.":::|

> [!IMPORTANT]
> After the clients are updated, remove any previously installed workarounds in Lync Server 2013 and Skype for Business 2015. To do this, delete the added registry keys.

## Workaround

> [!WARNING]
> These workarounds may make a computer or a network more vulnerable to attack by malicious users or by malicious software such as viruses. We do not recommend these workarounds. However, we are providing this information so that you can implement these workarounds at your own discretion. Use these workarounds at your own risk.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To work around the conferencing modality connection issues in Lync Server 2010, Lync Server 2013, and Skype for Business 2015, you must add an application exception for the Web Conferencing Service (DATAMCUSVC.exe).
Use the following examples to set the exceptions in your environment. 

### Skype for Business Server 2015

1. Determine and record the path of DATAMCUSVC.exe on the server.

    **Note** By default, the installation path is as follows:

    C:\Program Files\Skype for Business Server 2015\Web Conferencing

    You can also obtain this information through the Services tool by reviewing the properties of the Skype for Business Server Web Conferencing service.

2. Start Registry Editor. To do this, click **Start**, click **Run**, type regedit, and then click **OK**.   
3. Locate the following registry subkey:

    **HKEY_LOCAL_MACHINE\Software\Microsoft\.NETFramework\v4.0.30319\System.Net.ServicePointManager.SchSendAuxRecord**

    > [!NOTE]
    > If you are proactively deploying the update in advance of applying the .NET Framework security update, you must create one or more keys manually because they do not yet exist.

4. Create the following DWORD name and value:

    DWORD Name: **Path_obtained_in_Step_1\DATAMCUSVC.exe**
    DWORD Value: **0**

    > [!IMPORTANT]
    > Do not include quotation marks in the DWORD name.

    The new DWORD name and value should resemble the following:

    DWORD Name: **C:\Program Files\Skype for Business Server 2015\Web Conferencing\DATAMCUSVC.exe**
    
    DWORD Value: **0**

5. Restart the Skype for Business Server Web Conferencing service (RTCDATAMCU).   
6. Users must log in again by using their Lync or Skype for Business desktop client in order to completely resolve the problem.   

### Lync Server 2013

1. Determine and record the path of DATAMCUSVC.exe on the server.

    **Note** By default, the installation path is the following:

    C:\Program Files\Microsoft Lync Server 2013\Web Conferencing

    You can also obtain this information through the Services tool by reviewing the properties of the Lync Server Web Conferencing service.

2. Start Registry Editor. To do this, click **Start**, click **Run**, type regedit, and then click **OK**.   
3. Locate the following registry subkey:

    **HKEY_LOCAL_MACHINE\Software\Microsoft\.NETFramework\v4.0.30319\System.Net.ServicePointManager.SchSendAuxRecord**

    > [!NOTE]
    > If you are proactively deploying the update in advance of applying the .NET Framework security update, you must create one or more keys manually because they do not yet exist.

4. Create the following DWORD name and value:

    DWORD Name: **Path_obtained_in_Step_1\DATAMCUSVC.exe**
    DWORD Value: **0**

    > [!IMPORTANT]
    > Do not include quotation marks in the DWORD name.

    The new DWORD name and value should resemble the following:
    
    DWORD Name: **C:\Program Files\Microsoft Lync Server 2013\Web Conferencing\DATAMCUSVC.exe**
    
    DWORD Value: **0**

5. Restart the Lync Server Web Conferencing Service (RTCDATAMCU).   
6. Users must log in again by using their Lync or Skype for Business desktop client in order to completely resolve the problem.   

### Lync Server 2010

1. Determine and record the paths of DATAMCUSVC.exe and MeetingMCUSvc.exe on the server.

    **Note** By default, the installation paths are the following:

    C:\Program Files\Microsoft Lync Server 2010\Web Conferencing\DATAMCUSVC.exe 

    C:\Program Files\Microsoft Lync Server 2010\OCSMCU\Web Meeting Conferencing\MeetingMCUSvc.exe

    You can also obtain this information through the Services tool by reviewing the properties of the Lync Server Web Conferencing Service.

2. Start Registry Editor. To do this, click **Start**, click **Run**, type regedit, and then click **OK**.   
3. Locate the following registry subkey:

    **HKEY_LOCAL_MACHINE\Software\Microsoft\.NETFramework\v2.0.50727\System.Net.ServicePointManager.SchSendAuxRecord**

    > [!NOTE]
    > If you are proactively deploying the update in advance of applying the .NET Framework security update, you must create one or more keys manually because they do not yet exist.

4. Create the following DWORD names and values: 

    DWORD Name: **Path_obtained_in_Step_1\DATAMCUSVC.exe**

    DWORD Value: **0**

    DWORD Name: **Path_obtained_in_Step_1\MeetingMCUSvc.exe**
    
    DWORD Value: **0**

    DWORD Name:  **C:\windows\system32\inetsrv\w3wp.exe**

    DWORD Value: **0**

    > [!IMPORTANT]
    > Do not include quotation marks in the DWORD name. The w3wp.exe path is case sensitive and should be all in lowercase.

    The new DWORD name and value should resemble the following for all three processes:

    DWORD Name: **C:\Program Files\Microsoft Lync Server 2010\Web Conferencing\DATAMCUSVC.exe**

    DWORD Value: **0**   
5. Restart the Lync Server Web Conferencing service (RTCDATAMCU).   
6. Run the following command as an administrator:

    ```powershell
    iisreset /noforce   
    ```
7. Users must log in again by using their Lync or Skype for Business desktop client in order to completely resolve the problem.   

**Notes**

- Lync Web App may not function correctly in a Lync Server 2010 environment. To reduce Lync Web App problems in Lync Server 2010, you must add an exception for the Lync Web App component (w3wp.exe).   
- For Lync Server 2010, Lync Web App still requires exceptions for the MeetingMCUSvc.exe and w3wp.exe service processes.   


##  References

To learn more about the MS16-065 Security Update, see the following article in the Microsoft Knowledge Base:

[3155464](https://support.microsoft.com/help/3155464) MS16-065: Description of the TLS/SSL protocol information disclosure vulnerability (CVE-2016-0149): May 10, 2016

For a complete list of related .NET Framework updates, see the [Microsoft Security Bulletin MS16-065 – Important](/security-updates/SecurityBulletins/2016/ms16-065) topic on the Microsoft TechNet website.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).