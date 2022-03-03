import appShiftsList  from './apps/list.vue'

const routes =  [
    {
        path: "/working_weeks",
        component: appShiftsList
    },
    {
        path: "/",
        component: appShiftsList
    }
]

export default routes;