public class ErrorHandlingReturn {
    public static boolean birthdayGreetings(String name, int age) {
        boolean success;

        if (age > 0) {
            System.out.println("All the best to your " + age + ". birthday " + name);
            success = true;
        } else {
            System.err.println("ERROR: The given age must be larger zero but is: " + age);
            success = false;
        }

        return success;
    }
    public static boolean spam (String [] names, int [] ages) {
        boolean success= true;
        for (int i = 0; i<names.length; i++) {
            if (birthdayGreetings(names[i], ages[i])) {
            } else {
                birthdayGreetings(names[i], 20);
                success = false;
            }
        }
        return success;
    }
}
