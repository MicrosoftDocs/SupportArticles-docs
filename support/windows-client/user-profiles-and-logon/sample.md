# Troubleshoot certificate issue when using Windows Hello for Business

This article introduce the script to extract the certificate information saved in Active Directory user objects' msDS-KeyCredentialLink attribute. This information can be helpful when troubleshooting issues related to Windows Hello for Business (WHfB).

## Scenario

After deploying WHfB to a key trust hybrid environment, you encounter one of the following problems.

- Users are unable to logon to a hybrid join device by using WHfB.
- Single sign-on (SSO) to on-premises resources fails after logging on to a Entra join device by using WHfB.

## Analysis

To fix these issues, the msDS-KeyCredentialLink attribute of the Active Directory user object must have information on the certificate being used for authentication. This certificate is created during the user's WHfB provisioning and uploaded to Entra ID. This information is then expected to be synchronized from Entra ID to on-premises Active Directory through Microsoft Entra Connect. If this attribute is not properly synchronized, you may see WHfB logon failures, or SSO failures to on-premises resources.

## Resolution

To troubleshoot this issue, we recommend to use the script in [Script to view the certificate information in the msDS-KeyCredentialLink attribute from AD user objects](../../windows-server/support-tools/script-to-view-msds-keycredentiallink-attribute-value.md) to retrieve the certificate information.
