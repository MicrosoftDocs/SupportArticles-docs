---
title: Access denied when open Intune blade in Azure portal
description: Describes issues in which you can't open the Intune blade or the App protection policies blade after you set up a new Intune tenant.
ms.date: 05/13/2020
ms.prod-support-area-path: Sign in to Intune
---
# Access denied error when you try to open the Intune blade in the Azure portal

This article solves the **Access denied** error that occurs when you open the Intune blade in the Azure portal.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4469679

## Symptoms

After you set up a new Intune tenant to use with Intune or a third-party MDM solution, you experience the following issues:

- When you try to open the Intune blade, you receive the following error message:

    > Access denied  
    > You do not have access  
    > Looks like you don't have access to this content. To get access, please contact the owner.

    :::image type="content" source="media/access-denied-open-intune-blade/access-denied.png" alt-text="screenshot of Access denied":::

- When you try to open the **App protection policies** blade, you receive the following error message:

    > Bad Request  
    > Request not applicable to target tenant.

    :::image type="content" source="media/access-denied-open-intune-blade/bad-request.png" alt-text="screenshot of Bad request":::

## Cause

This issue occurs if the Intune Azure AD application is disabled.

To verify, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com/) as a global administrator.
2. Go to **Azure Active Directory** > **Enterprise Applications** > **Microsoft Intune** > **Properties**.
3. Check whether the **Enabled for users to sign-in?** option is set to **No**.

    :::image type="content" source="media/access-denied-open-intune-blade/intune-properties.png" alt-text="screenshot of Intune properties":::

## Resolution

To fix the issue, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com/)  as a global administrator.
2. Go to **Azure Active Directory** > **Enterprise Applications** > **Microsoft Intune** > **Properties**.
3. Set **Enabled for users to sign-in?** to **Yes**, then select **Save**.
4. Wait 1-24 hours for the tenant to reonboard and complete activation before you retry.
