---
title: Mobile Device Fingerprinting
description: This article describes Mobile device fingerprinting.
ms.topic: article
ms.reviewer: 
ms.date: 3/31/2021
---
# DFP and Mobile Device fingerprinting

This article describes Mobile device fingerprinting.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Fraud Protection  
_Original KB number:_ &nbsp; 4569098

Microsoft Dynamics 365 Fraud Protection provides device fingerprinting that (i) is based on artificial intelligence (AI); (ii) runs on Microsoft Azure; and (iii) is cloud-scalable, reliable, and has enterprise-grade security. Fraud Protection's device fingerprinting feature enables the identification of devices (computer, Xbox, tablet, and so on) across multiple sessions or interactions that engage with your business and other businesses in the Fraud Protection fraud network. Additionally, this feature allows Fraud Protection to link seemingly unrelated events to each other in the fraud network to identify patterns of fraud.

When you implement Fraud Protection device fingerprinting by integrating the reference implementation provided in your application, you (i) agree to Microsoft's APIs terms of use located [Microsoft APIs Terms of Use](/legal/microsoft-apis/terms-of-use), and (ii) you direct Microsoft to process the following types of data from the devices interacting with the Fraud Protection services (collectively, Device Fingerprinting Data):

1. Device attributes such as device ID, screen information, processor class, etc.
2. Operating system (OS) attributes, such as OS information, OS version, OEM details, etc.
3. Browser-related attributes if applicable such as browser language, installed default apps, etc.

It is your responsibility to:

1. Receive consent from your users to collect and allow Microsoft to process the Device Fingerprinting Data.
2. Inform your customers of your data collection and processing practices, for example by disclosing the data you collect and how it is used.
3. Disclose your use of third parties working on your behalf to process the data you collect, including Fraud Protection service providers.
4. Comply with all laws and regulations applicable to the use of Fraud Protection, including data protection laws.
