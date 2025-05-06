---
title: Resolve Communication Issues in Information Barriers
description: Discusses how to troubleshoot various Teams communication issues caused by Information Barriers policies.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.collection: 
  - M365-security-compliance
ms.custom:
  - sap:Information Barriers
  - Microsoft Purview
  - CSSTroubleshoot
  - CI 2883
  - CI 157252
  - seo-marvel-apr2020
ms.reviewer: simonklan, sathyana, meerak, v-shorestris
appliesto:
  - Microsoft 365
search.appverid: MET150
f1.keywords: 
  - NOCSH
ms.date: 12/13/2024
---

# Resolve communication issues in Information Barriers

Microsoft Purview [Information Barriers](/purview/information-barriers) can help your organization remain compliant with legal requirements and industry regulations. For example, you can use information barriers to restrict communication between specific groups of users to avoid a conflict of interest.

The following sections provide troubleshooting steps for various issues that you might experience.

> [!IMPORTANT]
> Before you troubleshoot Information Barriers issues, make sure that you have the [appropriate subscriptions and permissions](/purview/information-barriers-policies#required-subscriptions-and-permissions), meet the necessary [prerequisites](/purview/information-barriers-policies#step-1-make-sure-prerequisites-are-met), and [connect to Security & Compliance Center PowerShell](/powershell/exchange/connect-to-scc-powershell).

## Issue: Users are unexpectedly blocked from communicating with others in Teams

Your users report unexpected issues when they try to communicate with others by using Microsoft Teams. For example:

- A user searches for, but can't find, another user in Teams.
- A user can find, but can't select, another user in Teams.
- A user can see another user but can't send messages to that user in Teams.

### What to do

Determine whether the users are affected by an Information Barriers policy. Depending on how policies are configured, information barriers might be working as expected. Or, you might have to refine your organization's policies.

1. Use the [Get-InformationBarrierRecipientStatus](/powershell/module/exchange/get-informationbarrierrecipientstatus) cmdlet together with the **Identity** parameter.

   | **Syntax** | **Example** |
   |-|-|
   | `Get-InformationBarrierRecipientStatus -Identity`<br><br>You can use any identity value that uniquely identifies each recipient, such as Name, Alias, Distinguished name (DN), Canonical DN, Email address, or GUID. | `Get-InformationBarrierRecipientStatus -Identity meganb`<br><br>This example uses an alias (meganb) for the **Identity** parameter. This cmdlet returns information that indicates whether the user is affected by an Information Barriers policy. (Look for *ExoPolicyId: \<GUID\>.) |

   If the users aren't included in Information Barriers policies, contact [Microsoft Support](https://support.microsoft.com/contactus). Otherwise, go to the next step.

2. Determine which segments are included in an Information Barriers policy. To do this, use the [Get-InformationBarrierPolicy](/powershell/module/exchange/get-informationbarrierpolicy) cmdlet together with the **Identity** parameter.

   | **Syntax** | **Example** |
   |-|-|
   | `Get-InformationBarrierPolicy`<br><br>Use details, such as the policy GUID (ExoPolicyId) you received during the previous step, as an identity value. | `Get-InformationBarrierPolicy -Identity b42c3d0f-xyxy-4506-xyxy-bf2853b5df6f`<br><br>This example provides detailed information about the Information Barriers policy that has ExoPolicyId `b42c3d0f-xyxy-4506-xyxy-bf2853b5df6f`. |

   After you run the cmdlet, examine the results for **AssignedSegment**, **SegmentsAllowed**, and **SegmentsBlocked** values.

   For example, after you run the **Get-InformationBarrierPolicy** cmdlet, you see the following in the results:

   > AssignedSegment : Sales  
   > SegmentsAllowed : {}  
   > SegmentsBlocked : {Research}  

   In this case, you can see that an Information Barriers policy affects people who are in the Sales and Research segments. People in Sales are prevented from communicating with people in Research.

   If this seems correct, then the information barriers are working as expected. If not, go to the next step.

3. Make sure that your segments are defined correctly. To do this, use the [Get-OrganizationSegment](/powershell/module/exchange/get-organizationsegment) cmdlet, and review the list of results.

   | **Syntax** | **Example** |
   |-|-|
   | Get-OrganizationSegment<br><br>Use this cmdlet with the **Identity** parameter. | Get-OrganizationSegment -Identity c96e0837-c232-4a8a-841e-ef45787d8fcd<br><br>In this example, we're getting information about the segment that has GUID `c96e0837-c232-4a8a-841e-ef45787d8fcd`. |

   Review the details for the segment. If necessary, [edit a segment](/microsoft-365/compliance/information-barriers-edit-segments-policies#edit-a-segment), and then reuse the [Start-InformationBarrierPoliciesApplication](/powershell/module/exchange/start-informationbarrierpoliciesapplication) cmdlet.

   If you're still having issues when you use your Information Barriers policy, contact [Microsoft Support](https://support.microsoft.com/contactus).

## Issue: Communication is allowed between users who should be blocked in Teams

Although information barriers are defined, active, and applied, people who shouldn't be able to communicate with each other are able to chat with and call each other in Teams.

### What to do

Verify that the users in question are included in an Information Barriers policy.

1. Use the [Get-InformationBarrierRecipientStatus](/powershell/module/exchange/get-informationbarrierrecipientstatus) cmdlet together with the **Identity** and **Identity2** parameters.

   | **Syntax*** | **Example** |
   |-|-|
   | `Get-InformationBarrierRecipientStatus -Identity <value> -Identity2 <value>`<br><br>You can use any value that uniquely identifies each user, such as name, alias, distinguished name, canonical domain name, email address, or GUID. | `Get-InformationBarrierRecipientStatus -Identity meganb -Identity2 alexw`<br><br>This example refers to two user accounts in Microsoft 365: `meganb` for Megan, and `alexw` for Alex. |

   > [!TIP]
   > You can also use this cmdlet for a single user: `Get-InformationBarrierRecipientStatus -Identity <value>`

2. Review the findings. The [Get-InformationBarrierRecipientStatus](/powershell/module/exchange/get-informationbarrierrecipientstatus) cmdlet returns information about users, such as attribute values and any Information Barriers policies that are applied.

   Take your next steps, as described in the following table.

   | **Result**  | **What to do next**  |
   |-|-|
   | No segments are listed for the selected users | <ol><li>Use one of the following methods:<ul><li>Assign users to an existing segment by [editing their user profiles in Microsoft Entra ID](/microsoft-365/enterprise/configure-user-account-properties-with-microsoft-365-powershell)</li><li>Define a segment by using a [supported attribute for information barriers](/microsoft-365/compliance/information-barriers-attributes), then either [define a new policy](/purview/information-barriers-policies#step-3-create-ib-policies) or [edit an existing policy](/microsoft-365/compliance/information-barriers-edit-segments-policies#edit-a-policy) to include that segment.</li></ul></li><li>Run the [Start-InformationBarrierPoliciesApplication](/powershell/module/exchange/start-informationbarrierpoliciesapplication) cmdlet to apply all active Information Barriers policies.</li></ol> |
   | Segments are listed but no information barrier policies are assigned to those segments | <ol><li>Use one of the following methods:<ul><li>[Define a new information barrier policy](/purview/information-barriers-policies#step-3-create-ib-policies) for each applicable segment.</li><li>[Edit an existing information barrier policy](/microsoft-365/compliance/information-barriers-edit-segments-policies#edit-a-policy) to assign it to the applicable segment.</li></ul></li><li>Run the [Start-InformationBarrierPoliciesApplication](/powershell/module/exchange/start-informationbarrierpoliciesapplication) cmdlet to apply all active Information Barriers policies.</li></ol> |
   | Segments are listed and each is included in an information barrier policy | <ol><li>Run the [Get-InformationBarrierPolicy](/powershell/module/exchange/get-informationbarrierpolicy) cmdlet to verify that information barrier policies are active.</li><li>Run the [Get-InformationBarrierPoliciesApplicationStatus](/powershell/module/exchange/get-informationbarrierpoliciesapplicationstatus) cmdlet to verify that the policies are applied.</li><li>Run the [Start-InformationBarrierPoliciesApplication](/powershell/module/exchange/start-informationbarrierpoliciesapplication) cmdlet to apply all active Information Barriers policies.</li></ol> |

## Issue: I want to remove a single user from an Information Barriers policy

Information Barriers policies are in effect, and one or more users are unexpectedly blocked from communicating with others in Microsoft Teams. Instead of removing Information Barriers policies altogether, you can remove one or more individual users from Information Barriers policies.

### What to do

Information Barriers policies are assigned to segments of users. Segments are defined by using certain [attributes in user account profiles](/microsoft-365/compliance/information-barriers-attributes). If you must remove a policy from a single user, consider editing that user's profile in Microsoft Entra so that the user is no longer included in a segment that's affected by information barriers.

1. Use the [Get-InformationBarrierRecipientStatus](/powershell/module/exchange/get-informationbarrierrecipientstatus) cmdlet together with **Identity** and **Identity2** parameters. This cmdlet returns information about users, such as attribute values and any Information Barriers policies that are applied.

   | **Syntax** | **Example** |
   |-|-|
   | `Get-InformationBarrierRecipientStatus -Identity <value> -Identity2 <value>`<br><br>You can use any value that uniquely identifies each user, such as name, alias, distinguished name, canonical domain name, email address, or GUID. | `Get-InformationBarrierRecipientStatus -Identity meganb -Identity2 alexw`<br><br>This example refers to two user accounts in Microsoft 365: `meganb` for Megan, and `alexw` for Alex. |
   | `Get-InformationBarrierRecipientStatus -Identity <value>`<br><br>You can use any value that uniquely identifies the user, such as name, alias, distinguished name, canonical domain name, email address, or GUID. | `Get-InformationBarrierRecipientStatus -Identity jeanp`<br><br>This example refers to a single account in Microsoft 365: `jeanp`. |

2. Review the results to learn whether Information Barriers policies are assigned, and to which segments the users belong.

3. To remove a user from a segment that's affected by information barriers, [update the user's profile information in Microsoft Entra ID](/azure/active-directory/fundamentals/active-directory-users-profile-azure-portal).

4. Wait about 30 minutes for the FwdSync operation to finish. Or, run the [Start-InformationBarrierPoliciesApplication](/powershell/module/exchange/start-informationbarrierpoliciesapplication) cmdlet to apply all active Information Barriers policies.

## Issue: The Information Barriers application process takes too long

After running the [Start-InformationBarrierPoliciesApplication](/powershell/module/exchange/start-informationbarrierpoliciesapplication) cmdlet, the process takes a long time to finish.

### What to do

Keep in mind that when you run the policy application cmdlet, Information Barriers policies are being applied (or removed) user by user for all accounts in your organization. If you have many users, the process takes a while to run. (As a general guideline, it takes about one hour to process 5,000 user accounts.)

1. Use the [Get-InformationBarrierPoliciesApplicationStatus](/powershell/module/exchange/get-informationbarrierpoliciesapplicationstatus) cmdlet to view the status of the most recent policy application.

   | **For the most recent policy application** | **For all policy applications** |
   |-|-|
   | `Get-InformationBarrierPoliciesApplicationStatus` | `Get-InformationBarrierPoliciesApplicationStatus -All $true` |

   This command displays information about whether a policy application finished, failed, or is in progress.

2. Depending on the results of the previous step, take one of the following steps.

   | **Status** | **Next step** |
   |-|-|
   | **Not started** | If more than 45 minutes have passed since the **Start-InformationBarrierPoliciesApplication** cmdlet was run, review your audit log to see whether policy definitions contain any errors, or the application didn't start for some other reason. |
   | **Failed** | If the application failed, review your audit log. Also review your segments and policies. Are any users assigned to more than one segment? Are any segments assigned more than one policy? If it's necessary, [edit segments](/microsoft-365/compliance/information-barriers-edit-segments-policies#edit-a-segment) or [edit policies](/microsoft-365/compliance/information-barriers-edit-segments-policies#edit-a-policy), and then run the **Start-InformationBarrierPoliciesApplication** cmdlet again. |
   | **In progress** | If the application is still in progress, allow more time for it to finish. If several days have passed since the application was started, gather your audit logs, and then contact [Microsoft Support](https://support.microsoft.com/contactus). |

## Issue: Information Barriers policies aren't applied at all

You have defined segments, defined Information Barriers policies, and tried to apply those policies. However, when you run the [Get-InformationBarrierPoliciesApplicationStatus](/powershell/module/exchange/get-informationbarrierpoliciesapplicationstatus) cmdlet, you can see that policy application failed.

### What to do

Make sure that your organization doesn't have [Exchange address book policies](/exchange/address-books/address-book-policies/address-book-policies) in place. Such policies prevent Information Barriers policies from being applied.

1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Run the [Get-AddressBookPolicy](/powershell/module/exchange/get-addressbookpolicy) cmdlet, and review the results.

   | **Results** | **Next step** |
   |-|-|
   | Exchange address book policies are listed | [Remove address book policies](/exchange/address-books/address-book-policies/remove-an-address-book-policy). |
   | No address book policies exist | Review your audit logs to determine why the policy application failed. |

3. [View the status of user accounts, segments, policies, or policy application](/microsoft-365/compliance/information-barriers-policies#view-status-of-user-accounts-segments-policies-or-policy-application).

## Issue: Information Barriers policy isn't applied to all designated users

After you define segments and Information Barriers policies, and you try to apply those policies, you might learn that the policy is applied to some recipients but not to others. When you run the [Get-InformationBarrierPoliciesApplicationStatus](/powershell/module/exchange/get-informationbarrierpoliciesapplicationstatus) cmdlet, search the output for text that resembles the following:

> Identity: `<application guid>`  
> Total Recipients: 81527  
> Failed Recipients: 2  
> Failure Category: None  
> Status: Complete  

### What to do

1. Search in the audit log for `<application guid>`. You can copy this PowerShell code and modify it by substituting your variables:

   ```PowerShell
   $detailedLogs = Search-UnifiedAuditLog -EndDate <yyyy-mm-ddThh:mm:ss> -StartDate <yyyy-mm-ddThh:mm:ss> -RecordType InformationBarrierPolicyApplication -ResultSize 1000 |?{$_.AuditData.Contains(<application guid>)} 
   ```

2. Check the detailed output from the audit log for the values of the **UserId** and **ErrorDetails** fields. Doing this provides the reason for the failure. You can copy this PowerShell code and modify it by substituting your variables.

   ```PowerShell
   $detailedLogs[1] | FL
   ```

   For example:

   > "UserId": User1  
   > "ErrorDetails": "Status: IBPolicyConflict. Error: IB segment "segment id1" and IB segment "segment id2" has conflict and cannot be assigned to the recipient."

3. Usually, you learn that a user was included in more than one segment. You can fix this issue by updating segment membership. To do this, use the [Set-OrganizationSegment](/powershell/module/exchange/set-organizationsegment) cmdlet together with the `UserGroupFilter` parameter.

4. [Reapply Information Barriers policies](/purview/information-barriers-policies#apply-policies-using-powershell).
