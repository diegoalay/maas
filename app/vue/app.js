import app from 'appVue/app'

// Routes definition
import dashboardRoutes from './dashboard/routes.js';
import EmployeesRoutes from './employees/routes.js';
import ServicessRoutes from './services/routes.js';
import profileRoutes from './profile/routes.js'

app("",
    dashboardRoutes
    .concat(EmployeesRoutes)
    .concat(profileRoutes)
    .concat(ServicessRoutes)
)