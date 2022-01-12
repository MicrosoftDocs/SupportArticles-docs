---
title: How to install Dynamics GP 2015 using command line
description: Introduces how to install Microsoft Dynamics GP 2015 using the command line.
ms.reviewer: Theley, cwaswick
ms.topic: how-to
ms.date: 03/31/2021
---
# How to install Microsoft Dynamics GP 2015 using the command line

This article explains how to install Microsoft Dynamics GP 2015 using the command line.

_Applies to:_ &nbsp; Microsoft Dynamics GP 2015  
_Original KB number:_ &nbsp; 3036773

## Microsoft Dynamics GP 2015 pre-requisites

To install Microsoft Dynamics GP 2015 by using the command line, you must first install the pre-requisite software on the target computer. The pre-requisites are available on the Microsoft Dynamics GP media and can be installed silently or using the user interface.

### .NET Framework 3.51

Install Location: \<Media>\redist\DotNetFX35SP1

> [!NOTE]
> Location contains executable to run. The installation depends on the computers operating system version. For example in Windows 8 and Windows 2012 you will need to add as a windows feature.

### .NET Framework 4.5

Install Location: \<Media>\redist\DotNetFX451

> [!NOTE]
> Location contains executable to run.

### Lync SDK

Install Location: \<Media>\redist\LyncSdkRedist

Parameters: The only parameters are the Windows Installer parameters.

Example: msiexec /i LyncSdkRedist.msi /qb+

### Windows Installer 4.5

Install Location: \<Media>\redist\WindowsInstaller4_5

Parameters:

> [!NOTE]
> There are folders for the different operating systems, XP, Windows Server 2003 and Vista. Run the appropriate one for your environment. If you are on a newer operating system, this version will already be installed.

### SQL Native Client

Install Location: \<Media>\redist\SqlNativeClient

Parameters: The only parameters are the Windows Installer parameters.

Example: msiexec /i sqlncli_x64.msi /qb+

> [!NOTE]
> There is a file for x86 and x64 based computers. Select the appropriate one for your environment.

### Dexterity Shared Components

Install Location: \<Media>\redist\DexteritySharedComponents

Parameters: The only parameters are the Windows Installer parameters.

Example: msiexec /i Microsoft_Dexterity14_SharedComponents_x64_en-us.msi /qb+

> [!NOTE]
> There is a file for x86 based computers and one for x64 based computers. Select the appropriate one for your environment.

### Application Error Reporting (Watson)

Install Location: \<Media>\redist\Watson

Parameters: You must provide the Dexterity Shared Components product code as a parameter.

- Microsoft_Dexterity14_SharedComponents_x64_en-us = { F1B57F7A-EACA-488C-A900-B064D679E3D7}
- Microsoft_Dexterity14_SharedComponents_x86_en-us = { F9DCE6DC-5770-4D58-B5A3-B5012B297A7D}

Example: msiexec /i dw20sharedamd64.msi /qb+ APPGUID {F1B57F7A-EACA-488C-A900-B064D679E3D7}

> [!NOTE]
> There is a file for x86, x64 and i64 based computers. Select the appropriate one for your environment.

### Open XML SDK 2.0 for Microsoft Office

Install Location: \<Media>\redist\OpenXMLFormatSDK

Parameters: The only parameters are the Windows Installer parameters. Example:

Example: msiexec /i OpenXMLSDKv2.msi /qb+

## Microsoft Dynamics GP 2015

After installing the pre-requisites on the computer, you can install Microsoft Dynamics GP 2015 using the following parameters. Example of a command-line installation of an instance named CUSTOMER1 with the Human Resources and Fixed Assets features installed.

```console
msiexec /i GreatPlains.msi /qb+ INSTALLDIR="C:\Program Files\Microsoft 
Dynamics\GP$CUSTOMER1" SELECTED_COUNTRY="United States" 
SQL_SERVER_NAME="SERVERNAME\CUSTOMER1" TRANSFORMS=:Inst01 
INSTANCE_NAME="CUSTOMER1" MSINEWINSTANCE=1 ADDLOCAL = GP,HRM,FAM
```

### INSTALLDIR

Required: Yes, if *not* administrative installation.  
Default Value: \<None>  
Description: The target directory of the installation.  
Accepted Values: {OS Path Validation} + Cannot contain parenthesis or "\\\\"  
Validation: Failure if value specified is not an acceptable value or does not meet path requirements.

Example: INSTALLDIR = "C:\Program Files\Microsoft Dynamics\GP"

### SELECTED_COUNTRY

