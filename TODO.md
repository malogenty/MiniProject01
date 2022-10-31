
# Database
- [ ] Create table team 
	- Name (string)
	- ID
	- Nightshift pay (float)
	- Overtime pay (float)
	- start_of_day (time)
	- end_of_day (time) 

- [ ] associate_team_users
  - user_id
  - team_id

- [ ] Users
	- hour_rate (float, default)
	- role (string: 'general_manager' || 'manager' || 'employee')


On front-end, when clock_out with +4 hours difference clock_in, add confirmation && option to custom clock_out (changing clock_out hour/date)

- [ ] Clocks
	- add a route with custom clock_out
	- check that given time < curr_time before insert

On clock out, check : si le clock out > end_of_day --> alors excess : night_hours
si le clock_out > schedule.end --> alors excess : overtime_hours
le reste -> normal_hours
if clock_in.date !== clock_out.date, separate

- [ ] Hours_Worked instead of working times
	- date (date) 2022-10-31
	- normal_hours (float)
	- night_hours (float)
	- overtime_hours (float)
	- user_id
	- expected_worked_hours (float, default 0 )


On schedule update, also update hours_worked
  -> update hours_worked : expected_worked_hours : x
FRONT-END: schedule: test two last days if night_shift and add warning when trying to add
(if schedule.end > team.end_of_day)

- [ ] Schedule
	- user_id
	- start (date-time)
	- end (date-time)
	- title (string, default: work)
