---
title: Support Tip - Understanding the flow behind deployment, delivery, and processing of a Win32 application through Intune
description: This article highlights and explains the flow that is associated with a Win32 app during its deployment, delivery, and processing through Intune.
ms.date: 12/05/2023
ms.reviewer: kaushika, sausarka
author: helenclu
ms.author: sausarka
search.appverid: MET150
ms.custom: 
- CI 121778
- CSSTroubleshooting
- sap:app management
---

# Support Tip - Understanding the flow behind deployment, delivery, and processing of a Win32 application through Intune

Microsoft released the preview of Win32 app deployment through Intune in October 2018. The ability to deploy a Win32 application from Intune is a much-used feature because it enables you to achieve many uses cases.

This article highlights and explains the flow that is associated with a Win32 app during its deployment, delivery, and processing through Intune.

## Background

Refer to the following documentation to understand the basic administrative tasks behind Win32 app deployment through Intune:

- [Win32 app management in Microsoft Intune](/mem/intune/apps/apps-win32-app-management)

## Advantages of deploying a Win32 application

Deploying the Win32 app from Intune has the following advantages:

- You can now deploy `.exe` files by converting them to the `.intunewin` format.
- You can use detection logic to make sure that an app will be downloaded to the device and installed only if it's not detected as per a set rule.
- You can create rules to require that the app is applicable to, downloaded to, or installed in the device only if it meets a specific criterion.
- From the Intune user interface, you don't natively have the ability to deploy a single update to a Windows 10 device. If you have a critical update that has to be deployed to devices, you can use the Win32 app deployment approach.
- You can set dependencies for a Win32 app. This setting enables you to determine either the sequence in which the app would be installed or the priority of the apps.

## The flow behind deployment of a Win32 application from Intune

The following diagram is the architectural flow that occurs behind the deployment of a Win32 app through Intune.

:::image type="content" source="media/develop-deliver-working-win32-app-via-intune/win32-architecture-flow.png" alt-text="Diagram shows flow of the deployment of a Win32 app via Intune.":::

