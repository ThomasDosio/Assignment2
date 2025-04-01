- Name: Thomas Dosio
- Student ID: s2683470
- Tutorial group: Group 4
- Tutor: Rohit Allen
- Date: 2025-03-26

# The Absent-Minded Linguist #

# Target audience #

This worksheet is aimed at someone who knows basic java. The reader needs to
know about arraylists and loops. The reader should be a beginner in the Java
programming language. Hopefully the reader will learn a new data structure 
in java: enums, and how to use them effectively. 

# Prerequisite knowledge #

This worksheet requires basic java knowledge such as how loops work, how to
manipulate strings and how to effectively use arraylists. Ideally, the 
reader should also know about private classes, constructors, getters and 
setters.

# Learning outcomes #

The reader will hopefully learn how to use enums to simplify a task in java and
solidify their knowledge of arraylists and how to use arraylists of arraylists
effectively. The reader will learn what enums are, how they are implemented, 
why they can be more useful than other data structures.

# Introduction #

This worksheet will work through an example problem: The Absent-Minded 
Linguist, from the code golf website. In addition to explaining the 
algorithms used to solve the problem effectively, it will also explain enums 
to a beginner audience and how to use them in this example. 

# Accessibility text description of diagram #

The diagram has three figures. Figure 1 is a flowchart explaining the method 
givePossibleStrings. This is shown in a box with an arrow leading to a box 
saying "loops through possibleStrings". From this box there are two arrows 
leaving, corresponding to the three things this is doing. The first arrow 
leads to a box saying "Get the possible string" which in turn leads to "Find 
the startIndex of the current possibleString". The next arrow leads to a 
loop of three boxes which say respectively: check if the last character is a 
dot, get the last character of the current possibleString and then if the 
last charcter is a dot skip this string. This box is then connected back to 
the 'loops through possible strings' box. There's an arrow leading from the 
box that checks if the last character is a dot and links it to a series of 
connected boxes in the case that it isn't a dot. The read in order: loop
through sentence conditions, get the sentence conditions for the start index,
check if the current sentence condition is true, if so add a new possible 
string, create a new possible string by adding a dot at the specified index, 
and then finally: add the new possible string to the list of possbile 
strings. This box is then linked back to the 'loops through possible 
strings' box. Finally, in the bottom right corner there is a red box that 
reads end givePossibleStrings.

Figure 2 has a legend with the letters V S O V S written underneath 
respectively a blue triangle, a yellow square, an orange circle, a blue 
triangle and a yellow square. The rest of the diagram is a series of rows 
with arrows linking them. Each row contains the list of possible strings 
with a line underlying the one that is being worked on to get to the next 
step. Initially there is just the list of those five shapes with no dots. 
Then there is an arrow leading down to the next row where the index is now 
on the second element of the list. the list now has 4 elements: the original 
string, followed by the list of the five shapes with a dot after the first 
shape (a triangle), followed by the list of the shapes with a dot after two 
shapes instead, and then followed by the same list but with the dot after 
three shapes instead. There is then an arrow leading down to the next row 
which is the same as this one except it has an extra element at the end. The 
new element has two dots: one after the triangle and then one after three 
distinct shapes. The next row has another new element which has two dots, 
one after the frst two shapes and then one after the last three. The row 
under that has 2 new elements: one with a dot after three shapes and then 
after one more shape, and the other with a dot after three shapes and then 
after the remaining two shapes. The next row is the same as the previous 
one showing how the program has nothing to add after that. 

Figure 3 has the same legend as figure 2 with the string VSOVS associated to 
5 shapes, one for each letter. The figure is then split into two halfs: one 
for each of the two strings VSO . VS. and  VS . OVS. Then each sentence of 
shapes is associated with an arrow to a list of the six permutations of the 
triangle, the square and the circle. The four columns corresponding to VSO, 
VS, VS, OVS have green ticks and red crosses. For the 3-letter sentences 
the only permutations with green crosses are the ones corresponding to that 
sentence and for the 2-letter ones, the ones with different orders of 
triangles and squares have red crosses. The diagram then summarises that the 
only permutations that remain true for the first valid string of shapes is 
triangle, square, circle and for the second one is circle, triangle, square. 
The last part of the figure is the output which is the permutations followed 
by a colon and then the punctuated string of shapes. 

# Contents #

