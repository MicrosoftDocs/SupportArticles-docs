---
title: Set up a GL Transaction Integration with Analytical Accounting in Dynamics GP
description: This article provides a step-by-step example of how to set up a GL Transaction Integration with Analytical Accounting mappings in Integration Manager for Microsoft Dynamics GP.
ms.topic: how-to
ms.reviewer: grwill
ms.date: 03/31/2021
---
# Steps to set up a GL Transaction Integration with Analytical Accounting in Microsoft Dynamics GP

This document will walk you through the necessary steps to set up a GL Transaction integration that includes Analytical Accounting mappings using Integration Manager for Microsoft Dynamics GP. This article will cover two common setup scenarios for importing Analytical Accounting information with a GL Transaction.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2687958

## Business scenario

Many companies use the Analytical Accounting module to help track their financial information. Many users also need to import transaction information into Dynamics GP which will include the AA information. Previous to Dynamics GP and Integration Manager 10.0, this was not possible as Integration Manager did not support AA. Those users would have to manually add the AA information after the transactions were imported, a process which could be very time consuming (and outlined in KB 897742).

[How to move from Multidimensional Analysis to Analytical Accounting](https://support.microsoft.com/topic/how-to-move-from-multidimensional-analysis-to-analytical-accounting-857079fe-b667-8434-b3ea-6c8f3a63d5fb)

## Background information

Starting with Microsoft Dynamics GP/Integration Manager 10.0, Integration Manager now utilizes eConnect for select destination adapters (formerly the 'SQL Optimized' destination adapters). When using the eConnect destination adapters, it is now possible to import the following transaction types with Analytical Accounting information:

- GL Transactions
- Sales Transactions
- Inventory Transactions
- POP Receivings Transactions

In this article, we will look at two common scenarios for integrating GL Transactions that include AA information.

## Activate Analytical Accounting

1. In Dynamics GP, click on **Tools** under Microsoft Dynamics GP, point to **Setup**, point to **Company**, point to **Analytical Accounting** and click **Setup**. This will open the **Analytical Accounting Setup Wizard** window.
2. Ensure that **Create Default Record** is checked and click **Next**, then click **Finish**.
3. Go back to the **Analytical Accounting Setup Wizard** window again. (See step 1.) The **Create Default Record** option should now be grayed out.
4. Now check **Activate Analytical Accounting** option and click **Next**, then **Finish**.
5. Click **Yes** to proceed with the activation.
6. Click **OK** when it is finished.

## Set up sample AA Dimensions and Dimension Codes

1. First, create three new test accounts that we will use for AA:

    1. In Microsoft Dynamcis GP, click on **Cards**, point to **Financial** and click **Account**.
    2. Create the following accounts:

        |Account|Description|Category|
        |---|---|---|
        |999-9999-01|AA Test Account 1|Cash|
        |999-9999-02|AA Test Account 2|Cash|
        |999-9999-03|AA Test Account 3|Cash|
        ||||

    3. Accept all other defaults.

2. Create the AA Transactions Dimension:

    1. In Microsoft Dynamcis GP, click on **Cards**, point to **Financial**, point to **Analytical Accounting** and click **Transaction Dimension**.
    2. Create the Trx Dimension by entering ELECTRONICS for the Trx Dimension.
    3. Select for the Data Type Alphanumeric.
    4. Enter Electronics for the Description 1 field.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/enter-electronics-for-description1-field.jpg" alt-text="Enter Electronics for the Description 1 field.":::

    5. Click Save and close the Transaction Dimension Maintenance window.

3. Create the AA Transaction Dimension Codes:

    1. In Microsoft Dynamics GP, click on **Cards**, point to **Financial**, point to **Analytical Accounting**, and click **Transaction Dimension**.
    2. Choose the **Dimension ELECTRONICS**.
    3. Enter *XBOX* for the Trx Dimension Code.
    4. Enter *XBOX Hardware/Accessories* for the Description.
    5. Select the **Lookup** and choose **ELECTRONICS** for the **Linked to Node**.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/select-electronics-for-linked-to-node.jpg" alt-text="Choose ELECTRONICS for the Linked to Node.":::

    6. Click **Save**.
    7. Keep the window open, now enter *TV* for the Trx Dimension Code.
    8. Enter *Televisions* for **Description 1**.
    9. Select the Lookup and choose **ELECTRONICS** for the **Linked to Node**.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/select-electronics-for-linked-to-node-again.jpg" alt-text="Choose ELECTRONICS for the Linked to Node again.":::

    10. Click **Save**.
    11. Enter *STEREO* for the Trx Dimension Code.
    12. Enter *Stereo Equipment* for Description 1.
    13. Select the **Lookup** and choose **ELECTRONICS** for the **Linked to Node**.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/select-electronics.jpg" alt-text="select ELECTRONICS.":::

4. Now grant access to the Dimension Codes:

    1. In Microsoft Dynamics GP, click on **Tools**, point to **Setup**, point to **Company**, point to **Analytical Accounting** and click **User Access**.
    2. For **Trx Dimension**, choose the **Dimension ELECTRONICS**.
    3. Select the Trx Dimension Code XBOX, then click the **Distribute** and **Adjust** check boxes at the bottom of the window to enable the code for all users.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/grant-access-to-dimension-codes.jpg" alt-text="Grant user access to Dimension Codes.":::

    4. Click **Save**.
    5. Repeat steps b and c for the STEREO and TV" Dimension Codes.

5. Create the Accounting Class to link our test accounts we created to the AA Dimensions:

    1. In Microsoft Dynamics GP, click on **Cards**, point to **Financial**, point to **Analytical Accounting** and click **Accounting Class**.
    2. Enter the Class ID *ELECTR_CLASS*.
    3. Enter *Electronics Account Class* for the **Description 1** field.
    4. In the Grid, you should see the **ELECTRONICS** Trx Dimension. Change the **Analysis Type** to **Optional**.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/create-accounting-class-to-link-test-accounts.jpg" alt-text="Create Accounting Class to link test accounts.":::

    5. Click the **Accounts** in the bottom right corner.
    6. You may be prompted to save changes to the Accounting class. Click **Save**.
    7. Scroll down in the list of accounts and find the three accounts you created in step 1.
    8. Mark the **Link** checkbox next to each account 999-9999-01, 999-9999-02 and 999-9999-03.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/mark-link-checkbox-next-to-each-account.jpg" alt-text="Mark the Link checkbox next to each account.":::

        - You may be prompted with a message saying "This change will affect un-posted transactions and adjustments, if any. Do you want to continue?"
        - Click **Continue**.

    9. Close the **Account Class Link** window to return back to the **Accounting Class Maintenance** window.

    10. Click Save and close the window.

## Build the Integrations - GL Transaction (with Sequence required)

Example scenario:

One of the Analytical Accounting enabled accounts appears more than once in the distributions. Also, the distribution amount is being split out to multiple Dimension Codes. Because the same distribution account appears more than once, we must map the Line Item Sequence value on the GL Distributions so the AA information can be linked to the correct distribution line/amount.

Furthermore, since the distribution amount for a single line is being split out into multiple Dimension Codes, we must also map the "Assign ID" field for the Analytics Dimension.

1. To support these requirements, create a Tab Delimited text file for the header and distributions source queries with the following data (include the column headings as shown):

    |JournalNum|TrxDate|Account|Amount|Sequence|
    |---|---|---|---|---|
    |10000|4/12/2017|000-1100-00|500|500|
    |10000|4/12/2017|000-1200-00|-500|1000|
    |10001|4/12/2017|999-9999-01|16200|500|
    |10001|4/12/2017|000-1100-00|-16200|1000|
    |10001|4/12/2017|999-9999-01|2000|1500|
    |10001|4/12/2017|000-1200-00|-2000|2000|
    ||||||

2. Save the file as a Tab Delimited text file (*.TXT). For this example, name the file "AA GLTrx-with Seq.txt".

3. Create a second Tab Delimited source file that contains the AA Distribution information (include the column headings as shown):

    |JournalNum|Account|Amount|Dimension|DimensionCode|CodeAmount|AAAsignID|Sequence|
    |---|---|---|---|---|---|---|---|
    |10001|999-9999-01|16200|ELECTRONICS|XBOX|8000|1|500|
    |10001|999-9999-01|16200|ELECTRONICS|TV|7000|2|500|
    |10001|999-9999-01|16200|ELECTRONICS|STEREO|1200|3|500|
    |10001|999-9999-01|2000|ELECTRONICS|XBOX|1100|1|1500|
    |10001|999-9999-01|2000|ELECTRONICS|TV|600|2|1500|
    |10001|999-9999-01|2000|ELECTRONICS|STEREO|300|3|1500|
    |||||||||

    > [!NOTE]
    > The AAssignID value will be used since we are splitting the distribution amount across multiple Dimension codes. The Sequence value is required because the distribution account 999-9999-01 appears on more than one distribution line, therefore the Sequence value is required to link the AA information to the correct distribution line.

4. Save the file as a Tab Delimited text file (*.TXT). For this example, name the file AA GLTrx-with Seq AA Dimension.txt.

5. Open Integration Manager and click on **New Integration**. Give it the name GL Transaction - AA with Sequence".

6. Create the Header Source Query

    1. Click on **Add Source**, click on **Text**, then click on **Define New Text**.
    2. Give the source query the name GL Header and browse out to the first file you created named AA GLTrx-with Seq.txt.
    3. Choose **Tab** as the delimiter and check the box **First Row Contains Column Names**.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/check-the-box-first-row-contains-column-names.jpg" alt-text="Check the box First Row Contains Column Names.":::

    4. Since we are using a single source file for the Header and Distribution lines, we need to set up the Grouping on the header fields. Click on the **Sorting** tab.
    5. Add **JournalNum** and **TrxDate** to the **Group By** fields list, then click **OK** to save the query. Click **OK** again on **Warning** stating there are fields named as Show that is not in the Group By list. This is expected.
    6. Right-click on the GL Header query and make sure you can preview the data as follows:

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/preview-gl-header-query-data.jpg" alt-text="Preview data in GL Header query.":::

7. Create the Distribution Source Query

    1. Click on **Add Source**, click on **Text**, then click on **Define New Text**.
    2. Give the source query the name GL Distributions and again browse out to the first file you created named AA GLTrx-with Seq.txt.
    3. Choose **Tab** as the delimiter and check the box **First Row Contains Column Names**.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/query-properties.jpg" alt-text="Query Properties.":::

    4. Click **OK** to save the query. You will receive a message stating that you must set up Query Relationship. Click **OK** to dismiss the dialog. We will set that up later once all the queries are created.
    5. Right-click on the GL Distributions query and make sure you can preview the data as follows:

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/preview-data-on-the-gl-distributions-query.jpg" alt-text="Preview data on the GL Distributions query.":::

8. Create the AA Dimension Source Query

    1. Click on **Add Source**, click on **Text**, then click on **Define New Text**.
    2. Give the source query the name GL AA Dimension" and browse out to the second file you created for the AA information named AA GLTrx-with Seq AA Dimension.txt.
    3. Choose **Tab** as the delimiter and check the box **First Row Contains Column Names**.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/select-tab-as-delimiter.jpg" alt-text="Choose Tab as the delimiter.":::

    4. Click **OK** to save the query.
    5. Right-click on the GL AA Dimension query and make sure you can preview the data as follows:

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/preview-data-on-gl-aa-dimension-query.jpg" alt-text="Preview data on GL AA Dimension query.":::

9. Create the AA Dimension Code Source Query

    1. Click on **Add Source**, click on **Text**, then click on **Define New Text**.
    2. Give the source query the name GL AA Dimension Code and browse out to the second file you created for the AA information named AA GLTrx-with Seq AA Dimension.txt.
    3. Choose **Tab** as the delimiter and check the box **First Row Contains Column Names**.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/screenshot-of-step-3.jpg" alt-text="Screenshot of step 3.":::

    4. Click **OK** to save the query.
    5. Right-click on the GL AA Dimension Code query and make sure you can preview the data as follows:

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/preview-data-on-gl-aa-dimension-code-query.jpg" alt-text="Preview data on the GL AA Dimension Code query.":::

10. Set up the Query Relationships

    1. Double-click on **Query Relationships**.
        1. Since the Journal Number is the key field that differentiates one transaction from the next, this key field should go all the way through the Query relationship chain.

            :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/relationships-gl-transaction-aa-with-sequence.jpg" alt-text="Integration-Manager-GL Transaction - AA with Sequence - AA Samples.":::

        2. To link the AA information, since the AA Dimension information is linked per distribution line, next we need to establish a link between the GL Distributions query and the "L AA Dimension query. As stated in the overview, a given GL account may appear more than once in a single transaction, there we must us the Sequence field to link the AA Dimension to the correct distribution line.

            :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/link-information.jpg" alt-text="Link the AA information.":::

        3. Continuing down the relationship, the AA Dimension Codes are linked back to a given AA Dimension. In this example, we need to continue linking with the Sequence field and also add the DimensionCode field. At this point, all the appropriate relationships have been established so your Query Relationship window should look like the following:

            :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/link-with-sequence-add-dimensioncode.jpg" alt-text="Link with Sequence field and add DimensionCode field.":::

    2. Add the Destination Adapter

        1. Click on **Add Dest**, expand Microsoft Dynamics GP eConnect, click on **Financial** and select **GL Transaction**.
        2. In the Server Name field, enter in the name of your SQL Server instance (not a DSN name) and the company database name.

            :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/enter-sql-server-instance-name-and-company-database-name.jpg" alt-text="Enter SQL Server instance name and company database name.":::

    3. Define the field mappings

        1. Double-click on **Destination Mapping** to open the field mapping window.

        2. For GL Transactions with AA information, the Journal Entry # is *REQUIRED*. This field cannot be defaulted in! Some advanced users will use a VBScript on the Journal Entry# field to get the next number, but it does have to be supplied in the mapping otherwise the AA information cannot be linked to the transaction correctly.

        3. Provide a constant for the Batch ID and Reference fields.

            :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/provide-constant-for-batch-id-and-reference-fields.jpg" alt-text="Provide constant for Batch ID and Reference fields.":::

        4. Click on the **Entries** folder. Map the **Account Number**, **Debit/Credit Amount** and **Sequence Line** to the fields from the GL Distributions query.

            :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/map-fields.jpg" alt-text="Map the Account Number, Debit/Credit Amount and Sequence Line to the fields from the GL Distributions query.":::

            > [!NOTE]
            > The Sequence Line field is required in this case since the GL Account may appear more than once within the same GL Transaction. Without this field mapped, the AA information cannot be linked to the correct distribution.

        5. Click on the **Analytics** folder. Map the **Assign ID** and **Amount** field from the GL AA Dimension source query as follows:

            :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/map-assign-id-and-amount-field.jpg" alt-text="Map the Assign ID and Amount field from the GL AA Dimension source query.":::

            > [!NOTE]
            > The **Assign ID** field is required in this case since we are splitting out the distribution amount to more than one AA Dimension Code.

            Optional: If the percentages are known instead of the Amounts, you can map the **Assigned Percent** field instead of the **Amount** field. You do not need to map both!

        6. Click on the **Dimensions** folder. In this example, we are only using Alphanumeric Dimension Codes, so we will map the Transaction Dimension and Transaction Dimension AlphaNumeric" from the GL AA Dimension Code source query.

        7. Map the **Transaction Dimension** to the **Dimension** field from the source query and **Transaction Dimension AlphaNumeric** to the **DimensionCode** field from the source query:

            :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/map-field-from-source-query.jpg" alt-text="Map the field from the source query.":::

        8. The field mappings are now complete! Save the Integration.
        9. Go ahead and Run the integration now to bring in the two Journal Entries.

11. Verify the Transaction Integrated as expected.

    1. The first Journal Entry does not have any AA information, so we will look at the second transaction, Journal Number 10001.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/second-transaction-journal-number-10001.jpg" alt-text="The second transaction, Journal Number 10001.":::

    2. To inspect the AA distributions, click on the first distribution line, then click the **Analytical Accounting** button. We should see the distribution amount of $16,200 has been split across 3 different AA Dimension Codes as follows:

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/the-distribution-amount-of-16200.jpg" alt-text="The distribution amount of $16,200: $8000.":::

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/the-distribution-amount-of-16200-7000.jpg" alt-text="The distribution amount of $16,200: $7000.":::

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/the-distribution-amount-of-16200-1200.jpg" alt-text="The distribution amount of $16,200: $1200.":::

    3. You can use the VCR buttons at the bottom of the window to navigate to the second Analytics distribution where you will see that the distribution amount of $2000 has also been split out across the 3 AA Dimension Codes.

## Build the Integrations - GL Transaction (No Sequence required)

Example scenario:

The Analytical Accounting enabled accounts do NOT appear more than once in the distributions. The AA information represents a one-to-one relationship in the source data. This means that a single distribution line links to only one AA Dimension which has only one AA Dimension Code. Because it's one-to-one, we do not need a Sequence Number or the Assign ID fields. For this example scenario, we can use a single source file.

1. To support these requirements, create a Tab Delimited text file (*.TXT) with the following data:

    |JournalNum|TrxDate|Account|Amount|Dimension|DimensionCode|
    |---|---|---|---|---|---|
    |10003|4/12/2017|000-1100-00|500|||
    |10003|4/12/2017|000-1200-00|-500|||
    |10004|4/12/2017|999-9999-01|8000|ELECTRONICS|XBOX|
    |10004|4/12/2017|999-9999-02|7000|ELECTRONICS|TV|
    |10004|4/12/2017|999-9999-03|7000|ELECTRONICS|STEREO|
    |10004|4/12/2017|000-1100-00|-16200|||
    |10005|4/12/2017|999-9999-01|1100|ELECTRONICS|XBOX|
    |10005|4/12/2017|999-9999-02|600|ELECTRONICS|TV|
    |10005|4/12/2017|999-9999-03|300|ELECTRONICS|STEREO|
    |10005|4/12/2017|000-1100-00|-2000|||
    |||||||

2. Save the file as a Tab Delimited text file (*.TXT). For this example, name the file "AA GLTrx-No Seq.txt".

3. Open Integration Manager and click on **New Integration**. Give it the name "GL Transaction - AA without Sequence".

4. Create the Header Source Query.
    1. Click on **Add Source**, click on **Text**, then click on **Define New Text**.

    2. Give the source query the name GL Header - No Seq  and browse out to the source file you created named AA GLTrx-No Seq.txt.

    3. Choose **Tab** as the delimiter and check the box **First Row Contains Column Names**.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/check-the box-first-row-contains-column-names.jpg" alt-text="Check the box First Row Contains Column Names again.":::

    4. Since we are using a single source file, we need to setup the Grouping on the header fields. Click on the **Sorting** tab.

    5. Add JournalNum and TrxDate to the Group By fields list, then click **OK** to save the query. Click **OK** again on **Warning** stating there are fields named as Show that is not in the Group By list. This is expected.

    6. Right-click on the GL Header - No Seq query and make sure you can preview the data as follows:

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/preview-data-of-gl-header-no-seq-query.jpg" alt-text="Preview data of GL Header - No Seq query.":::

5. Create the Distribution Source Query.
    1. Click on **Add Source**, click on **Text**, then click on **Define New Text**.

    2. Give the source query the name GL Distributions - No Seq  and again browse out to the source file you created named AA GLTrx-No Seq.txt.

    3. Choose **Tab** as the delimiter and check the box **First Row Contains Column Names**.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/choose-tab-as-the-delimiter.jpg" alt-text="Choose Tab as the delimiter again.":::

    4. Click **OK** to save the query. You will receive a message stating that you must setup Query Relationship. Click **OK** to dismiss the dialog. We will set that up later once all the queries are created.
    5. Right-click on the GL Distributions - No Seq query and make sure you can preview the data as follows:

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/preview-data-of-gl-distributions-no-seq-query.jpg" alt-text="Preview data of GL Distributions - No Seq query.":::

6. Create the AA Dimension Source Query

    1. Click on **Add Source**, click on **Text**, then click on **Define New Text**.

    2. Give the source query the name GL AA Dimension - No Seq and browse out to the source file you created named AA GLTrx-No Seq.txt.
    3. Choose **Tab** as the delimiter and check the box **First Row Contains Column Names**.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/choose-tab-as-the-delimiter-for-aa-dimension-source-query.jpg" alt-text="Choose Tab as the delimiter and check the box First Row Contains Column Names.":::

        1. Click on the **Filter** tab and add a restriction with the following settings:
            - Column: Dimension
            - Operator: <>
            - Value: 0
        2. Click **And Into Criteria**.

            :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/click-and-into-criteria.jpg" alt-text="Click And Into Criteria.":::

    4. Click **OK** to save the query.
    5. Right-click on the GL AA Dimension - No Seq query and make sure you can preview the data as follows:

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/preview-data-of-aa-dimension-source-query.jpg" alt-text="Preview data of AA Dimension Source Query.":::

7. Create the AA Dimension Code Source Query
    1. This query will be setup identical to the Dimension query we just created since this example is a one-to-one sample for the distribution/dimension/dimension code relationship. Click on **Add Source**, click on **Text**, then click on **Define New Text**.
    2. Give the source query the name GL AA Dimension Code - No Seq and browse out to the source file you created named AA GLTrx-No Seq.txt.
    3. Choose **Tab** as the delimiter and check the box First Row Contains Column Names.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/select-first-row-contains-column-names.jpg" alt-text="AA Dimension Code Source Query - check First Row Contains Column Names.":::

        1. Click on the **Filter** tab and add a restriction with the following settings:
            - Column: Dimension
            - Operator: <>
            - Value: 0
        2. Click **And Into Criteria**.

            :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/select-and-into-criteria.jpg" alt-text="Select And Into Criteria.":::

    4. Click **OK** to save the query.
    5. Right-click on the GL AA Dimension Code - No Seq query and make sure you can preview the data as follows:

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/data-viewer-gl-aa-dimension-code-no-seq.jpg" alt-text="Data Viewer GL AA Dimension Code - No Seq.":::

8. Set up the Query Relationships.
    1. Double-click on **Query Relationships**.
        1. Since the **Journal Number** is the key field that differentiates one transaction from the next, this key field should go all the way through the Query relationship chain.

            :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/journal-number-field.jpg" alt-text="Journal Number field.":::

        2. To link the AA information, since this example demonstrates a one-to-one relationship between the Distribution/Dimension/Dimension Code, the relationship setup is fairly straightforward. All we need to add is a link to the Account field since the AA information pertains to a particular account number.

            :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/add-a-link-to-account-field.jpg" alt-text="Add a link to the Account field.":::

        3. Continuing down the relationship, the AA Dimension Codes are linked back to a given AA Dimension. In this example, we need to continue linking with the Sequence field and also add the DimensionCode field. At this point, all the appropriate relationships have been established so your Query Relationship window should look like the following:

            :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/query-relationship-window.jpg" alt-text="Query Relationship window.":::

9. Add the Destination Adapter.
    1. Click on **Add Dest.**, expand**Microsoft Dynamics GP eConnect**, click on **Financial** and select **GL Transaction**.
    2. In the **Server Name** field, enter in the name of your SQL Server instance (not a DSN name) and the company database name.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/enter-sql-server-instance-name-and-company-database-name.jpg" alt-text="Type SQL instance name and company name.":::

10. Define the field mappings.
    1. Double-click on **Destination Mappings** to open the field mapping window.
    2. For GL Transactions with AA information, the **Journal Entry#** is *REQUIRED*. This field cannot be defaulted in! Some advanced users with use a VBScript on the **Journal Entry#** field to get the next number, but it does have to be supplied in the mapping otherwise the AA information cannot be linked to the transaction correctly.
    3. Provide a constant for the **Batch ID** and **Reference** fields.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/provide-a-constant-for-batch-id-and-reference-fields.jpg" alt-text="Define a constant for the Batch ID and Reference fields.":::

    4. Click on the **Entries** folder. Map the **Account Number** and **Debit/Credit Amount** to the fields from the GL Distributions - No Seq query.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/map-account-number-and-debit-credit-amount-to-corresponding-fields.jpg" alt-text="Map Account Number and Debit/Credit Amount to corresponding fields from the GL Distributions – No Seq query.":::

    5. Click on the **Analytics** folder. Map the **Amount** field from the GL AA Dimension - No Seq source query as follows:

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/map-amount-field-from-gl-aa-dimension-no-seq-source-query.jpg" alt-text="Map the Amount field from the GL AA Dimension – No Seq source query.":::

        Optional: If the percentages are known instead of the Amounts, you can map the **Assigned Percent** field instead of the **Amount** field. You do not need to map both!

    6. Click on the **Dimensions** folder. In this example, we are only using Alphanumeric Dimension Codes, so we will map the Transaction Dimension and Transaction Dimension AlphaNumeric from the GL AA Dimension Code - No Seq source query.

    7. Map the **Transaction Dimension** to the **Dimension** field from the source query and **Transaction Dimension AlphaNumeric** to the **DimensionCode** field from the source query:

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/map-four-fields-from-source-query.jpg" alt-text="Map four fields from the source query.":::

    8. The field mappings are now complete! Save the Integration.
    9. Go ahead and run the integration now to bring in the two Journal Entries.

11. Define the field mappings.
    1. The first Journal Entry does not have any AA information, so we will look at the second transaction, Journal Number 10004.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/the-second-transaction-journal-number-10004.jpg" alt-text="The second transaction Journal Number 10004.":::

    2. To inspect the AA distributions, click on the first distribution line, then click the **Analytical Accounting** button. We should see the distribution amount of $8000 assigned to the XBOX dimension code as follows:

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/distribution-amount-of-8000-assigned-to-xbox-dimension-code.jpg" alt-text="Distribution amount of $8000 assigned to the XBOX dimension code.":::

    3. You can use the VCR buttons at the bottom of the window to navigate to the second Analytics distribution where you will see that the distribution amount of $7000 has been assigned to the TV Dimension Code.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/distribution-amount-of-7000.jpg" alt-text="The distribution amount of $7000.":::

    4. Lastly, the 3rd AA distribution has the amount of $1200 assigned to the STEREO dimension code.

        :::image type="content" source="./media/set-up-gl-transaction-integration-with-analytical-accounting/amount-of-1200-assigned-to-stereo-dimension-code.jpg" alt-text="The amount of $1200 assigned to the STEREO dimension code.":::

    5. You can also view Journal Entry 10005 in the same way to verify that the distributions have been assigned to the AA Dimension Codes as expected.
