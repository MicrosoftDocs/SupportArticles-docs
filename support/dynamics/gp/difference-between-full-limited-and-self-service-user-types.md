---
title: Difference between Full, Limited, and Self Service user types
description: This article provides the answer for the question about what is the difference between Full, Limited, and Self Service user types in User Setup in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 02/20/2024
---
# Difference between Full, Limited, and Self Service user types in User Setup in Microsoft Dynamics GP

This article introduces the difference between Full, Limited, and Self Service user types in **User Setup** in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4015051

> [!TIP]
> To open the **User Setup** window, select **Tools** under **Microsoft Dynamics GP**, point to **Setup** > **System**, and select **User**.

## Introduction

At a high level, the permissions for each user type are as follows:

- Self Service

  - Ability to Create requisitions.
  - Ability to enter Payroll timecards and expenses.
  - Ability to enter Project timesheets and expenses, benefits self service, and workflow. (Also known as **Enter** access.)

- Limited

  The Limited user can do all the Self Service user can do. In addition, the Limited user can view all inquiry, reports, and Smartlists. (Also known as **Enter** and **Inquire** access.)
- Full

  The Full user has full control in Microsoft Dynamics GP. (Also known as **Enter**, **Inquire**, and **Edit** access.)

This is always a grey area too because you might expect something then it doesn't allow it based on the user type. It is recommended setting up a user and testing your process if you have limited users.

Sometimes there is a window you want to see in the process that's not available. It is recommended always testing with a user with that type to make sure it all works for their process as you expect.
 
Both Self Service and Limited users can approve workflows.

## More information

The best way to really understand what the users can do is to look at the role-based security inside Microsoft Dynamics GP. For more information, see the following blog articles:

- [What are the SelfServe and Limited Users?](https://community.dynamics.com/blogs/post/?postid=5dd0d260-fd46-49ef-8ada-43ee2cd4db9d)
- [ESS Security roles in Microsoft Dynamics GP 2013/GP2015 - What do they give users access to?](https://community.dynamics.com/blogs/post/?postid=5381b125-c9b6-4f1a-9acf-49034f612b6d)

