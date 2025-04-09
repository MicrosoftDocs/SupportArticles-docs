# issues with email templates and formatting in Dynamics 365

This article addresses common issues encountered with email templates and formatting in Dynamics 365 Customer Service and Sales, including problems with the Enhanced Email form and email tracking tokens. The article provides detailed steps to resolve these issues.

## Symptoms

Users may experience the following issues with email templates and formatting in Dynamics 365:
1. Emails sent using Copilot with the Enhanced Email form display incorrect formatting, missing columns, and spacing issues when received by end users.
2. Emails sent from Dynamics 365 Sales using templates append an arbitrary tracking code (CRM:nnnnn) to the subject line and only send emails to the first contact in the selected list instead of all intended recipients.

## Cause
1. The email formatting issue with Copilot and the Enhanced Email form arises due to a known issue with the "New Look" or "Modern Text Editor" being enabled.
2. The arbitrary code appended to the email subject line and emails being sent only to the first contact is caused by the email tracking token setting being enabled.

## Solution 1: Resolve issues with Copilot and Enhanced Email form

Follow these steps to address the formatting issues caused by the Enhanced Email form:
1. Navigate to the Power Apps portal at [make.powerapps.com](https://make.powerapps.com).
2. Select the relevant environment.
3. Go to **Tables > Email > Forms**, and then select the Enhanced Email form.
4. Locate the **Body** field and delete the existing Text Editor control component.
5. Save and publish the changes.
6. Ensure the Enhanced Email Recipient control component is enabled for the **From**, **To**, **CC**, and **BCC** fields. Map these fields appropriately.
7. Set the **Static Value** for "Show Email address" to **True**.

After removing the Text Editor control component from the Body field and enabling the Enhanced Email Recipient control, the email template rendering issues should no longer occur. For detailed guidance, refer to [Enable enhanced recipient control for email | Microsoft Learn](https://learn.microsoft.com/en-us/dynamics365/customer-service/administer/add-recipient-control).

## Solution 2: Address issues with email tracking tokens

To prevent arbitrary tracking codes from being appended to the subject line and ensure emails are sent to all selected recipients:
1. Access the Dynamics 365 Sales environment as a system administrator.
2. Navigate to **Settings > Administration > System Settings**.
3. Under the **Email** tab, locate the **Use tracking tokens** setting.
4. Disable the **Use tracking tokens** option.
5. Save the changes.

Disabling tracking tokens will stop the system from appending codes to subject lines and ensure emails are sent to all intended recipients.

By following the above steps, users can resolve the identified issues with email templates and formatting in Dynamics 365.