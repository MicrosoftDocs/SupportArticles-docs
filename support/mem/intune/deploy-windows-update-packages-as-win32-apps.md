---
title: Deploy Windows update packages as Win32 apps
description: Discusses how to deploy Windows update packages (.msu files) as Win32 apps in Microsoft Intune.
ms.date: 07/31/2020
ms.prod-support-area-path: Add apps
---
# Deploy Windows update packages as Win32 apps in Intune

If you want to deploy a specific update package (.msu file) to Intune-managed Windows 10 devices, this article shows you how to use the [Intune Win32 app management](/mem/intune/apps/apps-win32-app-management) feature to deploy the .msu file as a Win32 app.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4550832

## Step 1: Prepare the Win32 app content

1. Download the update package by searching on [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/).
2. Use the [Microsoft Win32 Content Prep Tool](https://go.microsoft.com/fwlink/?linkid=2065730) to convert the .msu file into the .intunewin format. If no parameters for the command are specified, this tool guides you to input the required parameters step by step. Or, you can add the parameters based on the available command-line parameters.

## Step 2: Create the Win32 app

1. Sign in to the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
2. Select **Apps** > **All apps** > **Add**.
3. In the **Select app type** pane, look under **Other** app types, and select **Windows app (Win32)**.
4. Select **Select**, locate the **Add app** pane, and then select **Select app package file**.
5. In the **App package file** pane, select the .intunewin file, and then select **OK**.
6. On the **App information** page, add the details for your app.
7. On the **Program** page, specify the following installation and removal commands for the app:

    **Install command:**  

    `wusa.exe <full path of the .msu file> /quiet /norestart -Wait`

    For example, if the windows10.0-kb4532693-x64_e22f60a077a0ec5896266a18cc3daf26bfc29e16.msu file is in the current folder, type the following command in **Install command**:

    `wusa.exe .\windows10.0-kb4532693-x64_e22f60a077a0ec5896266a18cc3daf26bfc29e16.msu /quiet /norestart -Wait`

    **Uninstall command:**  

    `wusa.exe /uninstall /kb:<KB number> /quiet`

    See the following example.

    :::image type="content" source="media/deploy-windows-update-packages-as-win32-apps/command.png" alt-text="Example of editing commands.":::

    Use the `/quiet` switch to run Wusa.exe in quiet mode without user interaction. Use the `/norestart` switch to prevent Wusa.exe from restarting the computer. For more information about Wusa.exe, see [Description of the Windows Update Standalone Installer in Windows](https://support.microsoft.com/help/934307).

    The `-Wait` option is used to make sure that the app installation returns after Wusa.exe exits.

8. On the **Requirements** page, specify the [requirements](/mem/intune/apps/apps-win32-app-management#step-3-requirements) that devices must meet before the app is installed.

    **Minimum operating system**: Select the minimum operating system that is required to apply the update.

    To specify additional requirements, such as build number and Update Build Revision (UBR), select **Add** to display the **Add a Requirement rule** pane.

    For example, to install the app on only devices that are running Windows 10, version 1903, build 18362, UBR less than 329, select **Registry** as the **Requirement type**, and then specify the following rules:

    - **Key path**: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion`
    - **Value name**: CurrentBuildNumber
    - **Registry key requirement**: String comparison
    - **Operator**: Equals
    - **Value**: 18362
    - **Associated with a 32-bit app on 64-bit clients**: No

    :::image type="content" source="media/deploy-windows-update-packages-as-win32-apps/build-18362-example.png" alt-text="Screenshot of build 18362 example.":::

    - **Key path**: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion`
    - **Value name**: UBR
    - **Registry key requirement**: Integer comparison
    - **Operator**: Less than
    - **Value**: 329
    - **Associated with a 32-bit app on 64-bit clients**: No

    :::image type="content" source="media/deploy-windows-update-packages-as-win32-apps/example.png" alt-text="Screenshot of UBR less than 329 example.":::

9. On the **Detection rules** page, select **Use a custom detection script** as the **Rules format**.

    **Example:**

    :::image type="content" source="media/deploy-windows-update-packages-as-win32-apps/detection-rules.png" alt-text="Screenshot of Detection rules example.":::

    **Sample script file (DetectKB.ps1)**:

    ```powershell
    $result = systeminfo.exe | findstr KB<KB number>

    if ($result)
     {
        Write-Output "Found KB<KB number>"
        exit 0
     }
     else
     {
        exit 1
     }
    ```

10. Specify [assignments](/mem/intune/apps/apps-win32-app-management#step-7---assignments) for the app.

11. Review your settings, and then select **Create** to add the app to Intune.

## Step 3: Deploy the app

[Assign the app](/mem/intune/apps/apps-deploy) to groups.
