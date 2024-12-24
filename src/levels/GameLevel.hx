package levels;

import h2d.Text;
import ent.MaxSeaweed;
import ent.ExtraTime;
import ent.Seaweed.Seaweed;
import ent.Shark;
import hxd.Window;
import ent.Player;
import hxd.Res;
import h2d.Bitmap;

class GameLevel extends Level {
    var player: Player;

    var seaweedSpawnTimer: Float = 0;
    var seaweedSpawnInterval: Float = 2;

    var extraTimeSpawnTimer: Float = 0;
    var extraTimeSpawnInterval: Float = 10;

    var maxSeaweedSpawnTimer: Float = 0;
    var maxSeaweedSpawnInterval: Float = 40;

    var sharkSpawnTimer: Float = 0;
    var sharkSpawnInterval: Float = 3;

    var sharks: Array<Shark>;

    var seaweeds: Array<Seaweed>;
    var extraTimes: Array<ExtraTime>;
    var maxSeaweeds: Array<MaxSeaweed>;

    var font: h2d.Font = hxd.res.DefaultFont.get();

    var scoreText: Text;
    var timerText: Text;
    var highscoreText: Text;

    public function new() {
        super();

        Res.gameplaymusic.play(true);

        camera.setScale(2, 2);

        // game map
        new Bitmap(Res.GameLevel.toTile(), this);

        // player
        player = new Player(Window.getInstance().width / 2, 50, this);

        sharks = [];

        seaweeds = [];
        extraTimes = [];
        maxSeaweeds = [];

        var zoomScale: Float = 2;

        // Create text objects
        scoreText = new Text(font);
        this.addChild(scoreText);

        timerText = new Text(font);
        this.addChild(timerText);

        highscoreText = new Text(font);
        highscoreText.textAlign = Center;
        this.addChild(highscoreText);

        GameState.score = 0;
        GameState.timer = 31;
        GameState.highscore = 0;

        camera.x = player.x / 2;
        camera.y = player.y / 1.5;
    }

    public override function update(dt: Float) {
        player.update(dt);

        GameState.timer -= dt;
        if (GameState.timer <= 0) {
            GameState.timer = 0;
            this.dispose();
            Game.inst.setLevel(new ResultMenu());
            Res.gameplaymusic.dispose();
        }

        // Spawn seaweed
        seaweedSpawnTimer += dt;
        if (seaweedSpawnTimer >= seaweedSpawnInterval) {
            seaweedSpawnTimer = 0;
            var seaweed = new Seaweed(Random.int(49, 747), 543, this);
            seaweeds.push(seaweed);
            
        }

        // Spawn extra time
        extraTimeSpawnTimer += dt;
        if (extraTimeSpawnTimer >= extraTimeSpawnInterval) {
            extraTimeSpawnTimer = 0;
            var extraTime = new ExtraTime(Random.int(49, 747), 543, this);
            extraTimes.push(extraTime);
        }

        // Spawn max seaweed
        maxSeaweedSpawnTimer += dt;
        if (maxSeaweedSpawnTimer >= maxSeaweedSpawnInterval) {
            maxSeaweedSpawnTimer = 0;
            var maxSeaweed = new MaxSeaweed(Random.int(49, 747), 543, this);
            maxSeaweeds.push(maxSeaweed);
        }

        // Spawn sharks
        sharkSpawnTimer += dt;
        if (sharkSpawnTimer >= sharkSpawnInterval) {
            sharkSpawnTimer = 0;

            // Randomly decide left or right side spawn
            var screenWidth = Window.getInstance().width;
            var side = Random.int(0, 1); // 0 = left, 1 = right
            var x = side == 0 ? 0 : screenWidth; // X position: 0 for left, screen width for right
            var dirX = side == 0 ? 1 : -1; // Direction: 1 for right, -1 for left

            // Spawn shark and add to list
            var shark = new Shark(x, Random.int(100, Window.getInstance().height - 100), this, dirX);
            sharks.push(shark);
        }

        // Update sharks
        for (shark in sharks) {
            shark.update(dt);

            if (this.player.bounds.intersects(shark.bounds)) {
                this.dispose();
                Game.inst.setLevel(new CaughtMenu());
                Res.gameplaymusic.dispose();
            }
        }

        for (seaweed in seaweeds) {
            if (this.player.bounds.intersects(seaweed.bounds) && seaweed.collected == false && GameState.score < 50) {
                seaweed.collected = true;
                seaweed.remove();
                GameState.score += 10;
                Res.seaweedPickup.play();
            }
        }

        for (maxSeaweed in maxSeaweeds) {
            if (this.player.bounds.intersects(maxSeaweed.bounds) && maxSeaweed.collected == false && GameState.score < 50) {
                maxSeaweed.collected = true;
                maxSeaweed.remove();
                if (GameState.score < 50) {
                    GameState.score == 50;
                    Res.maxSeaweed.play();
                }
            }
        }

        for (extraTime in extraTimes) {
            if (this.player.bounds.intersects(extraTime.bounds) && extraTime.collected == false) {
                extraTime.collected = true;
                extraTime.remove();
                if (GameState.timer < 20) {
                    GameState.timer += 10;
                    Res.extraTimePickup.play();
                }
            }
        }

        if (player.y <= 30 && GameState.score == 50) {
            GameState.highscore += 50;
            GameState.score = 0;
            Res.highscore.play();
        }

        // Remove sharks that have moved off-screen
        sharks = sharks.filter(shark -> shark.x >= -50 && shark.x <= Window.getInstance().width + 50);

        // Update camera
        camera.x = player.x / 2;
        camera.y = player.y / 1.5;

        scoreText.x = camera.x; // Adjust position based on zoom
        scoreText.y = camera.y; // Adjust position based on zoom

        timerText.x = Window.getInstance().width / 2.3 + camera.x; // Adjust position based on zoom
        timerText.y = camera.y; // Adjust position based on zoom

        highscoreText.x = Window.getInstance().width / 4 + camera.x; // Adjust position based on zoom
        highscoreText.y = camera.y; // Adjust position based on zoom

        scoreText.text = "Score: " + GameState.score;
        timerText.text = "Time: " + Math.floor(GameState.timer);
        highscoreText.text = "Highscore: " + GameState.highscore;
    }
}
