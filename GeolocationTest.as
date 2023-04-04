package 
{ 
    import flash.display.Sprite; 
    import flash.display.StageAlign; 
    import flash.display.StageScaleMode; 
    import flash.events.GeolocationEvent; 
    import flash.events.MouseEvent; 
    import flash.events.StatusEvent; 
    import flash.sensors.Geolocation; 
    import flash.text.TextField; 
    import flash.text.TextFormat; 
 
    public class GeolocationTest extends Sprite 
    { 
         
        private var geo:Geolocation; 
        private var log:TextField; 
         
        public function GeolocationTest() 
        {             
            super(); 
            stage.align = StageAlign.TOP_LEFT; 
            stage.scaleMode = StageScaleMode.NO_SCALE; 
            setUpTextField(); 
             
            if (Geolocation.isSupported) 
            { 
                geo = new Geolocation(); 
                if (!geo.muted) 
                { 
                    geo.addEventListener(GeolocationEvent.UPDATE, geoUpdateHandler); 
                } 
                geo.addEventListener(StatusEvent.STATUS, geoStatusHandler); 
            } 
            else 
            { 
                log.text = "Geolocation not supported"; 
            } 
        } 
         
        public function geoUpdateHandler(event:GeolocationEvent):void 
        { 
            log.text = "latitude : " + event.latitude.toString() + "\n"; 
            log.appendText("longitude : " + event.longitude.toString() + "\n"); 
        } 
         
        public function geoStatusHandler(event:StatusEvent):void 
        { 
            if (geo.muted) 
                geo.removeEventListener(GeolocationEvent.UPDATE, geoUpdateHandler); 
            else 
                geo.addEventListener(GeolocationEvent.UPDATE, geoStatusHandler); 
        } 
         
        private function setUpTextField():void 
        { 
            log = new TextField(); 
            var format:TextFormat = new TextFormat("_sans", 24); 
            log.defaultTextFormat = format; 
            log.border = true; 
            log.wordWrap = true; 
            log.multiline = true; 
            log.x = 10; 
            log.y = 10; 
            log.height = stage.stageHeight - 20; 
            log.width = stage.stageWidth - 20; 
            log.addEventListener(MouseEvent.CLICK, clearLog); 
            addChild(log); 
        } 
        private function clearLog(event:MouseEvent):void 
        { 
            log.text = ""; 
        } 
    } 
}