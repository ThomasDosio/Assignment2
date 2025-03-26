import java.util.ArrayList;
import java.util.HashMap;

enum Permutation
{
    OSV("O, S, V, .", true), SOV("S, O, V, .", true), SVO("S, V, O, .",
        true), VOS("V, O, S, .", true), VSO("V, S, O, .", true), OVS(
        "O, V, S, .", true);

    private final String name;
    public boolean value;

    Permutation(String name, boolean value)
    {
        this.name = name;
        this.value = value;
    }

    public boolean getValue()
    {
        return value;
    }

    public void setValue(boolean value)
    {
        this.value = value;
    }

    public String getName()
    {
        return name;
    }
}

/**
 * @author Thomas Dosio
 * @version 2025-03-26
 * <p>
 * One sentence summary of this class.
 * <p>
 * Optionally: a bit more detail about this class.
 */
public class Design
{



    /*
     * @author Thomas Dosio
     * @version 2024-03-12
     * This class takes a non-empty string of Vs, Os, and/or Ss and inserts
     * punctuation at the end of a valid sentence.
     * <p>
     * A valid sentence contains: just a verb, a subject and a verb, or a
     * subject, a verb and an object. For each of the 6 permutations of these
     * three elements this class outputs the correct punctuation if the input
     * string can be made into a list of valid sentences for that order./
     */

    /**
     * This is the maximum number of different words our valid sentences can
     * have.
     */
    private static final int MAX_NUMBER_OF_WORDS_IN_A_SENTENCE = 3;

