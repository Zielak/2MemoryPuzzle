
package components;

import luxe.Component;
import luxe.Visual;

class Blinking extends Component
{

        // max blink interval
    public var interval:Float = 0.1;
        // current blink time
    var now:Float = 0;



    override public function init():Void
    {
        trace('blinking init()');
    }

    override public function update(rate:Float):Void
    {
        now += rate;
        if(now > interval)
        {
            now = 0;
            cast(entity, Visual).visible = !cast(entity, Visual).visible;
        }
    }

}