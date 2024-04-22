---
title: Create an external translation Integration Source file in Integration Manager for Microsoft Dynamics GP
description: Describes how to create an external translation Integration Source file in Integration Manager for Microsoft Dynamics GP.
ms.topic: how-to
ms.reviewer: theley, dlanglie
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to create an external translation Integration Source file in Integration Manager for Microsoft Dynamics GP

This article describes how to create an external translation Integration Source file in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 858951

## Introduction

In Integration Manager for Microsoft Dynamics GP, you can create an Integration Source file that acts as an external translation table. For example, if you perform a General Journal integration that requires translation from an old account number to a new account number, you can create an external translation Integration Source file that performs this action.

## More information

Typically, a General Journal integration contains the following two Integration Source files:

- A header Integration Source file
- A detail Integration Source file

If you want to use an external translation file, you must add a translation Integration Source file so that you have three Integration Source files. The translation table has the following two columns:

- A column for the old account number
- A column for the new account number that the old account number is translated to

To create an external translation Integration Source file, follow these steps:

1. Create the integration, and then perform the mapping exactly like you would perform the mapping for a standard integration that has two Integration Source files.

    > [!NOTE]
    > The integration does not run because the detail Integration Source file contains the old account numbers.

2. Create the additional translation Integration Source file, and then link the file to the detail Integration Source file by using the old account number. The linking must be as follows:

   - The date field in the General Journal header Integration Source file must link to the date field in the General Journal detail Integration Source file.
   - The account field in the general journal detail Integration Source file must link to the old account number field in the translation Integration Source file.

3. Open the Destination Mapping folder in General Journal, and then remap the account number column. Use the account number field from the translation Integration Source file instead of the account number field from the detail Integration Source file.

4. Run the integration. When you do this, Integration Manager views the original account number, and then Integration Manager looks up the new account number in the translation Integration Source file. After you follow these steps, Integration Manager uses the new account number when the General Journal transactions integrate into Microsoft Dynamics GP.
