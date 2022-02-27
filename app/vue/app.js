import app from 'appVue/app'

// Routes definition
import dashboardRoutes from './dashboard/routes.js';
import EmployeesRoutes from './employees/routes.js';

app("",
    dashboardRoutes
    .concat(salesRoutes)
    .concat(cashRegisterRoutes)
)