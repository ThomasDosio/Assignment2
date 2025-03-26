# Pretty-printing dice #

First configure this document's CSS `<STYLE>` to suit your needs.
Remember to delete these and the other instructions afterwards. Make time to
complete the `reflections.md` document.

|         |                                           |
|---------|-------------------------------------------|
| Author  | TODO insert name                          |
| Date    | TODO insert date in year-month-day format |
| Summary | TODO One sentence summary of your program |

Example summaries:

- A very simple way to pretty-print dice using `if` statements
- A very simple way to pretty-print dice using `switch`
- Using an array to pretty-printing dice
- Pretty-printing dice using a method optimised for saving space

## Optional task ##

Draft a set of instructions for a beginner or novice programmer trying to
implement your design(s). Do this using `markdown`.

## Background ##

TODO: Outline what the task is: basically converting a number to a picture
made from text.

## Design ##

TODO: Explain your design. Give an overview first. You will also need to say
which Java structures and corresponding syntax are necessary or recommended.

## Code requirements ##

Highlight the one or two really key lines that the entire design depends on.

## Engineering requirements ##

We can assess your design using some Software Engineering
[best practice](https://www.rfc-editor.org/rfc/rfc2119) called "engineering 
requirements."

It is possible to assess the design by analysing the code. But please do 
include your design in the `design` directory.

The program **MUST**:

1. be able to pretty-print all possible faces of a 6-sided dice
2. print the one face that the user requests
3. be consistent in its output

The program **MUST NOT**:

1. print the wrong dice face
2. print the correct dice face wrongly

The program **SHOULD**:

1. match its design
2. be commented sensibly, using JavaDoc and regular comments appropriately
3. be fully platform-independent
4. determine the appropriate end-of-line character at run-time
5. have a flexible design that allows relatively easy updating if the
   requirements change, for example a dice with a different number of sides
6. when encountering incorrect input either ignore it, recover from it, or
   fail gracefully with an explanatory error message

The program **SHOULD NOT**:

1. crash when encountering inappropriate input
2. print anything it is not supposed to (compare with the appropriate model
   output) unless a deliberate decision has been taken to produce additional
   output in certain circumstances (see the **MAY** section)

The program **MAY**:

1. accept more than one input and print multiple dice faces, possibly
   side-by-side if the designer wishes to interpret multiple numbers on the
   same input line that way
2. accept additional input that:
    1. prints debugging or status information
    2. configures how the program works

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