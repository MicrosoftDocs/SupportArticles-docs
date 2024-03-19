---
title: Fix problems in Windows Search
description: Provides troubleshooting options for problems that affect the search results for the Windows Search feature in Windows 11 and Windows 10.
ms.date: 01/12/2024
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: high
ms.reviewer: kaushika
ms.custom: sap:cortana-and-search, csstroubleshoot
---
# Fix problems in Windows Search

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806433" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common Windows Search issues.

If Windows Search is unresponsive or the search results don't appear as expected, try any of the following solutions in this article.

_Original KB number:_ 4520146

## Solution 1: Restart Windows Font Cache Service

Sometimes, you can resolve Windows Search issues by restarting Windows Font Cache Service. To do this, follow these steps:

1. In the search box on the taskbar, enter *services.msc* to start the Services console.
2. In the right pane, right-click **Windows Font Cache Service** and then select **Stop**.
3. Try to search again.
4. In the Services console, right-click **Windows Font Cache Service** and then select **Start**.

## Solution 2: Check for updates

When you use Windows 11 or Windows 10, you can choose when and how to get the latest updates to keep your device running smoothly and securely. To manage your options and see any available updates, select **Start** > **Settings** > **Update & Security** > **Windows Update** > **Check for updates**. Install any available updates, and then restart your computer if the updates require it.

