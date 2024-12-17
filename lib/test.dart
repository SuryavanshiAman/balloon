// import 'dart:math';
// import 'package:flame/components.dart';
// import 'package:flame/flame.dart';
// import 'package:flame/game.dart';
// import 'package:flutter/material.dart';
//
// class BalloonGame extends FlameGame {
//   late SpriteComponent balloon;
//   late Random random;
//   double balloonSize = 200.0;
//   double sizeIncrement = 2.0;
//   double burstThreshold = 300.0;
//   bool isFlying = false;
//   bool isButtonPressed = false;
//
//   @override
//   Future<void> onLoad() async {
//     random = Random();
//
//     // Load balloon image and create sprite
//     final sprite = await Sprite.load('balloon.png'); // Loading the image
//     balloon = SpriteComponent(sprite: sprite)..size = Vector2(balloonSize, balloonSize);
//
//     add(balloon); // Add balloon to the game
//   }
//
//   @override
//   void update(double dt) {
//     super.update(dt);
//
//     // Increase size if button is pressed
//     if (isButtonPressed) {
//       balloonSize += sizeIncrement;
//       balloon.size = Vector2(balloonSize, balloonSize);
//     }
//
//     // Check if balloon has reached burst threshold
//     if (balloonSize >= burstThreshold) {
//       if (random.nextBool()) {
//         startFlying();
//       } else {
//         showBurstAnimation();
//       }
//     }
//   }
//
//   // Start flying animation
//   void startFlying() {
//     isFlying = true;
//     // Move the balloon upwards
//     balloon.position = Vector2(balloon.position.x, balloon.position.y - 5.0);
//   }
//
//   // Show burst animation and reset game
//   void showBurstAnimation() {
//     // Trigger burst animation (e.g., a print statement or you could use a GIF)
//     print("Burst!");
//     resetBalloon();
//   }
//
//   // Reset balloon after burst or when flying
//   void resetBalloon() {
//     balloonSize = 200.0;
//     balloon.size = Vector2(balloonSize, balloonSize);
//     isFlying = false;
//     isButtonPressed = false;
//   }
//
//   // Gesture handling for button press
//   void onButtonPress() {
//     isButtonPressed = true;
//   }
//
//   void onButtonRelease() {
//     isButtonPressed = false;
//   }
// }
//
// class Ballon extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Balloon Game")),
//       body: GestureDetector(
//         onTapDown: (_) {
//           // Notify the game that the button is pressed
//           final game = GameWidget(game: BalloonGame());
//           game.game?.onButtonPress();
//         },
//         onTapUp: (_) {
//           // Notify the game that the button is released
//           final game = GameWidget(game: BalloonGame());
//           game.game?.onButtonRelease();
//         },
//         onTapCancel: () {
//           // Handle the cancel (button release or tap outside)
//           final game = GameWidget(game: BalloonGame());
//           game.game?.onButtonRelease();
//         },
//         child: Container(
//           color: Colors.red,
//             child: GameWidget(game: BalloonGame())),
//       ),
//     );
//   }
// }
//
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

class BalloonGame extends FlameGame {
  late SpriteComponent balloon;
  late double balloonSize;
  late double burstThreshold;
  final Random _random = Random();
  bool isFlying = false;
  bool blast = false;
  double multipliedValue = 0.0;
  late double screenHeight;
  late double screenWidth;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Get screen dimensions
    screenHeight = size.y;
    screenWidth = size.x;

    // Initial balloon settings
    balloonSize = 200.0;
    burstThreshold = balloonSize + _random.nextDouble() * 100.0;

    // Load the balloon sprite and add to the game
    balloon = SpriteComponent()
      ..sprite = await loadSprite('balloon.png') // Replace with your image asset
      ..size = Vector2(balloonSize, balloonSize)
      ..position = Vector2(screenWidth / 2 - balloonSize / 2, screenHeight - balloonSize);

    add(balloon);
  }

  void _increaseBalloonSize() {
    if (isFlying) return;

    // Increase the balloon size incrementally
    balloonSize += 5.0;
    balloon.size = Vector2(balloonSize, balloonSize);
    multipliedValue += 1.0;

    // Random chance for the balloon to burst
    if (_random.nextDouble() < 0.02) {
      blast = true;
      _showBurstAnimation();
    }

    // If the balloon reaches the burst threshold, either fly or burst
    if (balloonSize >= burstThreshold) {
      if (_random.nextBool()) {
        _startFlying();
      } else {
        blast = true;
        _showBurstAnimation();
      }
    }
  }

  void _startFlying() {
    isFlying = true;
    final flyingDuration = 2.0; // Duration for the flying animation
    final endPosition = Vector2(screenWidth / 2 - balloonSize / 2, screenHeight - balloonSize - 300); // Flying path

    // Move the balloon up
    balloon.position.add(Vector2(0, -200));

    // After the flying duration, reset balloon's position
    Future.delayed(Duration(seconds: flyingDuration.toInt()), () {
      isFlying = false;
      balloon.position = Vector2(screenWidth / 2 - balloonSize / 2, screenHeight - balloonSize);
    });
  }

  void _showBurstAnimation() {
    // Example burst animation (replace with actual logic for burst effect)
    print("POP! Balloon burst!");
    _resetBalloon();
  }

  void _resetBalloon() {
    // Reset balloon to its initial size and position after burst
    balloonSize = 200.0;
    burstThreshold = balloonSize + _random.nextDouble() * 100.0;
    balloon.size = Vector2(balloonSize, balloonSize);
    balloon.position = Vector2(screenWidth / 2 - balloonSize / 2, screenHeight - balloonSize);
    isFlying = false;
    blast = false;
    multipliedValue = 0.0;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // If the balloon is not flying, increment its size
    if (!isFlying) {
      _increaseBalloonSize();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Render the balloon and other game elements here if needed
  }
}


