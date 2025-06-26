---
title: Emoticons and emojis converted to text if more than 10 are sent in a message
description: Describes an issue that causes emoticons and emojis to be converted to text if more than 10 are sent in a single message block in Skype for Business.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business 2016
  - Skype for Business 2015
ms.date: 03/31/2022
---

# Emoticons and emojis converted to text if more than 10 are sent in a single message block in Skype for Business 2015 or 2016 clients

## Symptoms

Consider the following scenario: 
 
- You have the Skype for Business 2015 or Skype for Business 2016 client installed.    
- The client is updated by applying the Windows October 2, 2018, update for [Skype for Business 2015](https://support.microsoft.com/help/4461446) or [Skype for Business 2016](https://support.microsoft.com/help/4092445) or a later version.    
- You send more than 10 emoticons or emojis in a single message block.    

In this scenario, the emoticons or emojis are converted to text, as shown in the following examples. 

**Example 1:** Three messages in a single message block that contain a total of nine emoticons or emojis. 

:::image type="content" source="./media/emoticons-and-emojis-converted-to-text/three-messages.png" alt-text="Screenshot that shows a single message block with nine emojis.":::

**Example 2:** Four messages in a single message block that contain a total of 12 emoticons or emojis.

:::image type="content" source="./media/emoticons-and-emojis-converted-to-text/four-messages.png" alt-text="Screenshot that shows all 12 emojis in the message block with four messages are converted to text.":::

**Example 3:** One message that contains 11 emoticons or emojis. 

:::image type="content" source="./media/emoticons-and-emojis-converted-to-text/single-message.png" alt-text="Screenshot that shows all 11 emojis in a single message are converted to text.":::

After this behavior occurs, successive messages may also not render emoticons in some scenarios. 

## Cause

This behavior is a by-design change in the behavior of Skype for Business 2015 and 2016 for both MSI and C2R clients. This change was introduced in the following MSI client updates: 

**Skype for Business 2015** 

[October 2, 2018, update for Skype for Business 2015 (Lync 2013) (KB4461446)](https://support.microsoft.com/help/4461446/october-2-2018-update-for-skype-for-business-2015-lync-2013-kb4461446) 

**Skype for Business 2016** 

[October 2, 2018, update for Skype for Business 2016 (KB4092445)](https://support.microsoft.com/help/4092445/october-2-2018-update-for-skype-for-business-2016-kb4092445) 

## Workaround

To work around this issue and restore the emoticon functionality, close the current chat window, and then start a new chat session.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
