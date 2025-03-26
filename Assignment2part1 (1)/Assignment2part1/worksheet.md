- Name: Thomas Dosio
- Student ID: s2683470
- Tutorial group: Group 4
- Tutor: Rohit Allen
- Date: 2024-03-08

# Worksheet #

This worksheet will try to explain with the aid of a diagram a solution to the code golf challenge the absent-minded 
linguist. The problem input is a non-empty string of the characters V, S and O which stand for verb,
subject and object. The string represents a list of sentences to be analysed by your friend who is a linguist but has 
forgotten which language each belongs to. The problem consists in splitting the strings of characters into valid sentences
for each of the six permutations of V, S and O which are all valid orders in some natural language. A valid sentence can 
have just a verb, a verb and a subject or a verb, a subject and an object all of which must be in the right order for the given permutation. 

The solution presented to this problem has four main parts: it reads the input, it splits the string, it applies an algorithm to
work out which list of sentences are valid for each permutation, and then it print this as an output.

The input is read as a string and then converted to an arraylist of characters. This is because it lets us easily manipulate the string and add dot at the end of sentences.
This arraylist of characters is then split into possible sentences.

The algorithm for splitting the string is the most complicated part of the program. It works by massively expanding the
list of possible strings and then filtering to valid ones. Essentially, for each dot, it makes a copy of the string and adds a dot after the first character if it's a V.
If the first two characters are a V and an S in any order then it makes a copy of the string and adds a dot after two characters. 
If the first three characters are different then it puts a dot in a copy of the string after three characters. 
This ensures that every possible valid sentence has its own branch of the possibilities tree. 

Therefore, the number of possible strings increases by up to three after each dot. The arraylist of possible strings is iterated over
so that we keep working on the new strings we have created. Once all the latest strings end in full stops, we then filter the list of possible strings
to get just ones that end in a dot. We then apply the algorithm to every element of our list of punctuated strings.

Every permutation is represented by a string of its characters associated to a boolean value in a HashMap. 
The string allows for easy matching when searching in another string for that combination of characters. The boolean 
corresponds to the truth value of whether the permutation is still a valid option that will be printed. It starts at
true and then the algorithm changes the impossible permutation values to false.

The algorithm is quite straightforward to understand. If the sentence has three letters then it turns the 
boolean associated with the other permutations to false (this is because if the string contained OVS. for example then the order VSO must be wrong and so on). 
If the sentence has two letters then the algorithm turns all the permutations containing the opposite order of V and S to false. For example if there 
is the sentence: VS. then OSV, SOV and SVO are all no longer valid permutations for the string. By working like this through every sentence in the string
the booleans that remain true are the ones that are true for every sentence in the string.
For each true boolean for a given way of splitting a string, the program prints the permutation and the way of splitting the string.

So to sum up the program gives all the ways to split the input string into valid sentences and then if every sentence in one of these ways is valid for a given permutation the program prints the output.

Hopefully by reading this worksheet and the code in the design, the reader now has a more solid grasp of how to use hashmaps and arraylists effectively 
and has gained confidence in how the skills they already know in a good design can be used to solve complicated questions. 



# Original challenge question from CodeGolf #

[Link to the Absent Minded Linguist Problem](https://codegolf.stackexchange.com/q/69084 "The Absent Minded Linguist")



# Background #
Your friend, a linguist, has recorded and analyzed some simple conversation snippets in various languages. Being quite absent-minded, they have forgotten which language each snippet was in. You must help them by creating a program that analyzes the sentence structures and rules out impossible cases.

# Input #
Your input is a non-empty string containing the characters SVO, which stand for subject, verb, and object. It represents a conversation snippet analyzed by the linguist.

# Output #
Your task is to break the string into sentences, and enter a period . after each sentence. A sentence contains either a verb, OR a verb and a subject, OR a verb, a subject and an object. However, you don't know which word order the original language uses; English uses subject-verb-object, but other languages, like Latin, use subject-object-verb. In fact, all six permutations exist in natural languages, so you must check each of them.

Your output shall contain, in a newline-separated string, each applicable word order, a colon :, and the input string broken into sentences according to that order. If the string cannot be parsed in some word order, the corresponding line shall be omitted. The order of the lines does not matter, and it is guaranteed that at least one word order can be parsed.

Example
Consider the input

VSVOSV
In the VOS order, the snipped can be parsed as VS.VOS.V., and in the SVO order, it can be parsed as V.SVO.SV.. The order OSV also works, and the full output is

VOS:VS.VOS.V.
SVO:V.SVO.SV.
OSV:V.SV.OSV.
Rules and scoring
You can write a full program or a function. The lowest byte count wins, and standard loopholes are disallowed. Regular expressions and all built-ins are allowed.

# Test cases #
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

Input:
VSVOSV
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
  font-size:   1.3rem;
  /*font-size:   1.2rem;*/
  /* Zenburn dark theme */
  /*background-color: #2A252A;*/
  /*color:            #D5DAD5;*/
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
  background-color: white;
  color: black;
  /* nearly black on bright yellow */
  /*background-color: #FFFFAA;
  color:            #080808;*/
  /* black on bright blue */  
  /*background-color: #99CCFF;
  color:            blue;*/
}
body {
  /* width of the text column */
  width: 90%;
  /* line spacing */
  line-height: 300%;
  /*line-height: 200%;*/
  /* Font styles: */
  /* Default times-new-roman */
  /*font-family: times-new-roman;*/
  /* Default serif */
  /*font-family: serif;*/
  /* Specific font with generic fall-back */
  /* font-family: "Calibri Light", sans-serif; */
  font-family: "OpenDyslexic", sans-serif;
}
pre,
code,
pre code {
  /* line spacing */
  line-height: 200%;
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