- The prerequisite for a Win32 app deployment through Intune can be found at [Win32 app management in Microsoft Intune - prerequisites](/mem/intune/apps/apps-win32-app-management#prerequisites).

- The Win32 Content Prep tool can be found at [Microsoft Win32 Content Prep Tool](https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool).

- First, install the Win32 file manually on a device without using Intune. This installation method is to make sure that the application supports silent installation, that the installation commands are correct, and that you're sure of the installation folder (which can be used in detection logic).

## The flow behind delivery of a Win32 app to the client

The following diagram explains the flow that occurs behind the delivery of a Win32 app to a device through Intune.

:::image type="content" source="media/develop-deliver-working-win32-app-via-intune/win32-delivery-flow.png" alt-text="Diagram shows flow of the delivery of a Win32 app to a device through Intune.":::

- Because you are using Intune to deploy Win32 apps, grant access to the endpoints in which your tenant currently resides.

- The complete documentation (using our tenant ASU and the relevant CDN) can be found at [Network requirements for PowerShell scripts and Win32 apps](/mem/intune/fundamentals/intune-endpoints#network-requirements-for-powershell-scripts-and-win32-apps).
- If you want to see the contents of the `.intunewin` file after the file is created, rename its extension to `.zip`.
- The `.intunewin` file contains two folders: **Contents** and **Metadata**. These folders contain the application package (the installer), and the `Detection.xml` file (containing the file encryption information).

:::image type="content" source="media/develop-deliver-working-win32-app-via-intune/intunewin-folders.png" alt-text="Screenshot shows the .intunewin folders." border="false":::

:::image type="content" source="media/develop-deliver-working-win32-app-via-intune/detection-xml-content.png" alt-text="Screenshot shows the content of the detection.xml file." border="false":::

## Flow behind processing of a Win32 app at the device end

Here is the lifecycle of a Win32 app at the client's end.

:::image type="content" source="media/develop-deliver-working-win32-app-via-intune/win32-app-flow.png" alt-text="Diagram shows the lifecycle of a Win32 app at the client's end.":::

> [!NOTE]
>
> - The processing of a Win32 app from Intune to the device can be listed into a sequence of steps.
> - As discussed in the next section, the logging by the IME for each of these steps is very verbose.

## Logs

Here is the location of the log file of Intune Management Extension:

:::image type="content" source="media/develop-deliver-working-win32-app-via-intune/intune-log-file.png" alt-text="Screenshot shows the location for the log file of Intune Management Extension." border="false":::

This location mainly contains the following log files that track the described information:

- **AgentExecutor.log**: This logfile tracks PowerShell script executions (deployed by Intune).
- **ClientHealth.log**: This logfile tracks the sidecar agent-client health activities.
- **IntuneManagementExtension.log**: The IME log that tracks all the flow that is illustrated in the following steps.

## Detailed flow in IME Logs

Here is the detailed flow behind the processing of a Win32 app at the device end, as viewed in the IME logs. The steps are listed in the sequence of occurrence.

|Step|Message in the log|Explanation|
|---|---|---|
|1|Intune Management Extension gets initialized.|EMS Agent is started.|
|2|S Mode is checked.| |
|3|Content manager starts.| |
|4|Deviceid and OS version is noted.| |
|5|IME discovers the endpoint of Intune (CDNs)|Approve these items in the firewall (if blocked) as stated in the network pre-requisites listed earlier.|
|6|Impersonation for the user occurs, and token is requested or granted.| |
|7|PUT request is sent.| |
|8|You see a **Get Policies** response that contains the entire policy body (as configured by the admin in the portal).|You can check to make sure that the policy that is received by IME is in accordance with the configured policy.|
|9|ExecManager identifies the app name/appid/app installation intent.| |
|10|Dependency is checked for the apps that were discovered.|If dependencies are discovered, the dependent app is downloaded and installed first.|
|11|Detection rules are checked for the apps.|Detection rule as set in the policy is evaluated. If the app is detected in the device at this stage, the download and installation attempt of the app (in the following step) is skipped.|
|12|Applicability is checked for the app (requirement and extended requirement).|You can use a Powershell script as well (needs to be uploaded to the Intune portal) to run this requirement check.|
|13|Download starts by sending a toast notification.|User can see an intuitive notice in the device that indicates that the app is downloading and installing.|
|14|Download job is created and timer is set.| |
|15|Content is downloaded to `C:\Program Files (x86)\Microsoft Intune Management Extension\Content\Incoming\59f9a567-b92d-4dc2-9c7a-fdb94e29275c_1.bin`.| |
|16|Download job finishes, time taken is noted, bytes download is noted, job is closed.| |
|17|Verification of encrypted hash, decryption starts.| |
|18|Unzipping starts from **Content\Staging** to `C:\Windows\IMECache\59f9a567-b92d-4dc2-9c7a-fdb94e29275c_1`.| |
|19|Organize staging content.| |
|20|Installer execution starts.| |
|21|Prepare .msi cmdline for system context.| |
|22|`msiexec /i "7zip.msi" /q /qn ALLUSERS=1 REBOOT=ReallySuppress /norestart`|Command is specified by the admin for the app in the portal.|
|23|Installation finishes, results collected.|
|24|lpExitCode 0, determines whether it's a success.|
|25|DeviceRestartBehavior: 2 (checks , device restart behavior) handle is closed.|Device restart action as stated in the policy that is defined by the admin in the portal.|
|26|The detection rule starts by SideCarFileDetectionManager|The detection rule evaluated in **Step 11** is evaluated again after the app installation.|
|27|Checked under path: `C:\Temp`, file Path: `C:\Temp\7zip`, agent was checking under expanded: `C:\Temp\7zip`, applicationDetected: True.| |
|28|Set `ComplianceStateMessage` and application detected after execution.| |
|29|EnforcementStateMessage: determines the output after the detection process, toast message of the installation status is sent again.|User can see an intuitive notice in the device that indicates that the app installed successfully or failed (as applicable).|
|30|Organize staged content.`C:\Windows\IMECache\59f9a567-b92d-4dc2-9c7a-fdb94e29275c_1`.| |
|31|Start reporting app results.| |
|32|Send results to service.|The Intune admin can view the status of App deployment for the device in the Intune portal.|
