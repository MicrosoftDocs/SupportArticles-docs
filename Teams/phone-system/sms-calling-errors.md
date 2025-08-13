---
title: Ten-Digit Long Code Campaign Rejections
description: Provides a comprehensive list of potential 10DLC campaign rejection errors, along with clear descriptions, and actionable recommendations.
ms.date: 08/14/2025
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Calling (PSTN)
  - CI 7095
ms.reviewer: revaldiv
---
# Troubleshoot 10DLC Campaign Rejections in Microsoft Teams SMS

This article is designed for IT administrators and professionals who are enabling Short Message Service (SMS) in Microsoft Teams and need to troubleshoot and resubmit campaigns that were rejected during the 10-digit long code (10DLC) review process.

Before proceeding, ensure you've reviewed the following articles:

- [Plan for SMS in Teams](/microsoftteams/sms-overview)
- [Set up a Campaign for SMS in Microsoft Teams](/microsoftteams/sms-setup-campaign)

When a campaign is submitted, Microsoft and 10DLC operators evaluate it for compliance with Mobile Network Operator (MNO) and industry standards. If the campaign doesn't meet these requirements, it's rejected by one or more error codes.

This document provides a comprehensive list of potential rejection errors, along with clear descriptions, and actionable recommendations to help you resolve issues and successfully resubmit your campaign.

## Campaign Rejection errors

The error codes are organized by parameters like brand information and call-to-action.

### Call-to-Action

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| CallToActionContainsDisallowedContent | The call-to-action contains disallowed content. | Remove any prohibited content from the call-to-action. |
| CallToActionDoesNotContainRobustAgeGate | The call-to-action doesn't contain robust age gate for age-restricted content. | Add a clear age verification step for age-restricted campaigns. |
| CallToActionIsMissingOrInaccessible | The call-to-action is missing or inaccessible. | Ensure the call-to-action is present and accessible to users. |
| CallToActionMissingBrandName | The call-to-action doesn't contain the registered/DBA brand name. | Include the brand name in the call-to-action. |
| CallToActionMissingDataRatesDisclosure | The call-to-action doesn't include the "message and data rates may apply" disclosure. | Add the required disclosure to inform users of potential charges. |
| CallToActionMissingExplicitConsent | The call-to-action doesn't express explicit or written consent. | Include language that clearly obtains user consent. |
| CallToActionMissingExpressWrittenConsent | The call-to-action doesn't obtain express written consent for promotional message content. | Add a checkbox or statement for express written consent. |
| CallToActionMissingHelpInstructions | The call-to-action doesn't include HELP instructions. | Include HELP instructions for user support. |
| CallToActionMissingMessageFrequencyDisclosure | The call-to-action doesn't include the frequency at which messages will be sent. | Add a statement about message frequency. |
| CallToActionMissingPrivacyPolicyLink | The call-to-action or the opt-in form don't include a link to the privacy policy. | Include a link to the privacy policy or a statement about data sharing. |
| CallToActionMissingStopInstructions | The call-to-action doesn't contain STOP instructions. | Add STOP instructions to allow users to opt out. |
| CallToActionMissingTermsAndConditions | The call-to-action doesn't contain complete terms and conditions or a link to them. | Include full terms or a link to them. |
| CallToActionMissingVerbalScript | The call-to-action doesn't include verbal script or necessary disclosures. | Add a verbal script with required disclosures. |
| CallToActionOptInIssues | The opt-in URL is inaccessible or returns a certificate error. | Ensure the opt-in URL is valid and secure. |
| CallToActionMissingMessageType | The call-to-action doesn't mention types of messages a customer can expect. | Specify the types of messages users receive. |
| CallToActionInvalidOrIncomplete | The call-to-action is noncompliant or incomplete. | Ensure all required elements are present: brand name, HELP, STOP, frequency, fees, privacy policy. |

### Terms and conditions

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| TermsAndConditionsMissing | The terms and conditions URL is missing or inaccessible. | Provide a valid and accessible URL for terms and conditions. |
| TermsAndConditionsMissingBrandName | The terms and conditions don't contain the registered/DBA brand name. | Include the brand name in the terms and conditions. |
| TermsAndConditionsMissingCustomerSupportInformation | The terms and conditions don't contain customer support contact information. | Add customer support contact details. |
| TermsAndConditionsMissingMessageFrequency | The terms and conditions don't contain message frequency disclosure. | Include message frequency information. |
| TermsAndConditionsMissingOptOutInstructions | The terms and conditions don't contain information on how to opt out. | Add opt-out instructions. |
| TermsAndConditionsMissingPrivacyPolicyLink | The terms and conditions don't contain a link to the privacy policy. | Include a link to the privacy policy. |
| TermsAndConditionsMissingProgramDescription | The terms and conditions don't contain a description of the message program. | Add a description of the message program's purpose. |
| TermsAndConditionsMissingSweepstakesTerms | The terms and conditions don't contain sweepstakes terms when applicable. | Include sweepstakes terms if the campaign involves sweepstakes. |

### Privacy policy

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| PrivacyPolicyDataSharingIssue | The privacy policy indicates that mobile opt-in data may be shared with third parties. | Update the policy to explicitly state that data won't be shared with third parties. |
| PrivacyPolicyMissingOrInvalid | The privacy policy URL is invalid or missing required elements. | Provide a valid URL and ensure all required elements are included. |