For more information, see [Update Windows](https://support.microsoft.com/help/4027667).

## Solution 3: Search and Indexing troubleshooter

Windows automatically indexes content to deliver faster search results. If you're running Windows 10, version 1903 (May 2019 Update) or a later version and Windows detects a problem, Windows automatically runs the Search troubleshooter. This troubleshooter resets Windows Search to the default experience. To view your troubleshooter history, select **Start** > **Settings** > **Update & Security** > **Troubleshoot** > **View History**.

Use the Windows Search and Indexing troubleshooter to try to fix any problems that might arise. To use the troubleshooter, follow these steps:

1. Select **Start** > **Settings** > **Update & Security** > **Troubleshoot**.
2. Under **Find and fix other problems**, select **Search and Indexing**.
3. Run the troubleshooter and select any problems that apply. Windows tries to detect and solve those problems.

> [!NOTE]  
> You can use a Windows command prompt to open the Search and Indexing troubleshooter. To do this, open a Windows Command Prompt window, and then run the following command:
>
> ```console
> msdt.exe -ep WindowsHelp id SearchDiagnostic
> ```

For more information about Search and Indexing, see the following articles:

- [Performance issues that affect Windows Search and Search indexing](windows-search-performance-issues.md).
- [Search indexing in Windows 10: FAQ](https://support.microsoft.com/help/4098843).

## Solution 4: Restart Windows Search

Follow these steps to end the **SearchUI** process. Stopping this process stops Windows Search. The next time you search, Windows Search automatically starts.

1. Press <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>Delete</kbd>, and then select **Task Manager**.
2. In **Task Manager**, select **Details**.
3. In the **Name** column, right-click **SearchUI.exe**, and then select **End task**.
4. When you're prompted to end *SearchUI.exe*, select **End process**.

If this solution doesn't fix your problem, try restarting your device. Restarting also installs any pending updates.

> [!NOTE]  
> Before you restart, consider bookmarking this page.

## Solution 5: Reset Windows Search

Try resetting Windows Search by using the method that's appropriate for your version of Windows. To determine which version of Windows your device is running, follow these steps:

1. Select **Start** > **Settings** > **System** > **About**.
2. Under **Windows specifications**, check which version of Windows your device is running.

> [!NOTE]  
> Resetting Windows Search doesn't affect your files. However, it may temporarily affect the relevance of search results.

### Reset Windows Search when using Windows 10, version 1809 or an earlier version

If the computer runs Windows 10 October 2018 Update or an earlier update, follow these steps to reset Windows Search by resetting Cortana:

1. Select **Start**, right-click **Cortana**, and then select **More** > **App settings**.
2. In the Cortana settings, select **Reset**.

### Reset Windows Search when using Windows 11, Windows 10, version 1903, or a later version

If the computer runs Windows 11, Windows 10 May 2019 Update, or a later update, you can use a Windows PowerShell script to reset Windows Search.

> [!IMPORTANT]  
>
> - You must have administrator permissions to run this script.
> - If your organization has disabled the ability to run scripts, contact your administrator for help.

To reset Windows Search by using PowerShell, follow these steps:

1. Check the Windows PowerShell execution policy on the affected computer. To allow the script to run, the execution policy must be set to **Unrestricted**.  

   1. To check the execution policy, open an elevates PowerShell window, and then run the following cmdlet:

      ```powershell
      Get-ExecutionPolicy
      ```

   1. If the execution policy is **Unrestricted**, continue to step 2. Otherwise, record the value for later use. Then run the following cmdlet:

      ```powershell
      Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
      ```

      > [!IMPORTANT]  
      > This cmdlet generates a warning message that explains the security risks of an execution policy change. To accept the change, press <kbd>Y</kbd>, and then press <kbd>Enter</kbd>.

      To learn more about PowerShell execution policies, see [About Execution Policies](/powershell/module/microsoft.powershell.core/about/about_execution_policies).

   1. After the policy change finishes, close the PowerShell window.

1. Download *ResetWindowsSearchBox.ps1* from [Reset Windows Search PowerShell script](https://www.microsoft.com/download/details.aspx?id=100295), and save the file to a local folder.

1. Right-click the file that you saved, and then select **Run with PowerShell**.
1. If you're asked the following question, select **Yes**.

   > Do you want to allow this app to make changes to your device?

   The PowerShell script resets the Windows Search feature.

1. When the word **Done** appears, do one of the following:

   - If you didn't change the execution policy to run the script, close the PowerShell window.
   - If you changed the execution policy, keep the PowerShell window open and press any key to continue. Run the following command in the PowerShell window:

      ```powershell
      Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy <PreviousValue>
      ```

       In this command, <*PreviousValue*> represents the original execution policy. As you did previously, accept the policy change by pressing <kbd>Y</kbd> and then pressing <kbd>Enter</kbd>.

1. Close the PowerShell Window.

> [!NOTE]  
> If you receive the following message when you run the script, the execution policy is not set correctly.  
>
     > Cannot be loaded because running scripts is disabled on this system.  
>
> Return to the earlier steps in this procedure to check the execution policy and change it if needed. Then run the script again.

## Solution 5: Regenerate the Microsoft.Windows.Search package AppData folder

> [!NOTE]  
> Use the Windows Recovery Environment, or sign out and sign in to another user account.

[!INCLUDE [Registry warning](../../includes/registry-important-alert.md)]

1. Make sure that Windows Search works for a newly created Windows account.
1. Delete the *%USERPROFILE%\\AppData\\Local\\Packages\\Microsoft.Windows.Search_cw5n1h2txyewy* folder.

   > [!NOTE]  
   > In some earlier versions of Windows, this folder is named *Microsoft.Windows.Cortana_cw5n1h2txyewy*.

1. While signed in by using the affected account, in Registry Editor, navigate to the `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search` subkey.
1. Delete the `Search` registry key.
1. Open an elevated PowerShell Window, and then run the following cmdlet:

   ```PowerShell
   Add-AppxPackage -Path "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -Register
   ```

1. Restart the computer.
1. Try to search again. This action restarts search indexing, and regenerates the registry key and the *AppData* folder.

## Help us improve Search in Windows

If the previous suggestions don't fix the problem, let us know by sending feedback in the Feedback Hub. Provide details, such as a description of the problem, screenshots, log files, and any other information that might be helpful. In the Feedback Hub, select the appropriate category and subcategory. In this case, submit your feedback in the **Cortana and Search** category.
