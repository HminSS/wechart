package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.google.zxing.BarcodeFormat;
	import com.google.zxing.MultiFormatWriter;
	import com.google.zxing.common.ByteMatrix;
	import flash.text.TextField;
	
	
	public class WeChatCode extends MovieClip 
	{
		private var qrImg:Bitmap;
		private var mc:MovieClip=new MovieClip();
		private var txt:TextField = new TextField();
		private var _weChatString:String;
		
		public function WeChatCode(weChatString:String = "skcg,深圳时空数码科技有限公司") 
		{	
			_weChatString = weChatString;
			if (stage) 
				init();
			else 
				this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			var btn:Sprite = new Sprite();
			btn.graphics.beginFill(0xFFF000);
			btn.graphics.drawRect(10, 10, 50, 50);
			btn.graphics.endFill();
			this.addChild(btn);
			btn.buttonMode = true;
			txt.type = "input";
			txt.text = _weChatString;
			this.addChild(mc);
			//btn.addEventListener(MouseEvent.CLICK, refreshCode);
			refreshCode();
		}
		
		//如需要鼠标点击后再打开，那么请注释掉下面哪一行，打开鼠标事件
		//private final function refreshCode(e:MouseEvent):void
		private final function refreshCode():void
		{
			if(qrImg != null)
			{
				mc.removeChild(qrImg);
				qrImg = null;
			}
			var textString:String = txt.text;
			var matrix:ByteMatrix;
			var qrEncoder:MultiFormatWriter = new MultiFormatWriter();
			try
			{
				matrix = (qrEncoder.encode(textString,BarcodeFormat.QR_CODE,250,250)) as ByteMatrix;
			}
			catch (e:Error)
			{
				trace('err');
				return;
			}
			var bmd:BitmapData = new BitmapData(250, 250, false, 0x808080);
			for (var h:int = 0; h < 250; h++)
			{
				for (var w:int = 0; w < 250; w++)
				{
					if (matrix._get(w, h) == 0)
					{
						bmd.setPixel(w, h, 0x000000);
					}
					else
					{
						bmd.setPixel(w, h, 0xFFFFFF);
					}        
				}
			}
			qrImg = new Bitmap(bmd);
			mc.addChild(qrImg);
		}
	}
	
	
}
