package levels;

import hxd.Key;
import hxd.Window;
import hxd.Res;
import h2d.Bitmap;

class ResultMenu extends Level {
    var music = Res.bgmusic;

    public function new() {
        super();

        music.play(true);

        new Bitmap(Res.ResultMenu.toTile(), this);

        var font: h2d.Font = hxd.res.DefaultFont.get();
        var tf = new h2d.Text(font);
        tf.text = "Result:";
        tf.textColor = 0xFFB8B8B8;
        tf.scale(6);
        tf.x = Window.getInstance().width / 2;
        this.addChild(tf);

        var scoreText = new h2d.Text(font);
        scoreText.text = "Highscore: " + Globals.highscore;
        scoreText.scale(2);
        scoreText.x = Window.getInstance().width / 2.5;
        scoreText.y = Window.getInstance().height / 5;
        this.addChild(scoreText);
        
        var playAgainText = new h2d.Text(font);
        playAgainText.text = "Pres 'SPACE' to play again.";
        playAgainText.scale(3);
        playAgainText.x = Window.getInstance().width / 2.5;
        playAgainText.y = Window.getInstance().height / 3.5;
        this.addChild(playAgainText);
    }

    override function update(dt:Float) {
        if (Key.isPressed(Key.SPACE)) {
            music.dispose();
            Game.inst.setLevel(new MainMenu());
            this.dispose();
        }
    }
}