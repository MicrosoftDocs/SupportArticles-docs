---
title: You can't activate or sign-in after you update to Office 2016 for Mac version 15.33
description: Describes an issue in which you can't activate or sign in to any of the Microsoft Office 2016 applications after you install the version 15.33 update.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
localization_priority: Normal
ms.reviewer: balram
search.appverid: 
  - MET150
appliesto: 
  - office 2016
ms.date: 03/31/2022
---

# You can't activate or sign-in after you update to Office 2016 for Mac version 15.33

## Symptoms

When you try to activate or sign in to any of the Microsoft Office 2016 applications after you install the version 15.33 update, you receive a blank authentication screen.
  
Additionally, you may see any of the following symptoms.

### Symptom 1

The following issues occur in the Unified Logging Service (ULS) log:  

- The server has redirected to a non-https URL.    
- Errors occur in Azure Active Directory Authentication Library (ADAL) authentication.    

To locate the ULS log, open **Finder** and browse to the following path:

~/Library/Containers/com.microsoft.\<Application>/Data/Library/Caches/Microsoft/uls/com.microsoft.\<Application>/logs

**Note** \<Application> represents the name of the application that you are troubleshooting.

### Symptom 2

You notice that in an HTTP trace, the server response includes multiple WWW-Authenticate headers, such as the following:

WWW-Authenticate: Negotiate

WWW-Authenticate: NTLM 

## Cause

The symptoms occur for the following corresponding reasons:  
#### Cause for symptom 1

Starting from Office 2016 for Mac version 15.33, unsecured endpoint traffic is blocked in authentication flows. 
#### Cause for symptom 2

Starting from Office 2016 for Mac version 15.33, the authentication method no longer selects NTLM authentication when multiple WWW-Authenticate headers are present in the response. The issue occurs when the selected authentication method is unsuccessful.  

## Resolution

### Resolution for symptom 1

Configure all authentication endpoints to use the Secure Sockets Layer (SSL) protocol. 
### Resolution for symptom 2

Install the [September 2017 update for Office 2016 for Mac version 15.38](https://go.microsoft.com/fwlink/p/?linkid=525133). 

## More Information

### More information for symptom 1

The resolution applies when you use Microsoft Active Directory Federation Services or non-Microsoft federation solutions.