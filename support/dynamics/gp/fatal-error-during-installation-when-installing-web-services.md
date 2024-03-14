---
title: Fatal Error During Installation when installing Web Services
description: Describes how to avoid or resolve error messages that may occur during the installation of Web Services for Microsoft Dynamics GP.
ms.reviewer: theley, jplesuk, kyouells
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Fatal Error During Installation when you install Web Services for Microsoft Dynamics GP

This article describes how to avoid or resolve errors that occur during the installation of Web Services for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 973027

## Symptoms

When you try to install Web Services for Microsoft Dynamics GP, you may receive an error message such as the following error message:

> Fatal Error During Installation

## Workaround

To avoid or resolve installation errors, follow these steps:

1. If the server on which Web Services is being installed is different than the Microsoft SQL Server-based server on which the Microsoft Dynamics GP databases reside, enable Network DTC Access on both servers.

    Windows Server 2003

    For more information about how to enable network DTC access in Windows Server 2003, see [How to enable network DTC access](../../windows-server/application-management/enable-network-dtc-access.md).

    Windows Server 2008

    For more information about how to enable network DTC Access on Windows Server 2008, see [Enable Network DTC Access](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753510(v=ws.10)).

2. Verify that the ISO currency codes in Microsoft Dynamics GP are unique and are exactly three characters long. Do this for each currency.

   1. Sign in to Microsoft Dynamics GP as a user who has an administrator role.
   2. Use the appropriate method:

        - If you use Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **System**, and then select **Currency**.
        - If you use Microsoft Dynamics GP 9.0, select **Tools**, point to **Setup**, point to **System**, and then select **Currency**.

   3. In the Currency Setup dialog box, select the **lookup** button next to the **Currency ID** field.
   4. In the Currencies window, verify each currency ID to make sure that there are no duplicate ISO codes. Also, check that each ISO code is exactly three characters long.

3. Verify that a functional currency is specified for each company. To do this, follow these steps:

   1. Sign in to Microsoft Dynamics GP as a user who has an administrator role.
   2. Use the appropriate method:
      - If you use Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010, select **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Financial**, and then select **Multicurrency**.
      - If you use Microsoft Dynamics GP 9.0, select **Tools**, point to **Setup**, point to **Financial**, and then select **Multicurrency**.
   3. In the **Multicurrency Setup** dialog box, verify that there is a value in the **Functional Currency** field. If the **Functional Currency** field is empty, select the magnifying glass to the right side of the field, and then select a currency.
   4. Select **OK** if you made any changes.
   5. Repeat steps 3b through 3d for each company.

4. Verify that all the companies that are listed in the DYNAMICS database still exist. Then make sure that all the companies are upgraded to the current version of Microsoft Dynamics GP. To do this, follow these steps:

    1. Run the ClearCompanies.sql script to remove references in the DYNAMICS database to companies that no longer exist.

    2. Run the following script:

        ```sql
        select * from DYNAMICS..DB_UPGRADE
        ```

    3. In the results from the script that you ran in step 4b, verify that all entries in the **db_status** column are **0**.
    4. In the results of the script that you ran in step 4b, verify that all entries in the **db_verMajor** and **db_verOldMajor** columns are at the same number as the version of Microsoft Dynamics GP that you are using. For example, if you are using Microsoft Dynamics GP 10.0, all entries in the **db_verMajor** and **db_verOldMajor** columns will be **10**.

        > [!NOTE]
        > If the results in step 4c and 4d are incorrect, contact Microsoft Dynamics support to help resolve the upgrade issues before you try to install Web Services for Microsoft Dynamics GP.

5. If you use Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 9.0, make sure that the Internet Information Services (IIS) site on which Web Services is being installed has no other applications installed, such as SQL Reporting Services or Microsoft Dynamics CRM. In addition, the site cannot be extended through SharePoint. To do this, follow these steps.

    Windows Server 2003

    1. Select **Start**, and then select **Administrative Tools**.
    2. Select **Internet Information Services (IIS) Manager**.
    3. In Internet Information Services (IIS) Manager, expand the plus sign that is next to the computer name, and then expand **Web Sites**.
    4. Select the Web site on which Web Services will be installed. In the right pane, verify there are no virtual directories, files, or other contents already installed or listed on this site.

        > [!NOTE]
        > If there are any files displayed in step 5d, create a new IIS site to which you can install Web Services.

    Windows Server 2008

    1. Select **Start**, and then select **Administrative Tools**.
    2. Select **Internet Information Services (IIS) Manager**.
    3. In Internet Information Services (IIS) Manager, expand the plus sign next to the computer name, and then expand **Sites**.
    4. Select the Web site on which Web Services will be installed, and then select **Content View** at the bottom of the Internet Information Services (IIS) Manager window.
    5. In this Content View, verify that there are no virtual directories, files, or other contents already installed or listed in this site.

        > [!NOTE]
        > If there are any files that are displayed in step 5e, create a new IIS site on which you can install Web Services.

6. If you tried to install Web Services but failed after you followed steps 1 to 5, use one of the following methods.

    Method 1: Uninstall Web Services for Microsoft Dynamics GP

    > [!NOTE]
    > Make sure that all components of Web Services are removed from the environment.

## References

For more information about how to install Web Services for Microsoft Dynamics GP 10.0 on an x64 operating system, see [Description of the 64-bit operating systems that are supported together with Microsoft Dynamics GP](https://support.microsoft.com/topic/description-of-the-64-bit-operating-systems-that-are-supported-together-with-microsoft-dynamics-gp-d583064f-4896-a1f4-7fa9-f3f0dba0ab83).
