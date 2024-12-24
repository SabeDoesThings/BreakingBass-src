package levels;

import hxd.Key;
import hxd.Window;
import hxd.Res;
import h2d.Bitmap;

class CaughtMenu extends Level {
    public function new() {
        super();

        new Bitmap(Res.CaughtMenu.toTile(), this);

        var font : h2d.Font = hxd.res.DefaultFont.get();
        var tf = new h2d.Text(font);
        tf.text = "CAUGHT!";
        tf.textColor = 0xFFE31D1D;
        tf.scale(6);
        tf.x = Window.getInstance().width / 2;
        this.addChild(tf);

        var restartText = new h2d.Text(font);
        restartText.text = "Press 'SPACE' to restart.";
        restartText.scale(2);
        restartText.x = Window.getInstance().width / 2;
        restartText.y = Window.getInstance().height / 5;
        this.addChild(restartText);

        Res.police.play();
    }

    override function update(dt:Float) {
        if (Key.isPressed(Key.SPACE)) {
            Game.inst.setLevel(new GameLevel());
            this.dispose();
            Res.police.dispose();
        }
    }
}