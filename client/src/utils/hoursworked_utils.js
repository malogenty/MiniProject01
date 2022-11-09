import moment from 'moment'

// USER-ONLY DATA 
export const sortedUserDaily = (dates) => {
  let data_normal = {
    label: "Day hours",
    color: "#B7CECE",
    datas: {}
  }
  let data_night = {
    label: "Night hours",
    color: "#494331",
    datas: {}
  }
  let data_overtime = {
    label: "Overtime hours",
    color: "#DE541E",
    datas: {}
  }
  let labels = []
  dates.forEach(date => {
    const date_f = moment(date.date).format("YYYY-MM-DD")
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
    color: "#DBB3B1",
    datas: {}
  }
  let data_expected = {
    label: "Expected hours",
    color: "#2C1A1D",
    datas: {}
  }
  dates.forEach(date => {
    const date_f = moment(date.date).format("YYYY-MM-DD")
    data_normal.datas[date_f] = date.normal_hours + date.night_hours + date.overtime_hours
    data_expected.datas[date_f] = date.expected_worked_hours
  })
  return [data_normal, data_expected]
}

export const sortedUserWeekly = (dates) => {
  let data_normal = {
    label: "Day hours",
    color: "#B7CECE",
    datas: {}
  }
  let data_night = {
    label: "Night hours",
    color: "#494331",
    datas: {}
  }
  let data_overtime = {
    label: "Overtime hours",
    color: "#DE541E",
    datas: {}
  }
  let weekLabels = []
  dates.forEach(date => {
    weekLabels.push(moment(date.date).week())
    if(date.night_hours) {
      if(!data_night.datas[moment(date.date).week()]) data_night.datas[moment(date.date).week()] = 0
      data_night.datas[moment(date.date).week()] += date.night_hours
    }
    if(date.normal_hours) {
      if(!data_normal.datas[moment(date.date).week()]) data_normal.datas[moment(date.date).week()] = 0
      data_normal.datas[moment(date.date).week()] += date.normal_hours
    }
    if(date.overtime_hours) {
      if(!data_overtime.datas[moment(date.date).week()]) data_overtime.datas[moment(date.date).week()] = 0
      data_overtime.datas[moment(date.date).week()] += date.overtime_hours
    }
  })
  return {weekData: [data_normal, data_night, data_overtime], weekLabels}

}

export const summedUserWeekly = (dates) => {
  let data_normal = {
    label: "Total hours",
    color: "#DBB3B1",
    datas: {}
  }
  let data_expected = {
    label: "Expected hours",
    color: "#2C1A1D",
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
    color: "#B7CECE",
    datas: {}
  }
  let data_night = {
    label: "Average night hours",
    color: "#494331",
    datas: {}
  }
  let data_overtime = {
    label: "Average overtime hours",
    color: "#DE541E",
    datas: {}
  }
  let labels = []
  dates.forEach(date => {
    const date_f = moment(date.date).format("YYYY-MM-DD")
    labels.push(date_f)
    if(date.avg_night_hours) {
      data_night.datas[date_f] = date.avg_night_hours
    }
    if(date.avg_normal_hours) {
      data_normal.datas[date_f] = date.avg_normal_hours
    }
    if(date.avg_overtime_hours) {
      data_overtime.datas[date_f] = date.avg_overtime_hours
    }
  })
  return {weekData: [data_normal, data_night, data_overtime], labels}
}

export const dailyTeamAverage = (dates) => {
  let data_normal = {
    label: "Average total hours",
    color: "#DBB3B1",
    datas: {}
  }
  let data_expected = {
    label: "Average expected hours",
    color: "#2C1A1D",
    datas: {}
  }
  dates.forEach(date => {
    const date_f = moment(date.date).format("YYYY-MM-DD")
    data_normal.datas[date_f] = date.avg_normal_hours + date.avg_night_hours + date.avg_overtime_hours
    data_expected.datas[date_f] = date.avg_expected_worked_hours
  })
  return [data_normal, data_expected]
}

export const weeklyTeamSortedAverage = (dates) => {
  let data_normal = {
    label: "Average day hours",
    color: "#B7CECE",
    datas: {}
  }
  let data_night = {
    label: "Average night hours",
    color: "#494331",
    datas: {}
  }
  let data_overtime = {
    label: "Average overtime hours",
    color: "#DE541E",
    datas: {}
  }
  let weekLabels = []
  dates.forEach(date => {
    const w = moment(date.date).week()
    weekLabels.push(w)
    if(date.night_hours) {
      if(!data_night.datas[w]) data_night.datas[w] = 0
      data_night.datas[w] += date.avg_night_hours
    }
    if(date.normal_hours) {
      if(!data_normal.datas[w]) data_normal.datas[w] = 0
      data_normal.datas[w] += date.avg_normal_hours
    }
    if(date.overtime_hours) {
      if (!data_overtime.datas[w]) data_overtime.datas[w] = 0
      data_overtime.datas[w] += date.avg_overtime_hours
    }
  })
  return {weekData: [data_normal, data_night, data_overtime], weekLabels}
}

export const weeklyTeamAverage = (dates) => {
  let data_normal = {
    label: "Average total hours",
    color: "#DBB3B1",
    datas: {}
  }
  let data_expected = {
    label: "Average expected hours",
    color: "#2C1A1D",
    datas: {}
  }
  dates.forEach(date => {
    const w = moment(date.date).week()
    if(!data_normal.datas[w]) data_normal.datas[w] = 0
    data_normal.datas[w] += date.avg_normal_hours + date.avg_night_hours + date.avg_overtime_hours
    if(!data_expected.datas[w]) data_expected.datas[w] = 0
    data_expected.datas[w] += date.avg_expected_worked_hours
  })
  return [data_normal, data_expected]
}