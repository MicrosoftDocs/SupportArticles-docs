---
title: Troubleshooting scenarios for printing
description: Advanced troubleshooting printing scenarios.
ms.date: 05/16/2023
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-and-troubleshooting-print-output-or-print-failures, csstroubleshoot
ms.subservice: printing
---
# Troubleshooting scenarios for printing

The article guides you through various scenarios to help you troubleshoot and self-solve printing-related issues.

## Failed print job

Some of the scenarios described in this section:

- An application on the client stops responding while printing.
- Print job never reaches the printer.
- Print jobs are stuck in the queue.

Follow these steps on the client computer:

1. If application stopped responding, determine which print driver or print queue reproduces issue.

    Try printing from a text editor, such as Notepad. Does the issue repro? If it does, then try test another print queue by using different print driver. Narrow down the issue to learn which driver is the cause.
2. Clear the **Enable advanced printing features** check box on the **Advanced** tab of the property sheet of the printer.
3. Check the Spool folder to see whether it contains any old files. The default Spool folder is *%systemroot%\System32\Spool\Printers*.
4. [Reset the Print Spooler](third-party-print-driver-print-spooler-error.md#resolution) on the client, and then try again.
5. Update the printer driver to the latest version from the OEM. However, if the driver that's in use is already the latest version, try switching to a generic in-box driver.

## No print output

1. Clear the **Enable advanced printing features** check box on the **Advanced** tab of the printer properties.
2. Create a print queue for the device, and test printing through the new queue.
3. Restart the Spooler service.
4. Update the printer driver to the latest version from the OEM. However, if the driver that's in use is already the latest version, try switching to a generic in-box driver.
5. Check the Spool folder to see whether ir contains any old files. When printing is working correctly, the files in the Spool folder are deleted when the jobs are printed. The default Spool folder is: *%systemroot%\\System32\\Spool\\Printers*.
    1. You can verify the Spool folder location by checking the `DefaultSpoolDirectory` registry value in the following registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers`.
    2. Move any old files that are in the Spool folder to see whether the problem still occurs. Corrupted files in the Spool folder can cause Print Spooler service problems.
          > [!NOTE]
          > You might have to stop the Print Spooler service to move the files from the Spool folder.
    3. By default, the Print Spooler service is dependent on only the Remote Procedure Call service (RpcSs). To verify the Spooler dependencies, check the `DependOnService` value in the following Registry subkey:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Spooler`.
    4. Verify that the dependent services are started. If there are other dependent services in addition to the RpcSs, edit the `DependOnService` registry value to remove all dependencies except the RpcSs.
    5. It can sometimes be difficult to determine whether a print job is being spooled. Pausing the printer will let the job be spooled but not printed. This will give you time to verify that the print job is being spooled, helping you to further narrow the focus of your troubleshooting.

## Slow printing or unexpected output

Some of the scenarios described in this section:

- The print job takes "X" minutes to finish.
- Users are experiencing slowness when they print from all applications.
- Only Office or specific applications are slow to print.  
- The job takes a long time to spool.
- The job takes a long time to print.
- You experience slow printing on Hyper-V, RDS, or Azure.
- You experience slow printing when you try to print through a custom application.

Determine where the slowness occurs by running a *pause queue* test:

- Pause queue on the client and server.
- On the client, send the job from the application, and measure how quickly it creates the job.
- Unpause client queue, and then measure how quickly the job transfers to the queue on the Print server.
- Unpause queue on the Print server to measure how quickly it sends the job to the actual print hardware. This helps you to narrow down the search for where the slowness occurs.

1. Check the Spool folder to see whether it contains any old or orphaned files. When printing is working correctly, the files in the Spool folder are deleted as the jobs are printed. The default Spool folder is: *systemroot%\\System32\\Spool\\Printers*.
2. You can verify the location of the Spool folder by checking the *DefaultSpoolDirectory* value in the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers`.
3. Check whether there are any `.SHD` or `.SPL` files in *%systemroot%\\System32\\spool\\printers*. If there are, do the following:

    1. Run *MSINFO32.exe*, and examine **Software Environment**, **Print Jobs** to see whether you can determine the printer or job that is the source of the issue.
    1. MSINFO32 displays local print job information only. Therefore, it will most likely be helpful only for Terminal Server print spooler issues—if the print spooler has not been stopped. Files that are stuck in the Spool folder should be deleted or removed after the spooler is stopped. Any time that you make manual changes (files or registry entries), the spooler should at least be stopped and restarted.
    1. Move any old or orphaned files in the Spool folder to learn whether the problem still occurs. Corrupted files in the Spool folder can cause Print Spooler service problems. You might have to stop the Print Spooler service to remove the files from the Spool folder.
4. Visually check and document whether antivirus is scanning the Spool folder or `.SHD`, `.SPL`, or `.TMP` files. Antivirus programs can cause many side effects, such as  "access denied" errors and stuck print jobs in the Spool folder.
5. If you're using printer pooling to handle multiple jobs, and print jobs are taking a long time to reach the top of queue, consider adding more printers to the pool to distribute the print jobs over a larger set of printers.
6. > [!WARNING]
   > Before you delete third-party `…\Print\Monitors\<ABC>` keys (where ABC is the third-party component), verify that the customer does not have any subkeys below this one that define TCP/IP printer ports. Additionally you should search the registry for an "ABC" entry. All print drivers that have the "Monitors"="ABC" registry string should be modified so that "Monitor"="" (equal to nothing).

    1. Removing third-party printing components should be started. To do this, remove the printing components that are simple to remove and do not generally reduce print functionality. These include Print Monitors, Print Processors, and Print Providers.
    2. Always export `HKLM\SYSTEM\CurrentControlSet\Control\Print` before you manually remove printing components from the registry. Then, rename the file to `.txt` to avoid accidentally restoring it.
7. Exclusions for `.SHD` and `.SPL` files are created in the anti-virus.

## Print Spooler crash

1. Check the Spool folder to see whether it contains any old files. When printing is working correctly, the files in the Spool folder are deleted as the jobs are printed. The default Spool folder is: *systemroot\\System32\\Spool\\Printers*.
2. You can verify the Spool folder location by checking the `DefaultSpoolDirectory` value in the following registry subkey:
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers`.
3. Move any old files that are in the Spool folder to see whether the issue still occurs. Corrupted files in the Spool folder can cause Print Spooler service problems. You might have to stop the Print Spooler service to remove the files from the Spool folder.
4. By default, the Print Spooler service is dependent on only the RpcSs. To verify the Spooler dependencies, check the `DependOnService` value in the following Registry subkey:
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Spooler`.
5. Verify that the dependent services are started. If any other dependent services listed are listed in addition to the RpcSs, edit the `DependOnService` registry value to remove all dependencies except the RpcSs.
6. Because it can sometimes be difficult to determine whether a print job is being spooled, pausing the printer will let the job be spooled but not printed. It will allow you time to confirm that the print job is being spooled, helping you to further narrow your troubleshooting.
    - Another way to verify that the client print job is being spooled on the server is to configure the printer to use the NUL port. Because the NUL port is a virtual port and not an actual port, jobs sent to NUL do not waste paper, and do not interfere with print jobs that are printing to other installed ports.
    - By default, the NUL port is not listed in a printer's list of available ports. However, you can add it by changing the printer's configured port to a Local Port, selecting the **New Port** button, entering *NUL* as the port name, and then selecting **OK**. The NUL port is listed in the **Ports** list in **Print Server Properties**, and it can be used to test any installed printer.
    - After you install the NUL port, pause the printer by using this port, and then print to the printer from a client. You should see the print job being spooled in the print queue for the printer that's being tested. Resume the printer to process the spooled print job (the spools are then deleted).
    - Replace third-party drivers with Windows in-box drivers. It's important to understand that there's only one source for a true in-box driver: the *Driver.cab* file that ships on Windows' distribution media. Drivers that are on the Windows Catalog site are Microsoft Windows Hardware Quality Lab (WHQL)-signed, but are not tested by Microsoft. This means that the drivers meet published criteria but have not been stress-tested by Microsoft in the manner that other drivers in the distribution cab have been.

## Enable auditing of failures on specific printers

You might have to enable auditing on the specific objects (printers). Unless you have narrowed the focus of this issue down to certain printers, you will have to enable failure auditing on all printers by taking the following steps:

1. Select **Start** > **Settings** > **Devices** > **Printers & scanners**.
2. Select the printer that you want to audit, and then select **Printer properties**.
3. Select the **Security** tab, select the **Advanced** button, and then select the **Auditing** tab.
4. Select the **Add** button, select all the users or groups whose printer access you want to audit, and then select **OK**. The Auditing Entry window will appear to allow you to select the access events that you want to audit.
5. Place a check mark in the **Failure** column for all of the Access actions listed.
6. Select **OK** to return to the **Advanced Security Settings** window, and view the audit configuration that is in place.
7. Select **OK** to close the **Advanced Security Settings** window and return to **Properties** for the printer that you configured auditing for. Select **OK** to commit the changes.
8. Repeat steps 1-7 to enable auditing on all desired printer objects.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
