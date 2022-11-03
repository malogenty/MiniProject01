
# Database
BACK-END CHECK RIGHTS


## Hugo

- [x] Create table team 
	- Name (string)
	- ID
	- Nightshift pay (float)
	- Overtime pay (float)
	- start_of_day (time)
	- end_of_day (time) 

- [x] associate_team_users
  - user_id
  - team_id

- [x] Users
	- hour_rate (float, default)
	- role (string: 'general_manager' || 'manager' || 'employee')


- [x] Create and update routes accordingly 
- [x] Update schemas
- [ ] Check rights before insertion / getting
- [ ] Update front-end store accordingly
- [ ] Update front-end store accordingly
## End-Hugo

On front-end, when clock_out with +4 hours difference clock_in, add confirmation && option to custom clock_out (changing clock_out hour/date)

## Enzo
- [ ] Clocks
	- add a route with custom clock_out
	- check that given time < curr_time before insert

On clock out, check : si le clock out > end_of_day --> alors excess : night_hours
clock out available 12hrs onward from expected clockout (given schedule)
si le clock_out > schedule.end --> alors excess : overtime_hours
le reste -> normal_hours
if clock_in.date !== clock_out.date, separate

- [x] Hours_Worked instead of working times
	- date (date) 2022-10-31
	- normal_hours (float)
	- night_hours (float)
	- overtime_hours (float)
	- user_id
	- expected_worked_hours (float, default 0 )
## End-Enzo

On schedule update, also update hours_worked
  -> update hours_worked : expected_worked_hours : x
  
FRONT-END: schedule: test two last days if night_shift and add warning when trying to add
(if schedule.end > team.end_of_day)

- [ ] Schedule
	- user_id
	- start (date-time)
	- end (date-time)
	- title (work || holiday || sick, default: work)
- get for 1 user from date to date
- post for 1 user
	-> check from date && to date
	-> check if for that date there is hours_worked
		- if no, create and set expected_hours
		- if yes, set expected_hours += schedule.hours
	- edge case where event spreads on several days
- update
	-> update hours_worked
- delete
	-> update hours_worked
<<<<<<< HEAD


=======
>>>>>>> master

# Front-end
- Install && setup https://antoniandre.github.io/vue-cal/ with dummy data (taking into account the form it is supposed to have given the DB)
- Handle roles && auth page (even if not working / checking correctly yet)
  - user : 1 tab planning, 1 tab clock, settings
  - manager: (has access to HIS teams only)
    - home: teams-grid
      - teams: users-grid && button to clock-in ALL the team
        - user: 1 tab dashboard with stats, 1 tab planning schedule, 1 tab settings (or on username click)
  - general_manager: (has access to EVERYTHING)
    - home: teams-grid  
      - teams: users-grid && button to clock-in ALL the team
        - user: 1 tab dashboard with stats, 1 tab planning schedule, 1 tab settings (or on username click)


All users can :
X Edit their account information.
X Delete their account.
X Report their departure and arrival times. 
X View their dashboards.

The managers and general manager can :
• Manage their team(s).
X View the averages of the daily and weekly hours of the team over a given period. 
X View the daily and weekly workinghours of an employee over a period of time. 
X View their employees dashboards.

The general manager can :
<<<<<<< HEAD
• Promote a user from the rank of employee to manager. 
• View the dashboards of all users.
• Delete accounts from all users.


- [ ] api request to get total hours of team for a given period
=======
X Promote a user from the rank of employee to manager. 
X View the dashboards of all users.
X Delete accounts from all users.
>>>>>>> master
