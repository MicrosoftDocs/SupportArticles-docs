---
title: Troubleshoot Email Rendering in Customer Insights - Journeys
description: Troubleshoot email rendering issues in Customer Insights - Journeys. Fix problems in Outlook, Gmail, and other clients with custom HTML and CSS solutions.
ms.date: 07/06/2026
ms.reviewer: alfergus, v-shaywood
ms.custom: sap:Outbound marketing emails, templates, content blocks - view in browser, personalization, validation, and publishing
search.audienceType: 
  - admin
  - customizer
  - enduser
---

# Troubleshoot email rendering issues in Customer Insights - Journeys

## Summary

This article documents known limitations and provides recommended mitigations for email rendering issues across various email clients in Dynamics 365 Customer Insights - Journeys. Organized by email client, it covers issues that affect all clients, such as dark mode color changes, unsupported custom content blocks, and an email that appears black, plus client-specific issues in Gmail, Outlook (Classic), Outlook mobile, Bell.net, Orange mobile, and T-Online, including broken background images, inconsistent spacing and line height, and problems that appear only after an email is forwarded.

## Email rendering and best practices

Email clients vary widely in how they interpret standard HTML. To address these differences, the email designer applies a post-processing step that changes the HTML to work around known limitations. As a result, the final email HTML can be more complex than you expect. This process ensures consistent rendering across most email clients, but some limitations can't be fully resolved.

To reduce rendering issues, follow these recommendations:

- **Use the email designer toolbox**: Avoid manual HTML changes. The email designer can handle many limitations correctly through the themes capability, and it creates emails that render correctly on most email clients.
- **Use inline CSS for custom emails**: If you're not using the email designer toolbox, consider applying all CSS inline for consistent styling.
- **Limit email width**: Keep your email's maximum width between 600 and 800 pixels to prevent horizontal scrolling or content clipping.
- **Avoid background images**: Use solid background colors instead of images for reliable visibility across clients.
- **Provide web version links**: Include a link to a web-hosted version of the email for users who might experience rendering issues.

Most issues occur when you replace or change generated HTML with your own custom code. Microsoft doesn't provide support for issues caused by custom HTML. You must [validate and test your custom code across various email clients](/dynamics365/customer-insights/journeys/email-preview), and then fix issues by using the guidance in this article.

## All email clients

### Dark mode changes email colors unexpectedly

Most email clients automatically adjust email colors when the recipient's device is set to dark mode. This behavior varies by client, and you can't control it from the email editor. Any color changes that occur in dark mode are expected behavior of the email client.

To prevent color changes in dark mode, use background images instead of background colors. Email clients generally preserve background images in dark mode, whereas they often invert or replace background colors.

### Custom content blocks aren't supported

Custom content blocks aren't supported by default. When you use custom HTML code in a content block, you're responsible for making sure that the HTML renders correctly across email clients.

### Email appears black

> [!NOTE]
> This problem occurs only when you change or replace the HTML that the email designer generates with your own custom HTML that has syntax errors.

When an email contains invalid HTML or syntax errors, some email clients might fail to render the content correctly and display the email body as a solid black area. This behavior occurs in email clients such as Outlook (Classic) and Yahoo Mail. This problem is caused by how email clients handle malformed HTML and isn't controlled by the email designer.

To fix this problem, make sure the email HTML doesn't contain syntax errors introduced by manual editing. Pay special attention to unclosed tags, invalid nesting, or malformed attributes. If the problem persists, recreate the email by using the email designer and its drag-and-drop elements, which generate validated HTML and reduce the risk of client-specific rendering failures.

## Gmail

### Large emails are truncated

Gmail automatically truncates email messages that exceed a size limit, so part of your content might be hidden.

To fix this problem, make sure the email size is within the limits that Gmail supports:

- Reduce the size of images and avoid embedding large assets.
- Simplify the email layout and structure.
- Use text-based content instead of images where possible.

## Outlook (Classic)

### Margins and padding render inconsistently

> [!NOTE]
> This problem occurs only when you change or replace the HTML that the email designer generates with your own custom HTML. Custom HTML overrides the automatic adjustments that the email designer applies to handle this problem correctly.

Outlook (Classic) uses a Word-based HTML processing engine that has limited support for standard CSS margins and padding on HTML elements. This limitation can cause spacing to appear differently in Outlook than in web-based email clients.

To create correct spacing, add padding to the `td` elements of the tables that define the layout. For text, buttons, and other drag-and-drop elements, the post-processing step adds tables automatically to create the appropriate spacing.

