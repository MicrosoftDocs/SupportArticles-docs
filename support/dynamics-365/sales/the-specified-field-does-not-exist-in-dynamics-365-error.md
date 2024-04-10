---
title: Specified field does not exist error during configuration
description: You can't configure Microsoft Dynamics 365 for Outlook due to the specified field does not exist in Microsoft Dynamics 365 error. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# The specified field does not exist in Microsoft Dynamics 365 error when setting Microsoft Dynamics 365 for Outlook

This article provides a resolution for the issue that you can't set Microsoft Dynamics 365 for Outlook due to **The specified field does not exist in Microsoft Dynamics 365** error.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4503998

## Symptoms

When you try to configure Microsoft Dynamics 365 for Outlook, you encounter the following error:

> "The specified field does not exist in Microsoft Dynamics 365."

## Cause

This error occurs if you are using version 8.2.x of Microsoft Dynamics 365 for Outlook to connect to a Microsoft Dynamics 365 Online organization and the LinkedIn Sales Navigator solution is installed.

> [!NOTE]
> This solution was installed automatically for a period of time.

## Resolution

Microsoft is aware of this issue and investigating additional potential solutions. In the meantime, one of the following solutions can be used:

### Download and install version 9 of Microsoft Dynamics 365 for Outlook

Download and install version 9 of Microsoft Dynamics 365 for Outlook from [Dynamics 365 for Outlook, version 9.0 (Outlook client)](https://www.microsoft.com/download/details.aspx?id=56972).

### Uninstall the LinkedIn solutions

For some organizations, the LinkedIn Sales Navigator solution was installed automatically. If your organization is not using the LinkedIn Sales Navigator features, you can uninstall this solution. To successfully remove this solution, the following solutions need to be removed in this order:

- LinkedInSalesNavigatorControlsForUnifiedClient
- LinkedIn
- msdyn_LinkedInSalesNavigatorAnchor

1. To uninstall a solution, sign in to the Microsoft Dynamics 365 web application as a user with the System Administrator role.
2. Navigate to **Settings** and then select **Solutions**.
3. Select the solution with the **Name** = **LinkedInSalesNavigatorControlsForUnifiedClient** and then select **Delete.**  
4. Repeat this process for the other two solutions mentioned above in the order they are listed.
