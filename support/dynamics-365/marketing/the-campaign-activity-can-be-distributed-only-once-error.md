---
title: The Campaign Activity can be distributed only once error after deleting Campaign Activity StatusCode field values
description: Discusses an issue that will occur when trying to distribute a campaign activity, if the StatusCode field has values that are deleted. Provides a resolution.
ms.reviewer: kenakamu, chanson
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# The Campaign Activity can be distributed only once error after removing Campaign Activity StatusCode field values

This article provides a resolution for the issue that you may receive **The Campaign Activity can be distributed only once** error after deleting the Campaign Activity StatusCode field values.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2501788

## Symptoms

After you customized the Campaign Activity StatusCode field, the distribution of the Campaign Activities fails.

You get the following message when selecting the **Distribute Campaign Activity** button:

> The Campaign Activity can be distributed only once.

This issue happens when you removed some of the values from Campaign Activity StatusCode field.

## Cause

Distribute Campaign Activity operation needs certain values for StatusCode to be executed. Even though it is possible to remove values from customization, please do not remove them.

## Resolution

Once you removed the value, you are not able to add them back manually in Microsoft Dynamics CRM. Do not remove the values from the StatusCode field.

If you have removed some of the values, follow these steps to get them back:

1. Export the Default Solution:

    1. Select **Settings**.
    2. Select **Customizations** and select **Customize the System**.
    3. Select **Export Solution**.

    > [!NOTE]
    > You can also add the Campaign Activity to a new solution and just export that solution. Extract the contents of the solution zip file.

2. Open the customizations.xml in an xml editor like notepad or Visual Studio, and locate the following node:

    ```xml
    <Name LocalizedName="Campaign Activity" OriginalName="Campaign Activity">CampaignActivity</Name>
    <ObjectTypeCode>4402</ObjectTypeCode>
    <EntityInfo>
    ```

3. Locate the following section within this node. It will probably have a variation of the following where some status labels are missing.

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <statuses>
       <status value="1" state="0">
          <labels>
             <label description="Proposed" languagecode="1033" />
          </labels>
       </status>
       <status value="6" state="0">
          <labels>
             <label description="Completed" languagecode="1033" />
          </labels>
       </status>
       <status value="2" state="1">
          <labels>
             <label description="Closed" languagecode="1033" />
          </labels>
       </status>
       <status value="3" state="2">
          <labels>
             <label description="Canceled" languagecode="1033" />
          </labels>
       </status>
    </statuses>
    ```

4. You will need to add back the missing statuses (see below for a list of the default status you need to have.)

    > [!NOTE]
    > You can add new values in Microsoft Dynamics CRM but these default ones also need to be there.

    ```xml
    <statuses>
        <status value="1" state="0">
            <labels>
                <label description="Proposed" languagecode="1033" />
            </labels>
        </status>
        <status value="0" state="0">
            <labels>
                <label description="In Progress" languagecode="1033" />
            </labels>
        </status>
        <status value="4" state="0">
            <labels>
                <label description="Pending" languagecode="1033" />
            </labels>
        </status>
        <status value="5" state="0">
            <labels>
                <label description="System Aborted" languagecode="1033" />
            </labels>
        </status>
        <status value="6" state="0">
            <labels>
                <label description="Completed" languagecode="1033" />
            </labels>
        </status>
        <status value="2" state="1">
            <labels>
                <label description="Closed" languagecode="1033" />
            </labels>
        </status>
    ```

5. Save the modified customizations.xml. Then select the customization.xml file and any other files that where extracted with the solution so they are all highlighted, then right-click and choose **Send to** and select Compressed (zipped) folder.

    > [!NOTE]
    > The files need to be at the root of the zip file and not within a directory folder.

6. Within Microsoft Dynamics CRM, select Settings and select Solutions. Select **Import** and select the new zip file created in step 5 that contains the modified customizations.xml.

7. Select **Publish All Customizations** once the import completes.

## More information

When customizing the Campaign Activity entity, if you try to delete an option set value for the Status Reason you will see the following message:

> Existing records and customizations might reference this option value. Those references will not be updated if this option value is deleted. Do you want to continue?

If you continue and delete the Option Set value, you will run into this issue.
