---
title: Resolve Campaign Rejection Errors for SMS in Microsoft Teams
description: Provides a list of potential campaign rejection errors when setting up SMS in Teams, and guidance to resolve them.
ms.date: 01/12/2026
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Calling (PSTN)
  - CI 7095
ms.reviewer: julienp, revaldiv
---
# Resolve campaign rejection errors for SMS in Microsoft Teams

If you enable the [Short Message Service (SMS)](/microsoftteams/sms-overview) feature in Microsoft Teams, you might have to troubleshoot and resubmit [campaigns](/microsoftteams/sms-setup-campaign) that were rejected during the 10-digit-long code (10DLC) review process. After a campaign is submitted, Microsoft and 10DLC operators evaluate it for compliance with Mobile Network Operator (MNO) and industry standards. If the campaign doesn't meet these requirements, it's rejected and generates one or more error codes.

The following sections provide a comprehensive list of potential rejection errors, together with clear descriptions and actionable recommendations to help you resolve issues and successfully resubmit your campaign. The sections are organized by the categories of information that you submit to register a campaign.

## Call to Action 

| Error | Description | Recommended action |
|-------|-------------|--------------------|
|CallToActionConsentNotOptional |  The opt-in form is used for purposes beyond SMS messaging, but SMS consent isn't optional. | If your opt-in form serves multiple purposes (e.g., account creation, newsletter signup), make sure that SMS consent is optional. You can make this change either by making the phone number field optional or including a clearly labeled checkbox to let users agree to receive SMS messages. Forced consent isn't permitted. |
|CallToActionContainsDisallowedContent | The Call to Action contains disallowed content. | Remove any prohibited content from the Call to Action. |
|CallToActionCourtOrderedOptIn | Opt-in information implies that consent is acquired through a court order. This statement is disallowed. | Remove any language that suggests that opt-in is obtained through a legal mandate or court order. Consent must be voluntary and user-initiated.|
| CallToActionDoesNotContainRobustAgeGate | The Call to Action doesn't contain a robust age gate for age-restricted content. | Add a clear age verification step for age-restricted campaigns. |
| CallToActionIsMissingOrInaccessible | The Call to Action is missing or inaccessible. | Make sure that the Call to Action is present and accessible to users. |
| CallToActionMissingBrandName | The Call to Action doesn't contain the registered (DBA) brand name. | Add the brand name in the Call to Action. |
| CallToActionMissingDataRatesDisclosure | The Call to Action doesn't include the "message and data rates may apply" disclosure. | Add the required disclosure to inform users about potential charges. |
| CallToActionMissingExplicitConsent | The Call to Action doesn't express explicit or written consent. | Add language that clearly obtains user consent. |
| CallToActionMissingExpressWrittenConsent | The Call to Action doesn't obtain express written consent for promotional message content. | Add a checkbox or statement to obtain express written consent. |
| CallToActionMissingHelpInstructions | The Call to Action doesn't include HELP instructions. | Add HELP instructions for user support. |
| CallToActionMissingMessageFrequencyDisclosure | The Call to Action doesn't include the frequency at which messages are sent. | Add a statement about message frequency. |
|CallToActionMissingOptInForm | The webpage that's used for opt-in doesn't contain an opt-in form. | Make sure that the opt-in webpage includes a visible and functional opt-in form. Avoid linking to generic or unrelated pages.|
| CallToActionMissingPrivacyPolicyLink | The Call to Action or the opt-in form doesn't include a link to the privacy policy. | Add a link to the privacy policy or a statement about data sharing. |
| CallToActionMissingStopInstructions | The Call to Action doesn't contain STOP instructions. | Add STOP instructions to enable users to opt out. |
| CallToActionMissingTermsAndConditions | The Call to Action doesn't contain full terms and conditions or a link to them. | Add the full terms or a link to them. |
| CallToActionMissingVerbalScript | The Call to Action doesn't include a verbal script or required disclosures. | Add a verbal script that has the required disclosures. |
| CallToActionMissingMessageType | The Call to Action doesn't mention the kinds of messages that a customer can expect to receive. | Specify the kinds of messages that users might receive. |
| CallToActionOptInIssues | The opt-in URL is inaccessible or returns a certificate error. | Make sure that the opt-in URL is valid and secure. |
| CallToActionInvalidOrIncomplete | The Call to Action is noncompliant or incomplete. | Make sure that all required elements are present: brand name, HELP, STOP, frequency, fees, and privacy policy. |
| CallToActionMissingOptInForm | The Call to Action page does not include an opt-in form for users to provide consent. | Add a visible and functional opt-in form to the CTA page. Make sure that it collects explicit consent, and complies with the Cellular Telecommunications Industry Association [CTIA guidelines](https://api.ctia.org/wp-content/uploads/2023/05/230523-CTIA-Messaging-Principles-and-Best-Practices-FINAL.pdf). |
| CallToActionConsentNotOptional | SMS consent is mandatory on a multipurpose form. This status means that users cannot opt out of SMS while they complete other actions. | Update the form so that SMS consent is presented as an optional checkbox (not pre-selected), and is independent of other actions.|
| CallToActionVerificationIssues | The opt-in process cannot be verified because of missing confirmation steps, timestamps, or verification records. | Implement a confirmation step (e.g., "Thank you for opting in" message), and make sure that timestamps are logged for compliance audits.| 

## Terms and conditions 

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| TermsAndConditionsMissing | The terms and conditions document URL is missing or inaccessible. | Provide a valid and accessible URL for terms and conditions. |
| TermsAndConditionsMissingBrandName | The terms and conditions document doesn't contain the registered (DBA) brand name. | Add the brand name in the terms and conditions document. |
| TermsAndConditionsMissingCustomerSupportInformation | The terms and conditions document doesn't contain customer support contact information. | Add customer support contact details. |
| TermsAndConditionsMissingMessageFrequency | The terms and conditions document doesn't contain a message frequency disclosure. | Add message frequency information. |
| TermsAndConditionsMissingOptOutInstructions | The terms and conditions document doesn't contain information about how to opt out. | Add STOP instructions. |
| TermsAndConditionsMissingPrivacyPolicyLink | The terms and conditions document doesn't contain a link to the privacy policy. | Add a link to the privacy policy. |
| TermsAndConditionsMissingProgramDescription | The terms and conditions document doesn't contain a description of the message program. | Add a description of the message program's purpose. |
| TermsAndConditionsMissingSweepstakesTerms | The terms and conditions document doesn't contain sweepstakes terms, as applicable. | Add sweepstakes terms if the campaign involves sweepstakes. |

## Privacy policy

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| PrivacyPolicyDataSharingIssue | The privacy policy indicates that mobile opt-in data might be shared with third parties. | Update the policy to explicitly state that data isn't shared with third parties. |
| PrivacyPolicyMissingOrInvalid | The privacy policy URL is invalid or is missing required elements. | Provide a valid URL and make sure that all required elements are included. |

## Opt-in message

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| OptInMessageMissingMandatoryMessageTerminology | The opt-in message is missing key elements. | Add brand name, HELP, STOP, frequency, and fee disclosures. |
| OptInMessageMissingBrandName | The opt-in message doesn't contain the brand name. | Add the registered (DBA) brand name. |
| OptInMessageMissingDataRatesDisclosure | The opt-in message doesn't contain the "message and data rates may apply" disclosure. | Add the required disclosure. |
| OptInMessageMissingHelpInstructions | The opt-in message doesn't include HELP instructions. | Add HELP instructions. |
| OptInMessageMissingMessageFrequency | The opt-in message doesn't contain a message frequency disclosure. | Add message frequency information. |
| OptInMessageMissingOptOutInstructions | The opt-in message doesn't include opt-out instructions. | Add STOP instructions. |
| MandatoryMessageTerminologyMissing | Required message terminology is missing. | Add all mandatory terms: brand name, HELP, STOP, frequency, and fees. |

## Opt-out message

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| OptOutMessageMissingBrandName | The opt-out message doesn't contain the brand name. | Add the registered (DBA) brand name. |
| OptOutMessageMissingBrandNameOrConfirmation | The opt-out message doesn't contain the brand name or confirmation. | Add the brand name and confirm that no further messages will be sent. |
| OptOutMessageMissingConfirmation | The opt-out message doesn't confirm that no further messages will be sent. | Add confirmation that messaging will stop. |
| MandatoryMessageTerminologyMissing | Required message terminology is missing. | Add brand name, STOP, confirmation, and fee disclosures. |

## Help message

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| HelpMessageNotMatchingBrandSupportContactEmail | The support contact email address doesn't match the registered brand support email address. | Make sure that the support email address matches the brand's registered contact information. |
| HelpMessageMissingBrandName | The HELP message doesn't contain the brand name. | Add the registered (DBA) brand name. |
| HelpMessageMissingSupportContact | The HELP message doesn't include customer support contact information. | Add customer support contact details. |
| MandatoryMessageTerminologyMissing | Required message terminology is missing. | Add brand name, HELP, STOP, frequency, and fees. |

## Sample messages

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| SampleMessageContainsDisallowedContent | The sample messages contain disallowed content. | Remove prohibited content such as SHAFT, gambling, and illegal services. |
| SampleMessageContainsPublicURLShortener | The sample messages contain public URL shorteners. | Replace public shorteners with branded or full URLs. |
| SampleMessageMissing | The sample messages are missing or insufficient. | Provide at least two complete sample messages. |
| SampleMessageMissingBrandName | The sample messages don't contain the brand name. | Add the registered (DBA) brand name to all samples. |
| SampleMessageMissingOptOutInstructions | The sample messages don't contain opt-out instructions. | Add STOP instructions to each sample message. |
| SampleMessageUseCaseMismatch | The sample messages don't match the declared use cases. | Make sure that sample messages reflect the declared use case accurately. |
| SampleMessageMissingMessageFrequencyDisclosure | Sample messages do not include disclosure of message frequency (e.g., "You will receive X messages per month"). | Update sample messages to include frequency disclosure (e.g., "You will receive up to four (4) messages per month").|
| SampleMessageMissingDataRatesDisclosure | Sample messages do not include disclosure of potential data rates (e.g., "Msg & Data rates may apply").	| Add "Msg & Data rates may apply" to all sample messages that are provided during campaign registration.|

## Campaign (use case, description, and attributes)

| Error | Description | Recommended action |
|-------|-------------|--------------------|
| CampaignAttributesMissingOrInvalid | The campaign attributes are missing or invalid or not configured correctly. | Review the campaign attributes and make sure that all required fields are filled correctly. |
| CampaignAttributesNotMatchingCampaignDescription | The campaign attributes phone number or link is set to False, but the campaign description indicates a phone number or link. | Update the campaign attributes to match the description, especially regarding phone numbers and links. |
| CampaignContainsDisallowedContent | The campaign description includes disallowed content such as gambling, high-risk financial services, illegal substances, or SHAFT content. | Remove any SHAFT content or other prohibited categories. Review the [CTIA guidelines](https://api.ctia.org/wp-content/uploads/2023/05/230523-CTIA-Messaging-Principles-and-Best-Practices-FINAL.pdf) for compliance. |
| CampaignDescriptionNotMatchingBrandName | The submitted legal company name doesn't match the provided tax ID. | Make sure that the brand name matches the legal entity and tax ID records. |
| CampaignDescriptionNotMatchingUseCase | The campaign description doesn't sufficiently describe the service or doesn't match the declared use cases. | Update the campaign description to clearly describe the service and align the description with the declared use cases. |
| CampaignDescriptionNotUnique | The campaign description isn't unique or is a duplicate. | Modify the campaign description to be unique and specific to the brand's use case. |

## Brand

| Error | Description | Recommended action |  
|-------|-------------|--------------------|
| BrandAddressInvalid | The physical address of the brand is invalid or unverifiable. | Verify the brand address. Contact support to update the address or appeal the decision.|
| BrandAssociatedWithDisallowedContent | The brand is associated with disallowed content. | Remove any association with SHAFT or other prohibited content. |
| BrandAssociatedWithSpamScam | The brand or its address is associated with known spam or scam complaints. | Make sure that the brand isn't flagged for spam or scam activity. Contact support to appeal the decision, as applicable. |
| BrandEmailIssues | The brand email address is missing or invalid or hosted on a free domain. | Verify the brand contact email address. Contact support to update the brand email address or to appeal the decision. |
| BrandEntityTypeSoleProprietorsNotSupported | Sole proprietor campaigns must be associated with a brand that doesn't have a registered tax ID. | Provide a valid EIN or register the brand as a business entity. |
| BrandIdentifiedAsResellerOrIvr | The brand is a reseller or ISV, not the actual content provider. | Make sure that the brand is the actual content provider, not a reseller or ISV. |
| BrandNotAllowed | The brand isn't allowed by 10DLC operators and can't run a campaign. | Contact support to verify brand eligibility or appeal the restriction. |
| BrandPhoneNumberMissingOrInvalid | The brand phone number is missing or invalid. | Verify the brand contact phone number. Contact support to update the brand phone number or to appeal the decision. |
| BrandVettingScoreRequirementNotMet | The brand doesn't meet the minimum vetting score requirements. | Contact support to improve the vetting score or to appeal the decision. |
| BrandWebsiteIssues | The brand website URL is missing, doesn't match the brand name, is inaccessible, or doesn't reflect the campaign's declared use case. | Verify that the brand website is valid and has an accessible website URL. Make sure that the site is live and reflects the brand identity. Contact support to update the brand website or to appeal the decision.|
| BrandCampaignMismatch | The brand's name and website don't match, or the sample messages are incomplete or are missing the brand name. | Make sure that the brand name and website are consistent and that sample messages include the brand name. |
