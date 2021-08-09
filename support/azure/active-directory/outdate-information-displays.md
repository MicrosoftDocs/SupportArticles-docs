---
title: Azure AD Connect Health shows old information about on-premises server
description: Discusses an issue in which Azure AD Connect Health shows outdated information about the on-premises Azure AD Connect server. Provides a resolution.
ms.date: 05/28/2020
ms.prod-support-area-path: 
ms.reviewer: cychua, arrenc
---
# Azure AD Connect Health shows old information about on-premises Azure AD Connect server

This article discusses an issue in which Azure AD Connect Health shows outdated information about the on-premises Azure AD Connect server.

_Original product version:_ &nbsp; Azure Active Directory  
_Original KB number:_ &nbsp; 4053427

## Symptoms

Azure AD Connect Health blade no longer shows up-to-date information (for example, synchronization errors) about the on-premises Azure AD Connect server. In some cases, the Azure AD Connect Health Insight Service that is running on the Azure AD Connect server crashes and generates the following Windows Application event:

> Log Name: Application  
Source: Application Error  
Date: 10/19/2017 8:03:19 AM  
Event ID: 1000  
Task Category: (100)  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: XXXXXXX  
Description: Faulting application name: Microsoft.Identity.AadConnect.Health.AadSync.Host.exe, version: 3.0.68.0, time stamp: 0x5965450e Faulting module name: ntdll.dll, version: 6.3.9600.18696, time stamp: 0x59153753 Exception code: 0xc0000374 Fault offset: 0x00000000000f1c00 Faulting process id: 0x624 Faulting application start time: 0x01d348d2403fcb09 Faulting application path: C:\Program Files\Microsoft Azure AD Connect Health Sync Agent\Insights\Microsoft.Identity.AadConnect.Health.AadSync.Host.exe Faulting module path: C:\Windows\SYSTEM32\ntdll.dll Report Id: 7eb31450-b4c5-11e7-80cb-005056ba3ca2 Faulting package full name: Faulting package-relative application ID:

## Cause

The issue occurs if there is version mismatch between Azure AD Connect Synchronization Service and Azure AD Connect Health for Sync applications. This issue may occur if either component was not successfully upgraded during the last Azure AD Connect upgrade or auto-upgrade.

To verify that an existing Azure AD Connect server has a version compatibility issue between the two applications, follow these steps:

1. Get the version of the applications from the **Programs** item in Control Panel.

    :::image type="content" source="./media/old-information-on-premises-aad-connect-server/4053463_en_1.png" alt-text="Screenshot of Programs window.":::

2. Compare the version information against the following compatibility table:

    |Synchronization Service version|Compatible Health Agent version|
    |---|---|
    | 1.1.614.0 (or earlier version)| 3.0.68.0 (or earlier version) 3.0.127.0 |
    | 1.1.647.0 (or later version)| 3.0.103.0 3.0.129.0 |
    |||

## Resolution

To resolve this issue, use one of the following methods.

### Method 1

Manually upgrade your Azure AD Connect server to version 1.1.649.0 or a later version. During the manual upgrade, both applications will be upgraded to the versions that are compatible with each other.

For more information about how to upgrade Azure AD Connect server, see the following Azure article: [Azure AD Connect: Upgrade from a previous version to the latest](/azure/active-directory/connect/active-directory-aadconnect-upgrade-previous-version)

### Method 2

Manually reinstall Health Agent for Sync to a version that is compatible with the Synchronization Service version that is installed on the Azure AD Connect server. For example, you have an existing Azure AD Connect server that has Synchronization Service version 1.1.647.0 and Health Agent for Sync version 3.0.68.0. To resolve the incompatibility issue, you can reinstall Health Agent for Sync version 3.0.129.0.

To reinstall Health Agent for Sync:

1. Determine the version of Health Agent that is compatible with the version of Azure AD Connect Synchronization Service that you have installed:

    - If you have Azure AD Connect Synchronization Service version 1.1.614.0 (or an earlier version), use Health Agent Version 3.0.127.0.
    - If you have Azure AD Connect Synchronization Service version 1.1.647.0 (or a later version, use Health Agent Version 3.0.129.0.
2. Download a copy of the Health Agent installer (AadConnectHealthAadSyncSetup.exe) from the following Microsoft Download Center website, as appropriate:

    [Health Agent installer version 3.0.127.0](https://www.microsoft.com/download/details.aspx?id=56143)

    [Health Agent installer version 3.0.129.0](/azure/active-directory/hybrid/how-to-connect-install-roadmap#download-and-install-azure-ad-connect-health-agent)
3. Log on to the Azure AD Connect server by using an account that has Local Administrator rights.
4. To uninstall the existing version of Health Agent, follow these steps:

    1. Go to **Control Panel** > **Program and Features**. Select **Microsoft Azure AD Connect Health Agent for Sync**, and then select **Uninstall**.
        > [!NOTE]
        > This opens the setup window for the Health Agent.
    2. In the setup window for Health Agent, select **Uninstall**.
    3. After the uninstallation process finishes, select **Close**.

5. To install the compatible version of Health Agent:

   1. Double-click the downloaded executable file.
   2. On the **Setup** screen, select **Install**.
   3. After the installation finishes, select **Close**.
        > [!IMPORTANT]
        > Do not select **Configure**.
   4. Start a new PowerShell session. Register the installed Health Agent with Azure AD by running the following cmdlet:

        ```powershell
        Register-AzureADConnectHealthSyncAgent -AttributeFiltering:$false -StagingMode:$false
        ```

   5. When you are prompted for credentials, provide your Azure AD Global Admin credentials.
   6. Wait about two hours, and then verify that the Health panel is showing up-to-date information about Sync.
