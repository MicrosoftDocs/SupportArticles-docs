---
title: Add tracking number to SOP order and invoice forms
description: Introduces how to add tracking number to the SOP order and invoice forms in Microsoft Dynamics GP.
ms.reviewer: aeckman
ms.topic: how-to
ms.date: 03/13/2024
---
# How to add tracking number to the SOP order and invoice forms in Microsoft Dynamics GP

This article introduces how to add the Tracking numbers to our Sales Order Processing Orders and Invoice forms in Microsoft Dynamics GP.

You can see the full [BLOG](https://community.dynamics.com/blogs/post/?postid=cd4b596e-8373-4bb2-a315-fb08d69bff58) article.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4100256

Below are steps on how to create a calculated field in Report Writer using a function to pull the information on a form.

> [!NOTE]
> Steps below are how to add the tracking number to the SOP Blank invoice form, but the same concept applies to other forms. You will be using the `rw_CreateSOPTrackingNumberString` function to pull the information.

1. Open Report Writer by selecting **Microsoft Dynamics GP** > **Tools** > **Customize** > **Report Writer**. Select **Microsoft Dynamics GP** for Product and select **OK**.
2. Select **Reports**.
3. On the Original Report Side, select the **SOP Blank Invoice form** (or the report want to modify) and select **Insert** (Some examples to modify are: SOP Blank Invoice form, SOP Blank Order Form, SOP Blank History Invoice form, SOP Long Order Form, and so on).
4. Select the **SOP Blank Invoice form** on the Modified Reports Side and select **Open**.
5. In the Report Definition Window, select **Layout**.
6. Create a calculated field to pull the Tracking number as follows:

    1. In the **Toolbox**, select **Calculated Fields** from the drop-down list, and then select **New**.
    2. In the Calculated Field Definition window, type *Tracking Number* as the name.
    3. For the Result type, select **String** from the drop-down list.
    4. Select **Calculated** as the Expression Type.
    5. Select the Calculated Expression section.
    6. Select the **Functions** tab.
    7. Select **user Defined**.
    8. Select the drop-down list for **Core** and select **Sales**.
    9. Select the drop-down list for **Function** and select **rw_CreateSOPTrackingNumberString**. Select **Add**.
    10. Select the **Fields** tab.
    11. Select the drop-down list for **Resources** and select **Sales Transaction Work.**
    12. Select the drop-down list for **Fields** and select **SOP Number**. Select **Add**.
    13. Select the drop-down list for **Fields** and select **SOP Type**. Select **Add**.

        The Calculated Expression should read:

        **FUNCTION_SCRIPT(rw_CreateSOPTrackingNumberStringSOP_HDR_WORK.SOP NumberSOP_HDR_WORK.SOP Type)**
    14. Select **OK**.

7. Add the field new *Tracking* Calculated field to the RF section of the Invoice or Order you are modifying. It will print in alphabetical order with a comma between multiple tracking numbers.

    > [!NOTE]
    > There is a character limit of 80 when adding the Tracking Number to Invoices or Orders.

8. Go back to Microsoft Dynamics GP by selecting **File** > **Microsoft Dynamics GP**. Select **Save** to any message you receive.
9. Give access to your modified report by going to **Administration** > **Setup** > **System** > **Alternate/Modified Forms and Reports**.

    1. Select your **ID**.
    2. Select the drop-down list for **Series** and select **Sales**.
    3. Select the drop-down list for **Type** and select **Reports**.
    4. Select the Sales **+** sign in the Alternate/Modified Forms and Reports List section.
    5. Select the **SOP Blank Invoice** form + sign.
    6. Select the option for **Microsoft Dynamics GP (Modified)**.
    7. Select **Save** and close the window.

Hope this article is useful for getting the Tracking numbers onto your forms. If you have any issues or other modifications causing conflicts and need assistance, create a case for troubleshooting.