### Background images don't render

> [!NOTE]
> This problem occurs only when you change or replace the HTML that the email designer generates with your own custom HTML. Custom HTML overrides the automatic adjustments that the email designer applies to handle this problem correctly.

Outlook (Classic) doesn't natively support CSS background images on sections and columns.

To render background images, Outlook uses [VML (Vector Markup Language)](/windows/win32/vml/web-workshop---specs---standards----introduction-to-vector-markup-language--vml-) elements, which require a pre-calculated height for each section or column. The email designer's post-processing step handles adding VML elements automatically.

> [!IMPORTANT]
> Outlook (Classic) treats background colors that use transparency as background images, so they're subject to the same rendering limitations. To avoid this problem, use a fully opaque color instead of a transparent one.

Be aware of the following additional limitations when you use background images in Outlook:

- **Dynamic values in content:** When your email contains dynamic text, such as `{{FirstName}}`, the height calculation might not be precise, which can cause the background image to be cut off or misaligned.
- **Rounded corner buttons:** Buttons with rounded corners placed on a section or column that has a background image automatically lose their border radius, because VML-based buttons and VML backgrounds aren't compatible.

### Line height renders larger than in web clients

> [!NOTE]
> This problem occurs only when you change or replace the HTML that the email designer generates with your own custom HTML. Custom HTML overrides the automatic adjustments that the email designer applies to handle this problem correctly.

Outlook (Classic) renders line height larger than web-based clients do. This rendering results in more vertical space between lines of text than you intend. Also, numeric line-height values, such as `line-height: 1.5`, aren't supported.

To fix this problem, follow these recommendations:

- Apply `line-height` to the `<p>` element, not to `<span>` elements. When you set it on a `<span>`, a visible line can appear between sections in some cases.
- Use percentage values for line height. For example, replace `line-height: 1.5` with `line-height: 150%`. The email designer's post-processing step handles this conversion automatically.

### White lines appear between sections

> [!NOTE]
> This problem occurs only when you change or replace the HTML that the email designer generates with your own custom HTML. Custom HTML overrides the automatic adjustments that the email designer applies to handle this problem correctly.

Thin white lines can appear between email sections in Outlook (Classic). This problem is caused by the Word-based HTML processor that Outlook (Classic) uses. It's most commonly triggered by nested table layouts or by setting `line-height` on `<span>` elements instead of `<p>` elements.

The email designer's post-processing step handles this problem automatically by adding an empty `<p>` element with height 0, or by adding extra rows and cells to the nested tables. To avoid triggering this problem in your own HTML, apply `line-height` to `<p>` elements rather than `<span>` elements.

### Images appear in the wrong position when a link wraps the image

> [!NOTE]
> This problem occurs only when you change or replace the HTML that the email designer generates with your own custom HTML. Custom HTML overrides the automatic adjustments that the email designer applies to handle this problem correctly.

If a linked image has incorrect HTML element ordering (specifically, when the `<a>` element wraps the outer `<div>` instead of the inner `<img>` element), the image might render out of place or become misaligned.

This example shows the incorrect structure:

```html
<div data-editorblocktype="Image">
  <a href="<HrefLink>">
    <div class="imageWrapper">
      <img src="<SrcLink>" alt="<AltText>">
    </div>
  </a>
</div>
```

This example shows the correct structure:

```html
<div data-editorblocktype="Image">
  <div class="imageWrapper">
    <a href="<HrefLink>">
      <img src="<SrcLink>" alt="<AltText>">
    </a>
  </div>
</div>
```

To fix this problem, correct the HTML so that the `<a>` element wraps the `<img>` element rather than the outer `<div>`. Alternatively, remove the link from the image in the designer and then reapply it.

### A gap appears between sections when forwarding

When you forward an email from Outlook (Classic), the HTML is pre-processed before sending, which can introduce gaps between sections.

The email designer prevents this problem automatically. If you're using your own custom code, add an extra row to outer section tables by using the following VML conditional comment:

```html
<!--[if gte mso 9]>
<tr style="padding: 0px; mso-line-height-rule: exactly; line-height: 1px; background-color: rgb(0, 0, 0);" height="0">
  <td>&nbsp;</td>
</tr>
<![endif]-->
```

> [!NOTE]
> As a side effect of this workaround, sections that have no padding might still show a small gap when the email is forwarded.

### Rounded buttons break when forwarding to Gmail

When you forward an email that contains rounded-corner buttons from Outlook (Classic) to a Gmail web client, the button rendering breaks. This problem occurs because of how VML elements render rounded buttons in Outlook.

