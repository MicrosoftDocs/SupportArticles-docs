---
title: Can't sign in to Power Automate for desktop
description: Helps troubleshoot sign-in related issues with Power Automate for desktop.
ms.reviewer: pefelesk, matp
ms.date: 03/01/2024
ms.subservice: power-automate-desktop-flows
---
# Can't sign in to Power Automate for desktop

This article provides resolutions and workarounds for several sign-in related issues in Power Automate for desktop.

## Generic sign-in or sign-out issues

Power Automate for desktop uses a file named *msalcache.bin3* to acquire tokens and authenticate users.

If you encounter errors while signing in or signing out, remove all the stored tokens by deleting this file.

To delete the file, navigate to `%localappdata%\Microsoft\Power Automate Desktop\Cache\MSI` for [MSI installations](/power-automate/desktop-flows/install#install-power-automate-using-the-msi-installer) or `%localappdata%\Microsoft\Power Automate Desktop\Cache\Store` for [Microsoft Store installations](/power-automate/desktop-flows/install#install-power-automate-from-microsoft-store).

> [!NOTE]
> If the *AppData* folder isn't visible in your user folder, try to [display hidden files](https://support.microsoft.com/windows/show-hidden-files-0320fe58-0117-fd59-6851-9b7f9840fdb2).

After deleting the *msalcache.bin3* file, close the Power Automate console, exit Power Automate from the system tray or restart the Power Automate service, and then try again to sign in.

## Web Account Manager (WAM) errors

By default, Power Automate for desktop authenticates users through the Web Account Manager (WAM); a Windows component that ships with the operating system and acts as an authentication broker.

For more information about WAM and related errors, see [Using MSAL.NET with Web Account Manager (WAM)](https://aka.ms/msal-net-wam) and [Interactive with WAM](/entra/identity-platform/scenario-desktop-acquire-token-wam).

## Wrong region issues

Before signing in, make sure you have selected the correct region from the **Change region** option.

:::image type="content" source="media/cannot-sign-in-to-power-automate-for-desktop/change-region.png" alt-text="Screenshot that shows the Change region option in the Power Automate console." lightbox="media/cannot-sign-in-to-power-automate-for-desktop/change-region.png":::

## Browser blocks cookies

When you sign in to Power Automate for desktop, you receive the following error message:

> We can't sign you in. Your browser is currently set to block cookies. You need to allow cookies to use this service.

### Resolution

1. Go to **Control Panel** > **Internet Options** > **Security** > **Trusted Sites**.
1. Add the following URLs:

    - `login.microsoft.com`
    - `login.windows.net`
    - `login.microsoftonline.com`
    - `secure.aadcdn.microsoftonline-p.com`

## Can't sign in due to a connectivity issue

When you sign in to Power Automate for desktop, you receive the following error message:

> There was an issue during sign in. Try again later or contact an administrator.

### Verify the issue

Try to sign in to [Power Automate](https://make.powerautomate.com/). If it works as expected, the issue should be related to the local network configuration of the machine that hosts Power Automate for desktop.

### Resolution

For more information about possible causes and steps to resolve this issue, see [Can't create, edit, save, or view desktop flows](/troubleshoot/power-platform/power-automate/desktop-flows/cannot-sign-in-create-edit-save-view-desktop-flows#cause).

## Login window keeps popping up

While signing in to Power Automate for desktop, the **login to your account** window pops up when you enter the credentials. If you select the question mark (**?**) icon to reset the account in **Login to your Microsoft account**, the login window disappears.

### Cause

Another process might be running a named pipe server on the same machine. This process runs with elevated rights using the localhost endpoint and blocks other applications from using this endpoint.

To identify if another process is running:

1. Download the [Sysinternals Suite](/sysinternals/downloads/sysinternals-suite).
1. Extract the *.zip* file to a folder.
1. Run a command prompt as an administrator.
1. Navigate to the folder where the Sysinternals Suite has been extracted.
1. Run the following command:

    ```cmd
    handle net.pipe
    ```

   > [!NOTE]
   > Running this command should display a list of processes that use named pipes and the address they listen to.

1. Identify whether there's a process displaying the `EbmV0LnBpcGU6Ly8rLw==` string and decode the process using the following link:

    `https://www.base64decode.org/`

    For example:

    ```console
    PAD.BrowserNativeMessageHost.exe pid: 21064 type: Section 464: \Sessions\1\BaseNamedObjects\net.pipe:EbmV0LnBpcGU6Ly8rL0JST1dTRVJOQVRJVkVIT1NULzE2NjIwLzEv Microsoft.Management.Services.IntuneWindowsAgent.exe pid: 26708 type: Section 6AC: \BaseNamedObjects\net.pipe:EbmV0LnBpcGU6Ly8rL0lOVFVORU1BTkFHRU1FTlRFWFRFTlNJT04vU1RBVFVTU0VSVklDRS8= PipesTest.Server.exe pid: 6540 type: Section 3AC: \BaseNamedObjects\net.pipe:EbmV0LnBpcGU6Ly8rLw==
    ```

### Resolution

To fix this issue, stop the process identified in the previous step, or if it's an internal process, use a more specific endpoint, such as `net.pipe://localhost/something`.

- As an alternate, ensure Power Automate for desktop is closed (also from the taskbar), kill the process identified in the previous steps, and then try again to restart Power Automate for desktop.

- If the other solutions aren't possible, specify Power Automate for desktop executables to run as administrator. This workaround might only solve the issue in some cases, and it causes a User Account Control (UAC) prompt to appear each time.
