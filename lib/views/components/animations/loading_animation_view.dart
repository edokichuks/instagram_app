import 'package:instagram_app/views/components/animations/lottie_animation_view.dart';
import 'package:instagram_app/views/components/animations/models/lottie_animations.dart';

class LoadingAnimationView extends LottieAnimationView {
  const LoadingAnimationView({super.key})
      : super(
          animation: LottieAnimation.loading,
        );
}
