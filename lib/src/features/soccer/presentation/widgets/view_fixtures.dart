import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../config/app_route.dart';
import '../../../../core/domain/entities/soccer_fixture.dart';
import '../../../../core/l10n/app_l10n.dart';
import '../../../../core/extensions/context_ext.dart';
import 'fixture_card.dart';
import 'live_fixtures_card.dart';
import '../../../../core/widgets/app_empty.dart';
import 'view_all_tile.dart';
import 'package:live_score/src/core/constants/app_spacing.dart';

class ViewDayFixtures extends StatelessWidget {
  final List<SoccerFixture> fixtures;

  const ViewDayFixtures({super.key, required this.fixtures});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return fixtures.isNotEmpty
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(Icons.calendar_month, color: context.colorsExt.blue),
                Expanded(
                  child: Text(
                    l10n.fixtures,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ViewAllTile(onTap: () => context.push(Routes.fixtures)),
              ],
            ),
            ...List.generate(fixtures.length, (index) {
              final String fixtureTime = fixtures[index].startTime.toString();
              final localTime = DateTime.parse(fixtureTime).toLocal();
              final formattedTime = DateFormat(
                'h:mm a',
                context.localeName,
              ).format(localTime);
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  context.push(Routes.fixtureDetails, extra: fixtures[index]);
                },
                child: FixtureCard(
                  soccerFixture: fixtures[index],
                  fixtureTime: formattedTime,
                ),
              );
            }),
          ],
        )
        : const Padding(
          padding: EdgeInsets.symmetric(vertical: 48),
          child: AppEmptyWidget(),
        );
  }
}

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
        final cardWidth =
            constraints.maxWidth >= 1100
                ? 220.0
                : constraints.maxWidth >= 760
                ? 205.0
                : 190.0;
        final railHeight = constraints.maxWidth >= 760 ? 246.0 : 238.0;
        final scrollAmount = cardWidth + 20;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(Icons.stream, color: context.colorsExt.red),
                Expanded(
                  child: Text(
                    l10n.liveFixtures,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                _RailArrow(
                  icon: Icons.arrow_back_ios_new_rounded,
                  enabled: _canScrollLeft,
                  onTap: () => _scrollBy(-scrollAmount),
                ),
                _RailArrow(
                  icon: Icons.arrow_forward_ios_rounded,
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
                    onTap: () {
                      context.push(
                        Routes.fixtureDetails,
                        extra: widget.fixtures[index],
                      );
                    },
                    child: LiveFixtureCard(
                      soccerFixture: widget.fixtures[index],
                      width: cardWidth,
                    ),
                  );
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
        icon: Icon(icon, color: context.colorsExt.white),
      ),
    );
  }
}
