---
title: How to add normalization rules to change Japanese dial plans
description: A PSTN number cannot be normalized after a change in the Japanese PSTN calling dial plan. Provides steps to change a tenant dial plan by adding rules.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-swei
appliesto:
- Skype for Business Online
---

# How to add normalization rules to change Japanese dial plans

## Summary

Microsoft implements the public switched telephone network (PSTN) system by using service-level and tenant-level dial plans in Microsoft Skype for Business Online. These plans enable organizations to administer dialing pattern normalization based on their needs. 

We are making a change to the dial plan in the Japan region to maintain a similar environment to other regional dial plans. The change is to remove the "default rule" (that is, the normalization functionality) in the Japanese dial plan (JP). Removing this rule may affect Cloud Connector Edition (CCE), On Premises Call Handing (OPCH), and Direct Routing deployments that require normalization of unfixed length dialing patterns. Customers who use CCE deployments can use tenant dial plans to maintain the normalization functionality.
 
For example, assume that a user dials a PSTN number by using the Microsoft Skype for Business Online Service. They dial 8888-8888 to reach their call destination. This number is currently normalized to +81-8888-8888. After the user removes the default rule, this number will not be normalized and will dial as 8888-8888. If the PSTN translation device (such as IPPBX/PSTN Gateway) doesn't recognize this pattern, the call may fail. 

The tenant dial plan can be added to normalize this number to +81-8888-8888, as required. 

## Procedure

Organizations that require normalization of numbers that have unfixed lengths can create tenant dial plans to maintain this functionality. Tenant admins can use current documentation to create rules for their own needs. We also offer a solution that changes a tenant dial plan to use the currently offered normalization rules and, therefore, causes no change in functionality. 

Alternatively, organizations can change their PSTN Gateway/IPPBX devices to accept the number because the number is received from the Skype For Business service. See your specific vendor for detailed information about how to make these modifications. 

You can make a global change for tenant dial plans so that you don't have to assign a specific tenant dial plan to each user. All users will automatically start using the tenant dial plan. If you do not want to use this dial plan as a global setting, you can create a new tenant dial plan, and then assign users to it. 

> [!NOTE]
> If you currently use tenant dial plans, you can change these plans by adding normalization rules to create the outcome that you want. (See "Step 4: Add rules to an existing Tenant dial plan") 

To create dial plans, follow these steps.
 
### Step 1: Create a Remote Tenant PowerShell connection to Skype for Business Online

To do this, open a PowerShell window and then run the following commands in the given order: 
 
- ```$cred=Get-Credential admin@domain.onmicrosoft.com```
- ```$sess=New-CsOnlineSession -Credential $cred```
- ```New-PSSession $sess```
- ```Import-PSSession $sess```
 
### Step 2: Create normalization rules

After you successfully connect to your tenant, run the following commands to create normalization rules: 
 
- ```$a = New-CsVoiceNormalizationRule -Description 'JP International Dialing Rule' -Name 'JP International Dialing Rule' -Pattern '^010(\d+)$' -Translation '+$1' -Parent Global -InMemory```

- ```$b = New-CsVoiceNormalizationRule -Description 'JP Extensions Rule' -Name 'JP Extension Rule' -Pattern '^((\+)?(\d+))(;)?(ext|extn|EXT|EXTN|x|X)(=)?(\d+)$' -Translation '$1;ext=$7' -Parent Global -InMemory```

- ```$c = New-CsVoiceNormalizationRule -Description 'JP Long Distance Dialing Rule' -Name 'JP Long Distance Dialing Rule' -Pattern '^0(\d+)$' -Translation '+81$1' -Parent Global -InMemory```

- ```$d = New-CsVoiceNormalizationRule -Description 'JP Default Rule' -Name 'JP Default Rule' -Pattern '^(\d+)$' -Translation '+81$1' -Parent Global -InMemory```
 
### Step 3: Add normalization rules to a global or new tenant dial plan

> [!NOTE]
> If you add rules to an existing tenant dial plan, skip this step, and go to step 4.

To add rules to your global tenant dial plan, run the following command: 
 
- ```Set-CsTenantDialPlan -Identity Global -NormalizationRules @{replace=$a,$b,$c,$d}```

    > [!NOTE]
    > This command affects all users who do not have a currently assigned tenant dial plan.    
 
To add rules to a new tenant dial plan, and then apply them to specific users, run the following commands: 

- ```New-CsTenantDialPlan -Identity "Japan Tenant Dialplan with default rule" -NormalizationRules @{replace=$a,$b,$c,$d}```

- ```Grant-CsTenantDialPlan -PolicyName "Japan Tenant Dialplan with default rule"  -Identity user@domain.onmicrosoft.com```

### Step 4: Add rules to an existing Tenant dial plan

To add these rules to an existing tenant dial plan, you can use the same **set-CsTenantDialPlan** command plus variables to create the required normalization rules. To do this, run the following commands: 
 
- ```$a = New-CsVoiceNormalizationRule -Description 'Custom Dialing Rule 1' -Name 'Custom Dialing Rule 1' -Pattern 'custompattern1$' -Translation '+$1' -Parent Global -InMemory```
- ```$b = New-CsVoiceNormalizationRule -Description 'Custom Dialing Rule 2' -Name 'Custom Dialing Rule 2' -Pattern 'custompattern2$' -Translation '+$1' -Parent Global -InMemory```

> [!NOTE]
> In these commands, "Custom Dialing Rule" refers to the current rule or pattern that is in the currently configured tenant dial plan.

Run the following commands to create normalization rules: 
 
- ```$c = New-CsVoiceNormalizationRule -Description 'JP International Dialing Rule' -Name 'JP International Dialing Rule' -Pattern '^010(\d+)$' -Translation '+$1' -Parent Global -InMemory```
- ```$d = New-CsVoiceNormalizationRule -Description 'JP Extensions Rule' -Name 'JP Extension Rule' -Pattern '^((\+)?(\d+))(;)?(ext|extn|EXT|EXTN|x|X)(=)?(\d+)$' -Translation '$1;ext=$7' -Parent Global -InMemory```
- ```$e = New-CsVoiceNormalizationRule -Description 'JP Long Distance Dialing Rule' -Name 'JP Long Distance Dialing Rule' -Pattern '^0(\d+)$' -Translation '+81$1' -Parent Global -InMemory```
- ```$f = New-CsVoiceNormalizationRule -Description 'JP Default Rule' -Name 'JP Default Rule' -Pattern '^(\d+)$' -Translation '+81$1' -Parent Global -InMemory```
 
Then, run the following command to add these rules: 

```powershell
Set-CsTenantDialPlan -Identity "Existing Dialplan" -NormalizationRules @{replace=$a,$b,$c,$d,$e,$f}
```

> [!NOTE]
> In this command, "Existing Dialplan" refers to the dial plan that you are updating by using the new rules. 

## More information

For more information about the commands that are used to manage dial plans, see [Create and manage dial plans](/skypeforbusiness/what-are-calling-plans-in-office-365/create-and-manage-dial-plans). 

For more information about how tenant dial plans work, see [What are dial plans?](/skypeforbusiness/what-are-calling-plans-in-office-365/what-are-dial-plans)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).