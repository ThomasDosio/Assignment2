=== BEGIN PROJECT DEBRIEFING ===

EMPLOYER: Appdroid
PROJECT NAME: Sudoku World
DATE: TO BE CONFIRMED

----------------------

INTRODUCTION
------------
Greetings esteemed contractor,

Your task is to help us with our project Sudoku World (currently version 1.9).
This version is buggy and we cannot leave the project in its current state before preparing release 2.0.

We have received a multitude of bug reports from various sources.
You will find the bug reports archived together with this briefing.
Their filenames are in the format "bugreportDDMMYYYY.txt"

To help with your task, we also provided an extract from the Sudoku World project log in project_log.txt.
This file contains project history since the release before we received the first bug report.
We hope it may help to identify the changes in Sudoku World that may have introduced some of the bugs.

Use the provided solution_template.txt file to fill in details of bugs you found and how you fixed them, so we can use your notes to extend our project log.


PROJECT USAGE
-------------
You can run the project by opening the Appdroid directory in IntelliJ IDEA and running the "Main" run configuration.
You can also run "javac -d bin/ -cp sudoku/lib/ sudoku/src/*.java && java -cp bin/ SudokuWorld" from the Appdroid directory,
should you wish compile and run the project without an IDE.

The main class in Appdroid/sudoku/src/SudokuWorld.java allows choosing a particular sudoku game from some in-built data samples. Simply change "SampleGameData.sample1" to "SampleGameData.sample2" or similar and build & run the project again to use another sample.


ADVICE
------
Your top priority is to resolve the critical bugs.
Since stability is our main priority, you should view anything that results in a program crash as critical.
If you are running out of time, make sure you get to those first and you can leave the less important bugs for later.

You may find it helpful to start with the oldest bug reports first - this will help you to catch any bugs that may be causing more bugs down the line first.

When debugging, you can trust that the Java API and included libraries are bug-free, and so you do not need to debug any built-in Java classes nor files under Appdroid/sudoku/lib.

Do not fail, we are counting on you.

=== END PROJECT DEBRIEFING ===
