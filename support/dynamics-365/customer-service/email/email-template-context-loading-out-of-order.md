# rubik-generate-article-preview

# email template context loading out of order in Dynamics 365 Customer Service

This article addresses an issue in Microsoft Dynamics 365 Customer Service where the email template context loads out of order, particularly impacting content with bullet points. The article provides details on the symptoms, cause, and steps to resolve the problem.

## Symptoms

Users may encounter the following symptoms when using email templates in Dynamics 365 Customer Service:

- The email template content does not appear in the correct order.
- Bullet points within the email template are particularly affected, with content being misaligned or rearranged.

## Cause

The issue occurs due to invisible characters embedded in the HTML code of the email template. These characters are often found around the bullet points and interfere with the proper rendering of the template context.

## Solution 1: Identify and remove problematic characters

To resolve this issue, follow these steps:

1. **Create a new template**:

    - Create a new email template and gradually test sections of the original template content to identify the problematic portion.
2. **Inspect the HTML code**:

    - Use an API to inspect and compare the HTML code of the email templates.
    - Look for invisible characters in the HTML, particularly around the bullet point sections.
3. **Remove unwanted spaces**:

    - Eliminate spaces or unnecessary formatting between the lines in the affected template content.
    - This step helps remove the invisible characters causing the issue.

## Solution 2: Disable modern TextEditor control experience

If the issue persists after following the steps above, consider disabling the modern TextEditor control experience for email descriptions:

1. **Navigate to the AppModule page**:

    - Open Power Platform Designer at make.powerapps.com.
2. **Access settings**:

    - Click on the "Settings" option.
3. **Disable TextEditor control**:

    - Locate the "Enable a modern TextEditor control experience email descriptions" setting and disable it.
4. **Apply organization-wide settings if necessary**:

    - This setting can be disabled for the entire organization via the Settings Definition. Disabling it organization-wide will override the setting for all users.

By following these steps, you should be able to resolve the issue with email template context loading out of order in Dynamics 365 Customer Service. If the problem persists, consider reaching out to Microsoft Support for further assistance.