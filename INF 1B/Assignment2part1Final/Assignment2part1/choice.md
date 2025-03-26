# Your choice of challenge #

- Name: Thomas Edward Dosio
- Student ID: s2683470
- Tutorial group: Tutorial group 4
- Tutor: Rohit Allen
- Date: 2024-03-12

* [Audience](#audience-)
* [Main justifications for choosing this challenge](#main-justifications-for-choosing-this-challenge-)
* [Confidence](#confidence-)
* [Comparison of the winning design with the losing design](#comparison-of-the-winning-design-with-the-losing-design-)

# The Absent Minded Linguist #

# Audience #

This is targeted at somebody who has just started learning Java and knows about 
ArrayLists and loops. I hope that the reader will get a better understanding of 
how to take advantage of Arraylists and loops to build complicated algorithms. 
I also hope that this will encourage the reader to realize that some problems 
that appear hard or to need extra knowledge (e.g. regex) are within their reach 
if they make a good design before starting to code and split the task up into parts.

# Main justifications for choosing this challenge #

I am somebody who had never done any coding before six months ago. Unlike many
people who take Inf1a I have been learning about OOP as well as java over the 
last few months and so whenever I get a chance to try something that is just 
outside my programming reach I take that chance. I want to push myself to get
up to the level of my peers who have significantly more experience and to do that
I challenge myself. That's why when I looked through the possible challenges and 
found this one, for which a solution didn't immediately jump out, I knew that it would be 
a great opportunity to learn by making mistakes and that once solved it would also 
be a great example of how to solve a complicated challenge with basic skills. Coding
is a practical subject and this challenge was a great way to put what I have learned
into practice. 


# Confidence #

I felt this challenge was very well written with attention to detail and lots of specification on the details of what is a valid sentence.
I also liked how this challenge has recent solutions (two more have been added over the last three days) as this indicates people are enjoyingn it and recommending it to others.
The wording of the challenge definetely does encourage creativity at various points such as when it asks for "a full program or a function" suggesting that some less experienced programmers may want to take a more modular approach.


# Comparison of the winning design with the losing design #

The winning design is more DRY and modular than the losing one as it can be easily split into multiple parts. 
The logic is the same for all the statements, and it doesn't need much repetition, whereas the losing design had lots of duplicated code with minor changes.
I started by writing the losing desing and then when cleaning and refactoring my code I realised the desing idea was wrong.
Then by talking with Abdulrahman I came up with the idea of generating all the possible strings of valid sentences and then filtering which was the basis of my final design. 
This makes the winning desing easier to understand and modify. 

<STYLE>
* { /* Don't leave any empty lines or IntelliJ might not render correctly */
  /* Text size */
  font-size:   1.1rem;
  /*font-size:   1.2rem;*/
  /* Zenburn dark theme */
  background-color: #2A252A;
  color:            #D5DAD5;
  /* One Dark theme */
  /*background-color: #282C34;
  color:            #ABB2BF;*/
  /* white-ish on dull blue-ish */
  /*background-color: DarkSlateGray;
    color:            AntiqueWhite;*/
  /* white on black */
  /*background-color: black;
  color: white;*/
  /* black on white */
  /*background-color: white;
  color: black;*/
  /* nearly black on bright yellow */
  /*background-color: #FFFFAA;
  color:            #080808;*/
  /* black on bright blue */  
  /*background-color: #99CCFF;
  color:            black;*/
}
body {
  /* width of the text column */
  width: 80%;
  /* line spacing */
  line-height: 180%;
  /*line-height: 200%;*/
  /* Font styles: */
  /* Default sans serif */
  /*font-family: sans-serif;*/
  /* Default serif */
  font-family: serif;
  /* Specific font with generic fall-back */
  /* font-family: "Calibri Light", sans-serif; */
  /*font-family: "OpenDyslexic", sans-serif;*/
}
pre,
code,
pre code {
  /* line spacing */
  line-height: 150%;
  /* Default monospace */
  font-family: monospace;
  /* Specific fixed-width font with generic fall-back */
  /*font-family: "Consolas", monospace;*/
  /*font-family: "OpenDyslexicMono", monospace;*/
}
ol,
ol ol,
ol ol ol { /* Nested lists all use decimal numbering */
  list-style-type: decimal;
}
em {
  /* if you want underlining instead of italics */
  /*font-style: normal;
  border-bottom-style: solid;
  border-bottom-width: 1px;
  padding-bottom:      2px;*/
  text-decoration-skip-ink: auto;
}
h2 { /* Put a horizontal line above major headings to assist screen viewing */
  border-top:  1px solid #D5DAD5;
  margin-top:  80px;
  padding-top: 20px;
  }
</STYLE>