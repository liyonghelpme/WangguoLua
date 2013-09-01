/****************************************************************************
Copyright (c) 2010-2012 cocos2d-x.org

http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
****************************************************************************/
package org.cocos2dx.hellolua;
import java.math.BigDecimal;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lib.Cocos2dxGLSurfaceView;
import org.json.JSONException;

import com.google.ads.AdRequest;
import com.google.ads.AdSize;
import com.google.ads.AdView;
import com.paypal.android.sdk.payments.PayPalPayment;
import com.paypal.android.sdk.payments.PayPalService;
import com.paypal.android.sdk.payments.PaymentActivity;
import com.paypal.android.sdk.payments.PaymentConfirmation;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.widget.LinearLayout;

public class HelloLua extends Cocos2dxActivity{
	private MyHandler myHandler;
	LinearLayout layout;
	AdView view;
	AdRequest request;
	
	private class MyHandler extends Handler{
		public HelloLua h;
		public long passTime;
		public long since;
		public void handleMessage(Message msg) {
			
			//h.view.stopLoading();
			//h.layout.setVisibility(View.INVISIBLE);
			Date date = new Date();
			long now = date.getTime()/1000;
			if(now-passTime > 20) {
				long diffTime = now-since;
				//5s 调用一次timer
				if(view.getVisibility() == View.VISIBLE) {
					view.setVisibility(View.INVISIBLE);
				} else if(view.getVisibility() == View.INVISIBLE && diffTime >= 20) {
					since = now;
					if(diffTime % 2 == 0) {
						request = new AdRequest();
						view.loadAd(request);
					}
					view.setVisibility(View.VISIBLE);
					
				}
			}
		}
		public void setHelloLua(HelloLua hh) {
			h = hh;
		}
	}
	
	protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
		myHandler = new MyHandler();
		myHandler.passTime = (new Date().getTime())/1000;
		myHandler.since = (new Date().getTime())/1000;
		myHandler.setHelloLua(this);
		//setUpAds();
		//showBanner();
		
		Intent intent = new Intent(this, PayPalService.class);
		intent.putExtra(PaymentActivity.EXTRA_PAYPAL_ENVIRONMENT, PaymentActivity.ENVIRONMENT_SANDBOX);
		intent.putExtra(PaymentActivity.EXTRA_CLIENT_ID, "AX-XExBYZ0SxFVwhret3TPXaCsDhdZ2eJQO83Wyj_jRmuTruCt-3-nABxMI1");
		startService(intent);
	}
	
	public void onDestroy() {
		stopService(new Intent(this, PayPalService.class));
		super.onDestroy();
	}
	public void onBuyPressed() {
		PayPalPayment payment = new PayPalPayment(new BigDecimal("8.75"), "USD", "hipstar jeans");
		Intent intent = new Intent(this, PaymentActivity.class);
		intent.putExtra(PaymentActivity.EXTRA_PAYPAL_ENVIRONMENT, PaymentActivity.ENVIRONMENT_SANDBOX);
		intent.putExtra(PaymentActivity.EXTRA_CLIENT_ID, "AX-XExBYZ0SxFVwhret3TPXaCsDhdZ2eJQO83Wyj_jRmuTruCt-3-nABxMI1");
		//user id
		intent.putExtra(PaymentActivity.EXTRA_PAYER_ID, "liyonghelpme@gmail.com");
		intent.putExtra(PaymentActivity.EXTRA_RECEIVER_EMAIL, "liyonghelpme@gmail.com");
		intent.putExtra(PaymentActivity.EXTRA_PAYMENT, payment);
		
		startActivityForResult(intent, 0);
	}
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		if(requestCode == Activity.RESULT_OK) {
			PaymentConfirmation confirm = data.getParcelableExtra(PaymentActivity.EXTRA_RESULT_CONFIRMATION);
			if(confirm != null) {
				try{
					Log.i("payment Example", confirm.toJSONObject().toString(4));
					
				}catch(JSONException e){
					Log.e("payment Example", "failed", e);
				}
			}
		} else if(resultCode == Activity.RESULT_CANCELED) {
			Log.i("Example", "user canceled");
		} else if(resultCode == PaymentActivity.RESULT_PAYMENT_INVALID) {
			Log.i("Example", "Invalid payment");
		}
	}
	private void showBanner(){
		layout.setVisibility(View.VISIBLE);
		request = new AdRequest();
		LocationManager lm = (LocationManager)this.getSystemService(Context.LOCATION_SERVICE);
		Location location = lm.getLastKnownLocation(LocationManager.NETWORK_PROVIDER);
		LocationListener ll = new LocationListener() {

			@Override
			public void onLocationChanged(Location arg0) {
				// TODO Auto-generated method stub
				request.setLocation(arg0);
			}

			@Override
			public void onProviderDisabled(String arg0) {
				// TODO Auto-generated method stub
				
			}

			@Override
			public void onProviderEnabled(String arg0) {
				// TODO Auto-generated method stub
				
			}

			@Override
			public void onStatusChanged(String arg0, int arg1, Bundle arg2) {
				// TODO Auto-generated method stub
				
			}
			
		};
		//lm.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0, 0, ll);
		request.setLocation(location);
		view.loadAd(request);
		view.setVisibility(View.INVISIBLE);
		
		Timer timer = new Timer();
		
		timer.schedule(new TimerTask() {

			@Override
			public void run() {
				//Log.d("helloLua", "sendMessage");
				// TODO Auto-generated method stub
				Boolean ret = myHandler.sendMessage(new Message());
				Log.d("sendSuc?", ""+ret);
			}
			
		}
		, 0, 5000);
		
	}
	private void setUpAds() {
		
		layout = new LinearLayout(this);
		layout.setOrientation(LinearLayout.HORIZONTAL);
		addContentView(layout, new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.FILL_PARENT));
		view = new AdView(this, AdSize.BANNER, "a151ef863cb4e54");
		layout.addView(view);
	}
	
	public Cocos2dxGLSurfaceView onCreateGLSurfaceView() {
		return new LuaGLSurfaceView(this);
	}
	
	static {
        System.loadLibrary("hellolua");
   }
}

class LuaGLSurfaceView extends Cocos2dxGLSurfaceView{
	
	public LuaGLSurfaceView(Context context){
		super(context);
	}
	
	public boolean onKeyDown(int keyCode, KeyEvent event) {
    	// exit program when key back is entered
    	if (keyCode == KeyEvent.KEYCODE_BACK) {
    		android.os.Process.killProcess(android.os.Process.myPid());
    	}
        return super.onKeyDown(keyCode, event);
    }
}
