---
title: "Accidently Published heirarchy to future date"
description: "This artcile provides steps to resolve the situation where a heirarchy is accidently published to a future date."
author: bstorie
ms.author: brstor
ms.service: [the approved service name]
ms.topic: troubleshooting-problem-resolution #Don't change.
ms.date: 02052024

#customer intent: As a <role>, I want <what> so that <why>.

---

<!-- --------------------------------------

- Use this template with pattern instructions for:

Problem Resolution

- Before you sign off or merge:

Remove all comments except the customer intent.

- Feedback:

https://aka.ms/patterns-feedback

-->

# How to address the situation where a hiearchy was published to a future date.

<!-- Required: Article headline - H1

Identify the product or service the article
applies to.

-->

This article will help you to resolve the situation where a heirarchy change was incorrectly published to a future date preventing the system from replicating data to the channel database. 

<!-- Required: Introductory paragraphs (no heading)

Write a brief introduction that can help the user
determine whether the article is relevant for them 
and to describe the specific issue that the article
covers.

-->

## Symptoms

After making changes to an organization’s hierarchy the user selected to publish the hierarchy. However, the date field was incorrectly set to a future date.  Because of these products, pricing and other items are not appearing in the Channel. 

<!-- Required: Symptom identification - H2

In an H2 section, describe symptoms of the problem.

-->



## Solution [number]: [Summarize the solution]

To resolve this issue, you will need to delete the inaccurate dated hierarchy by following these steps. Once the inaccurate hierarchy is deleted you will then need to recreate your desire hierarchy changes and publish with the correct date. 

1.	Go to Organization Administration >  Organizations > Organization hierarchies
2.	Select the hierarchy with the problem
3.	Click on View
4.	On the right side of the screen click on Related Information fly-out
5.	Under Future Changes – Click on More  
<img width="162" alt="image" src="https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/55284555/cc70547f-e71a-49b6-a81a-0a9a160ce36b">

6.	On the Publication date column – Click the Filter icon  
 <img width="131" alt="image" src="https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/55284555/4c4fbd38-17be-46a9-8d16-8849e66eceeb">

7.	Click on Clear to remove the filtered value
8.	In the list select the hierarchy with the future publish date
9.	Click on delete
10. Finally recreate your changes to the hiearchy and ensure you publish to the desired date. 
