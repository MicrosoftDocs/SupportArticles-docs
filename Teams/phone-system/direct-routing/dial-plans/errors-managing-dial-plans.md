---
title: Errors when trying to manage dial plans
description: Describes errors that occur if you try to manage dial plans by using an unlicensed account. 
ms.date: 4/30/2021
author: meerak
ms.author: v-matham
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.service: msteams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams
ms.custom: 
- CI 148559
- CSSTroubleshoot 
ms.reviewer: teams_triage
---

# Errors when trying to manage dial plans 

## Symptoms

**Error message 1**

When you try to access a dial plan in the Microsoft Teams admin center, you receive the following error message:

> We can’t get the effective dial plan so the dial plan can’t be tested.

:::image type="content" source="./media/errors-managing-dial-plans/cant-get-dial-plan.png" alt-text="Test dial plan window shows error":::

**Error message 2**

When you try to test a dial plan, you receive the following error message:

> Something went wrong while testing this phone number. If you continue to have problems, contact Microsoft customer support. 

:::image type="content" source="./media/errors-managing-dial-plans/something-went-wrong.png" alt-text="Test number window shows error":::

**Error message 3**

When you run the [Get-CsEffectiveTenantDialPlan](/powershell/module/skype/get-cseffectivetenantdialplan) cmdlet in Teams PowerShell to try to see the details of a dial plan, you receive the following error message:

> Management object not found for identity <UPN> 

:::image type="content" source="./media/errors-managing-dial-plans/management-object.png" alt-text="Teams PowerShell shows error":::
  
## Cause

These actions trigger a query to look up the value of the **EffectiveTenantDialPlanName** property. This property is used to populate the information in the dial plan. If you’re an administrator who does not have an applicable product license, this query can’t run. Because the value is not returned, an error occurs.

## Resolution

If you have to [manage dial plans](/microsoftteams/create-and-manage-dial-plans), your administrator account must be [assigned a Teams license](microsoft365/admin/manage/assign-licenses-to-users).
