---
title: Best practices for Intune software distribution to Windows PC
description: Describes tips for distributing a software or update package to Windows PC clients by using Microsoft Intune.
ms.date: 05/11/2020
ms.prod-support-area-path: Software distribution
---
# Best practices for Intune software distribution to Windows PC

You can use Microsoft Intune to manage Windows PCs as computers by using the Intune software client. This article provides tips and best practices for using Intune to make software deployments to Windows PC clients. Intune deploys only software that can be installed silently without user interaction.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 2583929

## Prepare for software distribution

Before you distribute an update or other software package, gather the necessary installation or update files. These files must include one of the following files:

- An installation executable file, such as Setup.exe.
- A Windows Installer file, such as Application.msi.

If the installer file requires other files or folders to complete the installation, put all these files into a single and accessible folder. So they can be added to the software package by the Intune Software Publishing wizard.

For .exe files, Intune adds the `/Install` switch automatically. Most .exe files typically require extra command-line arguments to turn off the default user interaction, and install the package silently. Microsoft Intune deployments support only .exe installer packages. If you want to deploy runtime executable files, use a third-party tool to create an installer package.

For .msi files, Intune adds the `/quiet` switch automatically. The installer packages should detect that the installation is under the SYSTEM account, and automatically install in silent mode. However, it depends on how the software publisher creates the package. If an application installation requires user context, it probably can't be deployed by using Intune.

## Test the software installation by using the SYSTEM account

Before you deploy the software package, test whether the package can be installed silently under the SYSTEM account by following these steps:

1. Download [PsExec](/sysinternals/downloads/psexec).
2. Open an elevated Command Prompt window.
3. Navigate to the location of PsExec, type the following command, and then press Enter:

   ```console
   psexec -i -s cmd.exe
   ```

4. It opens a new Command Prompt window as the system context. Type `whoami` at the new command prompt. You should see the following result:

   ```output
   nt authority\system
   ```

5. Navigate to the location of the deployable package, and then run it by using the correct switches for silent installation.

   Most common switches for software deployment:

   - Lync 2010 (EXE): `/silent`
   - Skype (EXE): `/verysilent`
   - Skype (MSI): `/passive /qn`
   - Internet Explorer 10 (EXE): `/quiet /passive /norestart`
   - Internet Explorer 11 (EXE): `/quiet /norestart`
   - Notepad ++ (EXE): `/s`
   - Firefox (EXE): `-ms`
   - Adobe Reader (EXE): `/sAll /rs /msi EULA_ACCEPT=YES`

   If you don't know which switches to use for silent installation, run the command by adding the `/?` or `/help` switch.

   Here's an example of Skype MSI:

   :::image type="content" source="./media/software-distribution-best-practices/switch.png" alt-text="Screenshot of switch.":::

   Besides the `/quiet` switch that's added by Intune, you must add the `/passive` and `/qn` switches to enable silent installation.

6. If the installation fails, determine which switches will force the package to install through the SYSTEM account. For help, contact the software publisher or search for the information on the internet.

## Test the software deployment

Before you deploy the software to all Windows PCs, we recommend that you assign it as **Available**. Then manually install it from [https://portal.manage.microsoft.com](https://portal.manage.microsoft.com/) on at least one PC. If the installation seems not to occur, check the following log to verify whether the package tried to install:

`C:\Program Files\Microsoft\OnlineManagement\Logs\updates.log`

> [!NOTE]
> If the package starts installing and the log shows that it hasn't progressed for several hours, the process is likely stuck and waiting for user interaction.

## Unsupported scenario: Deploy scripts or batch files

The Intune service is used to deploy .msi or .exe files. Microsoft doesn't support using Intune to deploy custom scripts or batch files.

## References

[Troubleshooting MSI App deployments in Microsoft Intune](https://techcommunity.microsoft.com/t5/Intune-Customer-Success/Support-Tip-Troubleshooting-MSI-App-deployments-in-Microsoft/ba-p/359125)
