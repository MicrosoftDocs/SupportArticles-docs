---
title: Cannot sign in or create or edit or save or view desktop flows
description: Provides a resolution for the error message that occurs when you try to sign in, create, edit, save, or view desktop flows in Power Automate.
ms.reviewer: pefelesk
ms.date: 09/21/2022
ms.subservice: power-automate-desktop-flows
---
# Can't sign in, create, edit, save, or view desktop flows

This article provides a resolution to an issue where you receive an error message when trying to sign in, create, edit, or view a desktop flow in Microsoft Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5004096

## Symptoms

In Microsoft Power Automate for desktop, you experience the following issues:

- When you sign in to Power Automate for desktop, you receive the following error message:

   > Error during sign in - Sign in failed.

- When you create a new desktop flow, you receive the following error message:

   > You aren't permitted to create flows in this environment. Please switch to the default environment, or to one of your own environment(s), where you have maker permissions.

- When you edit a desktop flow, you receive the following error message:

   > Flow initialization failed.

- When you save a desktop flow, you receive the following error message:

   > Error during flow save - Flow failed to save.

- You can't view any desktop flows in the **My flows** list of the Console.

## Verifying issue

Try to do the same operation in the [Power Automate Portal](https://flow.microsoft.com) when applicable. If it works as expected, then the issue should be related to the local network configuration of the machine that hosts Power Automate for desktop.

## Cause

The machine that hosts Power Automate for desktop can't connect to the required domains. This issue could happen either because the domains are blocked on the network, or because you're using a proxy server that requires authentication.

For the latter, Power Automate for desktop can't authenticate with the proxy server, thus the communication fails. Note that the Proxy server should be using automatic authentication with the user's Active Directory account.

## Resolution for the blocked domains issue

Approve the [Required services](/power-automate/ip-address-configuration#required-services) to which Power Automate connects. Ensure none of these services are blocked on your network.

Approve the [Desktop flows services required for runtime](/power-automate/ip-address-configuration#desktop-flows-services-required-for-runtime) to enable the connection from the local machine for the desktop flows runs.

## Resolution for the proxy authentication issue

Right-click the Power Automate for desktop icon in the system tray and then exit Power Automate for desktop.

You need administrator rights to do the following changes:

1. Navigate to Power Automate for desktop installation folder (_C:\Program Files (x86)\Power Automate Desktop_).

2. Back up the _PAD.Designer.exe.config_ and _PAD.Console.Host.exe.config_ two files to recover them if any issues occur.

3. For both files, edit each file with administrator rights, and at the end of the root xml node (\<configuration>), add the following child xml node:

   ```xml
     <system.net>
          <defaultProxy enabled="true" useDefaultCredentials="true"> 
          </defaultProxy> 
     </system.net>
     ```

4. Save the files.
5. Restart Power Automate for desktop.
