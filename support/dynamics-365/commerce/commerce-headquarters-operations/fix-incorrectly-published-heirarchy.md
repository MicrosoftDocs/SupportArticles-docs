---
title: "Accidently Published heirarchy to future date"
description: "This article provides steps to resolve the situation where a heirarchy is accidently published to a future date."
author: bstorie
ms.author: brstor
ms.topic: troubleshooting-problem-resolution #Don't change.
ms.date: 02/05/2024

#customer intent: As a <role>, I want <what> so that <why>.

---

# How to address the situation where a hiearchy was published to a future date.

This article will help you to resolve the situation where a heirarchy change was incorrectly published to a future date preventing the system from replicating data to the channel database. 


## Symptom

After making changes to an organization’s hierarchy the user selected to publish the hierarchy. However, the date field was incorrectly set to a future date.  Because of these products, pricing and other items are not appearing in the Channel. 



## Solution

To resolve this issue, you will need to delete the inaccurate dated hierarchy by following these steps. Once the inaccurate hierarchy is deleted you will then need to recreate your desire hierarchy changes and publish with the correct date. 

1.	Go to Organization Administration >  Organizations > Organization hierarchies
2.	Select the hierarchy with the problem
3.	Click on View
4.	On the right side of the screen click on Related Information fly-out
5.	Under Future Changes – Click on More  
<img width="162" alt="image" src="https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/55284555/cc70547f-e71a-49b6-a81a-0a9a160ce36b"> 
   [hiearchyrelatedinformation image]

7.	On the Publication date column – Click the Filter icon  
 <img width="131" alt="image" src="https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/55284555/4c4fbd38-17be-46a9-8d16-8849e66eceeb">
 [hiearchyPublishedDatefilter image]

8.	Click on Clear to remove the filtered value
9.	In the list select the hierarchy with the future publish date
10.	Click on delete
11. Finally recreate your changes to the hiearchy and ensure you publish to the desired date. 
