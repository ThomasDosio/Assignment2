import java.util.ArrayList;

public class AbsentMindedLinguist
{
    public static void split(String str)
    {
        // puts the sentences into a separate arraylist for each permutation
        ArrayList<Character> charactersVSO = makeArrayList(str);
        ArrayList<Character> charactersVOS = makeArrayList(str);
        ArrayList<Character> charactersOVS = makeArrayList(str);
        ArrayList<Character> charactersOSV = makeArrayList(str);
        ArrayList<Character> charactersSVO = makeArrayList(str);
        ArrayList<Character> charactersSOV = makeArrayList(str);


        // while these are true then the grammar is fine and they will be printed
        boolean OSV = true;
        boolean OVS = true;
        boolean VSO = true;
        boolean VOS = true;
        boolean SVO = true;
        boolean SOV = true;

        // make an array with the six arraylists so that we can use the same algorithm over all 6

        ArrayList<ArrayList<Character>> permutations = new ArrayList<>();
        permutations.add(charactersVSO);
        permutations.add(charactersVOS);
        permutations.add(charactersSVO);
        permutations.add(charactersSOV);
        permutations.add(charactersOVS);
        permutations.add(charactersOSV);




        for (ArrayList<Character> characters : permutations)
        {
            // eliminates the impossible options
            for (int i = 0; i < characters.size() ; i++)
            {
                // Checks if its part of a sentence and skips to the end of the sentence
                boolean isPartOfSentence = false;
                for (int j = i; j < characters.size(); j++)
                {
                    if (characters.get(j) == '.') {isPartOfSentence = true; break;}

                }
                if (isPartOfSentence) continue;

                // checks for O then S then V

                if (i<=characters.size()-3 && characters.get(i) == 'O' && (OVS || OSV) )
                {
                    VSO = false;
                    VOS = false;
                    SVO = false;
                    SOV = false;
                    OVS = false;
                    OSV = false;
                    if (characters.get(i + 1) == 'V' && characters.get(i + 2) == 'S')
                    {
                        OVS = true;
                        if(characters == charactersOVS)
                        {
                            characters.add(i + 3, '.');
                        }
                    }
                    if (characters.get(i + 1) == 'S' && characters.get(i + 2) == 'V')
                    {
                        OSV = true;
                        if(characters == charactersOSV)
                        {
                            characters.add(i + 3, '.');
                        }
                    }
                }

                if (characters.get(i) == 'S' && (SVO || SOV))
                {
                    VSO = false;
                    VOS = false;
                    SVO = false;
                    SOV = false;
                    OVS = false;
                    OSV = false;
                    if (i<=characters.size()-3 && characters.get(i + 1) == 'V' && characters.get(i + 2) == 'O')
                    {
                        SVO = true;
                        if (characters== charactersSVO)
                        {
                            characters.add(i + 3, '.');
                        }
                    }
                    if (i<=characters.size()-3 && characters.get(i + 1) == 'O' && characters.get(i + 2) == 'V')
                    {
                        SOV = true;
                        if (characters==charactersSOV)
                        {
                            characters.add(i + 3, '.');
                        }

                    }
                    if (i<=characters.size()-2 && characters.get(i + 1) == 'V' &&
                            (!SOV || characters==charactersOSV) && (!SVO || characters==charactersOSV))
                    {
                        OSV = true;
                        SVO = true;
                        SOV = true;
                        if (characters== charactersOSV || characters== charactersSOV || characters== charactersSVO)
                        {
                            characters.add(i + 2, '.');
                        }
                    }
                }

                if (characters.get(i) == 'V' && i!=characters.size()-1)
                {
                    VSO = false;
                    VOS = false;
                    SVO = false;
                    SOV = false;
                    OVS = false;
                    OSV = false;
                    if (i<=characters.size()-3 && characters.get(i + 1) == 'S' && characters.get(i + 2) == 'O')
                    {
                        VSO = true;
                        if(characters==charactersVSO)
                        {
                            characters.add(i + 3, '.');
                        }
                    }
                    else if (i<=characters.size()-3 && characters.get(i + 1) == 'O' && characters.get(i + 2) == 'S')
                    {
                        VOS = true;
                        if(characters==charactersVOS)
                        {
                            characters.add(i + 3, '.');
                        }

                    }

                    if (i<=characters.size()-2 && characters.get(i+1) == 'S' && !VSO && !VOS)
                    {
                        VSO = true;
                        VOS = true;
                        if (characters==charactersVOS || characters==charactersVSO)
                        {
                            characters.add(i + 2, '.');
                        }
                    }

                    if (i<=characters.size()-2 && characters.get(i+1) == 'S' )
                    {
                        OVS = true;
                        if (characters==charactersOVS)
                        {
                            characters.add(i + 2, '.');
                        }
                    }




                    if (((characters == charactersVSO && !VSO) &&(i!=characters.size()-1 || i==0)))
                    {
                        VSO = true;
                        characters.add(i + 1, '.');
                    }
                    if (((characters == charactersVOS && !VOS) &&(i!=characters.size()-1 || i==0)))
                    {
                        VOS = true;
                        characters.add(i + 1, '.');
                    }
                    if (((characters == charactersSOV && !SOV) &&(i!=characters.size()-1 || i==0)))
                    {
                        SOV = true;
                        characters.add(i + 1, '.');
                    }
                    if (((characters == charactersSVO && !SVO) &&(i!=characters.size()-1 || i==0)))
                    {
                        SVO = true;
                        characters.add(i + 1, '.');
                    }
                    if (((characters == charactersOVS && !OVS) &&(i!=characters.size()-1 || i==0)))
                    {
                        OVS = true;
                        characters.add(i + 1, '.');
                    }
                    if (((characters == charactersOSV && !OSV) &&(i!=characters.size()-1 || i==0)))
                    {
                        OSV = true;
                        characters.add(i + 1, '.');
                    }

                }
                if(characters.get(i) == 'V' && (i==characters.size()-1))
                {
                    characters.add(i + 1, '.');
                }


                if (characters == charactersVSO && !VSO) break;
                if (characters == charactersVOS && !VOS) break;
                if (characters == charactersOVS && !OVS) break;
                if (characters == charactersSVO && !SVO) break;
                if (characters == charactersOSV && !OSV) break;
                if (characters == charactersSOV && !SOV) break;

            }
        }

        if (VSO) {
            System.out.println("VSO" + charactersVSO);
        }
        if (OSV) {
            System.out.println("OSV" + charactersOSV);
        }
        if (OVS) {
            System.out.println("OVS" + charactersOVS);
        }
        if (VOS) {
            System.out.println("VOS" + charactersVOS);
        }
        if (SVO) {
            System.out.println("SVO" + charactersSVO);
        }
        if (SOV) {
            System.out.println("SOV" + charactersSOV);
        }
    }


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

    public static void main(String[] args)
    {
        split(args[0]);
    }
}

