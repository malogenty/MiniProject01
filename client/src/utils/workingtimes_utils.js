import moment from 'moment'

export const datesToDuration = workingTime => new Date(workingTime.end) - new Date(workingTime.start);

export const getWeekNumber = date => {
	return moment(date).weeks() - 1
};

export const secondsToHours = seconds => seconds / 60 / 60 / 1000;

export const workingTimesToOrderedObject = workingTimes => {
	const dates = {};
	for (const workingTime of workingTimes) {
		const date = workingTime.start.split('T')[0];
		const duration = datesToDuration(workingTime);
		if(!dates[date]) {
			dates[date] = 0
		}
		dates[date] += secondsToHours(duration);
	}
	return dates;
};

export const orderByWeekNumbers = datesObject => {
	const weeks = {};
	for (const [key, value] of  Object.entries(datesObject)) {
		const weekNumber = getWeekNumber(key);
		if (!weeks[weekNumber]) {
			weeks[weekNumber] = {};
		}
		weeks[weekNumber] = {...weeks[weekNumber], [key]: value}
	}
	return weeks;
};

export const getDayDurationsByWeeks = workingTimes => {
	const datesObject = workingTimesToOrderedObject(workingTimes);
	const weeks = orderByWeekNumbers(datesObject);

	return weeks;
};

export const getDurationByWeeks = workingTimes => {
    const weeks = getDayDurationsByWeeks(workingTimes);

    for (const [weekNumber, weekValues] of Object.entries(weeks)) {
        const totalDuration = Object.values(weekValues).reduce((acc, duration) => acc + duration, 0);
        weeks[weekNumber] = totalDuration;
    }

	return weeks;
};

export const getAverageDurationByWeeks = workingTimes => {
    const weeks = getDayDurationsByWeeks(workingTimes);

		for (const [weekNumber, weekValues] of Object.entries(weeks)) {
			const averageDuration = Object.values(weekValues).reduce((acc, duration) => acc + duration, 0) / Object.keys(weeks[weekNumber]).length;
			weeks[weekNumber] = Math.round(averageDuration * 100) / 100;
    }
		return weeks;

};
