# Document about `Markdown` #

| ![Markdown logo: capital M followed by a down-pointing arrow](https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Markdown-mark.svg/208px-Markdown-mark.svg.png) | Image: Dustin Curtis |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|

If you have accessibility needs, look at `Configuring for accessibility` or
scroll to the bottom of the source and look at the `<STYLE>` section.

## Self-study instructions ##

1. Ensure that the `IntelliJ` window is showing both the source and the rendered
   output:
    1. There are three icons controlling whether you view source, output, or
       both. These icons appear when you move the mouse near the top-right
       corner of the output (if output is shown) or the top-right of the source
       code if the output is not shown
    2. You might want to maximise the entire `IntelliJ` window
    3. You might want to shrink the screen estate given to the `Project` view
       by dragging the boundary immediately to the left of the line numbers
       in this document
2. Jump to `Configuring for accessibility` section (after Introduction) and
   follow those instructions to help make working with the document more
   suitable for your needs
3. Read the `Introduction`
4. Work through the sections below in order, adhering to any time limit set
   by your tutor — you can self-study the rest in your own time

## Introduction ##

This document is a brief introduction to `markdown` format, a widely used format
for enhancing basic text files. `Markdown` is used frequently in professional
programming projects and is especially frequent in
[GitHub](https://www.github.com) repositories. You will make use of `markdown`
when writing some documentation in this course, **including the assignments**.

`markdown` assigns special meanings to some symbols in specific circumstances.
The quickest way to get started is looking at the source and rendered output
side-by-side. Detailed instructions:

- [IntelliJ flavour of `markdown`](https://www.jetbrains.com/help/hub/Markdown-Syntax.html)
- [basics with best practices](https://www.markdownguide.org/basic-syntax/)
- [cheat sheet](https://www.markdownguide.org/cheat-sheet)

`markdown` makes use of another markup language `CSS` (Cascading Style Sheets)
to configure the appearance of the rendered output. We are not teaching `CSS`
because it is not part of this course and there is no expectation for you to
learn it. But if you are interested you can self-study from a reputable source
such as the
[Mozilla Development Network (MDN)](https://developer.mozilla.org/en-US/docs/Web/CSS)

## Configuring for accessibility ##

1. Scroll to the `<STYLE>` part at the end and look at the markup
2. Note the use of block comments `/* ... */` in `CSS`
3. Blank lines and badly-formatted lines break things!
4. Comment out and uncomment the parts of the `STYLE` to suit your needs
5. Note that `IntelliJ`'s colour scheme can impact the rendering: if you
   view the rendered `markdown` in another program the appearance can differ
6. Once you are happy with the rendered output you can continue working
   through the rest of this file, allowing for any directions from your tutor

## Configure `IntelliJ` ##

1. `Settings > Editor > Code Style > Markdown `:
    1. In the tab `Wrapping and Braces` set:
        1. `Hard wrap at` to `80` (source code is 80 characters wide by
           tradition)
        2. `Wrap on typing` to `yes` (optional depending on your preference)
2. `OK` to close the dialogue
3. `Code > Reformat Code...` to reformat to the 80-character width (ideally
   use the shortcut key to speed up productivity)
4. Text that extended beyond the 80th column has been split across multiple
   lines to fit
5. The current `IntelliJ markdown` plugin `Project to Zip` is limited
   because it does not understand the way `markdown` handles URLs and so you
   might need to fix manually.
6. If the `Project to Zip` plugin is not installed in your device,
   you can install it from the `IntelliJ` [marketplace](https://plugins.jetbrains.com/plugin/26315-project-to-zip)
   and enable it
7. It is useful to learn `IntelliJ`'s feature for joining lines: `Edit >
   Join Lines` (learn the shortcut key)
7. Reformatting a `markdown` document might have no effect on reformatting
   the `CSS <STYLE>` section

<STYLE>
* {
  font-size:   1.1rem;
  /*font-size:   1.2rem;*/
  background-color: #2A252A;
  color:            #D5DAD5;
  /*background-color: DarkSlateGray;*/
  /*color:            AntiqueWhite;*/
  /*background-color: black;*/
  /*color: white;*/
  /*background-color: white;*/
  /*color: black;*/
}
body {
  width: 80%;
  font-family: "OpenDyslexic", serif;
  /*font-family: sans-serif;*/
  line-height: 180%;
  /*line-height: 200%;*/
}
pre,
code,
pre code {
  font-family: "OpenDyslexicMono", monospace;
  line-height: 150%;
}
ol,
ol ol,
ol ol ol {
  list-style-type: decimal;
}  
em {
  font-style: normal;
  border-bottom-style: solid;
  border-bottom-width: 1px;
  padding-bottom:      2px;
  /*text-decoration: underline;*/
  text-decoration-skip-ink: auto;
}
h2 {
  border-top:  1px solid #D5DAD5;
  margin-top:  80px;
  padding-top: 20px;
}
</STYLE>