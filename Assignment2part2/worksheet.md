- Name: Thomas Dosio
- Student ID: s2683470
- Tutorial group: Group 4
- Tutor: Rohit Allen
- Date: 2025-03-26

# The Absent-Minded Linguist #

# Target audience # 

TODO define your target audience

This worksheet is aimed at someone who knows basic java. The reader needs to
know about arraylists and loops. The reader should be a beginner in the Java
programming language. Hopefully the reader will learn a new data structure 
in java: enums, and how to use them effectively. 

# Prerequisite knowledge #

TODO outline what the target audience needs to know before starting.

This worksheet requires basic java knowledge such as how loops work, how to
manipulate strings and how to effectively use arraylists. Ideally, the 
reader should also know about private classes, constructors, getters and 
setters.

# Learning outcomes #

TODO outline what the target audience is expected to learn.

The reader will hopefully learn how to use enums to simplify a task in java and
solidify their knowledge of arraylists and how to use arraylists of arraylists
effectively. The reader will learn what enums are, how they are implemented, 
why they can be more useful than other data structures.

# Introduction #

This worksheet will work through an example problem: The Absent-Minded 
Linguist, from the code golf website. In addition to explaining the 
algorithms used to solve the problem effectively, it will also explain enums 
to a beginner audience and how to use them in this example. 

# The challenge #

Imagine a linguist has various conversations (made up of sentences) but doesn't 
remember which language each conversation is in. They ask you to help them 
by splitting the conversation into valid sentences for each language pattern 
so they can quickly sort the conversations into the right language. Your 
task therefore is to take a non-empty string of Vs, Ss and Os representing 
verbs, subjects and objects respectively. You have to check for each of the 
6 permutations of V, S and O if the string can be split into valid sentences 
for that order. A valid sentence is a verb, a subject, and an object, in the 
right order or just a verb and a subject in the right order or just a verb. 
The output is the input string, correctly punctuated and preceded by the 
right word order for all the valid orders.

# The Splitting Algorithm #



# What are Enums and how are we using them #



# The Checking Algorithm #



# Conclusion #






# Original challenge question from CodeGolf #

[Short link to CodeGolf challenge](https://codegolf.stackexchange.com/q/69084 "tooltip text")

Background
Your friend, a linguist, has recorded and analyzed some simple conversation
snippets in various languages. Being quite absent-minded, they have forgotten
which language each snippet was in. You must help them by creating a program
that analyzes the sentence structures and rules out impossible cases.

Input
Your input is a non-empty string containing the characters SVO, which stand for
subject, verb, and object. It represents a conversation snippet analyzed by the
linguist.

Output
Your task is to break the string into sentences, and enter a period . after each
sentence. A sentence contains either a verb, OR a verb and a subject, OR a verb,
a subject and an object. However, you don't know which word order the original
language uses; English uses subject-verb-object, but other languages, like 
Latin, use subject-object-verb. In fact, all six permutations exist in natural 
languages, so you must check each of them.

Your output shall contain, in a newline-separated string, each applicable word
order, a colon :, and the input string broken into sentences according to that
order. If the string cannot be parsed in some word order, the corresponding line
shall be omitted. The order of the lines does not matter, and it is guaranteed 
that at least one word order can be parsed.

Example
Consider the input

VSVOSV
In the VOS order, the snipped can be parsed as VS.VOS.V., and in the SVO order,
it can be parsed as V.SVO.SV.. The order OSV also works, and the full output is

VOS:VS.VOS.V.
SVO:V.SVO.SV.
OSV:V.SV.OSV.

Rules and scoring
You can write a full program or a function. The lowest byte count wins, and
standard loopholes are disallowed. Regular expressions and all built-ins are
allowed.

Test cases
Input:
V
Output:
VSO:V.
VOS:V.
SVO:V.
OVS:V.
SOV:V.
OSV:V.

Input:
SVV
Output:
SVO:SV.V.
SOV:SV.V.
OSV:SV.V.

Input:
VSVOV
Output:
SVO:V.SVO.V.

Input:
VSOVS
Output:
VSO:VSO.VS.
OVS:VS.OVS.

Input:
SVOSV
Output:
SVO:SVO.SV.
OSV:SV.OSV.

Input:VSVOSV
Output:
VOS:VS.VOS.V.
SVO:V.SVO.SV.
OSV:V.SV.OSV.

Input:
VSVVSOVSV
Output:
VSO:VS.V.VSO.VS.V.
OVS:VS.V.VS.OVS.V.
SOV:V.SV.V.SOV.SV.

Input:
SVVSVSOVSVV
Output:
SOV:SV.V.SV.SOV.SV.V.

Input:
VSOVSVSOVSVVS
Output:
VSO:VSO.VS.VSO.VS.V.VS.
OVS:VS.OVS.VS.OVS.V.VS.

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