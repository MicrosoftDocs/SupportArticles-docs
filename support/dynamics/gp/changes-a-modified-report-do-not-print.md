---
title: Changes to a Modified report don't print
description: Provides a solution to an issue where the changes that you make to a Modified report don't print in Microsoft Dynamics GP.
ms.reviewer: v-marjpa
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Changes that you make to a Modified report don't print in Microsoft Dynamics GP

This article provides a solution to an issue where the changes that you make to a Modified report don't print in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 863346

## Symptoms

You change a Modified report in Microsoft Dynamics GP. When the Modified report is printed, the changes that you made to the report don't print.

## Resolution

To resolve this issue, follow these steps:

1. Make sure that you're changing the correct report by printing the report to your screen, and then select **Modify**. It opens the Modified report in Report Writer.

    The **Modify** button is typically next to the **Send To** button at the top of the report window.
    > [!NOTE]
    > The name of the report. Check whether your changes appear in this report.

    If your changes don't appear, check the location of your modified report in Report Writer.
    > [!NOTE]
    > The name of the report that appears in the title bar of the report window. You can find the report in the **Modified Reports** section.

    > [!NOTE]
    > Maybe you're changing the wrong report or printing a report that you did not modify. Make sure that you are changing the correct report.
2. Make sure that you've the required security access to the report. To grant the required security access, follow these steps:

    Microsoft Dynamics GP 10.0

    1. Open the **Alternate/Modified Forms and Reports** window. To do it, select **Microsoft Dynamics GP**, select **Tools**, select **Setup**, select **System**, and then select **Alternate/Modified Forms and Reports**.
    1. Type the **ID** value and the **Description** text for the report.
    1. In the **Product** list, select **Microsoft Dynamics GP**.
    1. In the **Type** list, select **Reports**.
    1. In the **Alternate/Modified Forms and Report** list, a tree view will be displayed if there are any alternate or modified forms and reports for the product and type that you selected. The tree view is organized by series.
    1. Expand a series to display a list of the forms or reports that are available as alternate or modified forms or reports. By default, the original forms or reports are selected already. If you want a user to be able to access the alternate version of that form or report, choose the alternate form or report.

        For example, If you have a modified Trial Balance Detail report, you should find the report under **Financial Series**. When you expand **Financial Series**, you should see your Trial Balance Detail report, expand the report, and the following two items will be displayed:  
        - Microsoft Dynamics GP
        - Microsoft Dynamics GP (Modified)

        The item with the word **Modified** is the changed report. Choose the report that has the **Modified** option to give users access to the report.
    1. Select **Save**.

    Microsoft Dynamics GP 9.0 and Microsoft Business Solutions 8.0

    1. Open the **Security Setup** window. To do it, select **Tools**, select **Setup**, select **System**, and then select **Security**.
    1. In the **User ID** box, choose the user ID of the person for whom you are setting security. After you have chosen a user ID, all the companies the user has access are displayed in the **Company** list.
    1. In the **Company** list, choose a company. The security that you set for a company will apply to the user only when they access the company.
    1. Do one of the following in the **Product** list:
        - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP**.
        - In Microsoft Business Solutions 8.0, select **Great Plains**.
    1. In the **Type** list, select **Modified Reports**.
    1. In the **Series** list, choose the series that contains your modified report.
    1. In the **Access** list, remove or grant access to individual items.

        When you select a series, the Access list displays the items for the Product, Type, and Series that you selected. Each item appears marked with an asterisk (*). It means the item in the Access List is available for use.

        To remove security, unmark the item. To do it, double-clicking the item. The asterisk will disappear. To grant security to the user, double-click the item and the asterisk will reappear.

        You can select the **Unmark All** button to unmark all items that appear in the list or select **Mark All** to mark all items in the list.
    1. Select **OK** to save the user access information.

3. In the **Company Setup** window, make sure that Security is selected.
    - In Microsoft Dynamics GP 10.0, select **Microsoft Dynamics GP**, select **Tools**, select **Setup**, select **Company**, and then select **Company**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions 8.0, select **Tools**, select **Setup**, select **Company**, and then select **Company**.

4. Make sure that you've made the changes to the correct section in Report Writer.

    For example, if you change the **Page Header** section, you may not see the changes on the first page of the report unless you select the **First Page Header** option in the **Report Definition** window. To locate the **Report Definition** window, select **Printing Options**.
5. Make sure that the report is a **modified** report and not a **customized** report or **secondary copy** of a report.

    Open the **Report Definition** window in Report Writer and make sure that the **Report Name** field can be changed. This field can't be changed in a modified report.

    If you can change this field, then you're working in a **custom** or **secondary copy** of a report.

    To make sure that the **Report Name** field can be changed, follow these steps:

    1. Start Report Writer. To do it, do one of the following steps:
        - In Microsoft Dynamics GP 10.0, select **Microsoft Dynamics GP**, select **Tools**, select **Customize**, and then select **Report Writer**.
        - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions 8.0, select **Tools**, select **Customize**, and then select **Report Writer**.  
    1. Do one of the following steps:
        - In Microsoft Dynamics GP 10.0, select **Microsoft Dynamics GP for version 10**.
        - In Microsoft Dynamics GP 9.0, select **Microsoft Dynamics GP for version 9**.
        - In Microsoft Business Solutions 8.0, select **Great Plains**.  
    1. Select **Reports**.
    1. To open the report that you changed, select the report in the **Modified Reports** section, and then select **Open**. The **Report Definition** window should open.
    1. In the **Report Name** field, make sure that you can change the field.

6. Make sure that you're pointing to the correct Reports.dic file.

    To locate the Reports.dic file, follow these steps:

    1. Do one of the following steps:
        - In Microsoft Dynamics GP 10.0, select **Microsoft Dynamics GP**, select **Tools**, select **Setup**, select **System**, and then select **Edit Launch File**.
        - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions 8.0, select **Tools**, select **Setup**, select **System**, and then select **Edit Launch File**.  
    1. Select your version of Microsoft Dynamics GP.
    1. In the **Dictionary Locations** section, make sure where the **Report Dictionary Location** box is pointed.

        If the Reports.dic is saved locally, the changes that you make to the report will only affect the Reports.dic that is saved locally. If the Reports.dic file is saved to a network location, the changes that you make to the report will only affect the Reports.dic file that is saved to the network location. Make sure that you point the other workstations to the same Reports.dic where the changes were made. You can edit the location of the Reports.dic file in the **Edit Launch File** window on the other workstations.

        If you point to the correct Reports.dic file, but the changes don't appear, try recreating the Reports.dic file. For more information about how to re-create the Reports.dic file, see [How to re-create the Reports.dic file in Microsoft Dynamics GP](https://support.microsoft.com/help/850465).
