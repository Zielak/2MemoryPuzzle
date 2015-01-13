
package ;

import luxe.Visual;
import luxe.Color;

class Card extends Visual
{

        // Size of every card, rectangles
    public static inline var CARD_SIZE:Int = 40;



    override public function init():Void
    {
        
        // geometry = Luxe.draw.box({
        //     x: -CARD_SIZE/2,
        //     y: -CARD_SIZE/2,
        //     w: CARD_SIZE,
        //     h: CARD_SIZE
        // });
        color = new Color(0.2, 0.3, 0.2, 1);
        geometry = Luxe.draw.ngon({
            x: 0,
            y: 0,
            r: CARD_SIZE/2,
            sides: 4,
            solid: true
        });
        
    }




}
