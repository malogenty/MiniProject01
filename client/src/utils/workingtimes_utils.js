const datesToDuration = workingTime => new Date(workingTime.end) - new Date(workingTime.start);

const getWeekNumber = date => {
	const d = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
	const dayNum = d.getUTCDay() || 7;
	d.setUTCDate(d.getUTCDate() + 4 - dayNum);
    const yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));

	return Math.ceil(((d - yearStart) / 86400000 + 1) / 7);
};

const secondsToHours = seconds => seconds / 60 / 60 / 1000;

const workingTimesToOrderedObject = workingTimes => {
	const dates = {};
	for (const workingTime of workingTimes) {
		const date = workingTime.start.split(' ')[0];
		const duration = datesToDuration(workingTime);
		dates[date] = secondsToHours(duration);
	}
	
	return dates;
};

const orderByWeekNumbers = datesObject => {
	const weeks = {};
	for (const date in datesObject) {
		const weekNumber = getWeekNumber(new Date(date));
		if (!weeks[weekNumber]) {
			weeks[weekNumber] = [];
		}
		weeks[weekNumber] = { ...weeks[weekNumber], [date]: datesObject[date] };
	}

	return weeks;
};

const getDayDurationsByWeeks = workingTimes => {
	const datesObject = workingTimesToOrderedObject(workingTimes);
	const weeks = orderByWeekNumbers(datesObject);

	return weeks;
};

const getDurationByWeeks = workingTimes => {
    const weeks = getDayDurationsByWeeks(workingTimes);

    for (const week in weeks) {
        const totalDuration = Object.values(weeks[week]).reduce((acc, duration) => acc + duration, 0);
        weeks[week] = totalDuration;
    }

	return weeks;
};

const getAverageDurationByWeeks = workingTimes => {
    const weeks = getDayDurationsByWeeks(workingTimes);

    for (const week in weeks) {
        const averageDuration = Object.values(weeks[week]).reduce((acc, duration) => acc + duration, 0) / Object.keys(weeks[week]).length;
        weeks[week] = Math.round(averageDuration * 100) / 100;
    }

    return weeks;
};

module.exports = { getDayDurationsByWeeks, getDurationByWeeks, getAverageDurationByWeeks }