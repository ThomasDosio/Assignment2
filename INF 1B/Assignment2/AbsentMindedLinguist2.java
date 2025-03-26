import java.util.ArrayList;

public class AbsentMindedLinguist2
{
    public static boolean checkValidityOVS(ArrayList<Character> charactersOVS)
    {


        // creates a boolean that becomes true if every sentence is valid
        boolean isAllValidOVS = true;

        // OVS
        for (int i = 0; i < (charactersOVS).size(); i++)
        {
            // creates a boolean that becomes true if a sentence is valid
            boolean isValidOVS = false;

            // creates a boolean that makes higher for-loop skip characters already in a sentence
            boolean isPartOfSentence = skip(i, charactersOVS);
            if (isPartOfSentence)
            {
                continue;
            }

            // now we check if it's valid for if the current sentence starts with O
            if (i <= charactersOVS.size() - 3 &&
                    charactersOVS.get(i) == 'O' &&
                    charactersOVS.get(i + 1) == 'V' &&
                    charactersOVS.get(i + 2) == 'S')
            {
                isValidOVS = true;
                charactersOVS.add(i + 3, '.');
            }

            // if the sentence starts with s then it must be invalid
            // as it won't have a verb or the order will be wrong

            // now we check if it's valid if the sentence starts with V
            if (i <= charactersOVS.size() - 2 &&
                    charactersOVS.get(i) == 'V' &&
                    charactersOVS.get(i + 1) == 'S')
            {
                isValidOVS = true;
                charactersOVS.add(i + 2, '.');
            }

            //we use an else to not add more than one '.' if both of the conditions are valid
            else if (i <= charactersOVS.size() - 1 &&
                    charactersOVS.get(i) == 'V')
            {
                isValidOVS = true;
                charactersOVS.add(i + 1, '.');
            }

            // changes the value of overall validity appropriately
            if ((!isValidOVS && isAllValidOVS))  isAllValidOVS = false;
        }

        return isAllValidOVS;
    }

    public static boolean checkValidityOSV (ArrayList<Character> charactersOSV)
    {
        // creates a boolean that becomes true if every sentence is valid
        boolean isAllValidOSV = true;

        //OSV
        for (int i = 0; i < (charactersOSV).size(); i++)
        {
            // creates a boolean that becomes true if it is valid
            boolean isValidOSV = false;

            // creates a boolean that makes higher for-loop skip characters already in a sentence
            boolean isPartOfSentence = skip(i, charactersOSV);
            if (isPartOfSentence) continue;

            // now we check if it's valid for if the current sentence starts with O
            if (i <= charactersOSV.size() - 3 &&
                    charactersOSV.get(i) == 'O' &&
                    charactersOSV.get(i + 1) == 'S' &&
                    charactersOSV.get(i + 2) == 'V')
            {
                isValidOSV = true;
                charactersOSV.add(i + 3, '.');
            }

            // now we check if it's valid if the sentence starts with S
            if (i <= charactersOSV.size() - 2 &&
                    charactersOSV.get(i) == 'S' &&
                    charactersOSV.get(i + 1) == 'V')
            {
                isValidOSV = true;
                charactersOSV.add(i + 2, '.');
            }

            // now we check if it's valid if the sentence starts with V
            if (i <= charactersOSV.size() - 1 &&
                    charactersOSV.get(i) == 'V')
            {
                isValidOSV = true;
                charactersOSV.add(i + 1, '.');
            }

            // changes the value of overall validity appropriately
            if (!isValidOSV && isAllValidOSV)  isAllValidOSV = false;
        }
        return isAllValidOSV;
    }

