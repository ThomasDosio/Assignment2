import java.util.ArrayList;

/**
 * Creates an enum of 6 values that correspond to the 6 ways of ordering
 * verb, subject and object. Each of these is associated with a string which
 * is the way the three letters (V, S and O) appear once the arraylist of
 * characters that we will work through is converted to a string. They are
 * also associated with a boolean value that will change to false for the
 * strings where that permutation is invalid.
 */
enum Permutation
{
    OSV("O, S, V, .", true), SOV("S, O, V, .", true),
    SVO("S, V, O, .", true), VOS("V, O, S, .", true),
    VSO("V, S, O, .", true), OVS("O, V, S, .", true);

    private final String name;
    private boolean value;

    /**
     * Constructor for the permutations
     * @param name the name of the permutation in another format
     * @param value the truth-value of the permutation that the algorithm
     *              will change
     */
    Permutation(String name, boolean value)
    {
        this.name = name;
        this.value = value;
    }

    /**
     * Getter for the permutation's truth value
     * @return the truth value as it is
     */
    boolean getValue()
    {
        return value;
    }

    /**
     * Setter for the permutation's truth value
     * @param value the value we want to assign to the given permutation
     */
    void setValue(boolean value)
    {
        this.value = value;
    }

    /**
     * Getter for the permutation's name
     * @return the name as it would appear when the arraylist is converted to
     * a string
     */
    String getName()
    {
        return name;
    }
}

/**
 * @author Thomas Dosio
 * @version 2025-03-26
 * <p>
 * This class splits an ordered list of verbs, subjects and objects into a
 * string of sentences for each valid way of ordering them.
 * <p>
 * A valid sentence contains: just a verb, a subject and a verb, or a
 * subject, a verb and an object. For each of the 6 permutations of these
 * three elements this class outputs the correct punctuation if the input
 * string can be made into a list of valid sentences for that order.
 * The input is a non-empty string of Vs, Ss and/or Os that represent verb,
 * subject and object.
 */
public class Design
{
    /**
     * This is the maximum number of different words our valid sentences can
     * have.
     */
    private static final int MAX_NUMBER_OF_WORDS_IN_A_SENTENCE = 3;

    /**
     * Puts the characters of the string into an arraylist of characters
     *
     * @param str the string we want to transform
     * @return returns a list of the characters in the string
     */
    private static ArrayList<Character> makeArrayList(String str)
    {
        char[] chars = str.toCharArray();
        ArrayList<Character> characterList = new ArrayList<>();
        for (char aChar : chars)
        {
            characterList.add(aChar);
        }
        return characterList;
    }

    /**
     * This method makes a deep copy of the input list of characters.
     * Then working on that copy it adds a dot ('.') after a given number of
     * characters from an element at a given index.
     *
     * @param index      tells us where to start counting characters
     * @param characters the list of characters that we will punctuate
     * @param position   tells us after how many characters we put the dot
     * @return the new string of characters including the dot
     */
    private static ArrayList<Character> addDot(int index,
                                               ArrayList<Character> characters,
                                               int position)
    {
        ArrayList<Character> punctuatedCharacters = new ArrayList<>();
        for (Character character : characters)
        {
            punctuatedCharacters.add(character);
        }

        punctuatedCharacters.add(index + position, '.');
        return punctuatedCharacters;
    }

    /**
     * This method returns an arraylist of 4 booleans; 3 of which represent the
     * conditions that need to be met to build a valid sentence for each
     * possible length (1, 2, or 3). The fourth boolean is the case for if
     * none of the other three conditions are met.
     *
     * @param startIndex gives us the index from which we start checking if
     *                   the characters form a valid sentence
     * @param characters      the list of characters that we check
     * @return the four sets of conditions
     */
    private static ArrayList<Boolean> sentenceConditions(int startIndex,
                                                         ArrayList<Character>
                                                                 characters)
    {
        boolean valid3WordSentence = (characters.size() > startIndex + 2) &&
                (characters.get(startIndex) != characters.get(startIndex + 1)) &&
                (characters.get(startIndex + 1) != characters.get(startIndex + 2)) &&
                (characters.get(startIndex + 2) != characters.get(startIndex));

        boolean valid2WordSentence = (characters.size() > startIndex + 1) &&
                ((characters.get(startIndex + 1) == 'V' &&
                        characters.get(startIndex) == 'S') ||
                        (characters.get(startIndex + 1) == 'S' &&
                                characters.get(startIndex) == 'V'));

        boolean valid1WordSentence = characters.get(startIndex) == 'V';

        ArrayList<Boolean> validSentences = new ArrayList<>();
        validSentences.add(valid1WordSentence);
        validSentences.add(valid2WordSentence);
        validSentences.add(valid3WordSentence);

        return validSentences;
    }

    /**
     * This method gives the index of the first character in the list of
     * characters that isn't part of a sentence (isn't followed by a dot at a
     * later point).
     *
     * @param characters the list of characters we check
     * @return the index of the first element not in a sentence
     */
    private static int startIndex(ArrayList<Character> characters)
    {
        int index = 0;

        for (int i = 0; i < characters.size() - 1; i++)
        {
            if (characters.get(i) == '.')
            {
                index = i + 1;
            }
        }
        return index;
    }

