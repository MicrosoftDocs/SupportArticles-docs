---
title: A report displays an incorrect EEO class
description: Describes a problem that occurs after you apply the 2006 year-end update. A resolution is provided.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# An Equal Employment Opportunity report displays an incorrect EEO class when you print the EEO report in Microsoft Dynamics GP

This article provides a solution to an issue where an Equal Employment Opportunity report displays an incorrect EEO class when you print the EEO report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 940507

## Symptoms

When you print an Equal Employment Opportunity (EEO) report in Microsoft Dynamics GP, the report displays an incorrect EEO class. When this problem occurs, the report displays "N/A" for the class instead of displaying the actual class. This problem occurs after you apply the 2006 year-end update. This problem occurs in the following products:

- Microsoft Dynamics GP 10.0

- Microsoft Dynamics GP 9.0

- Microsoft Business Solutions - Great Plains 8.0

## Cause

This problem occurs because the 2006 year-end update includes changes to the 2007 EEO report.

## Resolution

To resolve this problem, use one of the following resolutions.

### Microsoft Dynamics GP 10.0

To resolve this problem, install the EEO update for Microsoft Dynamics GP 10.0. To do it, download and run the following file. The following file is available for download from the Microsoft Dynamics File Exchange Server:

- [MicrosoftDynamicsGP-KB940507-v10-ENU.msp](https://mbs2.microsoft.com/fileexchange/?fileid=c4a04a71-91d1-4ee5-b46d-60542fa60a33)

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.  

#### Installation information

Install the EEO update on the server before you update the client. After you install the EEO update on the server, you can use Microsoft Dynamics GP Utilities to update the DYNAMICS database and all the company databases.

We recommend that you have all users exit Microsoft Dynamics GP 10.0 before you install the EEO update. Sign in to Microsoft Dynamics GP 10.0 as the sa user to make sure that the installation is successful.

After you install the EEO update on the server, you can make the update available on the client.

> [!NOTE]
> To update the clients, use one of the following methods:
>
> - Use the Manage Automated Client Updates window to update all the clients. For information about how to set up the automatic updates, see the System Administrator manual.
> - Save the .msp file to each client. Then, double-click the file to complete the installation on each client.

If you use multiple instances of Microsoft Dynamics GP 10.0, you're prompted to restart the computer after you install the EEO update on an instance of Microsoft Dynamics GP 10.0.

You must restart the computer to apply the fixes that are contained in the EEO update. After you restart the computer, you have to install the EEO update again. Then, the EEO update is installed again on the instance that was previously fixed, and the EEO update is installed on all the other instances.

### Microsoft Dynamics GP 9.0

To resolve this problem, install the EEO update for Microsoft Dynamics GP 9.0. To do it, download and run the following file. The following file is available for download from the Microsoft Dynamics File Exchange Server:

- [HR9.00.283.exe](https://mbs2.microsoft.com/fileexchange/?fileid=a01e2334-a20b-4731-80e0-c554a6b0074a)

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.  

#### Installation Information

> [!NOTE]
>
> - To install the EEO update, verify that the version of Human Resources in Microsoft Dynamics GP is 9.00.0283. To verify the version of Human Resources, select **About Microsoft Dynamics GP** on the **Help** menu.
> - If the version of Human Resources is not 9.00.0283, install the latest hotfix for Microsoft Dynamics GP 9.0, and then install the EEO update.  

To install the EEO update for Microsoft Dynamics GP 9.0, follow these steps:

1. Extract the files from the HR9.00.283.exe file to the Microsoft Dynamics GP 9.0 installation folder on the computer.

    > [!NOTE]
    > An HR.cnk file is extracted to the Microsoft Dynamics GP 9.0 installation folder.
2. Repeat step 1 on each computer that uses the back-office application.
3. After the EEO update is installed on each computer, restart the back-office application on all the computers.
4. Sign in to Microsoft Dynamics GP 9.0 as a system administrator.
5. When you receive the following message, select **Yes**:

    > New code must be included.

> [!NOTE]
> If you restart the application, and new code is included before the update is installed on all the computers, the shared Reports.dic file may be damaged.

### Microsoft Business Solutions - Great Plains 8.0

To resolve this problem, install the EEO update for Microsoft Business Solutions - Great Plains 8.0. To do it, download and run the following file. The following file is available for download from the Microsoft Dynamics File Exchange Server:

- [HR800g79.exe](https://mbs2.microsoft.com/fileexchange/?fileid=b1817723-0a00-4e7a-b6fa-a107b8f79824)

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.  

#### Installation info

To install the EEO update for Microsoft Business Solutions - Great Plains 8.0, follow these steps:

1. Extract the files from the HR800g79.exe file to the Microsoft Business Solutions - Great Plains 8.0 installation folder on the computer.

    > [!NOTE]
    > An HR.cnk file is extracted to the Microsoft Business Solutions - Great Plains 8.0 installation folder.
2. Repeat step 1 on each computer that uses the back-office application.

3. After the EEO update is installed on each computer, restart the back-office application on all the computers.
4. Sign in to Microsoft Business Solutions - Great Plains 8.0 as a system administrator.
5. When you receive the following message, select **Yes**:
    > New code must be included.

> [!NOTE]
> If you restart the application, and new code is included before the update is installed on all the computers, the shared Reports.dic file may be damaged.

## Status

- Microsoft Dynamics GP 10.0

    Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section.

- Microsoft Dynamics GP 9.0

    Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section.

- Microsoft Business Solutions-Great Plains 8.0

    Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section.
