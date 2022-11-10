import moment from 'moment'

// COLORS
const dayColor = "#EBE784";
const nightColor = "#0069A4";
const overtimeColor = "#008DA1";
const totalColor = "#77BA99";
const expectedColor = "#00A76B";

// USER-ONLY DATA
export const sortedUserDaily = (dates) => {
  let data_normal = {
    label: "Day hours",
    color: dayColor,
    datas: {}
  }
  let data_night = {
    label: "Night hours",
    color: nightColor,
    datas: {}
  }
  let data_overtime = {
    label: "Overtime hours",
    color: overtimeColor,
    datas: {}
  }
  let labels = []
  dates.forEach(date => {
    const date_f = moment(date.date).format("MMM, Mo")
    labels.push(date_f)
    if(date.night_hours) {
      data_night.datas[date_f] = date.night_hours
    }
    if(date.normal_hours) {
      data_normal.datas[date_f] = date.normal_hours
    }
    if(date.overtime_hours) {
      data_overtime.datas[date_f] = date.overtime_hours
    }
  })
  return {data: [data_normal, data_night, data_overtime], labels}
}

export const summedUserDaily = (dates) => {
  let data_normal = {
    label: "Total hours",
    color: totalColor,
    datas: {}
  }
  let data_expected = {
    label: "Expected hours",
    color: expectedColor,
    datas: {}
  }
  dates.forEach(date => {
    const date_f = moment(date.date).format("MMM, Mo")
    data_normal.datas[date_f] = date.normal_hours + date.night_hours + date.overtime_hours
    data_expected.datas[date_f] = date.expected_worked_hours
  })
  return [data_normal, data_expected]
}

export const sortedUserWeekly = (dates) => {
  let data_normal = {
    label: "Day hours",
    color: dayColor,
    datas: {}
  }
  let data_night = {
    label: "Night hours",
    color: nightColor,
    datas: {}
  }
  let data_overtime = {
    label: "Overtime hours",
    color: overtimeColor,
    datas: {}
  }
  let weekLabels = {}
  dates.forEach(date => {
    const w = moment(date.date).week()
    if(!weekLabels[w]) weekLabels[w] = w
    if(date.night_hours) {
      if(!data_night.datas[w]) data_night.datas[w] = 0
      data_night.datas[w] += date.night_hours
    }
    if(date.normal_hours) {
      if(!data_normal.datas[w]) data_normal.datas[w] = 0
      data_normal.datas[w] += date.normal_hours
    }
    if(date.overtime_hours) {
      if(!data_overtime.datas[w]) data_overtime.datas[w] = 0
      data_overtime.datas[w] += date.overtime_hours
    }
  })
  return {weekData: [data_normal, data_night, data_overtime], weekLabels: Object.values(weekLabels)}

}

export const summedUserWeekly = (dates) => {
  let data_normal = {
    label: "Total hours",
    color: totalColor,
    datas: {}
  }
  let data_expected = {
    label: "Expected hours",
    color: expectedColor,
    datas: {}
  }
  dates.forEach(date => {
    let w = moment(date.date).week()
    if(!data_normal.datas[w]) data_normal.datas[w] = 0
    data_normal.datas[w] += date.normal_hours + date.night_hours + date.overtime_hours
    if(!data_expected.datas[w]) data_expected.datas[w] = 0
    data_expected.datas[w] += date.expected_worked_hours
  })
  return [data_normal, data_expected]
}


// TEAM-ONLY DATA

export const dailyTeamSortedAverage = (dates) => {
  let data_normal = {
    label: "Average day hours",
    color: dayColor,
    datas: {}
  }
  let data_night = {
    label: "Average night hours",
    color: nightColor,
    datas: {}
  }
  let data_overtime = {
    label: "Average overtime hours",
    color: overtimeColor,
    datas: {}
  }
  let labels = []
  dates.forEach(date => {
    const date_f = moment(date.date).format("MMM, Mo")
    labels.push(date_f)
    if(date.avg_night) {
      data_night.datas[date_f] = date.avg_night
    }
    if(date.avg_normal) {
      data_normal.datas[date_f] = date.avg_normal
    }
    if(date.avg_overtime) {
      data_overtime.datas[date_f] = date.avg_overtime
    }
  })
  return {data: [data_normal, data_night, data_overtime], labels}
}

export const dailyTeamAverage = (dates) => {
  let data_normal = {
    label: "Average total hours",
    color: totalColor,
    datas: {}
  }
  let data_expected = {
    label: "Average expected hours",
    color: expectedColor,
    datas: {}
  }
  dates.forEach(date => {
    const date_f = moment(date.date).format("MMM, Mo")
    data_normal.datas[date_f] = date.avg_normal + date.avg_night + date.avg_overtime
    data_expected.datas[date_f] = date.avg_expected
  })
  return [data_normal, data_expected]
}

export const weeklyTeamSortedAverage = (dates) => {
  let data_normal = {
    label: "Average day hours",
    color: dayColor,
    datas: {}
  }
  let data_night = {
    label: "Average night hours",
    color: nightColor,
    datas: {}
  }
  let data_overtime = {
    label: "Average overtime hours",
    color: overtimeColor,
    datas: {}
  }
  let weekLabels = {}
  dates.forEach(date => {
    const w = moment(date.date).week()
    if(!weekLabels[w]) weekLabels[w] = w
    if(date.avg_night) {
      if(!data_night.datas[w]) data_night.datas[w] = 0
      data_night.datas[w] += date.avg_night
    }
    if(date.avg_normal) {
      if(!data_normal.datas[w]) data_normal.datas[w] = 0
      data_normal.datas[w] += date.avg_normal
    }
    if(date.avg_overtime) {
      if (!data_overtime.datas[w]) data_overtime.datas[w] = 0
      data_overtime.datas[w] += date.avg_overtime
    }
  })
  return {weekData: [data_normal, data_night, data_overtime], weekLabels: Object.values(weekLabels)}
}

export const weeklyTeamAverage = (dates) => {
  let data_normal = {
    label: "Average total hours",
    color: totalColor,
    datas: {}
  }
  let data_expected = {
    label: "Average expected hours",
    color: expectedColor,
    datas: {}
  }
  dates.forEach(date => {
    const w = moment(date.date).week()
    if(!data_normal.datas[w]) data_normal.datas[w] = 0
    data_normal.datas[w] += date.avg_normal + date.avg_night + date.avg_overtime
    if(!data_expected.datas[w]) data_expected.datas[w] = 0
    data_expected.datas[w] += date.avg_expected
  })
  return [data_normal, data_expected]
}