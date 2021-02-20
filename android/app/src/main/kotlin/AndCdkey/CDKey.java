package AndCdkey;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class CDKey {
    //encrypt function:
    public static String encrypt(String key) throws Exception
    {
        return getRandomString(key,16);
    }

    //decrypt function:
    public static String decrypt(String key) throws Exception
    {
        return key.replaceAll("\\*[a-zA-Z]", "");
    }

    private static final String ALLOWED_CHARACTERS ="ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    private static String getRandomString(String key, int sizeOfRandomString)
    {
        final Random random=new Random();
        final StringBuilder sb=new StringBuilder(sizeOfRandomString);
        for(int i=0;i<sizeOfRandomString;++i) {
            sb.append(ALLOWED_CHARACTERS.charAt(random.nextInt(ALLOWED_CHARACTERS.length())));
            sb.append(key.charAt(i));
        }
        return sb.toString();
    }

    public static boolean isExpired(String valid_until, String id){
        boolean ret=false;
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        try {
            if (new Date().after(sdf.parse(valid_until))) {
                ret=true;
            }
        }catch (Exception ex){
            return  false;
        }
        return ret;
    }
}
