import 'package:instagram_app/state/image_upload/models/file_type.dart';

extension CollectionName on FileType {
  String get collectionName {
    switch (this) {                    
      case FileType.image:
        return 'iamges';
      case FileType.video:
        return 'videos';
    }
  }
}
