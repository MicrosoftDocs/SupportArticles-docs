---
title: Troubleshoot printing scenarios
description: Advanced troubleshooting printing scenarios.
ms.date: 27/09/2021
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:management-and-configuration-installing-print-drivers, csstroubleshoot
ms.technology: windows-server-printing
---
# Troubleshoot printing scenarios

The article covers scenario guides to help you troubleshoot and self-solve printing related issues.

## Failed print job

Some of the scenarios described in this section:

- The application on client freezes while printing.
- The print job never gets through the printer.
- The print jobs are stuck in queue.

Follow these steps from the client/workstation machine:

1. If application is freezing, then determine which print driver/print queue reproduces issue.

    Try printing from *Notepad.exe* does it repro?

    If yes, then try test another print queue using different print driver - narrow issue to which driver is the cause.
2. Uncheck the **Enable advanced printing features** check box on the **Advanced** tab of the property sheet of the printer.
3. Check the Spool folder to see if there are any old files in the folder. The default Spool folder is *%systemroot%\System32\Spool\Printers*.
4. [Reset the Print Spooler](third-party-print-driver-print-spooler-error.md#resolution) on the client and try again.
5. Update the printer driver to the latest from the OEM. However, if the driver being used is the latest version from the OEM, you may try switching to a generic in-box driver.

## No print output

1. Uncheck the **Enable advanced printing features** check box on the **Advanced** tab of the property of the printer.
2. Create a new print queue to the device, and test printing.
3. Restart the Spooler service.
4. Update the driver with the latest driver from the OEM. However, if the driver being used is the latest version from the OEM, you may try switching to a generic in-box driver.
5. Check the Spool folder to see if there are any old files in the folder. When printing is working properly, the files in the Spool folder are deleted as the jobs are printed. The default Spool folder is: *%systemroot%\\System32\\Spool\\Printers*.
    1. The Spool folder location can be confirmed by checking the `DefaultSpoolDirectory` registry value in the following registry key:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers`.
    2. Move any old files that are in the Spool folder to see if the problem still occurs. Corrupt files in the Spool folder can cause Print Spooler service problems. You may need to stop the Print Spooler service to move the files from the Spool folder.
    3. The Print Spooler service is, by default, dependent only upon the Remote Procedure Call (RPC) service, RPCSS. To confirm the Spooler dependencies, check the `DependOnService` value in the following Registry key:
    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Spooler`.
    4. Confirm that the dependent services are started. If there are any other dependent services listed, in addition to RPCSS, edit the `DependOnService` registry value to remove all dependencies except RPCSS.
    5. It can sometimes be difficult to confirm that a print job is being spooled, pausing the printer will allow the job to be spooled but not printed. It will allow you time to confirm that the print job is being spooled, helping to further narrow the focus of the problem.

## Slow printing or unexpected output

Some of the scenarios described in this section:

- The print job takes "X" minutes to complete.
- Users are experiencing slowness while printing from all applications.
- Only Office  or specific applications are slow to print.  
- The job takes long time to spool.
- The job takes longer time to print.
- Slow print on Hyper-V, RDS, or Azure.
- Slow printing behavior when trying to print through custom application.

Find out where the slowness occurs by doing a pause queue test.

- Pause queue on client and server.
- On the client, send job from application time to check how quickly it creates job.  
- Unpause client queue and then measure how fast it transfers to queue on Print server.
- Unpause queue on Print server to measure how quickly it sends job to actual print hardware. It helps narrow down where the slowness is occurring.

1. Check the Spool folder to see if there are any old or orphaned files in the folder. When printing is working properly, the files in the Spool folder are deleted as the jobs are printed. The default Spool folder is: *systemroot%\\System32\\Spool\\Printers*.
2. The Spool folder location can be confirmed by checking the *DefaultSpoolDirectory* registry value in the following Registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers`.
3. Are there `.SHD`and `.SPL` files in *%systemroot%\\System32\\spool\\printers*?

    1. If yes run *MSINFO32.exe* and look at **Software Environment**, **Print Jobs** to see if you are able to determine the printer/job that the problem originated at.
    1. MSINFO32 displays local print job information only so it will most likely only be helpful with Terminal Server print spooler issues, provided the print spooler has not been stopped.  Files that are stuck in the spool folder should be deleted or moved out after the spooler is stopped.  Anytime you are making manual changes (files or registry entries) spooler should at a minimum be stopped/restarted.
    1. Then move any old or orphaned files in the spool folder to see if the problem still occurs. Corrupt files in the Spool folder can cause Print Spooler service problems. You may need to stop the Print Spooler service to move the files from the Spool folder.
4. Visually check and document if antivirus is scanning the Spool folder or `.SHD`, `.SPL`, or `.TMP` files. It can cause many side effects like access is denied, stuck print jobs in the Spool folder.
5. If you are using printer pooling to handle a large number of jobs, and print jobs are taking a long time to get to the top of queue, consider adding more printers to the pool to distribute the print jobs over a larger set of printers.
6. > [!WARNING]
   > before deleting third-party *…\\Print\\Monitors\\\<ABC\>* keys (where ABC is the third-party component) verify that the customer does not have any subkeys below it that define TCP/IP printer ports. Additionally you should search the registry for ABC.  All print drivers that have the "Monitors"="ABC" registry string should be modified so that "Monitor"="" (equal to nothing).

    1. Removing third-party printing components should be started by removing the printing components that are simple to remove and do not generally reduce print functionality: Print Monitors, Print Processors, Print Providers.
    2. Always export `HKLM\SYSTEM\CurrentControlSet\Control\Print` before manually removing printing components from the registry, then rename the file to `.TXT` to avoid accidentally adding it back.  
7. Exclusions for `.SHD` and `.SPL` files are created in the anti-virus.

## Print Spooler crash

1. Check the Spool folder to see if there are any old files in the folder. When printing is working properly, the files in the Spool folder are deleted as the jobs are printed. The default Spool folder is: *systemroot\\System32\\Spool\\Printers*.
2. The Spool folder location can be confirmed by checking the `DefaultSpoolDirectory` registry value in the following registry key:
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers`.
3. Move any old files that are in the Spool folder to see if the problem still occurs. Corrupt files in the Spool folder can cause Print Spooler service problems. You may need to stop the Print Spooler service to move the files from the Spool folder.
4. The Print Spooler service is, by default, dependent only upon the Remote Procedure Call (RPC) service, RPCSS. To confirm the Spooler dependencies, check the `DependOnService` value in the following Registry key:
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Spooler`.
5. Confirm that the dependent services are started. If there are any other dependent services listed, in addition to RPCSS, edit the `DependOnService` registry value to remove all dependencies except RPCSS.
6. Since it can sometimes be difficult to confirm that a print job is being spooled, pausing the printer will allow the job to be spooled but not printed. It will allow you time to confirm that the print job is being spooled, helping to further narrow the focus of the problem.
    - Another way to confirm that the client print job is being spooled on the server is to configure the printer to use the NUL port. Since the NUL port is a virtual port, not an actual port, jobs sent to NUL do not waste paper, and do not interfere with print jobs that are printing to other installed ports.
    - The NUL port is not listed by default in a printer's list of available ports, but can be added by changing a printer's configured port to a Local Port, clicking the New Port button, entering NUL as the port name, and clicking OK. The NUL port is listed in the Print Server Properties' Ports list and can be used to test any installed printer.
    - After installing the NUL port, pause the printer using this port and print to the printer from a client. You should see the print job being spooled in the print queue for the printer being tested. Resume the printer to process the spooled print job (the spools are then deleted).
    - Replace third-party drivers with Windows in-box drivers. It is important to understand that there is only one source for a true inbox driver, the *Driver.cab* file that ships on Windows' distribution media. Drivers that are on the Windows Catalog site are Microsoft&reg; Windows&reg; Hardware Quality Lab (WHQL) signed, but are not tested by Microsoft. It means that the drivers meet published criteria but have not been stress-tested by Microsoft as other drivers in the distribution cab have been.

## Enable auditing of failures on specific printers

You may need to enable auditing on the specific objects (printers). Unless you have narrowed the focus of this issue down to certain printers, you will need to enable failure auditing on all printers by performing the following steps:

1. Select Start, and then select **Printers and Faxes**.
2. Right-click the printer you want to audit, and select **Properties**.
3. Select the **Security** tab, select the **Advanced** button, and then select the **Auditing** tab.
4. Select the **Add** button, and select all of the user(s) or group(s) whose printer access you wish to audit and select **OK**. The Auditing Entry window will appear to allow you to select the access events that you wish to audit.
5. Place a check in the Failure column for all of the Access actions listed.
6. Select **OK** to return to the Advanced Security Settings window and view the audit configuration that is in place.
7. Select **OK** to close the Advanced Security Settings window and return to the **Properties** for the printer that you configured auditing for. Select **OK** to commit the changes.
8. Repeat the steps above to enable auditing on all desired printer objects.
