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

## Solution 1: Check for updates

Windows 11 and Windows 10 let you choose when and how to get the latest updates to keep your device running smoothly and securely. To manage your options and see any available updates, select the **Start** button, and then go to **Settings** > **Update & Security** > **Windows Update** > **Check for updates**. Install any available updates, and then restart your computer if the updates require it.

For more information, see [Update Windows](https://support.microsoft.com/help/4027667).

## Solution 2: Search and Indexing troubleshooter

Your PC automatically indexes content to deliver faster search results. If you're running Windows 10, version 1903 (May 2019 Update) or later versions and Windows can detect a problem, we'll run the Search troubleshooter automatically. This troubleshooter will reset Windows Search back to the default experience. View your troubleshooter history under **Settings** > **Update & Security** > **Troubleshoot** > **View History**. Follow the solutions below if your issue is still not resolved.

Use the Windows **Search and Indexing** troubleshooter to try to fix any problems that may arise. To use the troubleshooter, follow these steps:

1. Select **Start** > **Settings**.
2. In **Windows Settings**, select **Update & Security** > **Troubleshoot**. Under **Find and fix other problems**, select **Search and Indexing**.
3. Run the troubleshooter and select any problems that apply. Windows will try to detect and solve them.

You can also use a command prompt to open the troubleshooter. Press the Windows logo key+<kbd>R</kbd>, enter *cmd* in the **Open** box, and then select **OK**. At the command prompt, run the following command:

```console
msdt.exe -ep WindowsHelp id SearchDiagnostic
```

 For more information about Search and Indexing, see the following articles:

- [Performance issues that affect Windows Search and Search indexing](windows-search-performance-issues.md).
- FAQs on [Search indexing in Windows 10](https://support.microsoft.com/help/4098843).

## Solution 3: Restart Windows Search

End the **SearchUI** process to restart Windows Search by following these steps:

1. Press <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>Delete</kbd>, and then select **Task Manager**.
2. In the **Task Manager** window, select the **Details** tab.
3. In the **Name** column, right-click **SearchUI.exe**, and then select **End task**.
4. When you're prompted to end *SearchUI.exe*, select **End process**.

> [!NOTE]
> The Windows Search process will automatically restart the next time you search.

If this solution doesn't fix your problem, try restarting your device. Restarting will also install any pending updates.

> [!NOTE]
> You may want to bookmark this page before you restart.

## Solution 4: Reset Windows Search

Try resetting Windows Search by using the method that's appropriate for your version of Windows.

To determine which version of Windows your device is running, follow these steps:

1. Select **Start** > **Settings** > **System** > **About**.

2. Under **Windows specifications**, check which version of Windows your device is running.

> [!NOTE]
> Resetting Windows Search doesn't affect your files. However, it may temporarily affect the relevance of search results.

### Windows 10, version 1809 and earlier

If the Windows 10 October 2018 Update or an earlier update is installed, reset Cortana to reset Windows Search by following these steps:

1. Select **Start**, right-click **Cortana**, and then select **More** > **App settings**.
2. In the Cortana settings, select **Reset**.

### Windows 11, Windows 10, version 1903, and later

If Windows 11, Windows 10 May 2019 Update, or a later update is installed, use Windows PowerShell to reset Windows Search by following these steps:

> [!IMPORTANT]
> You must have administrator permissions to run this script.

1. Download the *ResetWindowsSearchBox.ps1* script from the [Reset Windows Search PowerShell script](https://www.microsoft.com/download/details.aspx?id=100295), and save the file to a local folder.

2. Right-click the file that you saved and select **Run with PowerShell**.
3. If you're asked the following question, select **Yes**.

    > Do you want to allow this app to make changes to your device?

4. The PowerShell script resets the Windows Search feature. When the word **Done** appears, close the PowerShell window.
5. If you receive the "Cannot be loaded because running scripts is disabled on this system" error message, enter the following command on the command line of the PowerShell window, and then press Enter:

    ```powershell
    Get-ExecutionPolicy
    ```

    > [!NOTE]
    > The current policy appears in the window. For example, you might see **Restricted**. We recommend that you note this value because you'll have to use it later.

6. Enter the following command on the command line of the PowerShell window, and then press Enter:

    ```powershell
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
    ```

    > [!IMPORTANT]
    > You'll receive a warning message that explains the security risks of an execution policy change. Press Y, and then press Enter to accept the change.

    To learn more about PowerShell execution policies, see [About Execution Policies](/powershell/module/microsoft.powershell.core/about/about_execution_policies).

7. After the policy change is completed, close the window, and then repeat steps 2-4. However, when the **Done** message appears this time, DON'T close the PowerShell window. Instead, press any key to continue.

8. Revert to your previous PowerShell execution policy setting. Enter the following command on the command line of the PowerShell window, press the Spacebar, enter the policy value that you noted in step 5, and then press Enter:

    ```powershell
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy
    ```

    For example, if the policy that you noted in step 5 was **Restricted**, the command would resemble the following one:

    ```powershell
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Restricted
    ```

    > [!NOTE]
    > You'll receive a warning message that explains the security risks of an execution policy change. Press Y, and then press Enter to accept the change and revert to your previous policy setting.

9. Close the PowerShell window.

> [!IMPORTANT]
> If your organization has disabled the ability to run scripts, contact your administrator for help.

## Solution 5: Regenerate the Microsoft.Windows.Search package AppData folder

[!INCLUDE [Registry warning](../../includes/registry-important-alert.md)]

1. Make sure that Windows Search works for a newly created Windows account.
2. Delete the *%USERPROFILE%\\AppData\\Local\\Packages\\Microsoft.Windows.Search_cw5n1h2txyewy* folder.

     > [!NOTE]
     >
     > - Use the Windows Recovery Environment, or sign out and sign in to another user account.
     > - For an earlier version of Windows, *Microsoft.Windows.Search_cw5n1h2txyewy* should be replaced with *Microsoft.Windows.Cortana_cw5n1h2txyewy*.

3. Delete the `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search` registry key from the affected account.
4. Run the following cmdlet from an elevated PowerShell command prompt:

    ```PowerShell
    Add-AppxPackage -Path "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\Appxmanifest.xml" -DisableDevelopmentMode -Register
    ```

5. Restart the system and search for something for the system to initialize the indexing. The registry key and the *AppData* folder should be regenerated.

## Help us improve Search in Windows

If the previous suggestions don't fix the problem, let us know by sending feedback in the Feedback Hub. Provide details, such as a description of the problem, screenshots, log files, and any other information that might be helpful. In the Feedback Hub, select the appropriate category and subcategory. In this case, submit your feedback in the **Cortana and Search** category.
