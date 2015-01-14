
package ;

import luxe.Visual;
import luxe.Color;

class Card extends Visual
{

        // Size of every card, rectangles
    public static inline var CARD_SIZE:Int = 60;

    public var twin:Card;

    override public function init():Void
    {
        fixed_rate = 1/60;
        
        color = new Color(0.2, 0.3, 0.2, 1);
        geometry = Luxe.draw.ngon({
            x: 0,
            y: 0,
            r: CARD_SIZE*0.6,
            sides: 4,
            solid: true
        });

        add(new components.Clickable({
            name: 'clickable'
        }));

        events.listen('card.destroy', function(_){
            destroy(true);
        });
    }

}

typedef CardEvent = {
    var card : Card;
}
