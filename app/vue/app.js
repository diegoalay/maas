import app from 'appVue/app'

// Routes definition
import UsersRoutes from './users/routes.js';
import ServicessRoutes from './services/routes.js';
import profileRoutes from './profile/routes.js'
import workingWeeksRoutes from './working_weeks/routes.js'

app("",
    UsersRoutes
    .concat(profileRoutes)
    .concat(ServicessRoutes)
    .concat(workingWeeksRoutes)
)