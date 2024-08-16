---
title: Resolve setup errors in Viva Pulse
description: Fix error messages that you might experience when you navigate the setup process in Microsoft Viva Pulse.
manager: dcscontentpm
ms.author: michellehu
ms.reviewer: michellehu
ms.date: 11/06/2023
audience: ITPro
f1.keywords: NOCSH
ms.topic: troubleshooting
search.appverid: MET150
ms.custom: 
  - CSSTroubleshoot
  - CI 183792
ms.service: viva-pulse
---

# Resolve error messages during setup

As you navigate the setup process in Microsoft Viva Pulse, you might experience errors. The following table outlines the error messages you might see, a description of when they're displayed, and the next steps you can take to resolve those errors. This isn't an exhaustive list, and more error messages may be added in the future.

| Error Message | Where the error appears | How to fix it |
| ----------- | ----------- | ----------- |
| "We couldn't delete [x] right now. Try again later." | When the admin types in a person's name to delete their Pulse data, and that person couldn't be deleted. | The admin needs to repeat the steps and try to delete the person again to delete their Pulse data. |
| "There was an error saving your settings. Try again later." | When the admin changes the customization toggle, but the save wasn't completed. | The user should refresh the page or try again later. |
| "There was an error saving your privacy link. Please try again later." | When the admin tries to change the privacy link, but the link couldn't be saved. | The admin could refresh the page or try again later. |
| "Please use a valid URL that's 2,000 characters or less with permitted special characters." | When the admin tries to add a privacy link, but the link has invalid characters. | The user should try again, and follow these guidelines:<ul><li>Check that the URL starts with `http://` or `https://`, and contains a valid domain name with at least one dot (.) (such as `tinyurl.com`) and doesn't contain any illegal characters.</li><li>The permitted special characters in a URL are: a-z, A-Z, 0-9, hyphen (-), underscore (_), period (.), tilde (~), exclamation mark (!), asterisk (*), single quote ('), left parenthesis ((), right parenthesis ()), and forward slash (/).</li><li>The privacy policy should be under 2,000 characters to ensure compatibility with most web browsers.</li></ul>|