    public static boolean checkValiditySOV(ArrayList<Character> charactersSOV)
    {
        // creates a boolean that becomes true if every sentence is valid
        boolean isAllValidSOV = true;

        //SOV
        for (int i = 0; i < (charactersSOV).size(); i++)
        {
            // creates a boolean that becomes true if it is valid
            boolean isValidSOV = false;

            // creates a boolean that makes higher for-loop skip characters already in a sentence
            boolean isPartOfSentence = skip(i, charactersSOV);
            if (isPartOfSentence) continue;

            // now we check if it's valid for if the current sentence starts with S
            if (i <= charactersSOV.size() - 3 &&
                    charactersSOV.get(i) == 'S' &&
                    charactersSOV.get(i + 1) == 'O' &&
                    charactersSOV.get(i + 2) == 'V')
            {
                isValidSOV = true;
                charactersSOV.add(i + 3, '.');
            }

            // now we check if it's valid if the sentence starts with S but whose second letter is V
            if (i <= charactersSOV.size() - 2 &&
                    charactersSOV.get(i) == 'S' &&
                    charactersSOV.get(i + 1) == 'V')
            {
                isValidSOV = true;
                charactersSOV.add(i + 2, '.');
            }

            // now we check if it's valid if the sentence starts with V
            if (i <= charactersSOV.size() - 1 &&
                    charactersSOV.get(i) == 'V')
            {
                isValidSOV = true;
                charactersSOV.add(i + 1, '.');
            }

            // we don't check the case if it starts with O because those are only useful
            // for the first 2 permutations

            // changes the value of overall validity appropriately
            if (!isValidSOV && isAllValidSOV)  isAllValidSOV = false;
        }
        return isAllValidSOV;
    }

    public static boolean checkValiditySVO (ArrayList<Character> charactersSVO)
    {
        // creates a boolean that becomes true if every sentence is valid
        boolean isAllValidSVO = true;

        //SVO
        for (int i = 0; i < (charactersSVO).size(); i++)
        {
            // creates a boolean that becomes true if it is valid
            boolean isValidSVO = false;

            // creates a boolean that makes higher for-loop skip characters already in a sentence
            boolean isPartOfSentence = skip(i, charactersSVO);
            if (isPartOfSentence) continue;

            // now we check if it's valid for if the current sentence starts with S
            if (i <= charactersSVO.size() - 3 &&
                    charactersSVO.get(i) == 'S' &&
                    charactersSVO.get(i + 1) == 'V' &&
                    charactersSVO.get(i + 2) == 'O')
            {
                isValidSVO = true;
                charactersSVO.add(i + 3, '.');
            }

            // now we check if it starts with s but if the third character isn't an O
            // we use else to avoid putting 2 '.'
            else if (i <= charactersSVO.size() - 2 &&
                    charactersSVO.get(i) == 'S' &&
                    charactersSVO.get(i + 1) == 'V')
            {
                isValidSVO = true;
                charactersSVO.add(i + 2, '.');
            }

            // now we check if it's valid if it starts with V
            if (i <= charactersSVO.size() - 1 &&
                    charactersSVO.get(i) == 'V')
            {
                isValidSVO = true;
                charactersSVO.add(i + 1, '.');
            }

            // changes the value of overall validity appropriately
            if (!isValidSVO && isAllValidSVO)  isAllValidSVO = false;
        }

        return isAllValidSVO;
    }

    public static boolean checkValidityVSO (ArrayList<Character> charactersVSO)
    {
        // creates a boolean that becomes true if every sentence is valid
        boolean isAllValidVSO = true;

        //VSO
        for (int i = 0; i < (charactersVSO).size(); i++)
        {
            // creates a boolean that becomes true if it is valid
            boolean isValidVSO = false;

            // creates a boolean that makes higher for-loop skip characters already in a sentence
            boolean isPartOfSentence = skip(i, charactersVSO);
            if (isPartOfSentence) continue;

            // now we check if it's valid if it starts with V
            // we will have three cases here that we will split using else if statements
            if (i <= charactersVSO.size() - 3 &&
                    charactersVSO.get(i) == 'V' &&
                    charactersVSO.get(i + 1) == 'S' &&
                    charactersVSO.get(i + 2) == 'O')
            {
                isValidVSO = true;
                charactersVSO.add(i + 3, '.');
            } else if (i <= (charactersVSO).size() - 2 &&
                    charactersVSO.get(i) == 'V' &&
                    charactersVSO.get(i + 1) == 'S')
            {
                isValidVSO = true;
                charactersVSO.add(i + 2, '.');
            } else if (i <= (charactersVSO).size() - 1 &&
                    charactersVSO.get(i) == 'V')
            {
                isValidVSO = true;
                charactersVSO.add(i + 1, '.');
            }

            // changes the value of overall validity appropriately
            if (!isValidVSO && isAllValidVSO)  isAllValidVSO = false;
        }

        return isAllValidVSO;
    }

