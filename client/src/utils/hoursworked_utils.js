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
    labels.push(moment(date.date).format("YYYY-MM-DD"))
    if(date.night_hours) {
      data_night.datas[moment(date.date).format("YYYY-MM-DD")] = date.night_hours
    }
    if(date.normal_hours) {
      data_normal.datas[moment(date.date).format("YYYY-MM-DD")] = date.normal_hours
    }
    if(date.overtime_hours) {
      data_overtime.datas[moment(date.date).format("YYYY-MM-DD")] = date.overtime_hours
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
    data_normal.datas[moment(date.date).format("YYYY-MM-DD")] = date.normal_hours + date.night_hours + date.overtime_hours
    data_expected.datas[moment(date.date).format("YYYY-MM-DD")] = date.expected_worked_hours
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
    labels.push(moment(date.date).format("YYYY-MM-DD"))
    if(date.night_hours) {
      if(!data_night.datas[moment(date.date).format("YYYY-MM-DD")]) data_night.datas[moment(date.date).format("YYYY-MM-DD")] = 0
      data_night.datas[moment(date.date).format("YYYY-MM-DD")] += date.night_hours
    }
    if(date.normal_hours) {
      if(!data_normal.datas[moment(date.date).format("YYYY-MM-DD")]) data_normal.datas[moment(date.date).format("YYYY-MM-DD")] = 0
      data_normal.datas[moment(date.date).format("YYYY-MM-DD")] += date.normal_hours
    }
    if(date.overtime_hours) {
      if (!data_overtime.datas[moment(date.date).format("YYYY-MM-DD")]) data_overtime.datas[moment(date.date).format("YYYY-MM-DD")] = 0
      data_overtime.datas[moment(date.date).format("YYYY-MM-DD")] += date.overtime_hours
    }
  })
  return {data: [data_normal, data_night, data_overtime], labels}
}

export const dailyTeamAverage = (dates) => {
  let data_normal = {
    label: "Total hours",
    color: "#392F5A",
    datas: {}
  }
  dates.forEach(date => {
    if(!data_normal.datas[moment(date.date).format("YYYY-MM-DD")]) data_normal.datas[moment(date.date).format("YYYY-MM-DD")] = 0
    data_normal.datas[moment(date.date).format("YYYY-MM-DD")] += date.normal_hours + date.night_hours + date.overtime_hours
  })
  return [data_normal]
}