### Opt-In message

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| OptInMessageMissingMandatoryMessageTerminology | The opt-in message is missing key elements. | Include brand name, HELP, STOP, frequency, and fee disclosures. |
| OptInMessageMissingBrandName | The opt-in message doesn't contain the brand name. | Add the registered/DBA brand name. |
| OptInMessageMissingDataRatesDisclosure | The opt-in message doesn't contain the "message and data rates may apply" disclosure. | Include the required disclosure. |
| OptInMessageMissingHelpInstructions | The opt-in message doesn't include HELP instructions. | Add HELP instructions. |
| OptInMessageMissingMessageFrequency | The opt-in message doesn't contain message frequency disclosure. | Include message frequency information. |
| OptInMessageMissingOptOutInstructions | The opt-in message doesn't include opt-out instructions. | Add STOP instructions. |
| MandatoryMessageTerminologyMissing | Required message terminology is missing. | Include all mandatory terms: brand name, HELP, STOP, frequency, fees. |

### Help message

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| HelpMessageNotMatchingBrandSupportContactEmail | The support contact email doesn't match the registered brand support email. | Ensure the support email matches the brand's registered contact. |
| HelpMessageMissingBrandName | The HELP message doesn't contain the brand name. | Add the registered/DBA brand name. |
| HelpMessageMissingSupportContact | The HELP message doesn't include customer support contact information. | Include customer support contact details. |
| MandatoryMessageTerminologyMissing | Required message terminology is missing. | Include brand name, HELP, STOP, frequency, fees. |

### Opt-Out message

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| OptOutMessageMissingBrandName | The opt-out message doesn't contain the brand name. | Add the registered/DBA brand name. |
| OptOutMessageMissingBrandNameOrConfirmation | The opt-out message doesn't contain the brand name or confirmation. | Include brand name and confirm that no further messages will be sent. |
| OptOutMessageMissingConfirmation | The opt-out message doesn't confirm that no further messages will be sent. | Add confirmation that messaging will stop. |
| MandatoryMessageTerminologyMissing | Required message terminology is missing. | Include brand name, STOP, confirmation, and fee disclosures. |

### Sample messages

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| SampleMessageContainsDisallowedContent | The sample messages contain disallowed content. | Remove prohibited content such as SHAFT, gambling, or illegal services. |
| SampleMessageContainsPublicURLShortener | The sample messages contain public URL shorteners. | Replace public shorteners with branded or full URLs. |
| SampleMessageMissing | The sample messages are missing or insufficient. | Provide at least two complete sample messages. |
| SampleMessageMissingBrandName | The sample messages don't contain the brand name. | Include the registered/DBA brand name in all samples. |
| SampleMessageMissingOptOutInstructions | The sample messages don't contain opt-out instructions. | Add STOP instructions to each sample message. |
| SampleMessageUseCaseMismatch | The sample messages don't match the declared use case(s). | Ensure sample messages reflect the declared use case accurately. |

### Campaign (use case, description, and attributes)

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| CampaignAttributesMissingOrInvalid | The campaign attributes are missing or invalid or not configured correctly. | Review the campaign attributes and ensure all required fields are correctly filled. |
| CampaignAttributesNotMatchingCampaignDescription | The campaign attributes phone number or link are set to False, but the campaign description indicates phone number or link. | Update the campaign attributes to match the description, especially regarding phone numbers or links. |
| CampaignContainsDisallowedContent | The campaign description includes disallowed content such as gambling, high-risk financial services, illegal substances, or SHAFT content. | Remove any content related to SHAFT or other prohibited categories. Review CTA guidelines for compliance. |
| CampaignDescriptionNotMatchingBrandName | The submitted legal company name doesn't match with the provided tax ID. | Ensure the brand name matches the legal entity and tax ID records. |
| CampaignDescriptionNotMatchingUseCase | The campaign description doesn't sufficiently describe the service or doesn't match the declared use case(s). | Update the campaign description to clearly describe the service and align with the declared use case(s). |
| CampaignDescriptionNotUnique | The campaign description isn't unique or is a duplicate, indicating potential snowshoeing practices. | Modify the campaign description to be unique and specific to the brand's use case. |

### Brand

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| BrandAddressInvalid | The physical address of the brand is invalid or unverifiable. | Verify brand address. Contact support to update the address or appeal the decision.|
| BrandAssociatedWithDisallowedContent | The brand is associated with disallowed content. | Remove any association with SHAFT or other prohibited content. |
| BrandAssociatedWithSpamScam | The brand or its address is associated with known spam/scam complaints. | Ensure the brand isn't flagged for spam or scam activity. Contact support to appeal the decision if applicable. |
| BrandEmailIssues | The brand email is missing or invalid or a free domain. | Verify brand contact email. Contact support to update brand email or appeal the decision. |
| BrandEntityTypeSoleProprietorsNotSupported | Sole proprietor campaigns must be associated with a brand that doesn't have a registered tax ID. | Provide a valid EIN or register the brand as a business entity. |
| BrandIdentifiedAsResellerOrIvr | The brand is a reseller/ISV and not the actual content provider. | Ensure that the brand is the actual content provider, not a reseller, or ISV. |
| BrandNotAllowed | The brand isn't allowed by 10DLC operator(s) and can't run a campaign. | Contact support to verify brand eligibility or appeal the restriction. |
| BrandPhoneNumberMissingOrInvalid | The brand phone number is missing or invalid. | Verify brand contact phone number. Contact support to update brand phone number or appeal the decision. |
| BrandVettingScoreRequirementNotMet | The brand doesn't meet the minimum vetting score requirements. | Contact support to improve vetting score or appeal the decision. |
| BrandWebsiteIssues | The brand's website is missing, not matching with the brand name, inaccessible, or not reflective of the campaign's declared use case. | Verify that brand website is valid, accessible website URL. Ensure the site is live and reflects the brand's identity. Contact support to update brand website or appeal the decision.|
| BrandCampaignMismatch | The brand's name and website don't match or the sample messages are incomplete or missing the brand's name. | Ensure the brand name and website are consistent and sample messages include the brand name. |
