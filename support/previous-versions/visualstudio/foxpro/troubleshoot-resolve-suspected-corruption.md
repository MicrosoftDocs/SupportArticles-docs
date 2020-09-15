---
title: Troubleshoot to resolve suspected corruption
description: This article provides basic steps to begin troubleshooting data corruption problems encountered in Visual FoxPro.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.topic: how-to
ms.prod: visual-studio-family
---
# How to troubleshoot to resolve suspected corruption in Visual FoxPro

This article provides basic steps to begin troubleshooting data corruption problems encountered in Visual FoxPro.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 193952

## Summary

When you use Microsoft Visual FoxPro, you may sometimes run into problems. The cause of these problems is not always immediately clear. In such situations, you need a general method or a process of trial and error troubleshooting techniques. The steps in the 'More Information' section provide beginning steps for the troubleshooting process. The steps also apply to the distributed application .exe files that are written in Visual FoxPro that you install on client computers.

The first step is to make sure that you have an error free installation of the Visual FoxPro product.
In our experience, if you install the most recent version in the same folder as the previous version, the installation does not complete properly or reliably. This is because all of the files may not update or install correctly.

## More information

1. If Visual FoxPro is installed on local computers use the following steps:

   1. Back up your files. Save any files on the computer that you want to keep; especially database (.dbc/.dct/.dcx) files and table (.dbf/.fpt/.cdx) files, as well as other source files such as `.pjx, .pjt, .vcx,.vct, .scx,.sct, .mnx .mnt, .frx .frt`, and the Config.fpw file.
   2. Remove Visual FoxPro completely, and then delete the directory where it was installed.

        > [!NOTE]
        > This step is not necessary if you are in Step 3. You need to install into a completely new subdirectory.
   3. Close all open or running applications.
    Using CTRL+ALT+DELETE opens the system Task Manager allowing you to see what applications are currently running.

        > [!NOTE]
        > Do not close Explorer because it is the desktop user interface.
   4. Perform operating system disk error check by using Scandisk or a third-party disk repair tool. These tools check and try to fix any lost clusters on the hard drive. After this, run the Disk `Defragmenter` utility (in Windows XP) or other tool to optimize the disk.
2. Once again, close all open or running applications, (See step 1c).
3. Install Visual FoxPro into a new or different directory location.

    A successful product installation means that you do not receive any errors during the installation. Errors during installation indicate an unreliable installation of Visual FoxPro. If errors occur:

    1. Note any errors during installation process.
    2. Boot the machine in Safe Mode or Safe Mode with Networking. Furthermore, temporarily disable any anti virus software.
    3. Start at Step 1 again.

    > [!NOTE]
    > If this is your second time through this process, try using the Custom, Minimal or Laptop installation, instead of Complete.

4. If Visual FoxPro is installed on network server:

   1. You must have an error free installation of Visual FoxPro.
   2. Generally, you cannot perform ScanDisk or other disk integrity checking while a Local Area Network (LAN) or Server is running.
   3. Remove and reinstall Visual FoxPro until no installation errors are received.

5. Eliminate all DUPLICATE source code and project files. This includes both network and local drives.
  
    Duplicate files cause multiple problems. Make sure that you retain the correct version of the source or project file, and ONLY the correct one.
6. If your project contains a DATABASE/DBC, VALIDATE the database.

    > [!NOTE]
    > Please refer to the OPEN DATABASE command in the Visual FoxPro Help file for details.

    Use the OPEN DATABASE <dbcname> EXCLUSIVE VALIDATE command.

    Errors indicate table (.dbf) or index (.cdx) corruption.
7. Clean up the project.

    Open your project and then from the Project menu, choose "Clean Up Project".
  
    Errors indicate project (.pjx) file corruption.

8. As a way to test with a different file, USE the file as you would a table (.dbf), copy the .dbf structure to a new file, and append the records from the original table, and rename the files. This method necessitates the creation of a new index (.cdx) file, if needed.

    > [!NOTE]
    > The following steps use a sample table (.dbf) file named Customer.dbf.

    Database, Project, Screen, Menu, Report, and Label files are actually Table (.dbf) files that have a different extension other than .dbf.

    If your file is open in the Visual FoxPro interactive or design environment, close it.

    Issue the following commands in the Visual FoxPro Command window:

    ```console
     USE customer.dbf && Must specify extension if other than .dbf.
     ? RECCOUNT() && Note the number of records in the table.
     COPY STRUCTURE to newfile.dbf
     USE newfile.dbf && Empty file structure without records.
     APPEND FROM customer.dbf && Bring in records from original table.
     ? RECCOUNT() && Compare number of records with original file.
     RENAME customer.dbf to oldcust.dbf
     RENAME newfile.dbf to customer.dbf
    ```  

    > [!NOTE]
    > A difference in the number of records in the new file as compared to the original file. This is an indicator that file corruption exists in the original file.

9. Test on a different computer or in a different computer environment such as a single user environment if problems occur in a multiuser environment or use a different operating system.

10. If corrupt, the FoxPro resource file may cause problems.

    One way to test whether the resource file is a factor is to replace the file. Here are two ways to determine the name and location of the FoxPro resource file:

    1. You can determine the location of the currently active resource file by using the following FoxPro command: `?SYS(2005)`

    2. You can specify the FoxPro resource file in the FoxPro configuration file, named Config.fpw by default. If the resource file specified by the configuration file does not exist, FoxPro creates one.
       1. Use the following FoxPro command to determine the location of the configuration file: `?SYS(2019)`

       2. The configuration file is an ASCII text file, which can be edited with any editor that saves it in ASCII text format. The easiest way to edit the currently active FoxPro configuration file is with the following command: `MODIFY FILE SYS(2019)`

       3. The configuration file may contain a line of text that specifies the location and name of the resource file, such as follows:

            ```console
             RESOURCE=<path>\foxuser.dbf
            ```  

          If so, comment that line out by placing an asterisk (*) at the beginning of the line.
       4. Add a new line such as the following:

            ```console
             RESOURCE=<path>\newjunk.dbf && Any name of your choice.
            ```  

       5. Restart FoxPro for the new setting to take effect.

11. Create a log file that contains the results of the preceding steps for future reference.

## References

For more information about the setup requirements for Visual FoxPro, see the Readme.hlp Windows Help file that is located in the directory of the Visual FoxPro installation or on the original installation CD-ROM.

Visual FoxPro Help; search on: 'Installing Visual FoxPro', 'Testing and Debugging Applications'.