Required: Yes  
Default Value: \<None>  
Description: Indicates to the install the Country/Region the installation is for  
Accepted Values: {UI Country/Region List} (Case sensitive) Andean, Argentina, Australia, Austria, Belgium, Canada, Chile, China, France, Germany, Hong Kong SAR, Indonesia, Japan, Latin America, Luxembourg, Malaysia, Middle East, Netherlands, New Zealand, Philippines, Singapore, South Africa, Spain, Taiwan, Thailand, United Kingdom & Ireland or United States  
Validation: Failure if value specified is not an acceptable value

Example: SELECTED_COUNTRY="United States"

### SQL_SERVER_NAME

Required: No  
Default Value: \<None>  
Description: If provided, indicates the SQL Server Name used in the creation of the ODBC Data Source.  
Accepted Values: {Any valid SQL Server Name}  
Validation: Abort, Retry, Fail if value specified is not an acceptable value

Example: SQL_SERVER_NAME="."

### ADDLOCAL

Required: No  
Default Value: GP  
Description: The features that will be installed. If the parameter is not provided, only the core GP feature will be installed.  
Accepted Values: ALL or comma-delimited list of the Feature IDs (refer to feature list table below)  
Validation: Failure if value specified is not an acceptable value or does not meet requirements.

Example: ADDLOCAL = GP,HRM,FAM

### INSTANCE_NAME

Required: No  
Default Value: \<None>  
Description: If installing a named instance, indicates to the installation what the instance name should be. This property's value is converted to uppercase.
Accepted Values: <= 15 Characters, != "DEFAULT", !=\<Existing Instance Name>, Does not contain parenthesis or "\\\\"  
Note: MUST be used in conjunction with:"MSINEWINSTANCE=1"  
TRANSFORMS=\<see valid list of imbedded transforms>  
Validation: Failure if value specified is not an acceptable value or does not meet path requirements.

Example: TRANSFORMS=:Inst01 INSTANCE_NAME="FIRST_INSTANCE" MSINEWINSTANCE=1

### TRANSFORMS

Required: No  
Default Value: \<None>  
Description: This is a windows installer property. The intent of this section is to identify the instance transforms that are imbedded within the installation.
Accepted Values: {Inst<##>} :: 01 >= ## <= 50  
i.e. Inst01...Inst50  
Validation: See windows installer documentation.

Example: TRANSFORMS=:Inst01

### TARGETDIR

Required: Yes, if administrative installation.  
Default Value: \<None>  
Description: The target directory of the administrative installation.  
Accepted Values: {OS Path Validation}  
Validation: Failure if value specified is not an acceptable value or does not meet path requirements.

Example: TARGETDIR = "C:\GreatPlains"

### GPSYSDBNAME

Required: No  
Default Value: DYNAMICS  
Description: If provided, indicates the name of the GP system database for this installation. This property's value is converted to uppercase.  
Accepted Values: <= 10 Characters  
Validation: Failure if value specified is not an acceptable value

Example: GPSYSDBNAME="DYN01"

### SBA_USERDOMAIN

Required: Yes if SBA feature is being installed.  
Default Value: \<None>  
Description: The domain name for the Windows Account the Service Based Architecture's Dexterity Service will be run as. Will be combined with the SBA_USERNAME parameter in the format of domain\username.  
Accepted Values: Any valid domain name  
Validation: Failure if value specified is not an acceptable value

Example: SBA_USERDOMAIN="CONTOSO"

### SBA_USERNAME

Required: Yes if SBA feature is being installed.  
Default Value: \<None>  
Description: The user name for the Windows Account the Service Based Architecture's Dexterity Service will be run as. Will be combined with the SBA_USERDOMAIN parameter in the format of domain\username.  
Accepted Values: Any valid user name  
Validation: Failure if value specified is not an acceptable value

Example: SBA_USERNAME="DexServiceAccount"

### SBA_USERPASSWORD

Required: Yes if SBA feature is being installed.  
Default Value: \<None>  
Description: The password for the Windows Account the Service Based Architecture's Dexterity Service will be run as.  
Accepted Values: Valid password for the account provided.  
Validation: Failure if value specified is not an acceptable value.

Example: SBA_USERPASSWORD="Password"

:::image type="content" source="media/how-to-install-microsoft-dynamics-gp-2015-using-command-line/feature-details-1.png" alt-text="Screenshot of Feature list 1, which shows Feature ID, Feature Parent, Feature Name and Country/Region." border="false":::

:::image type="content" source="media/how-to-install-microsoft-dynamics-gp-2015-using-command-line/feature-details-2.png" alt-text="Screenshot of Feature list 2, which shows Feature ID, Feature Parent, Feature Name and Country/Region." border="false":::

:::image type="content" source="media/how-to-install-microsoft-dynamics-gp-2015-using-command-line/feature-details-3.png" alt-text="Screenshot of Feature list 3, which shows Feature ID, Feature Parent, Feature Name and Country/Region." border="false":::
