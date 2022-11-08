---
title: Human Resources reports for OSHA 300 300A and 301 are incorrect
description: The words on the OSHA 300, OSHA 300A, and OSHA 301 report in Microsoft Dynamics GP have a larger font and are cut off. Provides a resolution.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Human Resources reports for OSHA 300, OSHA 300A, and OSHA 301 display incorrectly

This article provides a resolution for the issue that the words on the OSHA 300, OSHA 300A, and OSHA 301 report in Microsoft Dynamics GP have a larger font and are cut off.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2517298

## Symptoms

The words on the OSHA 300, OSHA 300A, and OSHA 301 report in Microsoft Dynamics GP 2010 have a larger font and are cut off.

## Cause

The text font and characters per inch were changed in Microsoft Dynamics GP 2010 causing the words to be larger and cut off into other fields.

## Resolution

Modified versions of these reports have been created and can be installed using the following steps:

Step 1: Copy the link below to access the reports library on CustomerSource and download the modified reports to your local drive.

The reports are titled:

Modified_OSHA 301_2010.pkg  
Modified_OSHA300_2010.pkg  
Modified_OSHA300A_2010.pkg

Step 2: Import the modified reports from your local drive to Microsoft Dynamics GP:

1. Select Microsoft Dynamics GP, point to **Tools**, point to **Customize**, and then select **Customization Maintenance**.  
2. Select the **Import** button.
3. Select the **Browse...** button and browse out to the location where the appropriate package file has been saved.
4. Select **OK**.

Step 3: Grant security to the modified reports in Microsoft Dynamics GP:

1. Select Microsoft Dynamics GP, point to **Tools**, point to **Setup**, point to **System**, and then select **Alternate/Modified Forms and Reports**.
2. Select the User ID by selecting the looking glass.
3. Point to Product and then select **Human Resources** from within the dropdown menu.
4. Point to Type and then select **Reports** from within the dropdown menu.
5. In the **Alternate/Modified Forms and Reports** list, expand third Party by selecting the **expansion** button.
6. Expand the OSHA 300, OSHA 300A, or OSHA 301 report by selecting the **expansion** button next to each report name (as needed).
7. Select the **radio** button next to Human Resources (Modified).  
8. Select **Save**, and then exit the **Alternate/Modified Forms and Reports** window.
