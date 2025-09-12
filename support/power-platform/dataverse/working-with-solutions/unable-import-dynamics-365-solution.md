---
title: Unable to import Dynamics 365 solution
description: Provides a solution to an issue where you can't import Dynamics 365 solution or install an app because of web resource size.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Working with Solutions
---
# Unable to import Dynamics 365 solution or install an app because of web resource size

This article provides a solution to an issue where you can't import Dynamics 365 solution or install an app because of web resource size.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4499713

## Symptoms

When attempting to import a Dynamics 365 solution or install an app, the import/install fails. If you're importing a solution from within the Dynamics 365 web application, you may see a reference to error code 8004f114. If you're installing an app from the administration center, you may only see a message indicating the installation failed.

## Cause

If you've modified the attachment size limit within System Settings to be smaller than the default value of 5 MB, which can cause solution import to fail if it contains a web resource that is larger than the limit you've configured.

## Resolution

To fix this issue, follow these steps:

1. As a user with the System Administrator security role, access the Dynamics 365 web application and navigate to **Settings** and then select **Administration**.
2. Select **System Settings** and then select the **Email** tab.
3. Locate the section titled **Set file size limit for attachments** to find the option **Maximum file size.**  
4. If the current setting is lower than the default limit of 5,120 kb, change the value back to 5,120 and then select **OK**.
5. Try to import the solution again.
