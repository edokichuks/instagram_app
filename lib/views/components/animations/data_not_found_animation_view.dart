import 'package:instagram_app/views/components/animations/lottie_animation_view.dart';
import 'package:instagram_app/views/components/animations/models/lottie_animations.dart';

class DataNotFoundAnimationView extends LottieAnimationView {
  const DataNotFoundAnimationView({super.key})
      : super(
          animation: LottieAnimation.dataNotFound,
        );
}
