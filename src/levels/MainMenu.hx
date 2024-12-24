package levels;

import hxd.Key;
import hxd.Window;
import hxd.Res;
import h2d.Bitmap;

class MainMenu extends Level {
    public function new() {
        super();

        Res.bgmusic.play(true);

        new Bitmap(Res.TitleMenu.toTile(), this);

        var font : h2d.Font = hxd.res.DefaultFont.get();
        var tf = new h2d.Text(font);
        tf.text = "Press 'SPACE' to start.";
        tf.scale(3);
        tf.x = Window.getInstance().width / 2.4;
        tf.y = Window.getInstance().height / 2;
        this.addChild(tf);
    }

    override function update(dt: Float) {
        if (Key.isPressed(Key.SPACE)) {
            Game.inst.setLevel(new GameLevel());
            Res.bgmusic.stop();
            Res.bgmusic.dispose();
            this.dispose();
        }
    }
}