    /**
     * This method checks for each string in the list of possible strings, if
     * the characters after the last dot can be made into a valid sentence.
     * For each way this can be done, it adds this new sentence to a copy of
     * the string, and adds that to the list of possible strings. If any
     * input string ends with a dot it skips it as it is already valid.
     *
     * @param possibleStrings the initial set of all possible strings
     */
    private static void givePossibleStrings(
            ArrayList<ArrayList<Character>> possibleStrings)
    {
        for (int k = 0; k < possibleStrings.size(); k++)
        {
            ArrayList<Character> possibleString = possibleStrings.get(k);

            int startIndex = startIndex(possibleString);

            if (possibleString.getLast() == '.')
            {
                continue;
            }

            for (int j = 0; j < MAX_NUMBER_OF_WORDS_IN_A_SENTENCE; j++)
            {
                if (sentenceConditions(startIndex, possibleString).get(j))
                {
                    possibleStrings.add(
                            addDot(startIndex, possibleString, j + 1));
                }
            }
        }

    }

    /**
     * This method makes two arraylists, one that starts with the input
     * string and becomes a list of all the possible strings and the other
     * that selects the ones of these that are valid strings.
     *
     * @param str the input string that is made into a list of characters
     * @return the list of all valid, fully punctuated strings
     */
    private static ArrayList<ArrayList<Character>> giveValidStrings(String str)
    {
        ArrayList<ArrayList<Character>> possibleStrings = new ArrayList<>();
        ArrayList<ArrayList<Character>> allValidStrings = new ArrayList<>();
        ArrayList<Character> baseString = makeArrayList(str);

        possibleStrings.add(baseString);

        givePossibleStrings(possibleStrings);

        for (ArrayList<Character> possibleString : possibleStrings)
        {
            if (possibleString.getLast() == '.')
            {
                allValidStrings.add(possibleString);
            }
        }

        return allValidStrings;
    }

    /**
     * This method turns all the boolean values except the one linked to
     * the input string to false
     *
     * @param element the element whose truth value remains the same
     */
    private static void setFalseOthers(String element)
    {
        for (Permutation permutation : Permutation.values())
        {
            if (!permutation.getName().equals(element))
            {
                permutation.setValue(false);
            }
        }
    }

    /**
     * This method turns the values of half of the orderings to
     * false depending on the order of the V and S given as input.
     *
     * @param vsOrder the wanted order of v and s to remain the same
     */
    private static void setFalseOtherHalf(String vsOrder)
    {
        if (vsOrder.equals("VS"))
        {
            Permutation.OSV.setValue(false);
            Permutation.SVO.setValue(false);
            Permutation.SOV.setValue(false);
        }
        if (vsOrder.equals("SV"))
        {
            Permutation.OVS.setValue(false);
            Permutation.VSO.setValue(false);
            Permutation.VOS.setValue(false);
        }
    }

    /**
     * This method sets all the boolean values associated to the permutations
     * to true
     */
    private static void setAllToTrue()
    {
        for (Permutation permutation : Permutation.values())
        {
            permutation.setValue(true);
        }
    }

    /**
     * This method takes a string of characters and for each 3-letter
     * sentence in, it turns the values of the other permutations to false.
     *
     * @param input the string that gets searched through
     */
    private static void filterByPermutation(String input)
    {
        String[] permutations =
                {"O, S, V, .", "S, O, V, .", "S, V, O, .", "V, O, S, .",
                        "V, S, O, .", "O, V, S, ."};
        for (String permutation : permutations)
        {
            if (input.contains(permutation))
            {
                setFalseOthers(permutation);
            }
        }
    }

    /**
     * Prints the valid strings of sentences nicely
     * @param permutation the permutation that is valid
     * @param string the punctuated string for this permutation
     */
    private static void prettyPrint(Permutation permutation,
                                    ArrayList<Character> string)
    {

        System.out.print(permutation.toString() + ":");
        for (Character character : string)
        {
            System.out.print(character);
        }
    }

    /**
     * Prints the valid sentences for each valid order
     * @param validStrings the punctuated string that gets checked for each
     *                     order
     */
    private static void printTrue(ArrayList<ArrayList<Character>> validStrings)
    {
        for (ArrayList<Character> characterList : validStrings)
        {
            setAllToTrue();
            String string = characterList.toString();

            filterByPermutation(string);

            if (string.contains("V, S, ."))
            {
                setFalseOtherHalf("VS");
            }
            if (string.contains("S, V, ."))
            {
                setFalseOtherHalf("SV");
            }

            for (Permutation permutation : Permutation.values())
            {
                if (permutation.getValue())
                {
                    prettyPrint(permutation, characterList);
                    System.out.println();
                }
            }
        }
    }

    /**
     * The main method of this class makes a list of all potentially valid
     * strings. For each string if a sentence has three characters it
     * turns the associated boolean values of the other permutations to false,
     * if a sentence has two characters then it turns the associated boolean
     * values of the impossible half of the permutations to false. Then for each
     * true value it prints the permutation and the correctly punctuated string.
     *
     * @param args the string of characters to find valid sentences in
     */
    public static void main(String[] args)
    {
        ArrayList<ArrayList<Character>> allValidStrings =
                giveValidStrings(args[0].toUpperCase());

        printTrue(allValidStrings);
    }
}
