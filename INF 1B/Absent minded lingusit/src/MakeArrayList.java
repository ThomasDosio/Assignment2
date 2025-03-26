import java.util.ArrayList;

public class MakeArrayList
{
    public static ArrayList<Character> MakeArrayList(String input)
    {
        // splits the string into characters and then loops to add them to an arraylist 
        char[] chars = input.toCharArray();

        ArrayList<Character> characterList = new ArrayList<>();

        for (char aChar : chars)
        {
            characterList.add(aChar);
        }
        return characterList;

    }
}