    /**
     * // puts the characters of the string into an arraylist of characters
     *
     * @param str // the string we want to transform
     * @return // returns a list of the characters in the string
     */
    public static ArrayList<Character> makeArrayList(String str)
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
     * characters from an element at a given index. The new list of
     * characters is then returned.
     *
     * @param index      tells us where to start counting characters
     * @param characters the list of characters that we will punctuate
     * @param position   tells us after how many characters we put the dot
     * @return the new string of characters including the dot
     */
    public static ArrayList<Character> addDot(int index,
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
     * This method returns an array of 4 booleans; 3 of which represent the
     * conditions that need to be met to build a valid sentence for each
     * possible length (1, 2, or 3). The fourth boolean is the case for if
     * none of the other three conditions are met.
     *
     * @param startIndex gives us the index from which we start checking if
     *                   the chars form a valid sentence
     * @param chars      the list of chars that we check
     * @return the four sets of conditions
     */
    public static ArrayList<Boolean> SentenceConditions(int startIndex,
                                                        ArrayList<Character> chars)
    {
        boolean valid3WordSentence = (chars.size() > startIndex + 2) &&
                (chars.get(startIndex) != chars.get(startIndex + 1)) &&
                (chars.get(startIndex + 1) != chars.get(startIndex + 2)) &&
                (chars.get(startIndex + 2) != chars.get(startIndex));
        boolean valid2WordSentence = (chars.size() > startIndex + 1) &&
                ((chars.get(startIndex + 1) == 'V' &&
                        chars.get(startIndex) == 'S') ||
                        (chars.get(startIndex + 1) == 'S' &&
                                chars.get(startIndex) == 'V'));
        boolean valid1WordSentence = chars.get(startIndex) == 'V';

        boolean invalidSentence = !valid1WordSentence && !valid2WordSentence &&
                !valid3WordSentence;

        ArrayList<Boolean> validSentences = new ArrayList<>();
        validSentences.add(valid1WordSentence);
        validSentences.add(valid2WordSentence);
        validSentences.add(valid3WordSentence);
        validSentences.add(invalidSentence);

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
    public static int startIndex(ArrayList<Character> characters)
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

    public static Character getLast(ArrayList<Character> characters)
    {
        return characters.get(characters.size() - 1);
    }

    /**
     * This method checks for each string in the list of possible strings, if
     * the characters after the last dot can be made into a valid sentence.
     * For each way this can be done, it adds this new sentence to a copy of
     * the string, and adds that to the list of possible strings. If this
     * can't be done then it removes the string from the list of possible
     * strings. If any input string ends with a dot it skips it as it is
     * already valid.
     *
     * @param possibleStrings the initial set of all possible strings
     * @return the final set of all possible strings
     */
    public static ArrayList<ArrayList<Character>> givePossibleStrings(
            ArrayList<ArrayList<Character>> possibleStrings)
    {
        for (int k = 0; k < possibleStrings.size(); k++)
        {


            ArrayList<Character> possibleString = possibleStrings.get(k);

            int startIndex = startIndex(possibleString);

            if (getLast(possibleString) == '.')
            {
                continue;
            }

            for (int j = 0; j < MAX_NUMBER_OF_WORDS_IN_A_SENTENCE; j++)
            {
                if (SentenceConditions(startIndex, possibleString).get(j))
                {
                    possibleStrings.add(
                            addDot(startIndex, possibleString, j + 1));
                }
            }

            //possibleStrings.remove(possibleString); //issue wiht index change
        }

        return possibleStrings;
    }

    /**
     * This method makes two arraylists, one that starts with the input
     * string and becomes a list of all the possible strings and the other
     * that slects the ones of these that are valid strings.
     *
     * @param str the input string that is made into a list of characters
     * @return the list of all valid, fully punctuated strings
     */
    public static ArrayList<ArrayList<Character>> giveValidStrings(String str)
    {
        //
        ArrayList<ArrayList<Character>> possibleStrings = new ArrayList<>();
        ArrayList<ArrayList<Character>> allValidStrings = new ArrayList<>();
        ArrayList<Character> baseString = makeArrayList(str);
        possibleStrings.add(baseString);

        possibleStrings = givePossibleStrings(possibleStrings);

        for (ArrayList<Character> possibleString : possibleStrings)
        {
            if (getLast(possibleString) == '.')
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
     * @return the modified hashmap
     */
    public static void setFalseOthers(String element)
    {
        for (Permutation permutation : Permutation.values())
        {
            if (permutation.getName() != element)
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
     * @return the modified hashmap
     */
    public static void setFalseOtherHalf(String vsOrder)
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
     * This method sets all the boolean values in the given hashmap to true
     *
     * @return the modified hashmap
     */
    public static void setAllToTrue()
    {
        for (Permutation permutation : Permutation.values())
        {
            permutation.setValue(true);
        }
    }

    /**
     * This method creates a boolean value that starts at true for each
     * permutation and links this in a hashmap to a string of those
     * characters as they would appear in an ArrayList converted to string.
     * This makes it much easier to match the boolean to the permutation's
     * truth value.
     *
     * @return the hashmap of values that start at true
     */
    public static HashMap<String, Boolean> setPermutationValues()
    {
        HashMap<String, Boolean> valuesOfPermutations = new HashMap<>();
        boolean OVS = true;
        valuesOfPermutations.put("O, V, S, .", OVS);
        boolean VSO = true;
        valuesOfPermutations.put("V, S, O, .", VSO);
        boolean VOS = true;
        valuesOfPermutations.put("V, O, S, .", VOS);
        boolean SVO = true;
        valuesOfPermutations.put("S, V, O, .", SVO);
        boolean SOV = true;
        valuesOfPermutations.put("S, O, V, .", SOV);
        boolean OSV = true;
        valuesOfPermutations.put("O, S, V, .", OSV);

        return valuesOfPermutations;
    }

    /**
     * This method takes a string of characters and for each 3-letter
     * sentence in, it turns the values of the other permutations to false.
     *
     * @param input the string that gets searched for
     *              sentences of three letters
     * @return the modified hashmap
     */
    public static void filterByPermutation(String input)
    {
        String[] permutations = {"O, S, V, .", "S, O, V, .", "S, V, O, .",
                "V, O, S, .", "V, S, O, .", "O, V, S, ."};
        for (String permutation : permutations)
        {
            if (input.contains(permutation))
            {
                setFalseOthers(permutation);
            }
        }
    }

    public static void prettyPrint(Permutation permutation,
                                   ArrayList<Character> string)
    {

        System.out.print(permutation.toString() + ":");
        for (int k = 0; k < string.size(); k++)
        {
            System.out.print(string.get(k));
        }
    }

    /**
     * The main method of this class makes a list of all potentially valid
     * strings. For each string if a sentence has three characters it
     * turns the associated boolean values of the other permutations to false,
     * if a sentence has two characters then it turns the assiated boolean
     * values
     * of the impossible half of the permutations to false. Then for each
     * true value it prints the permutation and the correctly punctuated string.
     *
     * @param args the string of characters to find valid sentences in
     */
    public static void main(String[] args)
    {
        ArrayList<ArrayList<Character>> allValidStrings = giveValidStrings(
                args[0].toUpperCase());
        //HashMap<String, Boolean> valuesOfPermutations =
        // setPermutationValues();

        for (ArrayList<Character> characterList : allValidStrings)
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
}