* [The challenge](#The-Challenge-)
* [The Structure](#The-Structure-)
* [The Splitting Algorithm](#The-Splitting-Algorithm-)
* [What are Enums and how are we using them](#What-are-enums-and-how-are-we-using-them-)
* [The Checking Algorithm](#The-Checking-Algorithm-)
* [Conclusion](#Conclusion-)
* [Original challenge question from CodeGolf](#Original-challenge-question-from-CodeGolf-)



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

# The Structure #

The main method of this class calls two functions: one that gives all the valid 
strings of sentences and the other that for each string, prints the expected 
output, if it's true that the sentences in the string fulfill the sentence 
conditions. This is representative of the overall design structure. This 
challenge has two main issues: how to split the words into sentences and how to 
check if the sentences work for each permutation. Therefore, our design also has
two parts to it, an algorithm for each problem we are facing. 

# The Splitting Algorithm #

First, we will explain the algorithm for splitting the string of words into 
lists of valid sentences. Our first issue is that we would like to add '.'s 
at the end of our sentence or rather we want to be able to add a character to 
the string at a given index. To do this we will convert our string into an 
arraylist of characters. This allows us to take advantage of arraylist's add 
method at a given index. 

Hence, the first method we will call is makeArrayList. This method 
transforms the input string into an array or characters and then iterates 
over the array adding each character to an arraylist which we call 
characterList.

Now that we can add punctuation wherever we would like, we will move on to 
the main algorithm for this part, which is mainly contained in the method 
givePossibleStrings. As shown in figure 1 this method loops through the 
possible strings. This is an arraylist that we add elements to as we go work 
through the algorithm. The initial possible string is just the input string. 

As figure 1 shows clearly, the algorithm first of all finds the starting index. 
to do this we call another method that returns 0 if the string has no '.' or 
the index after the index of the last '.' otherwise. This method ensures 
that we don't punctuate a sentence that we have already finished. 

Next, the algorithm skips the strings that end in a dot. This is because 
these are already finished options that we don't want to change anymore. The 
algorithm will end when we have worked through all the strings and skipped 
the last ones which will have a dot at the end.

If the last character isn't a dot then we check for each of the sentence 
conditions for a 1, 2, and 3-word sentence if the conditions are true. The 
sentence conditions are found by calling a method with that name, given a 
starting index and the string we are working on. The conditions evaluate to 
true if there are enough characters left in the string to form a valid 
sentence of that length. A valid 1-word sentence has just a V, a valid 
2-word sentence has an S and a V and a valid 3-word sentence has all three 
letters V, S and O. For each string we are working on the conditions for 
each sentence length are checked separately by iterating through an arraylist 
that they are stored in. 

If a condition is true then we can form a sentence of that length after our 
index. Therefore, the next thing we want to do it make a copy of the string 
we are working on, add a '.' at the correct index. This is what the addDot 
method does. We then add this new possible string with one '.' more than 
before to the list of possible strings we are working through.

This means that if we have punctuated the last sentence, then the fully 
punctuated string will be skipped by the algorithm, and otherwise we will 
work on this string we added to punctuate the next sentence. Note that each 
string when the algorithm is applied to it can add 0-3 possible strings to 
the list we are working through. This is because there are 0-3 ways of 
making a sentence (it could be impossible (0), just a 1-word sentence (1), a 
1-word and a 2-word sentence (2), or all three lengths of sentences (3)). 

In figure 2, there is a worked example of how this algorithm works through 
the string VSOVS with the V shown as a blue triangle, the S as a yellow square 
and the O as an orange circle. It shows how the algorithm adds strings to 
the list of possible strings as it operates. 

Lastly, we want to filter the list of all possible strings that we've been 
working through, down to just the strings that are fully punctuated. To do 
this we will call the method allValidStrings that takes the possible strings 
and adds the ones that end in a '.' to the list of valid strings that will 
be returned to the main method. 

# What are Enums and how are we using them #

Enums are a data structure in java that are also a special type of class. 
They are used to hold a small number of constant values and iterate through 
them. This makes them much safer to use for checking if an input has typos or 
errors. It allows for compile time checking and evaluating. In this program we 
create an enum called permutation that contains the 6 valid permutations: 
OVS, OSV, SOV, SVO, VSO, VOS. We can also give the permutations parameters. 
We use this to give them two parameters. The first is a constant string that 
corresponds to how the permutations would look when the sentence was 
converted into an arraylist of characters. This allows us to do string 
comparison quickly. The second parameter we associate with a setter as well 
as just a getter and a constructor like the string. This parameter is a 
boolean value that starts at true and will change as we work through the 
checking algorithm.

# The Checking Algorithm #

The second main part of our program is the checking algorithm, that checks 
for all the valid strings if that combination of sentences is valid for each 
permutation and if it is, it prints the output. 
This algorithm works through each string of valid sentences separately. 

The algorithm is summarised with the following pseudocode:

for each string of sentences:
    set all the permutation truth values to true
    convert string of sentences from arraylist ot string
    check if the sentence has a 3-letter sentence:
        if so then for each one of these turn all the permutations except 
        that one to false
    check if the sentence has a 2-letter sentence:
        if so then for each one turn three of the permutations truth 
        values to false(the ones with the opposite v s order)
    for each permutation:
        check if the truth value for that permutation is true:
            if so print the permutation + : + the string we are working on
End


The first step this algorithm takes is turn all the truth values of the 
permutations to true. These will then be set to false if there is a 
conditions that prevents that permutation from being a valid one. 

Next we will convert the string of sentences we are working on from an 
arraylist of characters back to string. This allows us to check if the string 
at any point contains a given expression by using the string method contains. 

Now we will filter out the impossible truth values. If a string contains a 
sentence of three characters at any point then the other permutations must 
be false. For example, we can't have the permutation VSO if one sentence is 
OSV.  The method that filters with three letter permutations is 
filterByPermutation. This sets the truth values of the other permutations to 
false, for each permutation sentence it can find in the string. It does this by 
calling another method setFalseOthers which is self-explanatory. 

However, we also know that if we have a sentence with just a V and an S 
these also have to be in the right order. Therefore, we can turn half the 
values of the permutations to false for each 2-letter sentence.

Lastly, if we have any permutations that are still true we want to print the 
string we are working on with the corresponding permutation. This is what 
the last part of the printTrue method does. It calls the prettyPrint method 
that produces the output in the format we require. 

In figure 3, there is a worked example of how this algorithm works through
the possible valid strings of sentences for VSOVS with the V shown as a blue
triangle, the S as a yellow square and the O as an orange circle. It shows how
the algorithm changes the truth values of the permutations for each sentence.
The permutations associated with green ticks are true and the ones
associated with red crosses are false. The figure shows the two resulting
true permutations for each way of splitting the string.
Lastly figure 3 shows the expected output for that string.


# Conclusion #

Hopefully, by reading through this worksheet the reader will have a better 
idea of what enums are and how they can be implemented. We also hope that 
the reader enjoyed finding a solution to a complex problem such as this one 
and understood our design idea and how by dividing and conquering we broke 
the task down into small steps that were easier to implement.




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
  /* nearly black on bright yellow */
  background-color: #FFFFAA;
  color:            #080808;
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