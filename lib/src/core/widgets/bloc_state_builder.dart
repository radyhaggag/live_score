import 'package:flutter/material.dart';

import 'app_empty.dart';
import 'app_loading.dart';

/// Represents the bloc state builder entity/model.
class BlocStateBuilder<T> extends StatelessWidget {
  const BlocStateBuilder({
    super.key,
    required this.isLoading,
    this.errorMessage,
    required this.data,
    this.isEmpty,
    this.onLoading,
    required this.onLoaded,
    this.onError,
    this.onEmpty,
  });

  final bool isLoading;
  final String? errorMessage;
  final T? data;
  final bool Function(T data)? isEmpty;

  final WidgetBuilder? onLoading;
  final Widget Function(BuildContext context, T data) onLoaded;
  final Widget Function(BuildContext context, String message)? onError;
  final WidgetBuilder? onEmpty;

  @override
  Widget build(BuildContext context) {
    if (isLoading && data == null) {
      return onLoading != null
          ? onLoading!(context)
          : const Center(child: AppLoadingIndicator());
    }

    if (errorMessage != null && data == null) {
      return onError != null
          ? onError!(context, errorMessage!)
          : Center(child: AppEmptyWidget(message: errorMessage));
    }

    if (data != null) {
      if (isEmpty != null && isEmpty!(data as T)) {
        return onEmpty != null
            ? onEmpty!(context)
            : const Center(child: AppEmptyWidget());
      }
      return onLoaded(context, data as T);
    }

    return onEmpty != null ? onEmpty!(context) : const SizedBox.shrink();
  }
}