To fix this problem, remove the border radius from buttons before sending if the email is likely to be forwarded. Buttons without a border radius render correctly after forwarding.

### Long words break section width

Outlook (Classic) doesn't support selectively breaking only long words. It breaks either all words or none. Long words or URLs that don't break can cause the width of a section to expand beyond its intended size.

Using `&nbsp;` (non-breaking space) instead of a regular space character also causes Outlook (Classic) to treat the whole phrase as one unbreakable word, which might further widen columns.

To fix this problem, add the style `word-break: break-all;` to the `<p>` element that contains the long word or link. The email designer's post-processing step fixes the `&nbsp;` issue automatically.

### Dynamic images cause table width to expand

When the width or height of an element exceeds the table or cell width, Outlook expands the table to fit the content. This problem is especially noticeable with dynamic images that use personalization placeholders in the URL, because the actual image size isn't known during post-processing.

To fix this problem, set the image width to 100% instead of auto in the designer. This setting prevents Outlook (Classic) from expanding the table when the image dimensions aren't known in advance.

### Unwanted underline appears on buttons and linked text

Outlook (Classic) can apply a default underline to anchor (`<a>`) elements, which makes buttons and linked text appear underlined unexpectedly.

To fix this problem, add the following CSS to the email's default styles to remove the default underline while preserving intentional underlines that you apply through the toolbar:

```css
a { text-decoration: none; }
u a { text-decoration: underline; }
```

### Underline color on linked text doesn't match text color

In Outlook (Classic), the underline on linked text might appear in a different color than the text itself.

To make the underline color match the text color, follow these steps in order:

1. Select the text.
1. Apply the underline style.
1. Add a hyperlink to the selected text.
1. Set the font color on the selected text.

Setting the color as the last step makes both the text and the underline inherit the same color.

### Custom bullet styles don't render

Custom bullet types, such as square bullets, might not render correctly in Outlook (Classic) if you use only a CSS class to define the bullet style.

To fix this problem, in addition to setting the CSS class, include the `type` attribute directly on the `<ul>` element:

```html
<ul class="square" type="square">
  <li>Item</li>
</ul>
```

### Vertical line appears in the layout

A vertical line might appear in the email layout in Outlook when you apply a `direction: rtl` CSS style or `dir="rtl"` attribute to a container element.

To fix this problem, instead of setting `direction: rtl` on the container element, apply it only to the text elements inside the container. Alternatively, add the following scoped style to the email's `<style>` tag:

```css
[data-container="true"] div { direction: rtl; }
```

### Background image height is inaccurate when dynamic text is present

When a section or column uses a background image and also contains dynamic text, such as `{{FirstName}}`, the pre-calculated height of the VML background image can't account for the actual height of the dynamic content. This limitation can cause the background image to be clipped or misaligned.

Currently, there's no known solution for this problem.

### Divider height is limited to 10px

Outlook (Classic) limits table borders to a maximum of `10px`. Because the divider element uses a table border, the maximum divider height is also capped at `10px`.

Currently, there's no known solution for this problem.

### Background images on sections and columns are broken after forwarding

Background images that render correctly in the delivered email might appear broken after you forward the email from Outlook (Classic). Outlook (Classic) changes VML styles during the forwarding process, which can break the layout.

Currently, there's no known solution for this problem.

### Bullet points missing in Litmus preview for Outlook Classic 2016

Bullet points might not appear when you preview emails in Litmus for Outlook Classic 2016.

