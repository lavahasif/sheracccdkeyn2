//package AndCdkey;
//
//import android.os.Bundle;
//import android.support.v7.app.AppCompatActivity;
//import android.view.View;
//import android.widget.EditText;
//import android.widget.Toast;
//import android.content.Intent;
//
//public class MainActivity extends AppCompatActivity {
//
//    EditText serial,key;
//
//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_main);
//
//        serial = (EditText)findViewById(R.id.editText);
//        key = (EditText)findViewById(R.id.editText2);
//    }
//
//    public void generate(View v){
//        String no = serial.getText().toString();
//        if (no.length()>0){
//            try {
//                key.setText(CDKey.encrypt(no));
//            }catch (Exception ex){
//                ex.getMessage();
//            }
//        }else {
//            Toast.makeText(getApplicationContext(),"put serial no",Toast.LENGTH_SHORT).show();
//        }
//    }
//
//    public void share(View v){
//        String no = key.getText().toString();
//        if (no.length()>0){
//            //String toNumber = Result.getText().toString(); // contains spaces.
//            String message = key.getText().toString(); // contains spaces.
//            //toNumber = toNumber.replace("+", "").replace(" ", "");
//            Intent sendIntent = new Intent("android.intent.action.MAIN");
//            //sendIntent.putExtra("jid", toNumber + "@s.whatsapp.net");
//            sendIntent.putExtra(Intent.EXTRA_TEXT, message);
//            sendIntent.setAction(Intent.ACTION_SEND);
//            sendIntent.setPackage("com.whatsapp");
//            sendIntent.setType("text/plain");
//            startActivity(sendIntent);
//        }else {
//            Toast.makeText(getApplicationContext(),"not generated",Toast.LENGTH_SHORT).show();
//        }
//    }
//}
