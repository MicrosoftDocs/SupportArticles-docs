---
title: Tracking an email cannot resolve to associated record
description: This article provides a resolution for the problem that occurs when you track an email in Microsoft Office Outlook to a record in Microsoft Dynamics CRM 2011.
ms.reviewer: aaronric
ms.topic: troubleshooting
ms.date: 
---
# Tracking an email in Outlook does not resolve to the associated record in Microsoft Dynamics CRM 2011

This article helps you resolve the problem that occurs when you track an email in Microsoft Office Outlook to a record in Microsoft Dynamics CRM 2011.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2660401

## Symptoms

When you track an email in Microsoft Office Outlook to a record in Microsoft Dynamics CRM 2011, the record's email address in Microsoft Office Outlook fails to resolve to the associated record in Microsoft Dynamics CRM causing the email not to track or causing duplicate records to be created when creating the record from the unresolved email in Microsoft Office Outlook.

## Cause

The **EmailAddress1** field on the record's entity is set to a format of **text**. This may occur for Contacts, User, and Leads.

## Resolution

The example below is for the Contact entity. This will need to be slightly modified if it occurs for Users or Leads.

The **EmailAddress1** field on the Contact entity should be set to a format of **email**.

To resolve this; update the XML for this entity field. To do this, follow these steps:

1. Start the Microsoft Dynamics CRM web client as an administrator.
2. Create a New solution in the Microsoft Dynamics CRM:
    1. Navigate to the **Settings** section in Microsoft Dynamics CRM and select **Solutions**.
    1. Click **New Solution** to create a new solution.
    1. In the Solution window fill out the following form fields, and then click **Save**.
    - Display Name
    - Contact Name
    - Contact Publisher
    - Default Publisher for CRM2011
    - Version: 1.1.1.0
3. Click **Entities** in the **Solution**, and then click **Add Existing**.
4. Select the **Contact** entity, and then click **OK**.
5. When you are prompted about the missing components select **No, do not include required components**  and then click **OK**.
6. Click **Save**.
7. Click **Export Solution**.
8. Click **Next** unless you have not published customizations. If you have not published customization, click **Publish Customizations,** and then click **Next**.
9. You will be prompted about other missing components. Click **Next** to ignore these prompts because you will import the solution right back into the same organization.
10. At the next window, do not select any Settings, and then click **Next**.
11. Since this will be an unmanaged package, leave the current option **Unmanaged** selected, and then click **Export**.
12. You will be prompted to save the file. Save it to the desktop of the Microsoft Dynamics CRM server.
13. Go to the desktop of the Microsoft Dynamics CRM server and open the newly created zip file titled Contacts_1_1_1_0.zip.
14. Extract the file customizations.xml.
15. Open the customization.xml file with an XML editor.
16. Press **Ctrl+F** and search for the string **EmailAddress1**.
17. Under **EmailAddress1** locate the string `<Format>text</Format>`.
18. In the string, change the work **text** to **email**. Save and close the file
19. Place the modified customization.xml file back into the zipped solution Contacts_1_1_1_0.zip. If you are prompted to overwrite the existing file, choose **yes**.
20. In Microsoft Dynamics CRM Solutions click **Import**.
21. Browse to the location of the Solution file Contacts_1_1_1_0.zip, and then click **Next**.
22. Click **Next** to import the Solution.
23. Once the import completes click **Publish All Customizations.**  
24. Go into the **Contacts** entity and verify that the **EmailAddress1** field now shows a format of **email**.

After you make these changes, the Microsoft Dynamics CRM contact will resolve to the contact's E-mail address successfully.

## More information

If any records were created while this format value was set to text, the associated email record for the record will not be created in the EmailSearchBase table. Therefore, after correcting the format on the EmailAddress1, previously entered records will not resolve. The email record will need to be changed to another value, saved, and then changed back to the correct value and saved again. This will create the record in the EmailSearchBase table. If there are multiple records that need to be updated, please contact support for additional assistance.