    public static boolean checkValidityVOS(ArrayList<Character> charactersVOS)
    {
        // creates a boolean that becomes true if every sentence is valid
        boolean isAllValidVOS = true;

        //VOS
        for (int i = 0; i < (charactersVOS).size(); i++)
        {
            // creates a boolean that becomes true if it is valid
            boolean isValidVOS = false;

            // creates a boolean that makes higher for-loop skip characters already in a sentence
            boolean isPartOfSentence = skip(i, charactersVOS);
            if (isPartOfSentence) continue;

            // now we check if it's valid if it starts with V
            // we will have three cases here that we will split using else if statements
            if (i <= charactersVOS.size() -3 &&
                    charactersVOS.get(i) == 'V' &&
                    charactersVOS.get(i + 1) == 'O' &&
                    charactersVOS.get(i + 2) == 'S')
            {
                isValidVOS = true;
                charactersVOS.add(i+3, '.');
            }

            else if (i <= charactersVOS.size() -2 &&
                    charactersVOS.get(i) == 'V' &&
                    charactersVOS.get(i + 1) == 'S')
            {
                isValidVOS = true;
                charactersVOS.add(i+2, '.');
            }

            else if (i <= charactersVOS.size() -1 &&
                    charactersVOS.get(i) == 'V')
            {
                isValidVOS = true;
                charactersVOS.add(i+1, '.');
            }

            // changes the value of overall validity appropriately
            if (!isValidVOS && isAllValidVOS)  isAllValidVOS = false;
        }

        return isAllValidVOS;
    }

    public static boolean skip (int i, ArrayList<Character> characters)
    {
        boolean isPartOfSentence = false;
        for (int j = i; j < characters.size(); j++)
        {
            if (characters.get(j) == '.') {isPartOfSentence = true; break;}
        }
        return isPartOfSentence;
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
        double t = System.nanoTime();

        String str = args[0];

        // puts the sentences into a separate arraylist for each permutation
        ArrayList<Character> charactersVSO = makeArrayList(str);
        ArrayList<Character> charactersVOS = makeArrayList(str);
        ArrayList<Character> charactersOVS = makeArrayList(str);
        ArrayList<Character> charactersOSV = makeArrayList(str);
        ArrayList<Character> charactersSVO = makeArrayList(str);
        ArrayList<Character> charactersSOV = makeArrayList(str);


        // for each permutation it checks if it's a valid option.
        // if it is it prints the sentences
        // The order is the same throughout: OVS, OSV, SOV, SVO, VSO, VOS

        if (checkValidityOVS(charactersOVS))
        {
            System.out.println("OVS" + charactersOVS);
        }

        if (checkValidityOSV(charactersOSV))
        {
            System.out.println("OSV" + charactersOSV);
        }

        if (checkValiditySOV(charactersSOV))
        {
            System.out.println("SOV" + charactersSOV);
        }

        if (checkValiditySVO(charactersSVO))
        {
            System.out.println("SVO" + charactersSVO);
        }

        if (checkValidityVSO(charactersVSO))
        {
            System.out.println("VSO" + charactersVSO);
        }

        if (checkValidityVOS(charactersVOS))
        {
            System.out.println("VOS" + charactersVOS);
        }

        t -= System.nanoTime();
        t /= -1e6;
        System.out.println("Time taken: " + t);
    }
}
