# rubik-generate-article-preview

# email preview text showing error when not configured

This article provides guidance on resolving an issue in Dynamics 365 Customer Service where email preview text displays an error or unintended formatting when not explicitly configured.

## Prerequisites

- Access to Dynamics 365 Customer Service with appropriate permissions to configure email settings.
- Basic understanding of email templates and content setup in Dynamics 365.

## Symptoms

When users send emails in Dynamics 365 Customer Service, the email preview text may display an error or unintended formatting (e.g., "{ 0 margins ..") instead of a meaningful preview. This issue typically occurs when the email content is primarily an image and no explicit email preview text has been set.

## Cause

This issue happens because the system automatically uses the email's content as the preview text if no explicit preview text is configured. When the email content is an image, the system extracts the formatting details of the image, which can result in unintended text being displayed in the email preview.

## Solution

To resolve this issue and prevent unintended formatting messages from appearing in the email preview text:

1. Navigate to the email template in Dynamics 365 Customer Service.
2. Open the specific email template that contains an image as the primary content.
3. Locate the **Email Preview Text** field (this field may also be referred to as "Snippet Text" in some versions of Dynamics 365).
4. Enter a simple, meaningful text in the **Email Preview Text** field that represents the content of the email (e.g., "Check out our latest updates!" or "Special offer just for you").
5. Save the changes to the email template.
6. Test the email by sending it to ensure the preview text displays correctly.

By explicitly setting the **Email Preview Text**, you can avoid the system defaulting to the extracted formatting of the email content.

### Additional Tips

- Ensure that the preview text is concise and provides a clear summary of the email content to improve user engagement.
- Review all email templates that use images as their primary content and verify that appropriate preview text is configured.

By following these steps, you can ensure that the email preview text in Dynamics 365 Customer Service is displayed correctly and avoids showing unintended formatting details.