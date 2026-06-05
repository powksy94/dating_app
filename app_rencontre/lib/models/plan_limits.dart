class PlanLimits {
    final int? swipesPerDay;       // null = illimité
    final int? elegiesPerMonth;    // null = illimité
    final int? eventsPerMonth;     // null = illimité
    final int? boostPerMonth;
    final int? boostPerWeek;
    final bool whoLikedMe;
    final bool whoVisitedMe;
    final bool rewind;
    final int photosVisible;

    const PlanLimits({
        required this.swipesPerDay,
        required this.elegiesPerMonth,
        required this.eventsPerMonth,
        this.boostPerMonth,
        this.boostPerWeek,
        required this.whoLikedMe,
        required this.whoVisitedMe,
        required this.rewind,
        required this.photosVisible,
    });
}

const kOmbreLimits = PlanLimits(
    swipesPerDay:    30,
    elegiesPerMonth: 3,
    eventsPerMonth:  2,
    whoLikedMe:      false,
    whoVisitedMe:    false,
    rewind:          false,
    photosVisible:   2,
);

const kNocturneLimits = PlanLimits(
    swipesPerDay:    null,
    elegiesPerMonth: 15,
    eventsPerMonth:  4,
    boostPerMonth:   1,
    whoLikedMe:      true,
    whoVisitedMe:    true,
    rewind:          true,
    photosVisible:   6,
);

const kAbyssalLimits = PlanLimits(
    swipesPerDay:    null,
    elegiesPerMonth: null,
    eventsPerMonth:  null,
    boostPerWeek:    1,
    whoLikedMe:      true,
    whoVisitedMe:    true,
    rewind:          true,
    photosVisible:   6,
);
