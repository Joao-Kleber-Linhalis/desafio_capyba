import 'package:desafio_capyba/features/wheel/widgets/wheel_dialog.dart';
import 'package:desafio_capyba/shared/constants/rarity.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:spinning_wheel/controller/spin_controller.dart';
import 'package:spinning_wheel/spinning_wheel.dart';

class WheelScreen extends StatefulWidget {
  const WheelScreen({super.key});

  @override
  State<WheelScreen> createState() => _WheelScreenState();
}

class _WheelScreenState extends State<WheelScreen>
    with SingleTickerProviderStateMixin {
  SpinnerController controller = SpinnerController();

  final List<WheelSegment> _segments = Rarity.rarities.map((e) {
    return WheelSegment(
      e,
      Rarity.getColorForRarity(e),
      0,
    );
  }).toList();

  @override
  void initState() {
    super.initState();
  }

  bool _isSpinning = false;

  void _spinWheel() {
    if (_isSpinning) return;
    setState(() {
      _isSpinning = true;
    });
    controller.startSpin();
  }

  showResult(String rarity) {
    showDialog(
      context: context,
      builder: (context) {
        return WheelDialog(
          rarity: rarity,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          "Roleta de CAPYS",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            letterSpacing: 1.5,
            shadows: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black45,
                offset: Offset(2, 2),
              ),
            ],
          ),
          colors: Rarity.rarityColors,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            SizedBox(
              height: 350,
              width: 350,
              child: SpinnerWheel(
                controller: controller,
                segments: _segments,
                onComplete: (win) {
                  setState(() {
                    showResult(win.label);
                    _isSpinning = false;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 20),
              child: AnimatedContainer(
                alignment: Alignment.center,
                transformAlignment: Alignment.center,
                duration: Duration(milliseconds: 200),
                height: 60,
                width: 250,
                transform: Matrix4.identity()..scale(_isSpinning ? 0.9 : 1.0),
                child: ElevatedButton(
                  onPressed: _isSpinning ? null : _spinWheel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isSpinning ? Colors.grey : Colors.amber,
                    foregroundColor: Colors.brown.shade900,
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: _isSpinning ? 3 : 10,
                    shadowColor: Colors.black.withValues(alpha: 0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isSpinning ? Icons.hourglass_top : Icons.touch_app,
                        size: 28,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        _isSpinning ? "Roletando..." : "Rolete!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
