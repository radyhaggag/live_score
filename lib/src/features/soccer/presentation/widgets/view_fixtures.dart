import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../config/app_route.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/date_time.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/widgets/app_empty.dart';
import 'fixture_card.dart';
import 'live_fixtures_card.dart';
import 'view_all_tile.dart';

/// Displays the list of today's fixtures with a section header.
class ViewDayFixtures extends StatelessWidget {
  final List<SoccerFixture> fixtures;

  const ViewDayFixtures({super.key, required this.fixtures});

  @override
  Widget build(BuildContext context) {
    if (fixtures.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.jumbo),
        child: AppEmptyWidget(),
      );
    }

    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.m,
      children: [
        Row(
          spacing: AppSpacing.s,
          children: [
            Icon(
              PhosphorIcons.calendarBlank(PhosphorIconsStyle.fill),
              color: context.colors.primary,
            ),
            Expanded(
              child: Text(
                l10n.fixtures,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            ViewAllTile(onTap: () => context.push(Routes.fixtures)),
          ],
        ),
        ...List.generate(fixtures.length, (index) {
          final localTime = fixtures[index].startTime;
          final formattedTime =
              localTime == null
                  ? l10n.tbd
                  : localTime.formatForLocale(
                    context.localeName,
                    pattern: 'h:mm a',
                  );

          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap:
                () =>
                    context.push(Routes.fixtureDetails, extra: fixtures[index]),
            child: FixtureCard(
              soccerFixture: fixtures[index],
              fixtureTime: formattedTime,
            ),
          ).animate().fadeIn(delay: (index * 50).ms).slideY(begin: 0.1);
        }),
      ],
    );
  }
}

/// Horizontal scrollable rail of live fixture cards.
class ViewLiveFixtures extends StatefulWidget {
  final List<SoccerFixture> fixtures;

  const ViewLiveFixtures({super.key, required this.fixtures});

  @override
  State<ViewLiveFixtures> createState() => _ViewLiveFixturesState();
}

class _ViewLiveFixturesState extends State<ViewLiveFixtures> {
  final ScrollController _scrollController = ScrollController();
  bool _canScrollLeft = false;
  bool _canScrollRight = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollButtons);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateScrollButtons());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_updateScrollButtons)
      ..dispose();
    super.dispose();
  }

  void _updateScrollButtons() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    final canLeft = position.pixels > 0;
    final canRight = position.pixels < position.maxScrollExtent;
    if (canLeft != _canScrollLeft || canRight != _canScrollRight) {
      setState(() {
        _canScrollLeft = canLeft;
        _canScrollRight = canRight;
      });
    }
  }

  Future<void> _scrollBy(double offset) async {
    if (!_scrollController.hasClients) return;
    final target = (_scrollController.offset + offset).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );
    await _scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = switch (constraints.maxWidth) {
          >= 1100 => 220.0,
          >= 760 => 205.0,
          _ => 190.0,
        };
        final railHeight = constraints.maxWidth >= 760 ? 250.0 : 246.0;
        final scrollAmount = cardWidth + AppSpacing.xl;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.m,
          children: [
            Row(
              spacing: AppSpacing.s,
              children: [
                Icon(
                      PhosphorIcons.monitorPlay(PhosphorIconsStyle.fill),
                      color: context.colorsExt.red,
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .fade(begin: 0.5, end: 1.0, duration: 1.seconds),
                Expanded(
                  child: Text(
                    l10n.liveFixtures,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _RailArrow(
                  icon: PhosphorIcons.caretLeft(PhosphorIconsStyle.bold),
                  enabled: _canScrollLeft,
                  onTap: () => _scrollBy(-scrollAmount),
                ),
                _RailArrow(
                  icon: PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                  enabled: _canScrollRight,
                  onTap: () => _scrollBy(scrollAmount),
                ),
              ],
            ),
            SizedBox(
              height: railHeight,
              child: ListView.separated(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                        onTap:
                            () => context.push(
                              Routes.fixtureDetails,
                              extra: widget.fixtures[index],
                            ),
                        child: LiveFixtureCard(
                          soccerFixture: widget.fixtures[index],
                          width: cardWidth,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: (index * 100).ms)
                      .slideX(begin: 0.1);
                },
                separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.m),
                itemCount: widget.fixtures.length,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RailArrow extends StatelessWidget {
  const _RailArrow({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: IconButton.filledTonal(
        onPressed: enabled ? onTap : null,
        visualDensity: VisualDensity.compact,
        iconSize: 18,
        icon: Icon(
          icon,
          color:
              enabled ? context.colors.onSurface : context.colorsExt.textMuted,
        ),
        style: IconButton.styleFrom(
          backgroundColor: context.colorsExt.surfaceGlass,
        ),
      ),
    );
  }
}
