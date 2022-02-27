import appEmployeesList  from './apps/list.vue'
import appEmployeesNew   from './apps/new.vue'
import appEmployeesShow from './apps/show.vue'

const routes =  [
    {
        path: "/users",
        component: appEmployeesList
    },
    {
        path: "/users/new",
        component: appEmployeesNew
    },
    {
        path: "/users/:id",
        component: appEmployeesShow
    }
]

export default routes;