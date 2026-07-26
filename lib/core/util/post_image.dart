import 'dart:io';

class PostImage {
  final File? localFile;
  final String? url;

  const PostImage.local(File file) : localFile = file, url = null;
  const PostImage.remote(String this.url) : localFile = null;

  bool get isLocal => localFile != null;
}
