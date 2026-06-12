---
title: Microsoft IME common issues and solutions
description: Describes how to resolve common IME issues in Windows, including switching input methods, missing IME keyboards, and offline language pack installation.
ms.date: 06/12/2026
ms.custom:
- sap:windows desktop and shell experience\Language Packs, Multilingual User Interface (MUI) and Input (IME)
- pcy:WinComm User Experience
ms.reviewer: kaushika, warrenw, v-appelgatet
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Microsoft IME common issues and solutions

## Summary

This article describes common issues that affect the Microsoft Input Method Editor (IME) in supported versions of Windows Client, and provides solutions for each issue.

Use this article to troubleshoot the following issues:

- [You can't switch IME modes or input methods.](#cant-switch-ime-or-input-modes)
- [After you install the Traditional Chinese (Taiwan) language pack, you see unexpected behavior.](#unexpected-behavior-after-you-install-the-traditional-chinese-taiwan-language-pack)
- [You have to install a language pack that includes basic typing support on a device that doesn't have access to Windows Update or the Microsoft Store.](#how-to-install-a-language-pack-that-includes-basic-typing-in-a-non-internet-environment)

## Can't switch IME or input modes

### Symptoms

- You can't switch IME modes.
- You can't toggle IME input methods.
- If you try to change the input language by using the Windows logo key and Spacebar together, the selection doesn't change.  
- The IME icon is unresponsive.

### Cause

If the Text Input Management Service is disabled, Ctfmon.exe can't start. If the service doesn't start, the IME framework doesn't initialize, and you can't switch input methods.

> [!NOTE]  
> In versions of Windows that are earlier than Windows 11 25H2, the Text Input Management Service was referred to as the Touch Keyboard and Handwriting Panel Service.

### Resolution

1. On the affected computer, open the Services console (services.msc).

1. In the list of services, right-click the **Text Input Management Service** (or the **Touch Keyboard and Handwriting Panel Service**), and then select **Properties**.

   :::image type="content" source="media/troubleshoot-ime-common-issues/text-input-management-service-dialog-box.png" alt-text="Screenshot of the Text Input Management Service dialog box, showing the service settings.":::

1. Check the **Startup type** setting. If the startup type is set to **Disabled**, select either **Manual** or **Automatic**.

1. If the service isn't running, start it.

1. Sign out of Windows, and then sign back in.

## Unexpected behavior after you install the Traditional Chinese (Taiwan) language pack

### Symptoms

After you install the **Traditional Chinese (Taiwan)** language pack, you encounter the following symptoms:

- The Microsoft Bopomofo IME is missing.
- A Czech keyboard unexpectedly appears.
- Typing produces Czech characters instead of Chinese characters.

### Cause

The registry of the affected computer contains a custom keyboard layout mapping (ID `d0010404`) that's associated with the user profile. When the Traditional Chinese (Taiwan) language pack is installed, Windows overwrites the custom ID by incorrectly using the ID of the Czech keyboard layout, `00000405`. Even though the user interface uses Traditional Chinese, this error causes the keyboard input to be in Czech, instead.

### Resolution

#### Step 1: Review the registry entries

Check the following registry subkeys for the affected user:

- `HKEY_CURRENT_USER\Keyboard Layout\Preload`
- `HKEY_USERS\<UserSID>\Keyboard Layout\Preload`
- `HKEY_USERS\<UserSID>\Keyboard Layout\Substitutes`

> [!NOTE]  
> In these subkeys, \<UserSID> is the security ID (SID) that identifies the user profile.

The following table shows an example of values that are symptomatic for this issue.

| Entry | Value | Description |
| - | - | - |
| `HKEY_CURRENT_USER\Keyboard Layout\Preload\1` | `00000409` | (English - United States) |
| `HKEY_CURRENT_USER\Keyboard Layout\Preload\2` | `00000404` | (Traditional Chinese - Taiwan) |
| `HKEY_USERS\<UserSID>\Keyboard Layout\Preload\1` | `00000404` | (Traditional Chinese - Taiwan) |
| `HKEY_USERS\<UserSID>\Keyboard Layout\Preload\2` | `d0010404` | (Custom keyboard layout) |
| `HKEY_USERS\<UserSID>\Keyboard Layout\Substitutes` | `d0010404`=`00000405` | ID substitution; `00000405` identifies the Czech keyboard |


#### Step 2: Select a resolution method

To fix this issue, use one of the following methods:

- Recommended: [Use Windows Settings](#settings).
- If the Settings page isn't available, [use Windows PowerShell](#powershell).

<a id="settings"></a>**Fix by using Windows Settings**

1. On the affected computer, select **Start** > **Settings** > **Time & Language** > **Language** > **Traditional Chinese (Taiwan)** > **Options**.

1. Under **Keyboards**, select **Add a keyboard**.

1. Select **Microsoft Bopomofo**, and then select **Add**.

1. If the list of keyboards contains any unexpected keyboards (for example, the Czech keyboard), remove those keyboards.

1. Select **OK**, sign out of Windows, and then sign in again.

<a id="powershell"></a>**Fix by using PowerShell**

> [!IMPORTANT]  
> You can't use DISM or other command prompt commands to add keyboards or other input methods. To make such changes, you have to use PowerShell in the context of the affected user.

> [!NOTE]  
> These steps modify settings only for the current user. You don't have to use administrative permissions.

1. On the affected computer, open a PowerShell command prompt window.
1. To add Traditional Chinese (Taiwan) and Microsoft Bopomofo, run the following script:

   ```powershell
   $Lang = Get-WinUserLanguageList
   if ($Lang.LanguageTag -notcontains "zh-TW") {
       $Lang.Add("zh-TW")
   }
   # Add Microsoft Bopomofo Input Method
   $Zh = $Lang | Where-Object LanguageTag -eq "zh-TW"
   if ($Zh.InputMethodTips -notcontains "0404:00000404") {
       $Zh.InputMethodTips.Add("0404:00000404")
   }
   Set-WinUserLanguageList -LanguageList $Lang -Force
   ```

1. To remove the custom Czech keyboard mapping, run the following script:

   ```powershell
   # Registry paths
   $preloadPath = "HKCU:\Keyboard Layout\Preload"
   $subPath     = "HKCU:\Keyboard Layout\Substitutes"
   
   # Remove custom layout from Preload
   if (Test-Path $preloadPath) {
       $props = (Get-ItemProperty $preloadPath).PSObject.Properties |
           Where-Object {
               $_.MemberType -eq 'NoteProperty' -and $_.Value -eq 'd0010404'
           }
       foreach ($p in $props) {
           Remove-ItemProperty -Path $preloadPath -Name $p.Name -ErrorAction SilentlyContinue
       }
   }
   
   # Remove Substitutes mapping
   if (Test-Path $subPath) {
       if ((Get-ItemProperty $subPath -ErrorAction SilentlyContinue).PSObject.Properties.Name -contains 'd0010404') {
           Remove-ItemProperty -Path $subPath -Name 'd0010404' -ErrorAction SilentlyContinue
       }
   }
   ```

1. Sign out of Windows, and then sign in again.

## How to install a language pack that includes basic typing in a non-internet environment

In a non-internet environment (such as a restricted or "air gapped" enterprise environment) devices don't have access to Windows Update or the Microsoft Store. Use this procedure if a device requires you to install an IME to support basic typing functionality.

### Prerequisites

To use this procedure, you have to obtain the appropriate Features on Demand (FOD) ISO image. For example, for Windows 11 24H2, the image is Languages and Optional Features for Windows 11, version 24H2 (FOD ISO).

Such images are available to authorized administrators as part of a volume licensing agreement. If you don't have access to the ISO image, contact the IT administrator in charge of managing your volume licensing agreement.

### Step 1: Mount the ISO and extract the required files

You have to extract the following files from the ISO to a folder on the system that you're installing the language pack on. If you're installing the language pack on multiple systems, you can copy the files to a centralized location, and then map a drive to that location.

1. To mount the ISO image on a particular computer, open Explorer on that computer, and then locate the ISO file.
1. Double-click the ISO file. Windows mounts the ISO image as a new drive.

1. From the mounted ISO image, extract the following packages to a folder on the computer where you want to install the language pack:

   - Microsoft-Windows-Client-Language-Pack_x64_zh-tw.cab
   - Microsoft-Windows-LanguageFeatures-Basic-zh-tw-Package~\*.cab
   - Microsoft-Windows-LanguageFeatures-Fonts-Hant-Package~\*.cab
   - Microsoft-Windows-LanguageFeatures-Handwriting-zh-tw-Package~\*.cab
   - Microsoft-Windows-LanguageFeatures-OCR-zh-tw-Package~\*.cab
   - Microsoft-Windows-LanguageFeatures-Speech-zh-tw-Package~\*.cab
   - Microsoft-Windows-LanguageFeatures-TextToSpeech-zh-tw-Package~\*.cab

For more information about how to mount the ISO image and extract the required files, see [Create a content repository for language packages and features on demand](/azure/virtual-desktop/windows-11-language-packs#create-a-content-repository-for-language-packages-and-features-on-demand).

### Step 2: Install the language packages

1. Open an administrative Command Prompt window, and then change the directory to the folder that contains the .cab files.
1. Run `dism /online /add package`, as shown in the following example:

   ```cmd
   dism /online /add-package /packagepath:C:\temp\Microsoft-Windows-Client-Language-Pack_x64_zh-tw.cab
   dism /online /add-package /packagepath:C:\temp\Microsoft-Windows-LanguageFeatures-Basic-zh-tw-Package~*.cab
   dism /online /add-package /packagepath:C:\temp\Microsoft-Windows-LanguageFeatures-Handwriting-zh-tw-Package~*.cab
   dism /online /add-package /packagepath:C:\temp\Microsoft-Windows-LanguageFeatures-OCR-zh-tw-Package~*.cab
   dism /online /add-package /packagepath:C:\temp\Microsoft-Windows-LanguageFeatures-Fonts-Hant-Package~*.cab
   dism /online /add-package /packagepath:C:\temp\Microsoft-Windows-LanguageFeatures-Speech-zh-tw-Package~*.cab
   dism /online /add-package /packagepath:C:\temp\Microsoft-Windows-LanguageFeatures-TextToSpeech-zh-tw-Package~*.cab
   ```

   > [!NOTE]  
   > In this example, the .cab files reside in the c:\temp folder.

Verify that each of these commands finishes successfully.

### Step 3: Configure the language order and then reauthenticate

1. To configure the language order, run the following PowerShell script:

   ```powershell
   $UserLanguageList = New-WinUserLanguageList -Language "zh-TW"
   
   # Replace "ja-JP" with your base OS language if different
   
   $UserLanguageList.Insert(0, "ja-JP")
   $UserLanguageList.Insert(1, "zh-TW")
   Set-WinUserLanguageList -LanguageList $UserLanguageList -Force
   ```

1. Sign out of Windows, and then sign in again.

## References

- [Manage the language and keyboard/input layout settings in Windows](https://support.microsoft.com/windows/manage-the-language-and-keyboard-input-layout-settings-in-windows-12a10cb4-8626-9b77-0ccb-5013e0c7c7a2)
- [Enable or Disable Windows Features Using DISM](/windows-hardware/manufacture/desktop/enable-or-disable-windows-features-using-dism)
- [Create a content repository for language packages and features on demand](/azure/virtual-desktop/windows-11-language-packs#create-a-content-repository-for-language-packages-and-features-on-demand)
- [New-WinUserLanguageList](/powershell/module/international/new-winuserlanguagelist)
