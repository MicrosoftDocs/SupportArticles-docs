---
title: How to send an email with an embedded image
description: Introduces how to send an email with an embedded image.
ms.reviewer:  
ms.topic: how-to
ms.date: 
---
# How to send an email with an embedded image

This article introduces how to send an email message with an embedded image in Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4538673

## Scenario

You want to send an email with an image in the body, for example with the Office 365 Outlook: Send an email (V2) action.

## More information

In the body, first switch to code view by selecting `</>` (or for some actions, set `IsHtml:Yes`) see the NOTE below. You can use HTML to embed the image, to do so add the following to the email body where you want the image to show:

```html
<img src="URL" />
```

Where:

- URL is a link to the image, this can be a public link or dynamic content from a previous action (such as a link for an image in SharePoint.)
- URL can instead be a base64 encoded image, you can find a tool/website online that will encode for you (or use the `dataUri()` expression with file content from a previous action.)
- You can specify additional attributes such as to: configure the size of the image or `alt`. text in case the image cannot load. See resources below for more information.

Example image with a link and size:

```html
<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf8peeAQ8Jbw4lowjdYM9OYVJFJr8EwgGNTsJ6BtbqPdNHWz2m" width="500" height="100">
```

Example image with base64 (clipped for readability) and the `alt` attribute:

```html
\<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHMAAABzCAMAAA......" alt="SomeImage" />
```

> [!NOTE]
> To see if your action supports HTML, check if the action has the parameter `body` of type `html` in the connector documentation. Otherwise, for some actions you may need to choose `Is HTML: Yes` under Advanced Options.

## Resources

More ways to configure \<img>: [Image Embed element reference](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/img).
