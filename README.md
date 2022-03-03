# Maas System


- [Maas System](#maas-system)
  - [Tools](#tools)
    - [Front-End](#front-end)
    - [Backend](#backend)
  - [Video](#video)
  - [Setup](#setup)
  - [Database Structure](#database-structure)
  - [Algorithm](#algorithm)
    - [Explanation](#explanation)
    - [Weights](#weights)
    - [Code](#code)
    - [To improve](#to-improve)

## Tools
### Front-End
- Vue JS
- Javascript
- Saas
- HTML

### Backend
- RoR
- Postgresql

## Video
[MVP Demo](https://bit.ly/3hFVjcN)

## Setup
To configure the system in your local environment you need do the following steps.

1. Download the correct ruby, rails and pg version, the project was created using ruby version 2.7.2, rails 6.1.4.6 and postgres 14.1.
2. Download the repository from [**here**](https://github.com/diegoalay/maas)
3. After download the reposotory you need run bundle update
4. You need to configure de database credentials, you can do it running the following command if you have nano installed.
5
```bash
EDITOR="nano" rails credentials:edit --environment development
```
Then you need to add the database credentials.

```bash
db:
  database: maas_development
  username: YOUR_PG_USERNMAE
  password: YOUR_PASSWORD_USERNMAE
```

Save the file and that's it for the environment configuration.

5. Setup the database, you can do it with the following command.

``` ruby
rake db:reset
```
6. Now you are ready to run the rails server.

7. After ran the seed you are going to have the following user:
  - diego@maas-system.com [Admin]
  - ernesto@maas-system.com [Employee]
  - barbara@maas-system.com [Employee]
  - benjamin@maas-system.com [Employee]

The password for all the users: 123456

## Database Structure
- users
- services
- working_weeks
  - available_shifts
  - confirmed_shifts

## Algorithm
### Explanation
- First I determine a few of base cases.
- If there is only one user with shifts available, the shift always will be assign to the user.
- If the shift is free (any other user is free that day) always will be assign to the user.
- Here the difficult part comes, if a shift is available for two or more users I decide create an algorithm based on the priority, the priority is calculatng with the following formula: *priority = ngp + csp + pn*

###  Weights
- 0.40 -> For those users with the lowest amount of hours assigned.
- 0.60 -> For the neighboring hours_frequency, this mean that a user has sequencialy hours in one day.
- 1.00 -> If the user currently has assigned all the hours of the day.

### Code
```ruby
  #  priority = ngp + csp + pn
  #  ngp = |confirmed_shifts - confirmed_shifts_average| * 0.40) if the current user has all the week taken
  #  csp = (0.60 * neighboring_hours_frequency)
  #  np = 1 if the user has all the hours of the day assigned

  ngp = (info[:confirmed_shifts] - confirmed_shifts_average).abs * 0.40
  csp = info[:neighboring_hours_frequency] * 0.60
  np = info[:neighboring_hours_taken]
  priority = ngp + csp + np
```

### To improve
- Add Tests
- Add more Rubocop fixes
- Move the algorithm into a service
- Refactor code in the UI