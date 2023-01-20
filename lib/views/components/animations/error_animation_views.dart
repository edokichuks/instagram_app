import 'package:instagram_app/views/components/animations/lottie_animation_view.dart';
import 'package:instagram_app/views/components/animations/models/lottie_animations.dart';

class ErrorAnimationView extends LottieAnimationView {
  const ErrorAnimationView({super.key})
      : super(
          animation: LottieAnimation.error,
        );
}
