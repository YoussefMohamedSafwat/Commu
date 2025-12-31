import 'package:flutter/material.dart';

class CommentsSheetController {
  CommentsSheetController._();
  static final instance = CommentsSheetController._();

  final ValueNotifier<bool> isOpen = ValueNotifier(false);
  int? currentPostId;

  void open(int postId) {
    currentPostId = postId;
    isOpen.value = true;
  }

  void close() {
    isOpen.value = false;
    currentPostId = null;
  }
}
