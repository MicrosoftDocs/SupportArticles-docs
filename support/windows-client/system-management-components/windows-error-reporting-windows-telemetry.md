---
title: Setup and troubleshooting guidance on Windows Error Reporting and Windows Telemetry
description: Provides guidance on configuring Windows Error Reporting and Windows Telemetry.
ms.date: 01/12/2023
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
ms.technology: windows-client-system-management-components
ms.custom: sap:wer, csstroubleshoot
localization_priority: medium
ms.reviewer: kaushika
---
# Setup and troubleshooting guidance on Windows Error Reporting and Windows Telemetry

This article provides guidance on Windows Error Reporting (WER) and diagnostic data (Telemetry). WER is an event-based feedback infrastructure designed to gather information on issues that Windows can detect, report the information to Microsoft, and provide users with any available solutions.

## Enable Windows Error Reporting (WER)

1. Expand **Policies** under **Computer Configuration** in **Group Policy Management Editor** (*gpmc.msc*).

    > [!TIP]
    > Admins creating Group Policy Objects (GPOs) should be part of the Group Policy Creator Owners group in Active Directory (AD) or Domain/Enterprise Administrators.

    :::image type="content" source="media/windows-error-reporting-windows-telemetry/group-policy-management-editor-wer-policy.png" alt-text="Screenshot of Group Policy Management Editor with the Policies folder under Computer Configuration.":::

2. Go to **Computer Configuration** > **Administrative Template** > **System** > **Internet Communication Management** > **Internet Communication Settings**.
3. Double-click the **Turn off Windows Error Reporting** policy.
4. Select **Disabled** > **Apply** > **OK**.

    :::image type="content" source="media/windows-error-reporting-windows-telemetry/turn-off-windows-error-reporting.png" alt-text="Screenshot of the Turn off Windows Error Reporting window with Disabled selected.":::

5. Go to **Computer Configuration** > **Administrative Template** > **Windows Components** > **Windows Error Reporting**.
6. Double-click the **Disable Windows Error Reporting** policy.
7. Select **Disabled** > **Apply** > **OK**.

## Configure Windows diagnostic data (Telemetry)

Expand **Policies** under **Computer Configuration** in **Group Policy Management Editor** (*gpmc.msc*).

:::image type="content" source="media/windows-error-reporting-windows-telemetry/group-policy-management-editor-wer-policy.png" alt-text="Screenshot of Group Policy Management Editor with the Policies folder under Computer Configuration.":::

Follow below steps depending on the OS version:

### For Windows 11

1. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Data Collection and Preview Builds**.
2. Double-click the **Allow Diagnostic Data** policy.
3. Select **Enabled** and select the **Send optional diagnostic data** option from the **Options** drop-down list.

    :::image type="content" source="media/windows-error-reporting-windows-telemetry/allow-diagnostic-data.png" alt-text="Screenshot of the Allow Diagnostic Data window with the Send optional diagnostic data option selected.":::

    For more information about the level of data being sent, see [Diagnostics, feedback, and privacy in Windows](https://support.microsoft.com/windows/diagnostics-feedback-and-privacy-in-windows-28808a2b-a31b-dd73-dcd3-4559a5199319).

4. Select **Apply** > **OK**.
5. Double-click the **Configure diagnostic data opt-in settings user interface** policy.
6. Select **Enabled**, and select the **Disable diagnostic data opt-in settings** option from the **Options** drop-down list.

    :::image type="content" source="media/windows-error-reporting-windows-telemetry/configure-diagnostic-data-opt-in-settings-user-interface.png" alt-text="Screenshot of the Configure diagnostic data opt-in settings user interface window with Enabled selected.":::

7. Select **Apply** > **OK**.

### For Windows 10

1. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Data Collection and Preview Builds**.
2. Double-click the **Allow Telemetry** policy.
3. Select **Enabled**.
4. From the **Options** drop-down list select:

   - **Optional** for Windows 10, version 1903 or later
   - **Full** for Windows 10, version 1809 or earlier

    |Windows 10, version 1903 or later  |Windows 10, version 1809 or earlier  |
    |---------|---------|
    |:::image type="content" source="media/windows-error-reporting-windows-telemetry/allow-telemetry-windows-optional.png" alt-text="Screenshot of the Allow Telemetry window with Optional option selected.":::     |:::image type="content" source="media/windows-error-reporting-windows-telemetry/allow-telemetry-windows-full.png" alt-text="Screenshot of the Allow Telemetry window with Full option selected.":::         |

   > [!NOTE]  
   > Choose a minimum of **Enhanced** so that we can have enough actionable insights (for Windows 10,version 1903 or later. For more information about the level of data collected, see [Diagnostic data settings](/windows/privacy/configure-windows-diagnostic-data-in-your-organization#diagnostic-data-settings).

5. Select **Apply** > **OK**.

    The following steps require a minimum of Windows 10, version 1803.

6. Double-click the **Configure telemetry opt-in setting user interface** policy.
7. Select **Enabled**, and select the **Disable telemetry opt-in Settings** option from the **Options** drop-down list.

    :::image type="content" source="media/windows-error-reporting-windows-telemetry/configure-telemetry-opt-in-setting-user-interface.png" alt-text="Screenshot of the Configure telemetry opt-in setting user interface window with the Disable telemetry opt-in Settings option selected.":::

8. Select **Apply** > **OK**.

## Configure network endpoints to be allowed

The following table lists the network endpoints related to how you can manage the collection and control of diagnostic data.

- Port used: 443
- Protocol used: Https with SSL/TLS using certificate pinning

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

If the policies that are described in the article are enabled, Windows Error Reporting will send only kernel mini dumps and user mode triage dumps.

If you enable **Optional** data through Telemetry and want to control the type of dump information being shared with Microsoft, you can leverage the following policies. These policies allow you to limit the types of [crash dumps](/windows/win32/dxtecharts/crash-dump-analysis).

For Windows 11 and Windows 10 (version 1909 and later):

1. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Data Collection and Preview Builds**.
2. Double-click the **Limit Dump Collection** policy.

    :::image type="content" source="media/windows-error-reporting-windows-telemetry/limit-dump-collection.png" alt-text="Screenshot of the Limit Dump Collection window with Enabled selected.":::

3. Select **Enabled** > **Apply** >**OK**.
4. Double-click the **Limit Diagnostic Log Collection** policy.
5. Select **Enabled** > **Apply** > **OK**.

    :::image type="content" source="media/windows-error-reporting-windows-telemetry/limit-diagnostic-log-collection.png" alt-text="Screenshot of the Limit Diagnostic Log Collection window with Enabled selected.":::

For more information, see [Configure types of dump to be collected](/windows/win32/wer/collecting-user-mode-dumps).

## Validate the correct data setting checklist

Your group policy object will have the following settings configured:

:::image type="content" source="media/windows-error-reporting-windows-telemetry/computer-configuration-enabled.png" alt-text="Screenshot of all the group policy object settings.":::

After you have applied the above mentioned settings to the Organizational Unit, check the following items by using Registry Editor (*Regedit.exe*) to ensure the settings are configured and applied as desired on one of the machines:

- `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection`

    |Registry Key Name  |Data  |
    |---------|---------|
    |AllowTelemetry     |0x00000003         |
    |DisableTelemetryOptInSettingsUx     |0x00000001         |
    |LimitDiagnosticLogCollection     |0x00000001         |
    |LimitDumpCollection     |0x00000001         |

- `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting`

  - **Registry Key Name**: DoReport
  - **Data**: 0x00000001

- `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting`

    |Registry Key Name  |Data  |
    |---------|---------|
    |Disabled     |0x00000000         |
    |DontSendAdditionalData     |0x00000001         |

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Consent`

  - **Registry Key Name**: DefaultConsent
  - **Data**: 0x00000004

## Diagnosing Windows Error Reporting problems

You've completed the previous steps, but your Microsoft contact reports that Watson data isn't received by the Microsoft Watson service. Follow these steps:

1. Download the [CrashMe](http://windbg.info/apps/46-crashme.html) tool and unzip it on the test device. This utility allows you to force a crash on the test device to trigger the Windows Error Reporting system.
2. Test the crash and reporting.

    1. In Windows Explorer, go to *C:\\ProgramData\\Microsoft\\Windows\\WER\\ReportArchive*.
    2. Start the *CrashMe.exe* tool.
    3. Select the **Division By Null** button to trigger a crash of the CrashMe app.
    4. Once the CrashMe app has crashed (closed), go back to the *ReportArchive* folder from Step a, and check whether a new crash report has been created in this folder. It should look similar to the following:

        :::image type="content" source="media/windows-error-reporting-windows-telemetry/crashme-new-crash-report.png" alt-text="Screenshot of a new crash report showing under the ReportArchive folder.":::

        > [!NOTE]
        > If a new crash report is generated in Step d, it indicates that the Windows Error Reporting process works correctly on this device, although it doesn't guarantee that the report is actually received by Microsoft. Ask your Microsoft contact to confirm that crash reports have been received in the Watson system.
        >
        > If the crash report isn't generated in Step d, or if your Microsoft contact doesn't see any Watson crashes for your tenant, check your settings to ensure that they are correct. If all settings are set correctly, ask your Microsoft contact for assistance.

        > [!IMPORTANT]
        > Steps 3-5 are only supported if you have been asked by your Microsoft contact to perform them for deeper troubleshooting.

3. Select the WER folder (and contents) from here and download to a convenient directory on the device being tested.
4. Capture the Windows Telemetry settings.
    1. Open an elevated command prompt.
    2. Change the directory to where the diagnostic tools were downloaded (in step 3). For example, `cd c:\users\<username>\downloads\wer`.
    3. Run the script `CheckTelemetryStatus.cmd`.
    4. The script will output the various registry keys to the screen. Clip the results and share them with Microsoft contact.
5. Capturing the WER settings.
    1. Open an elevated command prompt.  
    2. Change the directory to where the diagnostic tools were downloaded (in step 3). For example, `cd c:\users\<username>\downloads\wer`.
    3. Run the script `Werdiag.cmd`.
    4. Share the `.CAB` file that is created on your desktop with Microsoft contact.
6. Collecting a trace.
    1. Open an elevated command prompt.
    2. Change the directory to where the diagnostic tools were downloaded (in Step 3). For example, `cd c:\users\<username>\downloads\wer`.
    3. Run the script *Werdiag.cmd -starttrace*.
    4. Go to the *CrashMe/release* folder that was created in step 1.
    5. Double-click *CrashMe.exe* to launch the CrashMe app.
    6. Select the **Division by NULL** button to cause a crash.
    7. Go back to the command prompt window.
    8. Run the script `Werdiag.cm -stoptrace`.
    9. Share the .CAB file that is created on your desktop with Microsoft contact.
