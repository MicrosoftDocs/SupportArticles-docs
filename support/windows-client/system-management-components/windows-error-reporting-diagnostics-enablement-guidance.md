---
title: Windows Error Reporting and Windows diagnostics enablement guidance
description: Provides guidance on configuring Windows Error Reporting and Windows Telemetry.
ms.date: 02/16/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
ms.subservice: system-mgmgt-components
ms.custom: sap:wer, csstroubleshoot
localization_priority: medium
ms.reviewer: kaushika, sangar, plingadevaru, v-lianna
---
# Windows Error Reporting and Windows diagnostics enablement guidance

This article provides guidance on Windows Error Reporting (WER) and diagnostic data. WER is an event-based feedback infrastructure designed to collect information on issues that Windows can detect, report the information to Microsoft, and provide users with any available solutions.

## Enable Windows Error Reporting (WER)

1. Expand **Policies** under **Computer Configuration** in **Group Policy Management Editor** (*gpmc.msc*).

    > [!TIP]
    > Admins creating Group Policy Objects (GPOs) should be part of the Group Policy Creator Owners group in Active Directory (AD) or Domain/Enterprise Administrators.

    :::image type="content" source="media/windows-error-reporting-diagnostics-enablement-guidance/group-policy-management-editor-wer-policy.png" alt-text="Screenshot of Group Policy Management Editor with the Policies folder under Computer Configuration.":::

2. Go to **Computer Configuration** > **Administrative Template** > **System** > **Internet Communication Management** > **Internet Communication Settings**.
3. Double-click the **Turn off Windows Error Reporting** policy.
4. Select **Disabled** > **Apply** > **OK**.

    :::image type="content" source="media/windows-error-reporting-diagnostics-enablement-guidance/turn-off-windows-error-reporting.png" alt-text="Screenshot of the Turn off Windows Error Reporting window with Disabled selected.":::

5. Go to **Computer Configuration** > **Administrative Template** > **Windows Components** > **Windows Error Reporting**.
6. Double-click the **Disable Windows Error Reporting** policy.
7. Select **Disabled** > **Apply** > **OK**.

## Configure Windows diagnostic data

Expand **Policies** under **Computer Configuration** in **Group Policy Management Editor** (*gpmc.msc*).

:::image type="content" source="media/windows-error-reporting-diagnostics-enablement-guidance/group-policy-management-editor-wer-policy.png" alt-text="Screenshot of Group Policy Management Editor with the Policies folder under Computer Configuration.":::

Perform the following steps depending on the OS version:

### For Windows 11

1. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Data Collection and Preview Builds**.
2. Double-click the **Allow Diagnostic Data** policy.
3. Select **Enabled**, and then select the **Send optional diagnostic data** option from the **Options** drop-down list.

    :::image type="content" source="media/windows-error-reporting-diagnostics-enablement-guidance/allow-diagnostic-data.png" alt-text="Screenshot of the Allow Diagnostic Data window with the Send optional diagnostic data option selected.":::

    For more information about the level of data sent, see [Diagnostics, feedback, and privacy in Windows](https://support.microsoft.com/windows/diagnostics-feedback-and-privacy-in-windows-28808a2b-a31b-dd73-dcd3-4559a5199319).

4. Select **Apply** > **OK**.
5. Double-click the **Configure diagnostic data opt-in settings user interface** policy.
6. Select **Enabled**, and then select the **Disable diagnostic data opt-in settings** option from the **Options** drop-down list.

    :::image type="content" source="media/windows-error-reporting-diagnostics-enablement-guidance/configure-diagnostic-data-opt-in-settings-user-interface.png" alt-text="Screenshot of the Configure diagnostic data opt-in settings user interface window with Enabled selected.":::

7. Select **Apply** > **OK**.

### For Windows 10

1. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Data Collection and Preview Builds**.
2. Double-click the **Allow Telemetry** policy.
3. Select **Enabled**.
4. From the **Options** drop-down list, select:

   - **Optional** for Windows 10, version 1903 or later
   - **Full** for Windows 10, version 1809 or earlier

    |Windows 10, version 1903 or later  |Windows 10, version 1809 or earlier  |
    |---------|---------|
    |:::image type="content" source="media/windows-error-reporting-diagnostics-enablement-guidance/allow-telemetry-windows-optional.png" alt-text="Screenshot of the Allow Telemetry window with Optional option selected." lightbox="media/windows-error-reporting-diagnostics-enablement-guidance/allow-telemetry-windows-optional.png":::     |:::image type="content" source="media/windows-error-reporting-diagnostics-enablement-guidance/allow-telemetry-windows-full.png" alt-text="Screenshot of the Allow Telemetry window with Full option selected." lightbox="media/windows-error-reporting-diagnostics-enablement-guidance/allow-telemetry-windows-full.png":::         |

   > [!NOTE]  
   > Select at least the **Enhanced** option so that we can have enough actionable insights for Windows 10, version 1903 or later. For more information about the level of data collected, see [Diagnostic data settings](/windows/privacy/configure-windows-diagnostic-data-in-your-organization#diagnostic-data-settings).

5. Select **Apply** > **OK**.

    The following steps require at least Windows 10, version 1803.

6. Double-click the **Configure telemetry opt-in setting user interface** policy.
7. Select **Enabled**, and then select the **Disable telemetry opt-in Settings** option from the **Options** drop-down list.

    :::image type="content" source="media/windows-error-reporting-diagnostics-enablement-guidance/configure-telemetry-opt-in-setting-user-interface.png" alt-text="Screenshot of the Configure telemetry opt-in setting user interface window with the Disable telemetry opt-in Settings option selected.":::

8. Select **Apply** > **OK**.

## Configure network endpoints to be allowed

The following table lists the network endpoints related to how you can manage the collection and control of diagnostic data.

- Port used: 443
- Protocol used: HTTPS with SSL/TLS using certificate pinning

| Windows versions | Endpoint |
|---------|---------|
| All Windows versions | watson.microsoft.com |
| Windows 10, version 1803 or later | watson.telemetry.microsoft.com |
| Windows 10, version 1809 or later | umwatsonc.events.data.microsoft.com |
| Windows 10, version 1809 or later | ceuswatcab01.blob.core.windows.net |
| Windows 10, version 1809 or later | ceuswatcab02.blob.core.windows.net |
| Windows 10, version 1809 or later | eaus2watcab01.blob.core.windows.net |
| Windows 10, version 1809 or later | eaus2watcab02.blob.core.windows.net |
| Windows 10, version 1809 or later | weus2watcab01.blob.core.windows.net |
| Windows 10, version 1809 or later | weus2watcab02.blob.core.windows.net |

For more information, see [Configure Windows diagnostic data](/windows/privacy/configure-windows-diagnostic-data-in-your-organization).

## Limit additional data from being sent to Microsoft (Optional)

If the policies described in the article are enabled, Windows Error Reporting will send only kernel mini dumps and user mode triage dumps.

If you enable **Optional** data through Telemetry and want to control the type of dump information shared with Microsoft, you can use the following policies. These policies allow you to limit the types of [crash dumps](/windows/win32/dxtecharts/crash-dump-analysis).

For Windows 11 and Windows 10 (version 1909 and later):

1. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Data Collection and Preview Builds**.
2. Double-click the **Limit Dump Collection** policy.

    :::image type="content" source="media/windows-error-reporting-diagnostics-enablement-guidance/limit-dump-collection.png" alt-text="Screenshot of the Limit Dump Collection window with Enabled selected.":::

3. Select **Enabled** > **Apply** >**OK**.
4. Double-click the **Limit Diagnostic Log Collection** policy.
5. Select **Enabled** > **Apply** > **OK**.

    :::image type="content" source="media/windows-error-reporting-diagnostics-enablement-guidance/limit-diagnostic-log-collection.png" alt-text="Screenshot of the Limit Diagnostic Log Collection window with Enabled selected.":::

For more information, see [Configure types of dump to be collected](/windows/win32/wer/collecting-user-mode-dumps).

## Validate the correct data setting checklist

Your group policy object will have the following settings configured:

:::image type="content" source="media/windows-error-reporting-diagnostics-enablement-guidance/computer-configuration-enabled.png" alt-text="Screenshot of all the group policy object settings.":::

After you've applied the above-mentioned settings to the Organizational Unit, check the following items by using Registry Editor (*Regedit.exe*), and ensure the settings are configured and applied as desired on one of the machines:

- `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection`

    |Registry Key Name  |Data  |
    |---------|---------|
    |`AllowTelemetry`     |0x00000003         |
    |`DisableTelemetryOptInSettingsUx`     |0x00000001         |
    |`LimitDiagnosticLogCollection`     |0x00000001         |
    |`LimitDumpCollection`     |0x00000001         |

- `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting`

  - **Registry Key Name**: `DoReport`
  - **Data**: 0x00000001

- `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting`

    |Registry Key Name  |Data  |
    |---------|---------|
    |`Disabled`     |0x00000000         |
    |`DontSendAdditionalData`     |0x00000001         |

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Consent`

  - **Registry Key Name**: `DefaultConsent`
  - **Data**: 0x00000004

## Gather key information before contacting Microsoft support

1. Download [TSS](https://aka.ms/getTSS) on all nodes and unzip it in the *C:\\tss* folder.
2. Open the *C:\\tss* folder from an elevated PowerShell command prompt.
3. Start the following traces on the problem computer by using the following cmdlets:

    ```powershell
    TSS.ps1 -SDP PERF,SETUP
    ```

    ```PowerShell
    TSS.ps1 -Scenario NET_WFP
    ```

4. Respond to the EULA prompt.
5. Wait until the automated scripts finish collecting the required data.

The traces will be stored in a zip file in the *C:\\MS_DATA\\SDP_PERFSETUP\\* folder, which can be uploaded to the Microsoft workspace for analysis.