To fix this problem, add the following MSO conditional style to the `<head>` of the email. For more information, see [The Ultimate Guide to Bullet Points in HTML Email](https://www.litmus.com/blog/the-ultimate-guide-to-bulleted-lists-in-html-email).

```html
<!--[if (gte mso 9)|(IE)]>
<style>
  li {
    margin-left: 27px !important;
    mso-special-format: bullet;
  }
</style>
<![endif]-->
```

### Custom font fallback isn't applied

When you use a custom font that Outlook (Classic) doesn't support, it might not fall back to the specified fallback font.

To fix this problem, add the following MSO conditional style block to the `<body>` of the email:

```html
<!--[if mso]>
<style type="text/css">
  body, table, td, h1, h2, h3, h4, h5, p, span {
    font-family: <FontName> !important;
  }
</style>
<![endif]-->
```

If your email uses a custom `@font-face` declaration, also add the `mso-font-alt` property to specify the fallback:

```css
@font-face {
  font-family: '<PrimaryFontName>';
  font-display: swap;
  src: url("<PrimaryFontUrl>");
  mso-font-alt: '<FallbackFontName>';
}
```

## Outlook mobile

### Table layouts don't reflow on small screens

> [!NOTE]
> This problem occurs only when you change or replace the HTML that the email designer generates with your own custom HTML. Custom HTML overrides the automatic adjustments that the email designer applies to handle this problem correctly.

`<table>` based layouts might not reflow correctly for smaller screens in Outlook mobile apps. Also, iOS Outlook requires `<th>` elements instead of `<td>` elements for responsive table layouts to work.

To fix this problem, make sure the email uses the latest responsive styles. For iOS Outlook, use `<th>` instead of `<td>` in table layouts.

## Bell.net

### Conditional comments are removed

> [!NOTE]
> This problem occurs only when you change or replace the HTML that the email designer generates with your own custom HTML. Custom HTML overrides the automatic adjustments that the email designer applies to handle this problem correctly.

The Bell.net email client removes Outlook-specific conditional comments (`<!--[if ...]>`) along with any HTML elements inside them. This removal can cause layout problems when those comments contain elements that are needed for correct rendering.

To fix this problem, use `<table>` based HTML layouts instead of `<div>` based layouts. This change reduces the need for Outlook conditional comments. The post-processing step doesn't add Outlook conditional comments for tables when spacing is set to 0.

## Orange mobile

### Div-based layouts don't render

> [!NOTE]
> This problem occurs only when you change or replace the HTML that the email designer generates with your own custom HTML. Custom HTML overrides the automatic adjustments that the email designer applies to handle this problem correctly.

The Orange mobile email client supports only HTML3 and `<table>` based layouts. Emails that use `<div>` based layouts don't render correctly.

Currently, there's no known solution for this problem.

## T-Online

The following capabilities aren't supported, or are supported with limitations:

- Background images
- Border radius
- Checkbox and radio button
- Classes
- CSS attribute selector
- HTML5 video
- Media query
- Styled ALT text
- Style in head
- Transitions and keyframe animations
- Web fonts

### Layout and responsiveness

Keep the following layout and responsiveness considerations in mind:

- **Fixed width constraint**: Emails wider than `800px` might be scaled down or partially hidden, especially when the viewport narrows below `645px`. Because T-Online doesn't support media queries, responsive designs that rely on them don't work as intended.
- **Table-based layouts**: Use `<table>` structures instead of `<div>` elements for layout. This approach improves compatibility across various email clients, including T-Online.de.

### CSS and styling limitations

Be aware of the following CSS and styling limitations:

- **Media queries**: Not supported. Avoid relying on them for responsive designs. Features like **Wrap on mobile** or **Hide on desktop** don't work.
- **Background images**: Not supported. Don't use background images for essential content.
- **Custom fonts**: Not supported. Specify fallback fonts when you use custom fonts, to make sure emails render properly in T-Online.de.
- **Advanced CSS features**: Properties like `border-radius`, transitions, and animations aren't supported, so rounded corners might not work. Design with only basic CSS for compatibility.
- **Cascading**: Style cascading doesn't always work properly. For example, in the following case, the text is still black:

    ```html
    div {
     color: red;
    }
    
    <div>
     <p><span>Use red color</span></p>
    </div>
    ```

    The email designer handles this case by using themes, where the color is specified at the `<p>` level.

    ```html
    p {
     color: red;
    }
    
    <div>
     <p><span>Use red color</span></p>
    </div>
    ```

- **Line-height on \<span> tags**: Setting `line-height` on a `<span>` tag causes the text to collapse to `0px` height. Instead, set `line-height` on `<p>` tags. The email designer handles this automatically.

### Link rendering issues

T-Online might misinterpret links that contain line breaks, which leads to rendering issues. Make sure all hyperlinks are continuous and free of line breaks to prevent display problems.

### HTML validation and security filters

Be aware of the following HTML validation and security filter behaviors:

- **Strict HTML parsing**: T-Online uses rigorous HTML validation. Invalid or nonstandard HTML can result in the entire email being blocked or displayed incorrectly. Make sure your HTML code is clean and follows standards.
- **Unsupported elements**: Elements like `<xml>` aren't supported and can cause rendering issues. Avoid including these elements in your emails.

## Related content

- [Create Customer Insights - Journeys emails](/dynamics365/customer-insights/journeys/real-time-marketing-email)
- [Preview personalized content](/dynamics365/customer-insights/journeys/real-time-marketing-preview-personalized-content)
