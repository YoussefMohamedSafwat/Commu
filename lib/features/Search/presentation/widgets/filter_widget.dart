import 'package:cleanarch/core/constants/enums/filter.dart';
import 'package:cleanarch/core/theming/app_theme.dart';
import 'package:cleanarch/features/Search/presentation/cubit/filter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFilterDropdown extends StatefulWidget {
  const SearchFilterDropdown({super.key});

  @override
  State<SearchFilterDropdown> createState() => _SearchFilterDropdownState();
}

class _SearchFilterDropdownState extends State<SearchFilterDropdown> {
  final LayerLink _link = LayerLink();
  OverlayEntry? _entry;

  void _toggle() => _entry == null ? _show() : _hide();

  void _show() {
    final overlay = Overlay.of(context);
    _entry = OverlayEntry(builder: (_) => _buildOverlay());
    overlay.insert(_entry!);
    setState(() {});
  }

  void _hide() {
    _entry?.remove();
    _entry = null;
    setState(() {});
  }

  void _select(SearchFilter f) {
    context.read<FilterCubit>().applyFilter(f);
    _hide();
  }

  Widget _buildOverlay() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _hide,
      child: Stack(
        children: [
          CompositedTransformFollower(
            link: _link,
            offset: const Offset(-20, 44),
            child: BlocBuilder<FilterCubit, SearchFilter>(
              builder: (context, filter) => Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
                child: Container(
                  width: 140,
                  decoration: BoxDecoration(
                    color: context.surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: context.primaryColor.withValues(alpha: 0.15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: context.isDark
                            ? Colors.black26
                            : context.primaryColor.withValues(alpha: 0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
                        child: Text(
                          "Search by",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: context.textTertiaryColor,
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 0.5,
                        color: context.textTertiaryColor.withValues(alpha: 0.2),
                      ),
                      _option(
                        filter,
                        SearchFilter.tags,
                        Icons.tag_rounded,
                        "Tags",
                      ),
                      Divider(
                        height: 1,
                        thickness: 0.5,
                        color: context.textTertiaryColor.withValues(alpha: 0.2),
                      ),
                      _option(
                        filter,
                        SearchFilter.users,
                        Icons.person_outline_rounded,
                        "Users",
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _option(
    SearchFilter current,
    SearchFilter f,
    IconData icon,
    String label,
  ) {
    final active = current == f;
    return InkWell(
      onTap: () => _select(f),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(
              icon,
              size: 17,
              color: active ? context.primaryColor : context.textSecondaryColor,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                color: active
                    ? context.textPrimaryColor
                    : context.textSecondaryColor,
              ),
            ),
            const Spacer(),
            if (active)
              Icon(Icons.check, size: 14, color: context.primaryColor),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, SearchFilter>(
      builder: (context, filter) {
        final isTag = filter == SearchFilter.tags;
        return CompositedTransformTarget(
          link: _link,
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            child: GestureDetector(
              onTap: _toggle,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: context.surfaceColor,
                  border: Border.all(
                    color: context.primaryColor.withValues(alpha: 0.25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: context.primaryColor.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isTag ? Icons.tag_rounded : Icons.person_outline_rounded,
                      size: 16,
                      color: context.primaryColor,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      isTag ? "Tags" : "Users",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      _entry != null
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 14,
                      color: context.textSecondaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
