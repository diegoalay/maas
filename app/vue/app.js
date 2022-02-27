import app from 'appVue/app'

// Routes definition
import dashboardRoutes from './dashboard/routes.js';
import UsersRoutes from './users/routes.js';
import ServicessRoutes from './services/routes.js';
import profileRoutes from './profile/routes.js'

app("",
    dashboardRoutes
    .concat(UsersRoutes)
    .concat(profileRoutes)
    .concat(ServicessRoutes)
)